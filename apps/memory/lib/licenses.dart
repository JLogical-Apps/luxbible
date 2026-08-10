import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

Future<void> registerLicenses() async {
  LicenseRegistry.addLicense(() async* {
    yield LicenseEntryWithLineBreaks(['Bitter'], await rootBundle.loadString('fonts/Bitter-OFL.txt'));

    yield const LicenseEntryWithLineBreaks(
      ['Berean Standard Bible (BSB)'],
      '''
The Holy Bible, Berean Standard Bible, BSB is produced in cooperation with Bible Hub, Discovery Bible, OpenBible.com, and the Berean Bible Translation Committee.

https://berean.bible/''',
    );

    yield const LicenseEntryWithLineBreaks(
      ['OpenBible.info Topic Scores'],
      '''
Topic-score data used to select the passages in Lux Memory's topical packs.

Copyright © OpenBible.info. Licensed under Creative Commons Attribution 4.0 International (CC BY 4.0): https://creativecommons.org/licenses/by/4.0/

Source: https://www.openbible.info/topics''',
    );
  });
}
