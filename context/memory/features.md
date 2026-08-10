# Feature Specification

Lux Memory currently provides an early local passage library and practice shell using the BSB.

Users can add passages from topical packs or find a passage directly in the Bible. Find in Bible opens a sheet with blank book and chapter fields. The Bible selector is hidden while BSB is the only bundled translation. After choosing a chapter, the sheet displays that chapter without Bible toolbars or adjacent-chapter swiping.

Tapping a verse selects and underlines it. Additional taps use the same anchored range-selection behavior as Lux Bible. Confirming returns the selected range to Add Passages, where an exactly identical passage is ignored while overlapping or adjacent ranges remain distinct.

The library lists added passages. Users can open a passage for reading, remove it, or begin one of the current prototype practice activities.

The ideas being considered are documented in [`roadmap.md`](roadmap.md). Move behavior into this file only after it exists in the working tree and is intended for an upcoming release.
