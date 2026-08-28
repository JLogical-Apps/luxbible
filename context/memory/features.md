# Feature Specification

Lux Memory currently provides an early local passage library and practice shell using the BSB.

Users can add passages from topical packs or find a passage directly in the Bible. Find in Bible opens a sheet with blank book and chapter fields. The Bible selector is hidden while BSB is the only bundled translation. After choosing a chapter, the sheet displays that chapter without Bible toolbars or adjacent-chapter swiping.

Tapping a verse selects and underlines it. Additional taps use the same anchored range-selection behavior as Lux Bible. Confirming returns the selected range to Add Passages, where an exactly identical passage is ignored while overlapping or adjacent ranges remain distinct.

The library lists added passages. Users can open a passage for reading, remove it, or begin one of the current prototype practice activities.

Word Type opens the native keyboard and asks for the first letter of each word in sequence. Words are revealed after a correct letter, while punctuation before a word is visible without being typed. A neighboring QWERTY key is accepted with a brief close-enough message, and other mistakes flash the activity red.

Reference Selection shows the full passage and asks the user to choose its reference from six canonically ordered options. The choices combine the correct book and two other books from the same testament with the correct range and two generated ranges of the same verse length. Each book and range appears twice.

Reference Type shows the full passage with book, chapter, and verse fields. The passage's starting reference is checked only when the user submits the verse field from the keyboard.

The ideas being considered are documented in [`roadmap.md`](roadmap.md). Move behavior into this file only after it exists in the working tree and is intended for an upcoming release.
