#!/usr/bin/env python3
"""Build an interlinear KJV as USX, ready for the app's USX parser.

Original-language data is sourced *directly*, not via the BSB:

  * NT  -> the KJV module already embeds the Textus Receptus layer on each word:
           src="<TR word position>", lemma.TR:<Greek form>, morph="robinson:<code>".
           So position/lemma/morph come straight from the KJV module (== the TR).
  * OT  -> the KJV-versified OSHB (content/sources/bibles/oshb/<Book>.xml). KJV English
           words are matched to OSHB tokens by Strong's number; the token gives the
           Hebrew position, lemma, and morphology.

Both source morphologies (Robinson for Greek, OSHB/Westminster for Hebrew) are
converted to the BibleHub codes that lib/models/morphology.dart understands.

Transliteration is intentionally omitted: neither the KJV module, the TR, nor
OSHB carries it, and borrowing it from the BSB could only be done by fuzzy
matching, which produced some wrong data — so the field is left blank.

Sectioning (words of Christ, pilcrow paragraphs, Psalm titles) comes from the
KJV module; section headings are carried over from the BSB, anchored to the
verse they precede.

Output: one USX file per book in content/sources/bibles/kjv/<USX>.usx.
Run from this directory: .venv/bin/python build_kjv_interlinear.py
"""
import os
import re
import xml.etree.ElementTree as ET
from xml.sax.saxutils import escape, quoteattr

from pysword.modules import SwordModules
from pysword.canons import canons

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", "..", "..", ".."))
KJV_MODULE = os.path.join(ROOT, "content", "sources", "sword", "KJV")
OSHB_DIR = os.path.join(ROOT, "content", "sources", "bibles", "oshb")
BSB_DIR = os.path.join(ROOT, "content", "sources", "bibles", "bsb")
OUT_DIR = os.path.join(ROOT, "content", "sources", "bibles", "kjv")

# (OSIS id, USX code); first 39 are the Old Testament. Mirrors book_type.dart.
OSIS_USX = [
    ("Gen", "GEN"), ("Exod", "EXO"), ("Lev", "LEV"), ("Num", "NUM"), ("Deut", "DEU"),
    ("Josh", "JOS"), ("Judg", "JDG"), ("Ruth", "RUT"), ("1Sam", "1SA"), ("2Sam", "2SA"),
    ("1Kgs", "1KI"), ("2Kgs", "2KI"), ("1Chr", "1CH"), ("2Chr", "2CH"), ("Ezra", "EZR"),
    ("Neh", "NEH"), ("Esth", "EST"), ("Job", "JOB"), ("Ps", "PSA"), ("Prov", "PRO"),
    ("Eccl", "ECC"), ("Song", "SNG"), ("Isa", "ISA"), ("Jer", "JER"), ("Lam", "LAM"),
    ("Ezek", "EZK"), ("Dan", "DAN"), ("Hos", "HOS"), ("Joel", "JOL"), ("Amos", "AMO"),
    ("Obad", "OBA"), ("Jonah", "JON"), ("Mic", "MIC"), ("Nah", "NAM"), ("Hab", "HAB"),
    ("Zeph", "ZEP"), ("Hag", "HAG"), ("Zech", "ZEC"), ("Mal", "MAL"),
    ("Matt", "MAT"), ("Mark", "MRK"), ("Luke", "LUK"), ("John", "JHN"), ("Acts", "ACT"),
    ("Rom", "ROM"), ("1Cor", "1CO"), ("2Cor", "2CO"), ("Gal", "GAL"), ("Eph", "EPH"),
    ("Phil", "PHP"), ("Col", "COL"), ("1Thess", "1TH"), ("2Thess", "2TH"), ("1Tim", "1TI"),
    ("2Tim", "2TI"), ("Titus", "TIT"), ("Phlm", "PHM"), ("Heb", "HEB"), ("Jas", "JAS"),
    ("1Pet", "1PE"), ("2Pet", "2PE"), ("1John", "1JN"), ("2John", "2JN"), ("3John", "3JN"),
    ("Jude", "JUD"), ("Rev", "REV"),
]
OT_OSIS = {osis for osis, _ in OSIS_USX[:39]}

STRONG_RE = re.compile(r"strong:([HG]\d+)")
GREEK_LEMMA_RE = re.compile(r"lemma\.TR:(\S+)")
ROBINSON_RE = re.compile(r"robinson:(\S+)")
DIR_OBJ_MARKER = "H853"
HEADING_STYLES = ("ms", "s1", "s2")


def norm_strong(raw):
    m = re.match(r"([HG])0*(\d+)", raw)
    return m.group(1) + m.group(2) if m else None


def local(tag):
    return tag.split("}")[-1]


# --------------------------------------------------------------------------- #
# Robinson (Greek) -> BibleHub morphology
# --------------------------------------------------------------------------- #

_ROB_SIMPLE = {
    "CONJ": "Conj", "COND": "Conj", "PREP": "Prep", "ADV": "Adv", "INJ": "I",
    "PRT": "Prtcl", "PRT-N": "Adv-NegPrt", "PRT-I": "IntPrtcl", "ARAM": "Heb",
    "HEB": "Heb", "N-PRI": "N", "A-NUI": "Adj", "N-OI": "Indec", "N-LI": "Indec",
}
_ROB_PRON_HEAD = {"P": "PPro", "R": "RelPro", "D": "DPro", "I": "IPro", "X": "IPro",
                  "F": "RefPro", "C": "RecPro", "S": "PPro", "Q": "IPro", "K": "DPro"}


def _reorder_cng_to_cgn(t):
    """Robinson nominal parse 'NSM' (case,number,gender) -> BibleHub 'NMS' (case,gender,number)."""
    return t[0] + t[2] + t[1] if len(t) == 3 else t


def convert_robinson(code):
    if code in _ROB_SIMPLE:
        return _ROB_SIMPLE[code]
    parts = code.split("-")
    head = parts[0]
    rest = parts[1:]

    if head == "ADV":  # -C comparative, -S superlative, -N negative; others plain
        return {"C": "Adv-C", "S": "Adv-S", "N": "Adv-NegPrt"}.get(rest[0] if rest else None, "Adv")
    if head in ("CONJ", "COND"):
        return "Conj"
    if head == "PRT":
        return {"N": "Adv-NegPrt", "I": "IntPrtcl"}.get(rest[0] if rest else None, "Prtcl")

    if head in ("N", "A", "T"):
        bib_head = {"N": "N", "A": "Adj", "T": "Art"}[head]
        if not rest:
            return bib_head
        cgn = _reorder_cng_to_cgn(rest[0])
        tail = "-".join(rest[1:])  # e.g. comparative 'C' / superlative 'S' on adjectives
        out = f"{bib_head}-{cgn}"
        return out + (f"-{tail}" if tail else "")

    if head in _ROB_PRON_HEAD:
        bib_head = _ROB_PRON_HEAD[head]
        if not rest:
            return bib_head
        raw = rest[0]
        if raw and raw[0].isdigit():  # 1st/2nd person: person, case, number (+ gender)
            person, case, number = raw[0], raw[1], raw[2]
            gender = raw[3] if len(raw) > 3 else ""
            return f"{bib_head}-{case}{gender}{person}{number}"
        # 3rd person: case, number, gender  (person 3 implied)
        case, number, gender = raw[0], raw[1] if len(raw) > 1 else "", raw[2] if len(raw) > 2 else ""
        return f"{bib_head}-{case}{gender}3{number}" if gender else f"{bib_head}-{case}{number}"

    if head == "V":
        if not rest:
            return "V"
        tvm = rest[0].lstrip("123")  # drop 2nd-aorist etc. form digit
        tense = tvm[0] if len(tvm) > 0 else ""
        voice = tvm[1] if len(tvm) > 1 else ""
        mood = tvm[2] if len(tvm) > 2 else ""
        voice = {"E": "M", "D": "M", "O": "P", "N": "M"}.get(voice, voice)  # deponents
        bib = f"V-{tense}{mood}{voice}"
        if len(rest) > 1:
            suffix = rest[1]
            # participle carries case-number-gender; finite carries person+number
            bib += "-" + (_reorder_cng_to_cgn(suffix) if mood == "P" else suffix)
        return bib

    return code  # unknown -> shown verbatim by morphology.dart


# --------------------------------------------------------------------------- #
# OSHB / Westminster (Hebrew) -> BibleHub morphology
# --------------------------------------------------------------------------- #

# Stem spelling follows the BSB (Nifal/Hifil/…), which morphology.dart also accepts.
_OSHB_STEM = {"q": "Qal", "N": "Nifal", "p": "Piel", "P": "Pual", "h": "Hifil",
              "H": "Hofal", "t": "Hitpael", "o": "Piel", "r": "Qal"}
_OSHB_ASPECT = {"p": "Perf", "q": "ConjPerf", "i": "Imperf", "w": "ConsecImperf",
                "v": "Imp", "a": "InfAbs", "c": "Inf", "r": "Prtcpl", "s": "Prtcpl",
                "h": "Imperf.Cohort", "j": "Imperf.Jus"}
_OSHB_PARTICLE = {"d": "Art", "o": "DirObjM", "n": "Adv-NegPrt", "i": "IntPrtcl",
                  "m": "Pd", "a": "Adv", "j": "I", "e": "Prtcl", "r": "Pr", "c": "Conj"}
PREP_LETTER = {"ב": "b", "כ": "k", "ל": "l", "מ": "m"}


def _heb_gns(code):
    """OSHB gender/number/state suffix -> BibleHub, e.g. 'fsa'->'fs', 'msc'->'msc', 'bsa'->'cs'."""
    if not code:
        return ""
    gender = {"m": "m", "f": "f", "b": "c", "c": "c"}.get(code[0], "")
    number = code[1] if len(code) > 1 else ""
    state = {"c": "c", "d": "d"}.get(code[2], "") if len(code) > 2 else ""
    return f"{gender}{number}{state}"


def _convert_oshb_morpheme(m, is_prefix, take):
    """`take()` pops the next base consonant of the word so stacked prefixes
    (waw + preposition + article) resolve to the right letters in order."""
    if not m:
        return None
    pos, sub = m[0], m[1:]
    if pos == "R":  # preposition
        if not is_prefix:  # standalone preposition word (e.g. בֵּין), no prefix letter
            return "Prep"
        letter = PREP_LETTER.get(take(), "")
        article = ", Art" if "d" in sub else ""  # assimilated definite article (Rd)
        return (f"Prep-{letter}" if letter else "Prep") + article
    if pos == "C":
        if is_prefix:
            take()
        return "Conj-w"
    if pos == "D":
        return "Adv"
    if pos == "T":
        if sub[:1] == "d":  # definite article prefix
            if is_prefix:
                take()
            return "Art"
        return _OSHB_PARTICLE.get(sub[:1], "Prtcl")
    if pos == "N":
        if sub[:1] == "p":
            return "N-proper"
        gns = _heb_gns(sub[1:])
        return f"N-{gns}" if gns else "N"
    if pos == "A":
        kind, gns = sub[:1], _heb_gns(sub[1:])
        if kind == "c":
            return f"Number-{gns}" if gns else "Number"
        if kind == "o":
            return f"Number-o{gns}" if gns else "Number"
        return f"Adj-{gns}" if gns else "Adj"
    if pos == "V":
        stem = _OSHB_STEM.get(sub[:1], "Qal")
        aspect = _OSHB_ASPECT.get(sub[1:2], "Perf")
        pgn = sub[2:]
        out = f"V-{stem}-{aspect}"
        if pgn:
            out += "-" + (pgn if pgn[0].isdigit() else _heb_gns(pgn))
        return out
    if pos == "P":
        kind, rest = sub[:1], sub[1:]
        head = {"p": "Pro", "d": "DPro", "i": "IPro", "r": "RelPro", "f": "IPro"}.get(kind, "Pro")
        return f"{head}-{rest}" if rest and head in ("Pro", "DPro") else head
    if pos == "S":  # suffix; only the pronominal suffix carries morphology
        return sub[1:] if sub[:1] == "p" else None
    return m


def convert_oshb(code, word_text):
    body = code[1:] if code[:1] in ("H", "A") else code  # strip language marker
    consonants = [c for c in word_text if "א" <= c <= "ת"]
    cursor = [0]

    def take():
        if cursor[0] < len(consonants):
            cursor[0] += 1
            return consonants[cursor[0] - 1]
        return None

    morphemes = body.split("/")
    parts = [
        p for p in (_convert_oshb_morpheme(m, i < len(morphemes) - 1, take) for i, m in enumerate(morphemes)) if p
    ]
    return " | ".join(parts) if parts else code


# --------------------------------------------------------------------------- #
# Source loaders
# --------------------------------------------------------------------------- #

def load_oshb(osis):
    """(chapter, verse) -> ordered OSHB tokens {norms, lemma, morph(BibleHub), position}."""
    path = os.path.join(OSHB_DIR, f"{osis}.xml")
    if not os.path.exists(path):
        return {}
    root = ET.parse(path).getroot()
    out = {}
    for verse in root.iter("verse"):
        parts = (verse.get("osisID") or "").split(".")
        if len(parts) != 3:
            continue
        ch, v = int(parts[1]), int(parts[2])
        words = [e for e in verse.iter() if local(e.tag) == "w"]
        for i, w in enumerate(words):
            hebrew = "".join(w.itertext())
            out.setdefault((ch, v), []).append(
                dict(
                    norms={norm_strong(s) for s in STRONG_RE.findall(w.get("lemma", "") or "")},
                    lemma=hebrew,
                    morph=convert_oshb((w.get("morph", "") or "").replace("oshm:", ""), hebrew),
                    position=i + 1,
                    used=False,
                )
            )
    return out


def load_bsb_headings(usx_code):
    """(chapter, verse) -> ordered [(style, text)] headings appearing before that verse."""
    path = os.path.join(BSB_DIR, f"{usx_code}.usx")
    if not os.path.exists(path):
        return {}
    root = ET.parse(path).getroot()
    headings, pending, ch, v = {}, [], 0, 0
    for el in root.iter():
        tag = local(el.tag)
        if tag == "chapter":
            n = el.get("number")
            ch, v, pending = (int(n) if n and n.isdigit() else ch), 0, []
        elif tag == "para" and el.get("style") in HEADING_STYLES:
            text = "".join(el.itertext()).strip()
            if text:
                pending.append((el.get("style"), text))
        elif tag == "verse":
            n = (el.get("number") or "").split("-")[0]
            v = int(n) if n.isdigit() else v
            if pending:
                headings.setdefault((ch, v), []).extend(pending)
                pending = []
    return headings


# --------------------------------------------------------------------------- #
# KJV module verse parsing
# --------------------------------------------------------------------------- #

def sanitize(body):
    lt, gt = body.rfind("<"), body.rfind(">")
    if lt > gt:
        body = body[:lt]
    try:
        ET.fromstring(f"<v>{body}</v>")
        return body
    except ET.ParseError:
        return re.sub(r"<[^>]*>", "", body).replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")


def convert_note(elem):
    """Convert an OSIS <note> into a USX <note style="f"> footnote the app parses.
    The reading (<rdg>: literal/alternate) becomes an italic run; a <reference> is
    kept as the (parser-skipped) fr caller; everything else is plain footnote text."""
    parts = []

    def add(text, style):
        if text and text.strip():
            parts.append(f'<char style="{style}">{escape(text)}</char>')

    def walk(node):
        tag = local(node.tag)
        if tag == "catchWord":
            return add("".join(node.itertext()), "ft")
        if tag == "rdg":
            return add("".join(node.itertext()), "fqa")
        if tag == "reference":
            return add("".join(node.itertext()), "fr")
        if node.text:
            add(node.text, "ft")
        for child in node:
            walk(child)
            if child.tail:
                add(child.tail, "ft")

    if elem.text:
        add(elem.text, "ft")
    for child in elem:
        walk(child)
        if child.tail:
            add(child.tail, "ft")
    inner = "".join(parts)
    return f'<note style="f" caller="+">{inner}</note>' if inner else ""


def parse_verse(body):
    """Flatten a KJV OSIS verse into ordered pieces. A "word" piece carries its
    English text plus the raw tags needed downstream (Strong's for OT alignment;
    src / Greek lemma / Robinson morph for the NT's embedded TR layer)."""
    pieces = []

    def walk(elem, red):
        tag = local(elem.tag)
        if tag == "note":
            note = convert_note(elem)
            if note:
                pieces.append(("note", note))
            return
        if tag == "w":
            # Untranslated words (self-closing <w src=.../>) are kept too, so they
            # can become empty interlinear tiles like the BSB's.
            lemma = elem.get("lemma", "") or ""
            pieces.append(("word", dict(
                text="".join(elem.itertext()),
                strongs=STRONG_RE.findall(lemma),
                greeks=GREEK_LEMMA_RE.findall(lemma),
                morphs=ROBINSON_RE.findall(elem.get("morph", "") or ""),
                srcs=(elem.get("src") or "").split(),
                red=red,
            )))
            return
        if tag == "milestone":
            if (elem.get("type", "") or "").startswith("x-p") or elem.get("marker") == "¶":
                pieces.append(("break",))
            return
        if tag == "title":
            title = "".join(elem.itertext()).strip()
            if title:
                pieces.append(("title", title))
            return
        if tag == "transChange":
            pieces.append(("text", "".join(elem.itertext()), red))
            return
        red = red or (tag == "q" and "jesus" in (elem.get("who") or "").lower())
        if elem.text:
            pieces.append(("text", elem.text, red))
        for child in elem:
            walk(child, red)
            if child.tail:
                pieces.append(("text", child.tail, red))

    root = ET.fromstring(f"<v>{sanitize(body)}</v>")
    if root.text:
        pieces.append(("text", root.text, False))
    for child in root:
        walk(child, False)
        if child.tail:
            pieces.append(("text", child.tail, False))
    return pieces


# --------------------------------------------------------------------------- #
# Per-word interlinear resolution
# --------------------------------------------------------------------------- #

def resolve_ot(word, oshb):
    """Claim an OSHB token (by Strong's) for each of the KJV word's Strong's numbers,
    so untranslated particles (the direct-object marker אֵת, etc.) are consumed too.
    Returns tiles sorted by original position; the content word is flagged primary
    (it carries the English), the rest are empty particle tiles — like the BSB."""
    norms = [n for n in (norm_strong(s) for s in word["strongs"]) if n]
    if not norms:
        return []
    content = {n for n in norms if n != DIR_OBJ_MARKER} or set(norms)
    claimed = []
    for n in norms:
        tok = next((t for t in oshb if not t["used"] and n in t["norms"]), None)
        if tok:
            tok["used"] = True
            claimed.append((n, tok))
    if not claimed:
        return []
    primary_i = next((i for i, (n, _) in enumerate(claimed) if n in content), 0)
    tiles = [
        dict(strong=n, position=t["position"], lemma=t["lemma"], morph=t["morph"], primary=(i == primary_i))
        for i, (n, t) in enumerate(claimed)
    ]
    tiles.sort(key=lambda d: d["position"])
    return tiles


def resolve_nt(word):
    """Emit a tile for every TR word folded into this KJV word (positions from src).
    The content word (non-article) carries the English; Greek articles and other
    untranslated words become empty tiles — like the BSB."""
    n = max(len(word["strongs"]), len(word["greeks"]), len(word["morphs"]), len(word["srcs"]))

    def at(seq, i):
        return seq[i] if i < len(seq) else None

    tiles = []
    for i in range(n):
        src = at(word["srcs"], i)
        if not (src and src.isdigit()):
            continue
        morph = at(word["morphs"], i)
        tiles.append(dict(
            strong=norm_strong(at(word["strongs"], i) or ""),
            position=int(src),
            lemma=at(word["greeks"], i),
            morph=convert_robinson(morph) if morph else None,
            primary=False,
        ))
    if not tiles:
        return []
    primary_i = next((i for i, t in enumerate(tiles) if not (t["morph"] or "").startswith("Art")), 0)
    tiles[primary_i]["primary"] = True
    tiles.sort(key=lambda d: d["position"])
    return tiles


def char_xml(text, data):
    # The USX parser (and InterlinearData) require an original position; a word
    # without one cannot be an interlinear tile, so it degrades to plain text.
    if data is None or data["position"] is None:
        return escape(text)
    attrs = ["style=\"w\""]
    if data["strong"]:
        attrs.append(f"strong={quoteattr(data['strong'])}")
    attrs.append(f'x-position={quoteattr(str(data["position"]))}')
    if data["lemma"]:
        attrs.append(f"x-lemma={quoteattr(data['lemma'])}")
    if data["morph"]:
        attrs.append(f"x-morph={quoteattr(data['morph'])}")
    return f"<char {' '.join(attrs)}>{escape(text)}</char>"


# --------------------------------------------------------------------------- #
# Book assembly
# --------------------------------------------------------------------------- #

def build_book(bible, book_name, chapters, osis, usx_code):
    is_ot = osis in OT_OSIS
    oshb = load_oshb(osis) if is_ot else {}
    headings = load_bsb_headings(usx_code)
    out = ['<?xml version="1.0" encoding="UTF-8"?>', f'<usx version="3.1"><book style="id" code="{usx_code}">KJV</book>']
    stats = dict(words=0, matched=0, tiles=0, empty=0, headings=0, notes=0)
    buf = []

    def flush_para():
        if buf:
            out.append(f'<para style="p">{"".join(buf)}</para>')
            buf.clear()

    for ch in range(1, len(chapters) + 1):
        flush_para()
        out.append(f'<chapter number="{ch}" style="c"/>')
        for v in range(1, chapters[ch - 1] + 1):
            try:
                body = bible.get(books=[book_name], chapters=[ch], verses=[v], clean=False)
            except Exception:
                continue
            if not body or not body.strip():
                continue
            pieces = parse_verse(body.strip())
            verse_oshb = oshb.get((ch, v), [])

            for style, text in headings.get((ch, v), []):
                flush_para()
                out.append(f'<para style="{style}">{escape(text)}</para>')
                stats["headings"] += 1

            # Build the verse as ordered items so untranslated original words can be
            # inserted at their position: ("tile", pos, frag) | ("raw", frag) |
            # ("break",) | ("title", text).
            vitems = [("raw", f'<verse style="v" number="{v}"/>')]
            claimed = set()

            def red_wrap(frag, red):
                return f'<char style="wj">{frag}</char>' if red else frag

            for piece in pieces:
                kind = piece[0]
                if kind == "break":
                    vitems.append(("break",))
                elif kind == "note":
                    vitems.append(("raw", piece[1]))
                    stats["notes"] += 1
                elif kind == "title":
                    vitems.append(("title", piece[1]))
                elif kind == "text":
                    text = re.sub(r"\s+", " ", piece[1])
                    if text:
                        vitems.append(("raw", red_wrap(escape(text), piece[2])))
                elif kind == "word":
                    word = piece[1]
                    tiles = resolve_ot(word, verse_oshb) if is_ot else resolve_nt(word)
                    if word["text"].strip():
                        stats["words"] += 1
                        if tiles:
                            stats["matched"] += 1
                    if not tiles:
                        if word["text"]:
                            vitems.append(("raw", red_wrap(escape(word["text"]), word["red"])))
                        continue
                    for tile in tiles:
                        text = word["text"] if tile["primary"] else ""
                        claimed.add(tile["position"])
                        stats["tiles"] += 1
                        if not text.strip():
                            stats["empty"] += 1
                        vitems.append(("tile", tile["position"], red_wrap(char_xml(text, tile), word["red"])))

            # OSHB backbone: every Hebrew word gets a tile, so the forward interlinear
            # matches OSHB word-for-word. Words the KJV never tagged become empty tiles,
            # inserted before the first higher-position tile.
            if is_ot:
                for tok in verse_oshb:
                    if tok["position"] in claimed:
                        continue
                    frag = char_xml("", dict(
                        strong=next(iter(sorted(tok["norms"])), None),
                        position=tok["position"], lemma=tok["lemma"], morph=tok["morph"],
                    ))
                    idx = next((i for i, it in enumerate(vitems) if it[0] == "tile" and it[1] > tok["position"]), len(vitems))
                    vitems.insert(idx, ("tile", tok["position"], frag))
                    stats["tiles"] += 1
                    stats["empty"] += 1

            for it in vitems:
                if it[0] == "break":
                    flush_para()
                elif it[0] == "title":
                    flush_para()
                    out.append(f'<para style="d">{escape(it[1])}</para>')
                else:
                    buf.append(it[2] if it[0] == "tile" else it[1])
        flush_para()

    out.append("</usx>")
    with open(os.path.join(OUT_DIR, f"{usx_code}.usx"), "w", encoding="utf-8") as fh:
        fh.write("\n".join(out))
    return stats


def main():
    os.makedirs(OUT_DIR, exist_ok=True)
    for f in os.listdir(OUT_DIR):
        os.remove(os.path.join(OUT_DIR, f))

    sm = SwordModules(KJV_MODULE)
    bible = sm.get_bible_from_module(list(sm.parse_modules().keys())[0])
    entry_by_osis = {b[1]: b for b in canons["kjv"]["ot"] + canons["kjv"]["nt"]}

    totals = dict(words=0, matched=0, tiles=0, empty=0, headings=0, notes=0)
    for osis, usx_code in OSIS_USX:
        entry = entry_by_osis[osis]
        stats = build_book(bible, entry[0], entry[3], osis, usx_code)
        for k in totals:
            totals[k] += stats[k]
        pct = 100 * stats["matched"] / stats["words"] if stats["words"] else 0
        print(f"{usx_code:4s} {osis:6s}: {stats['matched']:6d}/{stats['words']:6d} words aligned ({pct:5.1f}%), "
              f"{stats['tiles']:6d} tiles ({stats['empty']:5d} empty), {stats['headings']:3d} headings")

    pct = 100 * totals["matched"] / totals["words"] if totals["words"] else 0
    print(f"\nTOTAL: {totals['matched']}/{totals['words']} translated words aligned ({pct:.1f}%)")
    print(f"       {totals['tiles']} interlinear tiles ({totals['empty']} untranslated/empty, like the BSB)")
    print(f"       {totals['headings']} section headings carried over from the BSB")
    print(f"       {totals['notes']} footnotes from the KJV module")


if __name__ == "__main__":
    main()
