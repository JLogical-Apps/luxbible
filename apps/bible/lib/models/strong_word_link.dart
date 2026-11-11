import 'package:lux/lux_core.dart';

class StrongWordLink {
  static const linkPrefix = 'strong:';

  final Reference reference;
  final String strongId;
  final int occurrence;

  StrongWordLink({required this.reference, required this.strongId, required this.occurrence});

  // Links take the form `strong:Gen.3.15/H2233`, or `strong:Gen.3.15/H2233/2` for the word's second use in the verse.
  static StrongWordLink? parse(String link) {
    if (!link.startsWith(linkPrefix)) return null;
    if (link.substring(linkPrefix.length).split('/') case [
      final osisId,
      final strongId,
      ...final rest,
    ] when rest.length <= 1 && VerseSelection.isOsisId(osisId)) {
      final occurrence = rest.isEmpty ? 1 : int.tryParse(rest.single);
      if (VerseSelection.fromOsisId(osisId).references case [
        final reference,
      ] when occurrence != null && occurrence > 0) {
        return StrongWordLink(reference: reference, strongId: strongId, occurrence: occurrence);
      }
    }
    return null;
  }

  Word? getWord(Verse verse) =>
      verse.words.where((word) => word.data?.strongId == strongId).elementAtOrNull(occurrence - 1);
}
