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

The output is a JSON object mapping each uppercase lookup key to {"t": title, "d": definition}.

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
OUTPUT = os.path.join(ROOT, 'assets/dictionary/easton.json')


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

    definition = re.sub(r'<title>.*?</title>', '', tei, flags=re.S)
    definition = re.sub(r'</p>\s*<p[^>]*>', '\n\n', definition)
    definition = re.sub(r'<[^>]+>', '', definition)
    definition = html.unescape(definition)
    definition = re.sub(r'[ \t]+', ' ', definition)
    definition = re.sub(r'\n{3,}', '\n\n', definition).strip()
    return title, definition


def main():
    entries = {}
    for key, tei in read_entries():
        title, definition = parse(tei)
        if key in entries:
            entries[key]['d'] += '\n\n' + definition
        else:
            entries[key] = {'t': title, 'd': definition}

    os.makedirs(os.path.dirname(OUTPUT), exist_ok=True)
    with open(OUTPUT, 'w') as f:
        json.dump(entries, f, ensure_ascii=False, separators=(',', ':'))
    print(f'Wrote {len(entries)} entries to {OUTPUT}')


if __name__ == '__main__':
    main()
