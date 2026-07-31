#!/usr/bin/env python3
"""Build the ASV as USX from the ASV SWORD module.

The module's own Strong's tagging is crude and carries no morphology or word
positions, so it is dropped entirely. What is kept is the ASV's own structure —
`<div type="x-p">` paragraph breaks, `<l>` poetic lines, and canonical Psalm
`<title>`s — plus the BSB section headings, anchored to the verse they precede
(the same heading process used for the KJV).

Output: one USX file per book in content/sources/bibles/asv/<USX>.usx, parsed
by tools/content/bin/generate_asv_json.dart via the shared USX parser.

Run from this directory: .venv/bin/python build_asv.py
"""
import os
import re
import xml.etree.ElementTree as ET
from xml.sax.saxutils import escape

from pysword.modules import SwordModules
from pysword.canons import canons

from build_kjv_interlinear import ROOT, OSIS_USX, local, sanitize, load_bsb_headings, convert_note

ASV_MODULE = os.path.join(ROOT, "content", "sources", "sword", "ASV")
OUT_DIR = os.path.join(ROOT, "content", "sources", "bibles", "asv")

# The module uses typographic quotes; the app's ASV text uses straight ones.
QUOTES = str.maketrans({"’": "'", "‘": "'", "“": '"', "”": '"'})


def needs_space(prev, nxt):
    """The module occasionally drops the space at a <transChange> boundary, butting
    a word directly against the next. Insert one when a token end meets a word start."""
    if not prev or prev[-1].isspace():
        return False
    return (nxt[0].isalnum() or nxt[0] in "[(") and (prev[-1].isalnum() or prev[-1] in ")]}.,:;!?\"'")


def parse_verse(body):
    """Flatten an ASV OSIS verse into ordered pieces:
      ("para", style)  starts a new paragraph (p / q1 / q2)
      ("title", text)  a canonical Psalm title
      ("text", text)   surface text (Strong's/notes stripped)
    """
    pieces = []

    def walk(elem):
        tag = local(elem.tag)
        if tag == "note":
            note = convert_note(elem)
            if note:
                pieces.append(("note", note))
            return
        if tag == "transChange":  # translator-supplied words — the ASV brackets them
            inner = "".join(elem.itertext())
            if inner.strip():
                pieces.append(("text", f"[{inner}]"))
            return
        if tag == "title":
            title = "".join(elem.itertext()).strip()
            if title:
                pieces.append(("title", title))
            return
        if tag == "div":
            if "x-p" in (elem.get("type") or "") and elem.get("sID"):
                pieces.append(("para", "p"))
            return
        if tag == "l":
            if elem.get("sID"):
                pieces.append(("para", "q2" if elem.get("level") == "2" else "q1"))
            return
        if tag in ("lg", "milestone", "chapter", "verse"):
            return
        if elem.text:
            pieces.append(("text", elem.text))
        for child in elem:
            walk(child)
            if child.tail:
                pieces.append(("text", child.tail))

    root = ET.fromstring(f"<v>{sanitize(body)}</v>")
    if root.text:
        pieces.append(("text", root.text))
    for child in root:
        walk(child)
        if child.tail:
            pieces.append(("text", child.tail))
    return pieces


def build_book(bible, book_name, chapters, usx_code):
    headings = load_bsb_headings(usx_code)
    out = ['<?xml version="1.0" encoding="UTF-8"?>', f'<usx version="3.1"><book style="id" code="{usx_code}">ASV</book>']
    stats = dict(verses=0, headings=0, notes=0)
    buf, style = [], ["p"]

    def flush():
        if buf:
            out.append(f'<para style="{style[0]}">{"".join(buf)}</para>')
            buf.clear()

    for ch in range(1, len(chapters) + 1):
        flush()
        style[0] = "p"
        out.append(f'<chapter number="{ch}" style="c"/>')
        for v in range(1, chapters[ch - 1] + 1):
            try:
                body = bible.get(books=[book_name], chapters=[ch], verses=[v], clean=False)
            except Exception:
                continue
            if not body or not body.strip():
                continue
            stats["verses"] += 1

            for hstyle, text in headings.get((ch, v), []):
                flush()
                style[0] = "p"
                out.append(f'<para style="{hstyle}">{escape(text)}</para>')
                stats["headings"] += 1

            buf.append(f'<verse style="v" number="{v}"/>')
            for kind, value in parse_verse(body.strip()):
                if kind == "para":
                    flush()
                    style[0] = value
                elif kind == "note":
                    buf.append(value)
                    stats["notes"] += 1
                elif kind == "title":
                    flush()
                    out.append(f'<para style="d">{escape(value)}</para>')
                    style[0] = "p"
                elif kind == "text":
                    text = re.sub(r"\s+", " ", value).translate(QUOTES)
                    if text:
                        if buf and needs_space(buf[-1], text):
                            text = " " + text
                        buf.append(escape(text))
        flush()

    out.append("</usx>")
    with open(os.path.join(OUT_DIR, f"{usx_code}.usx"), "w", encoding="utf-8") as fh:
        fh.write("\n".join(out))
    return stats


def main():
    os.makedirs(OUT_DIR, exist_ok=True)
    for f in os.listdir(OUT_DIR):
        os.remove(os.path.join(OUT_DIR, f))

    sm = SwordModules(ASV_MODULE)
    bible = sm.get_bible_from_module(list(sm.parse_modules().keys())[0])
    entry_by_osis = {b[1]: b for b in canons["kjv"]["ot"] + canons["kjv"]["nt"]}

    total_verses = total_headings = total_notes = 0
    for osis, usx_code in OSIS_USX:
        entry = entry_by_osis[osis]
        stats = build_book(bible, entry[0], entry[3], usx_code)
        total_verses += stats["verses"]
        total_headings += stats["headings"]
        total_notes += stats["notes"]
        print(f"{usx_code:4s} {osis:6s}: {stats['verses']:5d} verses, {stats['headings']:3d} headings, {stats['notes']:2d} notes")

    print(f"\nTOTAL: {total_verses} verses, {total_headings} section headings, {total_notes} footnotes")


if __name__ == "__main__":
    main()
