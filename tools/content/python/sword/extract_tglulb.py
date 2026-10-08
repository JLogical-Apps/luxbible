#!/usr/bin/env python3
"""Stage 1 for the Tagalog Unlocked Literal Bible.

Reads the tglulb2018eb SWORD module (eBible.org) from
content/sources/sword/tglulb2018eb/ and writes one faithful per-book OSIS XML
file into content/sources/bibles/tglulb/.

The module is NRSV-versified, which matches KJV everywhere except two verses
that KJV folds into a neighbour:
  * 3 John 1:15 -> 3 John 1:14
  * Rev 12:18   -> Rev 13:1
Those keep their native reference in an origin="..." attribute.

Two source quirks are also handled here:
  * Linked verses (Num 14:36-37) come back from pysword with the same body in
    every linked slot, so a body identical to the previous verse is dropped.
  * Where the translators merged a verse into its neighbour, the emptied verse
    holds only "-" (1 Chr 8, Dan 4:28). Those are dropped.

Run from the repository root: /opt/homebrew/bin/python3.12 tools/content/python/sword/extract_tglulb.py
"""
import os
import re
import xml.etree.ElementTree as ET

from pysword.modules import SwordModules
from pysword.canons import canons

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", "..", "..", ".."))
OUT_DIR = os.path.join(ROOT, "content", "sources", "bibles", "tglulb")
MODULE_DIR = os.path.join(ROOT, "content", "sources", "sword", "tglulb2018eb")

KJV_VERSES = {b[1]: b[3] for b in canons["kjv"]["ot"] + canons["kjv"]["nt"]}
NRSV_BOOKS = canons["nrsv"]["ot"] + canons["nrsv"]["nt"]

REMAPPED = {
    ("3John", 1, 15): ("3John", 1, 14),
    ("Rev", 12, 18): ("Rev", 13, 1),
}


def plain_text(body):
    return re.sub(r"<[^>]*>", "", body).strip()


def main():
    sm = SwordModules(MODULE_DIR)
    sm.parse_modules()
    bible = sm.get_bible_from_module("tglulb2018eb")

    collected = {}
    order = linked = placeholders = 0
    for book_name, osis, _, verse_counts in NRSV_BOOKS:
        previous = None
        for ch in range(1, len(verse_counts) + 1):
            for v in range(1, verse_counts[ch - 1] + 1):
                body = (bible.get(books=[book_name], chapters=[ch], verses=[v], clean=False) or "").strip()
                ET.fromstring(f"<v>{body}</v>")
                if plain_text(body) in ("", "-"):
                    placeholders += 1
                    continue
                if body == previous:
                    linked += 1
                    continue
                previous = body
                native = (osis, ch, v)
                dest = REMAPPED.get(native, native)
                order += 1
                collected.setdefault(osis, []).append((dest, native if dest != native else None, body, order))

    filled = {dest for rows in collected.values() for dest, _, _, _ in rows}
    empty = [
        f"{osis}.{ch}.{v}"
        for osis, counts in KJV_VERSES.items()
        for ch in range(1, len(counts) + 1)
        for v in range(1, counts[ch - 1] + 1)
        if (osis, ch, v) not in filled
    ]

    os.makedirs(OUT_DIR, exist_ok=True)
    for f in os.listdir(OUT_DIR):
        os.remove(os.path.join(OUT_DIR, f))
    for osis, rows in collected.items():
        rows.sort(key=lambda r: (r[0][1], r[0][2], r[3]))
        lines = ['<?xml version="1.0" encoding="UTF-8"?>', f'<osis><div type="book" osisID="{osis}">']
        for (db, dc, dv), origin, body, _ in rows:
            attrs = f'osisID="{db}.{dc}.{dv}"'
            if origin:
                attrs += f' origin="{origin[0]}.{origin[1]}.{origin[2]}"'
            lines.append(f"<verse {attrs}>{body}</verse>")
        lines.append("</div></osis>")
        with open(os.path.join(OUT_DIR, f"{osis}.xml"), "w", encoding="utf-8") as fh:
            fh.write("\n".join(lines))
    print(f"tglulb: {len(collected)} books, {order} verses, {len(REMAPPED)} remapped, "
          f"{linked} linked duplicates and {placeholders} placeholders dropped")
    print(f"empty KJV slots ({len(empty)}): {' '.join(empty)}")


if __name__ == "__main__":
    main()
