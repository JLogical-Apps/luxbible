#!/usr/bin/env python3
"""Stage 1 for the Russian Synodal Bible (1876).

Reads the RusSynodal SWORD module from content/sources/sword/RusSynodal/ and
writes one faithful per-book OSIS XML file into content/sources/bibles/synodal/.

The module is Synodal-versified, so all versification work happens here and the
Dart stage never touches it:
  * Psalms : the Synodal psalter follows the Greek numbering (Ps 9 holds Hebrew
             9+10, 113 holds 114+115, 146+147 collapse to 147), so it takes the
             same regrouping the LXX extraction uses. Superscriptions are
             numbered verses in Synodal but unnumbered in KJV, so the surplus
             leading verses of a psalm fold into its first KJV slot.
  * Other  : 49 of the 66 books already carry KJV chapter lengths, so they map
             through unchanged. The 17 that diverge do so at a handful of known
             chapter boundaries (Job 39-41, Dan 3-4, Jonah 1-2, Rom 14/16, ...),
             listed verse-exactly in SEGMENTS below.
  * The deuterocanon (Dan 3:24-90, Susanna, Bel, Ps 151) and the Septuagint
     pluses in Joshua, Proverbs and Numbers have no KJV home and are dropped;
     Lux carries the 66-book canon.

Each <verse> carries osisID="<KJV destination>" and, when the source verse
differs, origin="<native Synodal reference>".

Run from the repository root: python3 tools/content/python/sword/extract_synodal.py
"""
import os
import re
import xml.etree.ElementTree as ET

from pysword.modules import SwordModules
from pysword.canons import canons

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", "..", "..", ".."))
OUT_DIR = os.path.join(ROOT, "content", "sources", "bibles", "synodal")
MODULE_DIR = os.path.join(ROOT, "content", "sources", "sword", "RusSynodal")
REPORT_PATH = os.path.join(HERE, "data", "synodal_discrepancies.txt")

OT_OSIS = [
    "Gen", "Exod", "Lev", "Num", "Deut", "Josh", "Judg", "Ruth", "1Sam", "2Sam",
    "1Kgs", "2Kgs", "1Chr", "2Chr", "Ezra", "Neh", "Esth", "Job", "Ps", "Prov",
    "Eccl", "Song", "Isa", "Jer", "Lam", "Ezek", "Dan", "Hos", "Joel", "Amos",
    "Obad", "Jonah", "Mic", "Nah", "Hab", "Zeph", "Hag", "Zech", "Mal",
]
NT_OSIS = [
    "Matt", "Mark", "Luke", "John", "Acts", "Rom", "1Cor", "2Cor", "Gal", "Eph",
    "Phil", "Col", "1Thess", "2Thess", "1Tim", "2Tim", "Titus", "Phlm", "Heb",
    "Jas", "1Pet", "2Pet", "1John", "2John", "3John", "Jude", "Rev",
]

KJV_VERSES = {b[1]: b[3] for b in canons["kjv"]["ot"] + canons["kjv"]["nt"]}
SYNODAL = {b[1]: b for b in canons["synodal"]["ot"] + canons["synodal"]["nt"]}



def sanitize_osis(body):
    """Guarantee a well-formed OSIS fragment.

    SWORD's ztext format stores verse length in 16 bits, so an oversized verse
    can come back truncated mid-tag. Trim any dangling partial tag; if it still
    won't parse, fall back to escaped plain text.
    """
    lt, gt = body.rfind("<"), body.rfind(">")
    if lt > gt:
        body = body[:lt]
    try:
        ET.fromstring(f"<v>{body}</v>")
        return body
    except ET.ParseError:
        text = re.sub(r"<[^>]*>", "", body)
        return text.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")


# Synodal -> KJV for the chapter boundaries where the two versifications part.
# ((syn_chapter, first_verse, last_verse), (kjv_chapter, first_kjv_verse));
# anything not listed for a book maps straight through.
SEGMENTS = {
    "Num": [((13, 1, 1), (12, 16)), ((13, 2, 34), (13, 1)),
            ((30, 1, 1), (29, 40)), ((30, 2, 17), (30, 1))],
    "Josh": [((5, 16, 16), (6, 1)), ((6, 1, 26), (6, 2))],
    "1Sam": [((20, 43, 43), (20, 42)),
             ((24, 1, 1), (23, 29)), ((24, 2, 23), (24, 1))],
    "Job": [((39, 31, 35), (40, 1)), ((40, 1, 19), (40, 6)),
            ((40, 20, 27), (41, 1)), ((41, 1, 26), (41, 9))],
    "Eccl": [((4, 17, 17), (5, 1)), ((5, 1, 19), (5, 2))],
    "Song": [((7, 1, 1), (6, 13)), ((7, 2, 14), (7, 1))],
    "Dan": [((3, 91, 97), (3, 24)), ((3, 98, 100), (4, 1)), ((4, 1, 34), (4, 4))],
    "Hos": [((14, 1, 1), (13, 16)), ((14, 2, 10), (14, 1))],
    "Jonah": [((2, 1, 1), (1, 17)), ((2, 2, 11), (2, 1))],
    "Rom": [((14, 24, 26), (16, 25))],
    "3John": [((1, 15, 15), (1, 14))],
}

# Septuagint and deuterocanonical material with no KJV home.
DROPPED = {
    "Josh": [(24, 34, 36)],
    "Prov": [(4, 28, 29), (13, 26, 26), (18, 25, 25)],
    "Dan": [(3, 24, 90), (13, 1, 64), (14, 1, 42)],
}


def in_ranges(ranges, ch, v):
    return any(c == ch and lo <= v <= hi for c, lo, hi in ranges)


def build_psalm_map(syn_ps, kjv_ps):
    """Synodal (Greek-numbered) -> KJV Psalm verse map."""
    groups = [([c], [c]) for c in range(1, 9)]
    groups.append(([9], [9, 10]))
    groups += [([c], [c + 1]) for c in range(10, 113)]
    groups.append(([113], [114, 115]))
    groups.append(([114, 115], [116]))
    groups += [([c], [c + 1]) for c in range(116, 146)]
    groups.append(([146, 147], [147]))
    groups += [([c], [c]) for c in range(148, 151)]
    pmap = {}
    for syn_chs, kjv_chs in groups:
        syn_verses = [(c, v) for c in syn_chs for v in range(1, syn_ps[c - 1] + 1)]
        kjv_slots = [(c, v) for c in kjv_chs for v in range(1, kjv_ps[c - 1] + 1)]
        surplus = max(0, len(syn_verses) - len(kjv_slots))
        for i, sv in enumerate(syn_verses):
            pmap[sv] = kjv_slots[min(max(0, i - surplus), len(kjv_slots) - 1)]
    return pmap


def main():
    psalm_map = build_psalm_map(SYNODAL["Ps"][3], KJV_VERSES["Ps"])

    sm = SwordModules(MODULE_DIR)
    sm.parse_modules()
    bible = sm.get_bible_from_module("RusSynodal")

    def resolve(osis, ch, v):
        """Return (dest, method); dest is None when there is no KJV home."""
        if in_ranges(DROPPED.get(osis, []), ch, v):
            return None, "dropped"
        if osis == "Ps":
            dest = psalm_map.get((ch, v))
            return (("Ps",) + dest if dest else None), "psalm"
        for (sc, lo, hi), (kc, kv) in SEGMENTS.get(osis, []):
            if sc == ch and lo <= v <= hi:
                return (osis, kc, kv + v - lo), "segment"
        return (osis, ch, v), "identity"

    collected = {}
    report = {}
    order = remapped = dropped = 0
    for osis in OT_OSIS + NT_OSIS:
        entry = SYNODAL[osis]
        book_name, verse_counts = entry[0], entry[3]
        rep = report.setdefault(osis, dict(total=0, identity=0, psalm=0, segment=0, dropped=0, dropped_refs=[], dest_sources={}))
        for ch in range(1, len(verse_counts) + 1):
            for v in range(1, verse_counts[ch - 1] + 1):
                try:
                    body = bible.get(books=[book_name], chapters=[ch], verses=[v], clean=False)
                except Exception:
                    continue
                if body is None or not body.strip():
                    continue
                body = sanitize_osis(body.strip())
                native = (osis, ch, v)
                dest, method = resolve(osis, ch, v)
                rep["total"] += 1
                db, dc, dv = dest if dest else (None, None, None)
                if dest is None or db not in KJV_VERSES or not (1 <= dc <= len(KJV_VERSES[db])) \
                        or not (1 <= dv <= KJV_VERSES[db][dc - 1]):
                    rep["dropped"] += 1
                    rep["dropped_refs"].append(f"{ch}:{v}")
                    dropped += 1
                    continue
                rep[method] += 1
                rep["dest_sources"].setdefault((dc, dv), set()).add(ch)
                if dest != native:
                    remapped += 1
                order += 1
                collected.setdefault(db, []).append((dc, dv, native if dest != native else None, body, order))

    os.makedirs(OUT_DIR, exist_ok=True)
    for f in os.listdir(OUT_DIR):
        os.remove(os.path.join(OUT_DIR, f))
    for db, rows in collected.items():
        rows.sort(key=lambda r: (r[0], r[1], r[4]))
        lines = ['<?xml version="1.0" encoding="UTF-8"?>', f'<osis><div type="book" osisID="{db}">']
        for dc, dv, origin, body, _ in rows:
            attrs = f'osisID="{db}.{dc}.{dv}"'
            if origin:
                attrs += f' origin="{origin[0]}.{origin[1]}.{origin[2]}"'
            lines.append(f"<verse {attrs}>{body}</verse>")
        lines.append("</div></osis>")
        with open(os.path.join(OUT_DIR, f"{db}.xml"), "w", encoding="utf-8") as fh:
            fh.write("\n".join(lines))
    print(f"synodal: {len(collected)} books, {order} verses, {remapped} remapped, {dropped} dropped")
    write_report(report)


def write_report(report):
    lines = ["Synodal -> KJV mapping discrepancy report", "=" * 60, "",
             "Built from: the Greek/Synodal Psalm regrouping + the explicit chapter",
             "boundary segments in SEGMENTS + identity. The items below are where",
             "the Synodal versification has no clean KJV home.", "", ""]
    total_dropped = total_merge = 0
    for osis, rep in report.items():
        cross = {d: chs for d, chs in rep["dest_sources"].items() if len(chs) > 1}
        oob = rep["dropped_refs"]
        if not oob and not cross:
            continue
        total_dropped += len(oob)
        total_merge += len(cross)
        lines.append(f"## {osis}  (total {rep['total']}: {rep['identity']} identity, "
                     f"{rep['segment']} segment-shift, {rep['psalm']} psalm)")
        if oob:
            lines.append(f"  DROPPED, no KJV verse exists [{len(oob)}]: "
                         + ", ".join(oob[:40]) + (" ..." if len(oob) > 40 else ""))
        if cross:
            items = [f"{c}:{v}<-SynCh{sorted(chs)}" for (c, v), chs in sorted(cross.items())]
            lines.append(f"  RESIDUAL MERGES (KJV verse holds text from >1 Synodal chapter) [{len(items)}]: "
                         + ", ".join(items[:40]) + (" ..." if len(items) > 40 else ""))
        lines.append("")
    lines[6] = f"SUMMARY: {total_dropped} dropped (no KJV home), {total_merge} residual cross-chapter merges."
    os.makedirs(os.path.dirname(REPORT_PATH), exist_ok=True)
    with open(REPORT_PATH, "w", encoding="utf-8") as fh:
        fh.write("\n".join(lines))
    print(f"report -> {REPORT_PATH}")
    print(f"  {total_dropped} dropped (no KJV home), {total_merge} residual merges")


if __name__ == "__main__":
    main()
