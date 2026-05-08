# Translation assets

Each `*.json` file is one Bible translation, minified, encoded as nested objects:

```
{ "<book_key>": { "<chapter>": { "<verse>": <Verse> } } }
```

- `book_key` matches `BookType.tomlKey()` in [book_type.dart](../../lib/models/bible/book_type.dart) — the enum name, except `songOfSolomon` becomes `song_of_solomon`.
- `chapter` and `verse` are stringified positive integers.
- The shape of `<Verse>` differs by translation — see below.

## Two verse formats

### KJV / ASV — plain string

```jsonc
"genesis": { "1": {
  "1": "In the beginning God created the heaven and the earth.",
  "2": "And the earth was without form, and void; ...",
  ...
}}
```

The verse text concatenated as a single string, ready to render. No Strong's, no morphology, no original-language data.

### BSB — fragment array (rich interlinear)

```jsonc
"genesis": { "1": { "1": [
  {"e": "In the beginning ", "s": "H7225", "op": 1, "w": "בְּרֵאשִׁ֖ית", "m": "Prep-b | N-fs"},
  {"e": "God ",              "s": "H430",  "op": 3, "w": "אֱלֹהִ֑ים",     "m": "N-mp"},
  {"e": "- ",                "s": "H853",  "op": 4, "w": "אֵ֥ת",         "m": "DirObjM"},
  {"e": "created ",          "s": "H1254", "op": 2, "w": "בָּרָ֣א",        "m": "V-Qal-Perf-3ms"},
  {"e": "the heavens ",      "s": "H8064", "op": 5, "w": "הַשָּׁמַ֖יִם",   "m": "Art | N-mp"},
  {"e": "and ",              "s": "H853",  "op": 6, "w": "וְאֵ֥ת",         "m": "Conj-w | DirObjM"},
  {"e": "the earth. ",       "s": "H776",  "op": 7, "w": "הָאָֽרֶץ׃",      "m": "Art | N-fs"}
]}}
```

A flat array of fragments in English reading order.

#### Fragment fields

| key | meaning | always present? |
|---|---|---|
| `e` | English text including any trailing space; concatenate fragments to reconstruct verse text | yes |
| `s` | Single Strong's number for this fragment's lemma. Prefix `H` (Hebrew/OT) or `G` (Greek/NT). | usually — omitted on punctuation-only fragments and on Hebrew bound morphemes that have no Strong's lemma (~1.4% of fragments) |
| `op` | 1-based position in the verse's original-language reading order. Sort the verse array by `op` to render the original-order interlinear view. | yes |
| `w` | The inflected original-language surface form as it appears in the verse | yes |
| `m` | Descriptive morphology code, e.g. `V-Qal-Perf-3ms` (verb stem + aspect + person/gender/number) or `Conj-w \| Art \| N-fs`. Particles, prefixes, and suffixes appear before/after the verb segment with `\|` separators. | yes for ~99.93% of fragments — proper nouns and a few edge cases lack `m` |

#### Rendering tips

- **English-order view**: walk the verse array left-to-right and concatenate `e`. The Hebrew root for *created* (`op=2`) appears 4th in English — `op` captures that re-ordering.
- **Original-language interlinear view**: sort fragments by `op` ascending. Every BSB fragment has an `op`, so no filtering is needed.

## Three translations

| file | shape | Strong's? | morphology? | size |
|---|---|---|---|---:|
| `kjv.json` | string per verse | no | no | 4.4 MB |
| `asv.json` | string per verse | no | no | 4.4 MB |
| `bsb.json` | fragment array per verse | yes (`s`) | yes (`m`) | 34 MB |

## Other files in this directory

- [`bsb/`](bsb/) — per-book USX files used by the BSB display renderer (paragraphs, section headings, poetry). Independent of `bsb.json`.

## Sources

- KJV/ASV: plain text only.
- BSB: built from the openbible.com BSB Tables xlsx (`biblosinterlinear96` sheet, ~754k rows).
