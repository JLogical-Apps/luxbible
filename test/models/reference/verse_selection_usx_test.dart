import 'package:bible/models/reference/verse_selection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('converts USX references and ranges to OSIS', () {
    expect(
      VerseSelection.fromUsxId('ISA.7.14+MAT 1:1-3+MAT 2:1-3:4').osisId(),
      'Isa.7.14 Matt.1.1-Matt.1.3 Matt.2.1-Matt.3.4',
    );
  });

  test('returns null for invalid USX references', () {
    expect(VerseSelection.tryFromUsxId(null), isNull);
    expect(VerseSelection.tryFromUsxId('not a reference'), isNull);
  });
}
