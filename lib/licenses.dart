import 'package:flutter/foundation.dart';

Future<void> registerLicenses() async {
  LicenseRegistry.addLicense(() async* {
    yield const LicenseEntryWithLineBreaks(
      ['Berean Standard Bible (BSB)'],
      '''
The Holy Bible, Berean Standard Bible (BSB).

The Berean Bible and Majority Bible texts are officially dedicated to the public domain as of April 30, 2023. Attribution is appreciated but not required.

Suggested attribution: "The Holy Bible, Berean Standard Bible, BSB is produced in cooperation with Bible Hub, Discovery Bible, OpenBible.com, and the Berean Bible Translation Committee."

Source: https://berean.bible/''',
    );

    yield const LicenseEntryWithLineBreaks(
      ['King James Version (KJV)'],
      '''
The Holy Bible, King James Version (KJV).

The King James Version is in the public domain in the United States and most of the world. (In the United Kingdom, rights are vested in the Crown.)''',
    );

    yield const LicenseEntryWithLineBreaks(
      ['American Standard Version (ASV)'],
      '''
The Holy Bible, American Standard Version (ASV), 1901.

The American Standard Version is in the public domain.''',
    );

    yield const LicenseEntryWithLineBreaks(
      ["Matthew Henry's Commentary"],
      '''
Matthew Henry's Commentary on the Whole Bible.

Written by Matthew Henry (1662–1714); first published in 1706. The work is in the public domain.

Obtained from the Christian Classics Ethereal Library (CCEL). CCEL hosts editions based on books that are in the public domain in the United States, made available for personal, educational, or non-profit use.

Source: https://ccel.org/ccel/henry/mhc''',
    );

    yield const LicenseEntryWithLineBreaks(
      ['Cross References'],
      '''
Cross-reference data.

Copyright © OpenBible.info. Licensed under a Creative Commons Attribution License (CC BY 4.0): https://creativecommons.org/licenses/by/4.0/

The dataset is derived from the Treasury of Scripture Knowledge (public domain), with supplementary data from OpenBible.info.

Source: https://www.openbible.info/labs/cross-references/''',
    );

    yield const LicenseEntryWithLineBreaks(
      ["Strong's Greek & Hebrew Dictionaries"],
      '''
Strong's Greek and Hebrew Dictionaries.

Dictionaries of Greek and Hebrew words taken from Strong's Exhaustive Concordance by James Strong, S.T.D., LL.D. (1890). Public Domain — Copy Freely.

Digital editions prepared and corrected by the OpenScriptures project (contributors include Ulrik Petersen, David Troidl, and David Instone-Brewer).

Source: https://github.com/openscriptures/strongs
  - greek/StrongsGreekDictionaryXML_1.4/strongsgreek.xml
  - hebrew/StrongHebrewG.xml''',
    );
  });
}
