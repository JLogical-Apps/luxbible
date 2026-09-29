#!/usr/bin/env python3
"""Converts the World English Bible Classic from eBible.org's USFM into per-book USX.

Writes the 66 canonical books to content/sources/bibles/web/. The text is not
changed, since a modified text may not be called the World English Bible. Only
the Strong's word tags are removed: they are machine-assigned and too unreliable
for Lux's study features.

Setup:
  python3 -m venv .tmp/venv && .tmp/venv/bin/pip install usfmtc
  curl -o content/sources/sword/eng-web_usfm.zip https://ebible.org/Scriptures/eng-web_usfm.zip
  unzip content/sources/sword/eng-web_usfm.zip -d content/sources/sword/eng-web_usfm

Run from the repository root:
  .tmp/venv/bin/python tools/content/python/web/prepare_web.py content/sources/sword/eng-web_usfm
"""
import re
import sys
from pathlib import Path

import usfmtc

ROOT = Path(__file__).resolve().parents[4]
OUT_DIR = ROOT / 'content' / 'sources' / 'bibles' / 'web'

BOOKS = (
    'GEN EXO LEV NUM DEU JOS JDG RUT 1SA 2SA 1KI 2KI 1CH 2CH EZR NEH EST JOB PSA PRO ECC SNG ISA JER LAM EZK DAN HOS '
    'JOL AMO OBA JON MIC NAM HAB ZEP HAG ZEC MAL MAT MRK LUK JHN ACT ROM 1CO 2CO GAL EPH PHP COL 1TH 2TH 1TI 2TI TIT '
    'PHM HEB JAS 1PE 2PE 1JN 2JN 3JN JUD REV'
).split()
STRONGS_WORD = re.compile(r'\\(\+?)w (.*?)\|strong="[^"]*"\\\1w\*')


def main(usfm_dir):
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for book in BOOKS:
        [source] = usfm_dir.glob(f'*-{book}eng-web.usfm')
        usfm = STRONGS_WORD.sub(r'\2', source.read_text(encoding='utf-8'))
        if '\\w ' in usfm or '\\+w ' in usfm:
            raise ValueError(f'{book} has a word tag without a Strong\'s number')
        usfmtc.USX.fromUsfm(usfm).saveAs(str(OUT_DIR / f'{book}.usx'))
        print(f'Wrote {book}')


if __name__ == '__main__':
    main(Path(sys.argv[1]))
