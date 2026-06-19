#!/usr/bin/env python3
"""Stage 1 of the original-language pipeline.

Reads the five SWORD modules from ../source_files/sword/<MODULE>/ and writes one
faithful per-book OSIS XML file per translation into ../source_files/bibles/<name>/.

All versification work happens here so the Dart stage never touches it:
  * OSHB  (MT)  -> KJV via the module's own inline <note>KJV:Bk.Ch.Vs</note>
  * TR/Byz/SR   (KJV) -> identity
  * LXX   (LXX) -> KJV, best-effort:
      - Psalms   : the standard LXX/KJV psalm regrouping (build_psalm_map)
      - Jeremiah and other books that share MT's chapter boundaries against KJV:
        the MT->KJV map harvested from OSHB's notes (handles e.g. Gen 31:55 <- 32:1)
      - remaining LXX-specific shifts: STEPBible TVTMS 'Greek' rules
      - everything else: identity

Each <verse> carries osisID="<KJV destination>" and, when the source verse
differs, origin="<native reference>".

Run from the scripts/sword/ directory:  .venv/bin/python extract_sword.py
"""
import os
import re
import xml.etree.ElementTree as ET

from pysword.modules import SwordModules
from pysword.canons import canons

HERE = os.path.dirname(os.path.abspath(__file__))
OUT_ROOT = os.path.join(HERE, "..", "..", "source_files", "bibles")
SWORD_ROOT = os.path.join(HERE, "..", "..", "source_files", "sword")
TVTMS_PATH = os.path.join(HERE, "data", "TVTMS.txt")

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

MODULES = {
    "oshb":       dict(path="OSHB",       canon="mt",  books=OT_OSIS, mode="oshb"),
    "tr":         dict(path="TR",         canon="kjv", books=NT_OSIS, mode="kjv"),
    "byz":        dict(path="Byz",        canon="kjv", books=NT_OSIS, mode="kjv"),
    "statresgnt": dict(path="StatResGNT", canon="kjv", books=NT_OSIS, mode="kjv"),
    "lxx":        dict(path="LXX",        canon="lxx", books=OT_OSIS, mode="lxx"),
}

# STEPBible/Tyndale book codes -> OSIS, for the protestant OT (used by the LXX map).
TVTMS_TO_OSIS = {
    "Gen": "Gen", "Exo": "Exod", "Lev": "Lev", "Num": "Num", "Deu": "Deut",
    "Jos": "Josh", "Jdg": "Judg", "Rut": "Ruth", "1Sa": "1Sam", "2Sa": "2Sam",
    "1Ki": "1Kgs", "2Ki": "2Kgs", "1Ch": "1Chr", "2Ch": "2Chr", "Ezr": "Ezra",
    "Neh": "Neh", "Est": "Esth", "Job": "Job", "Psa": "Ps", "Pro": "Prov",
    "Ecc": "Eccl", "Sng": "Song", "Isa": "Isa", "Jer": "Jer", "Lam": "Lam",
    "Ezk": "Ezek", "Dan": "Dan", "Hos": "Hos", "Jol": "Joel", "Amo": "Amos",
    "Oba": "Obad", "Jon": "Jonah", "Mic": "Mic", "Nam": "Nah", "Hab": "Hab",
    "Zep": "Zeph", "Hag": "Hag", "Zec": "Zech", "Mal": "Mal",
}

KJV_VERSES = {b[1]: b[3] for b in canons["kjv"]["ot"] + canons["kjv"]["nt"]}

OSHB_KJV_NOTE = re.compile(r"<note>KJV:([1-3]?[A-Za-z]+)\.(\d+)\.(\d+)</note>")


def sanitize_osis(body):
    """Guarantee a well-formed OSIS fragment.

    SWORD's ztext format stores verse length in 16 bits, so verses over 65535
    bytes (e.g. the LXX 1Kgs 12:24 Jeroboam supplement) come back truncated
    mid-tag. Trim any dangling partial tag; if it still won't parse, fall back
    to escaped plain text.
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


def parse_tvtms_ref(token):
    """'Jer.37:1', 'Psa.13:Title', 'Gen.5:32; 6:1', 'Exo.28:29!a' -> (osis, ch, v) or None."""
    token = token.strip()
    if not token:
        return None
    token = re.split(r"[;\-]", token)[0].strip().split("!")[0].strip()
    m = re.match(r"^([1-4]?[A-Za-z]+)\.(\d+):(.+)$", token)
    if not m:
        return None
    code, ch, verse = m.group(1), int(m.group(2)), m.group(3).strip()
    osis = TVTMS_TO_OSIS.get(code)
    if osis is None:
        return None
    digits = re.match(r"\d+", verse)
    v = 1 if verse.lower().startswith("title") else (int(digits.group(0)) if digits else None)
    return (osis, ch, v) if v is not None else None


def load_lxx_map():
    """LXX->KJV verse rules from TVTMS Greek traditions (plain 'Greek' wins; the
    variants fill gaps). Psalms are handled separately by build_psalm_map."""
    rows = {"Greek": [], "other": []}
    with open(TVTMS_PATH, encoding="utf-8-sig") as f:
        for line in f:
            fields = line.rstrip("\n").split("\t")
            if len(fields) < 3 or not fields[0].startswith("Greek"):
                continue
            src = parse_tvtms_ref(fields[1])
            dst = parse_tvtms_ref(fields[2])
            if src is None or dst is None or src[0] == "Ps":
                continue
            rows["Greek" if fields[0] == "Greek" else "other"].append((src, dst))
    mapping = {}
    for src, dst in rows["Greek"] + rows["other"]:
        mapping.setdefault(src, dst)
    return mapping


def build_psalm_map(lxx_ps, kjv_ps):
    """Complete LXX->KJV Psalm verse map via the standard psalm regrouping."""
    groups = []
    for c in range(1, 9):
        groups.append(([c], [c]))
    groups.append(([9], [9, 10]))
    for c in range(10, 113):
        groups.append(([c], [c + 1]))
    groups.append(([113], [114, 115]))
    groups.append(([114, 115], [116]))
    for c in range(116, 146):
        groups.append(([c], [c + 1]))
    groups.append(([146, 147], [147]))
    for c in range(148, 151):
        groups.append(([c], [c]))
    pmap = {}
    for lxx_chs, kjv_chs in groups:
        lxx_verses = [(c, v) for c in lxx_chs for v in range(1, lxx_ps[c - 1] + 1)]
        kjv_slots = [(c, v) for c in kjv_chs for v in range(1, kjv_ps[c - 1] + 1)]
        surplus = max(0, len(lxx_verses) - len(kjv_slots))
        for i, lv in enumerate(lxx_verses):
            pmap[lv] = kjv_slots[min(max(0, i - surplus), len(kjv_slots) - 1)]
    return pmap


def main():
    lxx_map = load_lxx_map()
    psalm_map = build_psalm_map({b[1]: b[3] for b in canons["lxx"]["ot"]}["Ps"], KJV_VERSES["Ps"])
    mt_to_kjv = {}  # MT ref -> KJV ref, harvested from OSHB's inline notes (OSHB runs first)
    lxx_report = {}

    def resolve_lxx(osis, ch, v):
        """Return (dest, method). dest is None when there is no KJV home."""
        if osis == "Ps":
            d = psalm_map.get((ch, v))
            return ((("Ps",) + d) if d else None), "psalm"
        native = (osis, ch, v)
        if native in mt_to_kjv:  # MT/KJV boundary shift shared by the LXX
            return mt_to_kjv[native], "mt"
        if native in lxx_map:    # LXX-specific shift (Jeremiah reorder, etc.)
            return lxx_map[native], "tvtms"
        return native, "identity"

    for name, cfg in MODULES.items():
        sm = SwordModules(os.path.join(SWORD_ROOT, cfg["path"]))
        bible = sm.get_bible_from_module(list(sm.parse_modules().keys())[0])
        entry_by_osis = {b[1]: b for b in canons[cfg["canon"]]["ot"] + canons[cfg["canon"]]["nt"]}

        collected = {}  # dest_book -> list of (dc, dv, origin|None, body, order, method, native_ch)
        order = remapped = dropped = 0
        for osis in cfg["books"]:
            entry = entry_by_osis.get(osis)
            if entry is None:
                continue
            book_name, verse_counts = entry[0], entry[3]
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
                    method = None
                    if cfg["mode"] == "kjv":
                        dest = native
                    elif cfg["mode"] == "oshb":
                        m = OSHB_KJV_NOTE.search(body)
                        dest = (m.group(1), int(m.group(2)), int(m.group(3))) if m else native
                        if m and dest != native:
                            mt_to_kjv[native] = dest
                    else:  # lxx
                        dest, method = resolve_lxx(osis, ch, v)

                    rep = lxx_report.setdefault(osis, dict(
                        total=0, identity=0, psalm=0, tvtms=0, mt=0,
                        dropped=[], collision_dropped=[], dest_sources={})) if method else None
                    if rep is not None:
                        rep["total"] += 1
                    if dest is None:
                        if rep is not None:
                            rep["dropped"].append(f"{ch}:{v}")
                        dropped += 1
                        continue
                    db, dc, dv = dest
                    if db not in KJV_VERSES or dc < 1 or dc > len(KJV_VERSES[db]) or dv < 1 or dv > KJV_VERSES[db][dc - 1]:
                        if rep is not None:
                            rep["dropped"].append(f"{ch}:{v}")
                        dropped += 1
                        continue
                    if dest != native:
                        remapped += 1
                    order += 1
                    collected.setdefault(db, []).append((dc, dv, native if dest != native else None, body, order, method, ch))

        out_dir = os.path.join(OUT_ROOT, name)
        os.makedirs(out_dir, exist_ok=True)
        for f in os.listdir(out_dir):
            os.remove(os.path.join(out_dir, f))
        for db, rows in collected.items():
            # An authoritative (mt/tvtms) verse wins its KJV slot; a stray identity
            # verse colliding with it is dropped (recorded) rather than merged.
            authoritative = {(r[0], r[1]) for r in rows if r[5] in ("mt", "tvtms")}
            kept = []
            for r in rows:
                dc, dv, _, _, _, method, ch = r
                if method == "identity" and (dc, dv) in authoritative:
                    rep = lxx_report.get(db)
                    if rep is not None:
                        rep["collision_dropped"].append(f"{ch}:{dv}->{dc}:{dv}")
                    dropped += 1
                    continue
                kept.append(r)
                rep = lxx_report.get(db)
                if rep is not None and method:
                    rep[method] += 1
                    rep["dest_sources"].setdefault((dc, dv), set()).add(ch)
            kept.sort(key=lambda r: (r[0], r[1], r[4]))
            lines = ['<?xml version="1.0" encoding="UTF-8"?>', f'<osis><div type="book" osisID="{db}">']
            for dc, dv, origin, body, _, _, _ in kept:
                attrs = f'osisID="{db}.{dc}.{dv}"'
                if origin:
                    attrs += f' origin="{origin[0]}.{origin[1]}.{origin[2]}"'
                lines.append(f"<verse {attrs}>{body}</verse>")
            lines.append("</div></osis>")
            with open(os.path.join(out_dir, f"{db}.xml"), "w", encoding="utf-8") as fh:
                fh.write("\n".join(lines))
        print(f"{name:11s}: {len(collected)} books, {order} verses, {remapped} remapped, {dropped} dropped")

    write_lxx_report(lxx_report)


def write_lxx_report(lxx_report):
    lines = ["LXX -> KJV mapping discrepancy report", "=" * 60, "",
             "Built best-effort from: standard Psalm regrouping + the MT->KJV map",
             "(OSHB notes, for boundary shifts shared with the LXX) + STEPBible TVTMS",
             "'Greek' rules (Jeremiah reorder etc.) + identity. The SWORD LXX is a",
             "'compromise' versification with no authoritative KJV mapping, so the",
             "items below are where this is imperfect.", ""]
    total_dropped = total_collide = total_merge = 0
    for osis, rep in lxx_report.items():
        cross = {d: chs for d, chs in rep["dest_sources"].items() if len(chs) > 1}
        oob, coll = rep["dropped"], rep["collision_dropped"]
        if not oob and not coll and not cross:
            continue
        total_dropped += len(oob)
        total_collide += len(coll)
        total_merge += len(cross)
        lines.append(f"## {osis}  (total {rep['total']}: {rep['identity']} identity, "
                     f"{rep['mt']} mt-shift, {rep['psalm']} psalm, {rep['tvtms']} tvtms)")
        if oob:
            lines.append(f"  DROPPED, no KJV verse exists [{len(oob)}]: "
                         + ", ".join(oob[:40]) + (" ..." if len(oob) > 40 else ""))
        if coll:
            lines.append(f"  DROPPED, identity verse displaced by authoritative mapping [{len(coll)}]: "
                         + ", ".join(coll[:40]) + (" ..." if len(coll) > 40 else ""))
        if cross:
            items = [f"{c}:{v}<-LXXch{sorted(chs)}" for (c, v), chs in sorted(cross.items())]
            lines.append(f"  RESIDUAL MERGES (KJV verse holds text from >1 LXX chapter) [{len(cross)}]: "
                         + ", ".join(items[:40]) + (" ..." if len(items) > 40 else ""))
        lines.append("")
    lines.insert(8, f"SUMMARY: {total_dropped} dropped (no KJV home), {total_collide} dropped "
                    f"(displaced by mapping), {total_merge} residual cross-chapter merges.")
    lines.insert(9, "")
    path = os.path.join(HERE, "data", "lxx_discrepancies.txt")
    with open(path, "w", encoding="utf-8") as fh:
        fh.write("\n".join(lines))
    print(f"\nLXX discrepancy report -> {path}")
    print(f"  {total_dropped} dropped (no KJV home), {total_collide} dropped (displaced), "
          f"{total_merge} residual merges")


if __name__ == "__main__":
    main()
