import 'dart:convert';
import 'dart:io';

import 'package:bible/models/strong.dart';
import 'package:bible/utils/markdown.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late List<Map<String, dynamic>> json;
  late Map<String, Strong> strongs;

  setUpAll(() {
    json = (jsonDecode(File('assets/strongs/strongs.json').readAsStringSync()) as List).cast<Map<String, dynamic>>();
    strongs = {for (final entry in json) entry['i'] as String: Strong.fromJson(entry)};
  });

  test('contains every canonical Strong entry with sanitized markdown', () {
    expect(strongs, hasLength(14197));
    expect(
      strongs.values.where(
        (strong) =>
            strong.definition.text.isEmpty ||
            strong.description.text.isEmpty ||
            RegExp(r'<[^>]+>|&(?:#\d+|\w+);').hasMatch('${strong.definition.text}${strong.description.text}'),
      ),
      isEmpty,
    );
  });

  test('combines rich Greek lexicon metadata', () {
    final strong = strongs['G26']!;

    expect(strong.definition.text, contains('brotherly love'));
    expect(strong.description.text, contains('[G25](G25)'));
    expect(strong.derivation?.text, 'from [G25](G25)');
    expect(strong.partOfSpeech, 'Noun Feminine');
    expect(strong.lexiconReference, 'TDNT 01:21,5');
    expect(strong.relatedStrongIds, containsAll(['G25', 'H160']));
    expect(strong.kjvUsage, containsPair('love', 75));
  });

  test('preserves nested definition indentation', () {
    expect(
      strongs['H430']!.definition.text,
      contains('**1.** (plural)\n\t\t**a.** rulers, judges\n\t\t**b.** divine ones'),
    );
  });

  test('falls back safely when an upstream definition is truncated', () {
    final strong = strongs['H164']!;

    expect(strong.definition.text, isNotEmpty);
    expect(strong.description.text, isNotEmpty);
    expect(strong.relatedStrongIds, contains('H161'));
  });

  test('reconstructs the H1961 source hierarchy', () {
    final strong = strongs['H1961']!;

    expect(strong.derivation?.text, r'a primitive root \[compare [H1933](H1933)\]');
    expect(
      strong.definition.text,
      contains(
        '**1.** to be, become, come to pass, exist, happen, fall out\n'
        '\t\t**a.** (Qal)\n'
        '\t\t\t\t**1.** -----\n'
        '\t\t\t\t\t\t**a.** to happen, fall out, occur, take place, come about, come to pass',
      ),
    );
    expect(strong.definition.text, contains('\t\t\t\t\t\t**b.** to come about, come to pass'));
    expect(strong.definition.text, contains('\t\t**b.** (Niphal)'));
  });

  test('removes stray Greek hierarchy suffixes', () {
    final definition = strongs['G1210']!.definition.text;

    expect(definition, contains('to bind, put under obligation, of the law, duty etc.'));
    expect(definition, isNot(contains('duty etc. 1b')));
  });

  test('does not include escaped brackets in link text', () {
    final elements = Markdown(r'a primitive root \[compare [H1933](H1933)\]').elements;
    final links = elements.whereType<MarkdownLink>().toList();

    expect(elements.plainText, 'a primitive root [compare H1933]');
    expect(links, hasLength(1));
    expect(links.single.plainText, 'H1933');
    expect(links.single.target, 'H1933');
  });
}
