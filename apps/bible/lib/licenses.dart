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
      ['King James Version (KJV) Audio Bible'],
      '''
Narration by David, retrieved from OpenBible.com.

Source: https://openbible.com/audio/kjv/''',
    );

    yield const LicenseEntryWithLineBreaks(
      ['Berean Standard Bible (BSB) Audio Bible'],
      '''
Narration by Barry Hays, retrieved from Berean Bible.

Source: https://berean.bible/''',
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
      ['Byzantine Textform 2005 (BYZ)'],
      '''
The New Testament in the Original Greek: Byzantine Textform 2005, edited by Maurice A. Robinson and William G. Pierpont.

The editors released the Greek text into the public domain. It may be copied, distributed, stored in a database, incorporated into other works, and otherwise used without restriction. Attribution is retained to identify the edition and responsibility for the text. Lux's use does not imply the editors' or publisher's agreement with Lux's views.

Lux converts the official one-verse-per-line ASCII edition to unaccented lowercase Unicode Greek and its bundled Bible data format.

Sources:
https://byzantinetext.com/study/editions/robinson-pierpont/
https://www.dropbox.com/s/oil2m3la4vsnbpb/editions-rp2-ascii.zip?dl=0''',
    );

    yield const LicenseEntryWithLineBreaks(
      ['Statenvertaling (SV)'],
      '''
The Holy Bible, Statenvertaling, 1637.

The Statenvertaling is in the public domain.

Text obtained from the DutSVV SWORD module distributed by the CrossWire Bible Society. CrossWire's module is based on the electronic edition from Statenvertaling online. Lux transforms the module into its bundled Bible data format.

Sources:
https://www.crosswire.org/sword/modules/ModInfo.jsp?modName=DutSVV
https://bijbel.coas.nl/''',
    );

    yield const LicenseEntryWithLineBreaks(
      ['Petrus Canisiusvertaling 1939 (NLD1939)'],
      '''
De Heilige Schrift, Petrus Canisiusvertaling, 1939.

The Petrus Canisius translation is in the public domain.

Text obtained from the nld1939eb SWORD module published by eBible.org. Lux transforms the module into its bundled Bible data format and uses eBible.org's verse-marked HTML for Daniel because the module stores Daniel under the combined Catholic DAG book.

Source: https://ebible.org/bible/details.php?id=nld1939''',
    );

    yield const LicenseEntryWithLineBreaks(
      ['La Sainte Bible, Ostervald 1744 (FOB)'],
      '''
La Sainte Bible, Ostervald 1744.

Public domain. This work may be copied and published freely.

Text obtained from the fraFOB1744eb SWORD module distributed by eBible.org. Lux transforms the module into its bundled Bible data format.

Source: https://eBible.org/Scriptures/''',
    );

    yield const LicenseEntryWithLineBreaks(
      ['Bible David Martin 1744 (Martin)'],
      '''
La Sainte Bible, Version David Martin 1744.

Public domain.

Text obtained from the FreBDM1744 SWORD module distributed by the CrossWire Bible Society. Lux transforms the module into its bundled Bible data format.

Sources:
https://www.crosswire.org/sword/modules/ModInfo.jsp?modName=FreBDM1744
http://earnestlycontending.com/BibleMartin/index.html''',
    );

    yield const LicenseEntryWithLineBreaks(
      ['Santa Biblia Reina Valera Gómez 2010 (RVG)'],
      '''
Santa Biblia Reina Valera Gómez.

Copyright © 2004, 2010, 2023 Dr. Humberto Gómez Caballero. All rights reserved.

Free non-commercial distribution is permitted when the text is not changed. Printing or reproduction for profit is prohibited.

Text obtained from the sparvg2010eb SWORD module distributed by eBible.org. Lux transforms the module into its bundled Bible data format.

Source: https://eBible.org/Scriptures/''',
    );

    yield const LicenseEntryWithLineBreaks(
      ['Septuagint, Rahlfs (LXX)'],
      '''
Septuagint, Morphologically Tagged Rahlfs' text.

Copyrighted; free non-commercial distribution.

Text obtained from the LXX SWORD module distributed by the CrossWire Bible Society. The module was built from data from the Center for Computer Analysis of Texts at the University of Pennsylvania. Lux transforms the module into its bundled Bible data format.

Source: https://www.crosswire.org/sword/modules/ModInfo.jsp?modName=LXX''',
    );

    yield const LicenseEntryWithLineBreaks(
      ['Textus Receptus, Stephens 1550 (TR)'],
      '''
Textus Receptus, Stephens 1550, transcribed and proofed by Maurice A. Robinson. The source also records Scrivener 1894 variants.

The electronic Greek text was released into the public domain and may be used for any purpose. Attribution is retained to identify the preparer and responsibility for the text.

Lux converts the official ASCII source to unaccented lowercase Unicode Greek and its bundled Bible data format.

Sources:
https://byzantinetext.com/study/editions/scrivener/
https://www.dropbox.com/s/dnlsgrcan5t36sk/editions-stevens-scrivener-parsed.zip?dl=0''',
    );

    yield const LicenseEntryWithLineBreaks(
      ['Statistical Restoration Greek New Testament (SR)'],
      '''
Statistical Restoration Greek New Testament, edited by Alan Bunning, Center for New Testament Restoration.

Copyright © 2022-2023 Alan Bunning. Licensed under Creative Commons Attribution 4.0 International (CC BY 4.0): https://creativecommons.org/licenses/by/4.0/

Lux transforms the source text into its bundled Bible data format.

Source: https://github.com/Center-for-New-Testament-Restoration/SR/blob/4be18e67c6870388d317d38d2b10a70e8b5e8775/SR.tsv''',
    );

    yield const LicenseEntryWithLineBreaks(
      ['Open Scriptures Hebrew Bible (OSHB)'],
      '''
Open Scriptures Hebrew Bible, based on the public-domain Westminster Leningrad Codex.

Licensed under Creative Commons Attribution 4.0 International (CC BY 4.0): https://creativecommons.org/licenses/by/4.0/

Original work of the Open Scriptures Hebrew Bible available at https://github.com/openscriptures/morphhb

Lux transforms the source text into its bundled Bible data format.

Source: https://github.com/openscriptures/morphhb''',
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
      ["John Calvin's Commentaries"],
      '''
John Calvin's collected Bible commentaries.

The commentary is in the public domain. Lux's electronic text was obtained from the Christian Classics Ethereal Library (CCEL).

Sources:
https://www.ccel.org/ccel/calvin
https://crosswire.org/sword/modules/ModInfo.jsp?modName=CalvinCommentaries''',
    );

    yield const LicenseEntryWithLineBreaks(
      ['Jamieson-Fausset-Brown Commentary'],
      '''
Commentary Critical and Explanatory on the Whole Bible by Robert Jamieson, A. R. Fausset, and David Brown, first published in 1871.

The work is in the public domain. Lux's electronic text was obtained from the Christian Classics Ethereal Library (CCEL).

Source: https://www.ccel.org/ccel/jamieson/jfb.html''',
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
  - hebrew/StrongHebrewG.xml

The public-domain status of the Greek dictionary is also documented by the CrossWire Bible Society:
https://www.crosswire.org/sword/modules/ModInfo.jsp?modName=StrongsGreek''',
    );

    yield const LicenseEntryWithLineBreaks(
      ["Easton's Bible Dictionary"],
      '''
Easton's Bible Dictionary.

These dictionary topics are from M.G. Easton M.A., D.D., Illustrated Bible Dictionary, Third Edition, published by Thomas Nelson, 1897. Public Domain — Copy Freely.

Sourced from the Christian Classics Ethereal Library (CCEL).

Source: https://www.ccel.org/ccel/easton/ebd2''',
    );

    yield const LicenseEntryWithLineBreaks(
      ['Bible Reading Plans'],
      '''
Reading plan schedules (daily passage references only; no Bible text is included).

Compiled from the open-source "readingplans" project by Kyle Hornberg, licensed under the MIT License, itself derived from devkardia/bibleplan.
https://github.com/khornberg/readingplans

The individual plans remain the work of their original publishers:

M'Cheyne — Robert Murray M'Cheyne (1813-1843). Public domain.

Old and New Testament; Gospels and Epistles; Every Day in the Word; Literary Study Bible; Chronicles and Prophets; Pentateuch and History of Israel; Psalms and Wisdom Literature: ESV reading plans, Crossway. https://www.esv.org

Through the Bible: Equipping Godly Women Bible in a Year Reading Plan. https://equippinggodlywomen.com/faith/read-the-bible-in-a-year/

One Year Chronological: The One Year Bible, Tyndale House Publishers. https://www.oneyearbibleonline.com

Historically Blended; Different Topics; New Testament, Psalms & Proverbs: Heartlight, Inc. https://www.heartlight.org

5x5x5 New Testament Bible Reading Plan: Copyright © 2005 by The Navigators. All Rights Reserved. Adapted from the Discipleship Journal 5x5x5 Bible Reading Plan. Permission is granted to reprint unlimited copies for non-commercial use. All copyright information must be retained. https://www.navigators.org/resource/bible-reading-plans/

Only the daily passage references are used; the Scripture text is provided under the Bible translation licenses.''',
    );

    yield const LicenseEntryWithLineBreaks(
      ['Verse of the Day', "Jonathan Bagster's Daily Light on the Daily Path"],
      '''
The Verse of the Day passage schedule is derived from Jonathan Bagster's Daily Light on the Daily Path: A Devotional Textbook for Every Day of the Year, in the Very Words of Scripture.

Prepared by Jonathan Bagster (1813-1872) and other members of his family. Distributed by the CrossWire Bible Society as the Daily SWORD module, version 1.0. Public domain. Copy freely.

Only the calendar schedule and Scripture references are included. Scripture text is provided under the selected Bible translation's license.

Source: https://www.crosswire.org/sword/modules/ModInfo.jsp?modName=Daily''',
    );
  });
}
