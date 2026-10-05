import 'package:collection/collection.dart';
import 'package:lux/lux_core.dart';

mixin LinkedResource {
  String get title;

  bool matchesTitleSearch(List<String> searchTerms) =>
      searchTerms.every((searchTerm) => title.bibleSearchTerms.any((word) => word.startsWith(searchTerm)));
}

extension LinkedResourceIterableExtensions<T extends LinkedResource> on Iterable<T> {
  Iterable<T> whereLinkedTo(VerseSelection selection, {required List<VerseSelection> Function(T) getPassages}) =>
      map(
            (resource) => (
              resource: resource,
              overlap: getPassages(
                resource,
              ).where((passage) => passage.hasAnyOf(selection)).map((passage) => passage.references.length).minOrNull,
            ),
          )
          .where((entry) => entry.overlap != null)
          .sorted((a, b) => a.overlap!.compareTo(b.overlap!).nullIfZero ?? a.resource.title.compareTo(b.resource.title))
          .map((entry) => entry.resource);

  Iterable<T> whereMatchingTitleSearch(String search) {
    final searchTerms = search.bibleSearchTerms;
    return where((resource) => resource.matchesTitleSearch(searchTerms));
  }
}
