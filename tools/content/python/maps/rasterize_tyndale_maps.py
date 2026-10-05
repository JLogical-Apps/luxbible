#!/usr/bin/env python3
"""Rasterizes the Tyndale Open Bible Dictionary map PDFs to grayscale WebP.

Reads every PDF in content/sources/dictionary/tyndale/Maps/artfiles/ and writes
apps/bible/assets/maps/tyndale/<id>.webp, where <id> is the lowercase file name,
matching the ids in content/sources/dictionary/tyndale/maps.json.

Labels are vector and the relief shading is a 250 dpi raster, so pages render at
6x (432 dpi) with a 1600 px floor on the long edge. Small maps then still have
zoom headroom on a phone, and the large overview maps keep their small labels
sharp without upscaling the relief further than needed.

Setup (global pip install is blocked on Homebrew Python):
  python3 -m venv .tmp/maps-venv
  .tmp/maps-venv/bin/pip install pymupdf pillow

Run from the repository root:
  .tmp/maps-venv/bin/python tools/content/python/maps/rasterize_tyndale_maps.py
"""
import glob
import json
import os

import pymupdf
from PIL import Image, ImageOps

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", "..", "..", ".."))
SOURCE_DIR = os.path.join(ROOT, "content", "sources", "dictionary", "tyndale")
OUT_DIR = os.path.join(ROOT, "apps", "bible", "assets", "maps", "tyndale")

ZOOM = 6
MIN_LONG_EDGE = 1600
MARGIN = 8
QUALITY = 75


def rasterize(pdf_path):
    page = pymupdf.open(pdf_path)[0]
    zoom = max(ZOOM, MIN_LONG_EDGE / max(page.rect.width, page.rect.height))
    pixmap = page.get_pixmap(matrix=pymupdf.Matrix(zoom, zoom), colorspace=pymupdf.csGRAY, alpha=False)
    image = Image.frombytes("L", (pixmap.width, pixmap.height), pixmap.samples)
    # Some pages leave white space around the map's frame.
    left, top, right, bottom = ImageOps.invert(image).point(lambda value: 255 if value > 24 else 0).getbbox()
    return image.crop(
        (max(left - MARGIN, 0), max(top - MARGIN, 0), min(right + MARGIN, image.width), min(bottom + MARGIN, image.height))
    )


def main():
    with open(os.path.join(SOURCE_DIR, "maps.json")) as file:
        ids = {entry["id"] for entry in json.load(file)}
    pdf_paths = {os.path.basename(path)[:-4].lower(): path for path in glob.glob(os.path.join(SOURCE_DIR, "Maps", "artfiles", "*.pdf"))}
    if ids != set(pdf_paths):
        raise SystemExit(f"maps.json and the PDFs disagree: {sorted(ids ^ set(pdf_paths))}")

    os.makedirs(OUT_DIR, exist_ok=True)
    total = 0
    for map_id, pdf_path in sorted(pdf_paths.items()):
        out_path = os.path.join(OUT_DIR, f"{map_id}.webp")
        rasterize(pdf_path).save(out_path, "WEBP", quality=QUALITY, method=6)
        total += os.path.getsize(out_path)
    print(f"Wrote {len(pdf_paths)} maps, {total / 1e6:.1f} MB")


if __name__ == "__main__":
    main()
