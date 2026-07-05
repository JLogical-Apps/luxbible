import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

Future<void> registerLicenses() async {
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks(['Bitter'], await rootBundle.loadString('fonts/Bitter-OFL.txt'));
    yield LicenseEntryWithLineBreaks(['Lora'], await rootBundle.loadString('fonts/Lora-OFL.txt'));
    yield LicenseEntryWithLineBreaks(['Merriweather'], await rootBundle.loadString('fonts/Merriweather-OFL.txt'));
    yield LicenseEntryWithLineBreaks(['PT Serif'], await rootBundle.loadString('fonts/PTSerif-OFL.txt'));
    yield LicenseEntryWithLineBreaks(['Open Sans'], await rootBundle.loadString('fonts/OpenSans-OFL.txt'));
    yield LicenseEntryWithLineBreaks(['Lato'], await rootBundle.loadString('fonts/Lato-OFL.txt'));
    yield LicenseEntryWithLineBreaks(['OpenDyslexic'], await rootBundle.loadString('fonts/OpenDyslexic-OFL.txt'));
    yield LicenseEntryWithLineBreaks(['Ezra SIL'], await rootBundle.loadString('fonts/EzraSIL-OFL.txt'));

    yield const LicenseEntryWithLineBreaks(
      ['Berean Standard Bible (BSB)'],
      '''
The Holy Bible, Berean Standard Bible, BSB is produced in cooperation with Bible Hub, Discovery Bible, OpenBible.com, and the Berean Bible Translation Committee.

https://berean.bible/''',
    );

    yield const LicenseEntryWithLineBreaks(
      ['King James Version (KJV)'],
      '''
The Holy Bible, King James Version (KJV), 1769.

The King James Version base text is in the public domain in the United States and most of the world. (In the United Kingdom, rights are vested in the Crown.)

Strong's numbers, Greek morphology, and footnotes are taken from the KJV SWORD module of the CrossWire Bible Society, licensed under the GNU General Public License (GPL). Hebrew morphology is derived from the Open Scriptures Hebrew Bible, licensed under Creative Commons Attribution 4.0 (CC BY 4.0).

Source: https://www.crosswire.org''',
    );

    yield const LicenseEntryWithLineBreaks(
      ['American Standard Version (ASV)'],
      '''
The Holy Bible, American Standard Version (ASV), 1901.

The American Standard Version is in the public domain.

Text, paragraph formatting, and footnotes are taken from the ASV SWORD module distributed by the CrossWire Bible Society, sourced from eBible.org.

Source: http://www.ebible.org/bible/asv/''',
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

    yield const LicenseEntryWithLineBreaks(
      ["Easton's Bible Dictionary"],
      '''
Easton's Bible Dictionary.

These dictionary topics are from M.G. Easton M.A., D.D., Illustrated Bible Dictionary, Third Edition, published by Thomas Nelson, 1897. Public Domain — Copy Freely.

Distributed as a SWORD module by CrossWire Bible Society, sourced from the Christian Classics Ethereal Library (CCEL).

Source: https://www.crosswire.org/sword/modules/''',
    );
  });
}
