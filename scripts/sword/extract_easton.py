#!/usr/bin/env python3
"""Extract Easton's Bible Dictionary from its SWORD zLD module into easton.json.

The SWORD zLD (compressed lexicon/dictionary) format used here is made of:
  easton.idx  array of 8-byte entries: uint32 offset, uint32 length into easton.dat
  easton.dat  per entry: "<KEY>\r\n" followed by 8 bytes: uint32 block, uint32 indexInBlock
  easton.zdx  array of 8-byte block descriptors: uint32 offset, uint32 compressedSize into easton.zdt
  easton.zdt  zlib-compressed blocks; each decompresses to: uint32 count,
              count * (uint32 offset, uint32 size), then the concatenated TEI entry bodies

Entry bodies are TEI (<entryFree>, <title>, <p>, <foreign>, <ref osisRef="...">). We keep the
display title and the plain-text article (paragraphs joined by blank lines) and drop all markup.

Two files are written, both JSON objects mapping each uppercase lookup key to its data:
  - the shipped asset, {"t": title, "d": definition}
  - a full-fidelity archive in source_files that additionally keeps {"r": [osisRef, ...]},
    the scripture cross-references found in the article (deduped, in order of appearance,
    with the SWORD "Bible:" prefix stripped so they parse as app osisIds)

Usage: python3 scripts/sword/extract_easton.py
"""

import html
import json
import os
import re
import struct
import zlib

ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
MODULE = os.path.join(ROOT, 'source_files/sword/Easton/modules/lexdict/zld/easton')
ASSET_OUTPUT = os.path.join(ROOT, 'assets/dictionary/easton.json')
RAW_OUTPUT = os.path.join(ROOT, 'source_files/dictionary/easton.json')


def read_entries():
    idx = open(os.path.join(MODULE, 'easton.idx'), 'rb').read()
    dat = open(os.path.join(MODULE, 'easton.dat'), 'rb').read()
    zdx = open(os.path.join(MODULE, 'easton.zdx'), 'rb').read()
    zdt = open(os.path.join(MODULE, 'easton.zdt'), 'rb').read()

    blocks = {}

    def block(num):
        if num not in blocks:
            offset, size = struct.unpack_from('<II', zdx, num * 8)
            blocks[num] = zlib.decompress(zdt[offset:offset + size])
        return blocks[num]

    for i in range(len(idx) // 8):
        offset, length = struct.unpack_from('<II', idx, i * 8)
        record = dat[offset:offset + length]
        key = record.split(b'\r\n', 1)[0].decode('utf-8')
        block_num, entry_in_block = struct.unpack_from('<II', record[-8:], 0)
        body = block(block_num)
        entry_offset, entry_size = struct.unpack_from('<II', body, 4 + entry_in_block * 8)
        yield key, body[entry_offset:entry_offset + entry_size].decode('utf-8')


def parse(tei):
    title_match = re.search(r'<title>(.*?)</title>', tei, re.S)
    title = html.unescape(title_match.group(1).strip()) if title_match else ''

    references = []
    for match in re.finditer(r'osisRef="([^"]+)"', tei):
        osis = match.group(1).replace('Bible:', '')
        if osis not in references:
            references.append(osis)

    definition = re.sub(r'<title>.*?</title>', '', tei, flags=re.S)
    definition = re.sub(r'</p>\s*<p[^>]*>', '\n\n', definition)
    definition = re.sub(r'<[^>]+>', '', definition)
    definition = html.unescape(definition)
    definition = re.sub(r'[ \t]+', ' ', definition)
    definition = re.sub(r'\n{3,}', '\n\n', definition).strip()
    return title, definition, references


def main():
    raw = {}
    for key, tei in read_entries():
        title, definition, references = parse(tei)
        if key in raw:
            raw[key]['d'] += '\n\n' + definition
            raw[key]['r'].extend(ref for ref in references if ref not in raw[key]['r'])
        else:
            raw[key] = {'t': title, 'd': definition, 'r': references}

    os.makedirs(os.path.dirname(RAW_OUTPUT), exist_ok=True)
    with open(RAW_OUTPUT, 'w') as f:
        json.dump(raw, f, ensure_ascii=False, indent=2)
    print(f'Wrote {len(raw)} entries to {RAW_OUTPUT}')

    asset = {key: {'t': entry['t'], 'd': entry['d']} for key, entry in raw.items()}
    os.makedirs(os.path.dirname(ASSET_OUTPUT), exist_ok=True)
    with open(ASSET_OUTPUT, 'w') as f:
        json.dump(asset, f, ensure_ascii=False, separators=(',', ':'))
    print(f'Wrote {len(asset)} entries to {ASSET_OUTPUT}')


if __name__ == '__main__':
    main()
