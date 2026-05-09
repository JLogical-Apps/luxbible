import 'dart:convert';
import 'dart:io';

import 'package:bible/models/morphology.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Morphology.fromCode — single components', () {
    test('Article (Hebrew)', () {
      final [m as MorphologyArticle] = Morphology.fromCodes('Art');
      expect(m.language, Language.hebrew);
      expect(m.grammaticalCase, isNull);
    });

    test('Article (Greek, Nominative Masculine Singular)', () {
      final [m as MorphologyArticle] = Morphology.fromCodes('Art-NMS');
      expect(m.language, Language.greek);
      expect(m.grammaticalCase, GrammaticalCase.nominative);
      expect(m.gender, GrammaticalGender.masculine);
      expect(m.number, GrammaticalNumber.singular);
    });

    test('Conjunction with waw particle', () {
      final [m as MorphologyConjunction] = Morphology.fromCodes('Conj-w');
      expect(m.particle, 'w');
    });

    test('Bare conjunction', () {
      final [m as MorphologyConjunction] = Morphology.fromCodes('Conj');
      expect(m.particle, isNull);
    });

    test('Preposition with prefix letter', () {
      final [m as MorphologyPreposition] = Morphology.fromCodes('Prep-b');
      expect(m.prefix, 'b');
    });

    test('Standalone preposition', () {
      final [m as MorphologyPreposition] = Morphology.fromCodes('Prep');
      expect(m.prefix, isNull);
    });

    test('Adverb', () {
      final [m as MorphologyAdverb] = Morphology.fromCodes('Adv');
      expect(m.modifier, isNull);
    });

    test('Negative adverb', () {
      final [m as MorphologyAdverb] = Morphology.fromCodes('Adv-NegPrt');
      expect(m.modifier, 'NegPrt');
      expect(m.attributes[MorphologyAttribute.type], MorphologyType.negativeAdverb);
    });

    test('Comparative adverb', () {
      final [m as MorphologyAdverb] = Morphology.fromCodes('Adv-C');
      expect(m.attributes[MorphologyAttribute.degree], Degree.comparative);
    });

    test('Superlative adverb', () {
      final [m as MorphologyAdverb] = Morphology.fromCodes('Adv-S');
      expect(m.attributes[MorphologyAttribute.degree], Degree.superlative);
    });

    test('Hebrew adjective (feminine singular)', () {
      final [m as MorphologyAdjective] = Morphology.fromCodes('Adj-fs');
      expect(m.language, Language.hebrew);
      expect(m.gender, GrammaticalGender.feminine);
      expect(m.number, GrammaticalNumber.singular);
      expect(m.degree, Degree.positive);
    });

    test('Hebrew adjective construct state', () {
      final [m as MorphologyAdjective] = Morphology.fromCodes('Adj-msc');
      expect(m.state, HebrewState.construct);
    });

    test('Greek adjective comparative', () {
      final [m as MorphologyAdjective] = Morphology.fromCodes('Adj-NMS-C');
      expect(m.language, Language.greek);
      expect(m.degree, Degree.comparative);
    });

    test('Greek adjective superlative', () {
      final [m as MorphologyAdjective] = Morphology.fromCodes('Adj-AFP-S');
      expect(m.degree, Degree.superlative);
      expect(m.grammaticalCase, GrammaticalCase.accusative);
      expect(m.gender, GrammaticalGender.feminine);
      expect(m.number, GrammaticalNumber.plural);
    });

    test('Hebrew noun', () {
      final [m as MorphologyNoun] = Morphology.fromCodes('N-fs');
      expect(m.gender, GrammaticalGender.feminine);
      expect(m.number, GrammaticalNumber.singular);
      expect(m.proper, isFalse);
    });

    test('Hebrew construct noun', () {
      final [m as MorphologyNoun] = Morphology.fromCodes('N-csc');
      expect(m.gender, GrammaticalGender.common);
      expect(m.number, GrammaticalNumber.singular);
      expect(m.state, HebrewState.construct);
    });

    test('Hebrew proper noun', () {
      final [m as MorphologyNoun] = Morphology.fromCodes('N-proper-ms');
      expect(m.proper, isTrue);
      expect(m.gender, GrammaticalGender.masculine);
    });

    test('Bare proper-noun prefix', () {
      final [m as MorphologyNoun] = Morphology.fromCodes('N-proper-mb');
      expect(m.proper, isTrue);
    });

    test('Greek noun (Nominative Masculine Singular)', () {
      final [m as MorphologyNoun] = Morphology.fromCodes('N-NMS');
      expect(m.language, Language.greek);
      expect(m.grammaticalCase, GrammaticalCase.nominative);
      expect(m.gender, GrammaticalGender.masculine);
      expect(m.number, GrammaticalNumber.singular);
    });

    test('Number (cardinal)', () {
      final [m as MorphologyNumber] = Morphology.fromCodes('Number-fs');
      expect(m.gender, GrammaticalGender.feminine);
      expect(m.number, GrammaticalNumber.singular);
      expect(m.ordinal, isFalse);
    });

    test('Number (ordinal construct)', () {
      final [m as MorphologyNumber] = Morphology.fromCodes('Number-ofsc');
      expect(m.ordinal, isTrue);
      expect(m.state, HebrewState.construct);
    });

    test('Generic Hebrew pronoun', () {
      final [m as MorphologyPronoun] = Morphology.fromCodes('Pro-2ms');
      expect(m.kind, MorphologyType.pronoun);
      expect(m.person, Person.second);
      expect(m.gender, GrammaticalGender.masculine);
      expect(m.number, GrammaticalNumber.singular);
    });

    test('Personal pronoun (Greek)', () {
      final [m as MorphologyPronoun] = Morphology.fromCodes('PPro-AF3S');
      expect(m.kind, MorphologyType.personalPronoun);
      expect(m.language, Language.greek);
      expect(m.grammaticalCase, GrammaticalCase.accusative);
      expect(m.gender, GrammaticalGender.feminine);
      expect(m.person, Person.third);
      expect(m.number, GrammaticalNumber.singular);
    });

    test('Demonstrative pronoun', () {
      final [m as MorphologyPronoun] = Morphology.fromCodes('DPro-NMS');
      expect(m.kind, MorphologyType.demonstrativePronoun);
    });

    test('Interrogative pronoun', () {
      final [m as MorphologyPronoun] = Morphology.fromCodes('IPro-AMS');
      expect(m.kind, MorphologyType.interrogativePronoun);
    });

    test('Reciprocal pronoun', () {
      final [m as MorphologyPronoun] = Morphology.fromCodes('RecPro-AMP');
      expect(m.kind, MorphologyType.reciprocalPronoun);
    });

    test('Reflexive pronoun', () {
      final [m as MorphologyPronoun] = Morphology.fromCodes('RefPro-GM3S');
      expect(m.kind, MorphologyType.reflexivePronoun);
      expect(m.person, Person.third);
    });

    test('Relative pronoun', () {
      final [m as MorphologyPronoun] = Morphology.fromCodes('RelPro-DFP');
      expect(m.kind, MorphologyType.relativePronoun);
      expect(m.grammaticalCase, GrammaticalCase.dative);
    });

    test('Particle (negative)', () {
      final [m as MorphologyParticle] = Morphology.fromCodes('Pn');
      expect(m.kind, MorphologyType.negativeParticle);
    });

    test('Particle (interrogative — Pi/IntPrtcl/Interrog)', () {
      for (final code in ['Pi', 'IntPrtcl', 'Interrog']) {
        final [m as MorphologyParticle] = Morphology.fromCodes(code);
        expect(m.kind, MorphologyType.interrogativeParticle, reason: code);
      }
    });

    test('Particle (demonstrative)', () {
      final [m as MorphologyParticle] = Morphology.fromCodes('Pd');
      expect(m.kind, MorphologyType.demonstrativeParticle);
    });

    test('Particle (generic)', () {
      final [m as MorphologyParticle] = Morphology.fromCodes('Pg');
      expect(m.kind, MorphologyType.genericParticle);
    });

    test('Particle (relative)', () {
      final [m as MorphologyParticle] = Morphology.fromCodes('Pr');
      expect(m.kind, MorphologyType.relativeParticle);
    });

    test('Particle (unspecified)', () {
      final [m as MorphologyParticle] = Morphology.fromCodes('Prtcl');
      expect(m.kind, MorphologyType.particle);
    });

    test('Direct object marker', () {
      final [m] = Morphology.fromCodes('DirObjM');
      expect(m, isA<MorphologyDirectObjectMarker>());
    });

    test('Punctuation', () {
      final [m] = Morphology.fromCodes('Punc');
      expect(m, isA<MorphologyPunctuation>());
    });

    test('Interjection (I and Interjection)', () {
      for (final code in ['I', 'Interjection']) {
        final [m] = Morphology.fromCodes(code);
        expect(m, isA<MorphologyInterjection>(), reason: code);
      }
    });

    test('Indeclinable', () {
      final [m] = Morphology.fromCodes('Indec');
      expect(m, isA<MorphologyIndeclinable>());
    });

    test('Hebrew loanword', () {
      final [m] = Morphology.fromCodes('Heb');
      expect(m, isA<MorphologyHebraism>());
    });

    test('Pronominal suffix (3ms)', () {
      final [m as MorphologyPronominalSuffix] = Morphology.fromCodes('3ms');
      expect(m.person, Person.third);
      expect(m.gender, GrammaticalGender.masculine);
      expect(m.number, GrammaticalNumber.singular);
    });

    test('Pronominal suffix with energic (1cse)', () {
      final [m as MorphologyPronominalSuffix] = Morphology.fromCodes('1cse');
      expect(m.person, Person.first);
      expect(m.gender, GrammaticalGender.common);
      expect(m.number, GrammaticalNumber.singular);
    });
  });

  group('Hebrew verbs', () {
    test('Qal perfect 3ms', () {
      final [m as MorphologyHebrewVerb] = Morphology.fromCodes('V-Qal-Perf-3ms');
      expect(m.stem, HebrewStem.qal);
      expect(m.aspect, HebrewAspect.perfect);
      expect(m.person, Person.third);
      expect(m.gender, GrammaticalGender.masculine);
      expect(m.number, GrammaticalNumber.singular);
      expect(m.mood, isNull);
    });

    test('Qal consecutive imperfect 3ms', () {
      final [m as MorphologyHebrewVerb] = Morphology.fromCodes('V-Qal-ConsecImperf-3ms');
      expect(m.aspect, HebrewAspect.consecutiveImperfect);
    });

    test('Piel participle feminine singular', () {
      final [m as MorphologyHebrewVerb] = Morphology.fromCodes('V-Piel-Prtcpl-fs');
      expect(m.stem, HebrewStem.piel);
      expect(m.aspect, HebrewAspect.participle);
      expect(m.gender, GrammaticalGender.feminine);
      expect(m.number, GrammaticalNumber.singular);
      expect(m.person, isNull);
    });

    test('Imperfect jussive', () {
      final [m as MorphologyHebrewVerb] = Morphology.fromCodes('V-Qal-Imperf.Jus-3ms');
      expect(m.aspect, HebrewAspect.imperfect);
      expect(m.mood, HebrewVerbMood.jussive);
    });

    test('Imperfect cohortative', () {
      final [m as MorphologyHebrewVerb] = Morphology.fromCodes('V-Qal-Imperf.Cohort-1cs');
      expect(m.mood, HebrewVerbMood.cohortative);
      expect(m.person, Person.first);
    });

    test('Imperfect h-suffix', () {
      final [m as MorphologyHebrewVerb] = Morphology.fromCodes('V-Qal-Imperf.h-1cp');
      expect(m.mood, HebrewVerbMood.hSuffix);
    });

    test('All Hebrew stems are recognized', () {
      const samples = {
        'Qal': HebrewStem.qal,
        'QalPass': HebrewStem.qalPassive,
        'Nifal': HebrewStem.niphal,
        'Niphal': HebrewStem.niphal,
        'Piel': HebrewStem.piel,
        'Pual': HebrewStem.pual,
        'Hifil': HebrewStem.hiphil,
        'Hiphil': HebrewStem.hiphil,
        'Hofal': HebrewStem.hophal,
        'Hophal': HebrewStem.hophal,
        'Hitpael': HebrewStem.hithpael,
        'Hithpael': HebrewStem.hithpael,
        'Nithpael': HebrewStem.nithpael,
      };
      for (final entry in samples.entries) {
        final [m as MorphologyHebrewVerb] = Morphology.fromCodes('V-${entry.key}-Perf-3ms');
        expect(m.stem, entry.value, reason: entry.key);
      }
    });
  });

  group('Greek verbs', () {
    test('Present indicative active 3rd singular', () {
      final [m as MorphologyGreekVerb] = Morphology.fromCodes('V-PIA-3S');
      expect(m.tense, GreekTense.present);
      expect(m.mood, GreekMood.indicative);
      expect(m.voice, GreekVoice.active);
      expect(m.person, Person.third);
      expect(m.number, GrammaticalNumber.singular);
    });

    test('Aorist indicative active 1st plural', () {
      final [m as MorphologyGreekVerb] = Morphology.fromCodes('V-AIA-1P');
      expect(m.tense, GreekTense.aorist);
      expect(m.person, Person.first);
      expect(m.number, GrammaticalNumber.plural);
    });

    test('Present participle active NMS', () {
      final [m as MorphologyGreekVerb] = Morphology.fromCodes('V-PPA-NMS');
      expect(m.mood, GreekMood.participle);
      expect(m.grammaticalCase, GrammaticalCase.nominative);
      expect(m.gender, GrammaticalGender.masculine);
      expect(m.number, GrammaticalNumber.singular);
    });

    test('Perfect participle middle/passive NMS', () {
      final [m as MorphologyGreekVerb] = Morphology.fromCodes('V-RPM/P-NMS');
      expect(m.tense, GreekTense.perfect);
      expect(m.mood, GreekMood.participle);
      expect(m.voice, GreekVoice.middleOrPassive);
      expect(m.gender, GrammaticalGender.masculine);
    });

    test('Aorist infinitive active', () {
      final [m as MorphologyGreekVerb] = Morphology.fromCodes('V-ANA');
      expect(m.tense, GreekTense.aorist);
      expect(m.mood, GreekMood.infinitive);
      expect(m.voice, GreekVoice.active);
    });
  });

  group('Compound codes', () {
    test('Prep-b | N-fs', () {
      final result = Morphology.fromCodes('Prep-b | N-fs');
      expect(result, hasLength(2));
      expect(result[0], isA<MorphologyPreposition>());
      expect(result[1], isA<MorphologyNoun>());
    });

    test('Conj-w, Art | N-fs (mixed comma + pipe)', () {
      final result = Morphology.fromCodes('Conj-w, Art | N-fs');
      expect(result, hasLength(3));
      expect(result[0], isA<MorphologyConjunction>());
      expect(result[1], isA<MorphologyArticle>());
      expect(result[2], isA<MorphologyNoun>());
    });

    test('Verb with pronominal suffix', () {
      final result = Morphology.fromCodes('Conj-w | V-Piel-ConjImperf-2mp | 1cs, Pn');
      expect(result, hasLength(4));
      expect(result[0], isA<MorphologyConjunction>());
      expect(result[1], isA<MorphologyHebrewVerb>());
      expect(result[2], isA<MorphologyPronominalSuffix>());
      expect(result[3], isA<MorphologyParticle>());
    });
  });

  group('attributes (UI map)', () {
    test('Greek verb omits person when participle', () {
      final [m] = Morphology.fromCodes('V-PPA-NMS');
      expect(m.attributes.containsKey(MorphologyAttribute.person), isFalse);
      expect(m.attributes[MorphologyAttribute.grammaticalCase], GrammaticalCase.nominative);
    });

    test('Hebrew verb keeps mood key only when present', () {
      final [plain] = Morphology.fromCodes('V-Qal-Perf-3ms');
      expect(plain.attributes.containsKey(MorphologyAttribute.mood), isFalse);
      final [jussive] = Morphology.fromCodes('V-Qal-Imperf.Jus-3ms');
      expect(jussive.attributes[MorphologyAttribute.mood], HebrewVerbMood.jussive);
    });

    test('Adjective omits degree when positive', () {
      final [m] = Morphology.fromCodes('Adj-NMS');
      expect(m.attributes.containsKey(MorphologyAttribute.degree), isFalse);
    });

    test('Particle type is computed from kind', () {
      final [m] = Morphology.fromCodes('Pn');
      expect(m.attributes[MorphologyAttribute.type], MorphologyType.negativeParticle);
    });

    test('Unknown morphology surfaces the raw code in a literal value', () {
      const m = MorphologyUnknown('???');
      final value = m.attributes[MorphologyAttribute.code];
      expect(value, isA<MorphologyAttributeLiteral>());
      expect(value!.displayName, '???');
    });

    test('Conjunction particle "w" carries Hebrew waw description', () {
      final [m] = Morphology.fromCodes('Conj-w');
      final particle = m.attributes[MorphologyAttribute.particle]!;
      expect(particle.displayName, 'w');
      expect(particle.description, contains('waw'));
      expect(particle.examples, contains('and'));
    });

    test('Preposition prefix "b" carries Hebrew bet description', () {
      final [m] = Morphology.fromCodes('Prep-b');
      final prefix = m.attributes[MorphologyAttribute.prefix]!;
      expect(prefix.displayName, 'b');
      expect(prefix.description, contains('bet'));
    });

    test('Every value provides displayName, description, and examples', () {
      const codes = [
        'V-Qal-Perf-3ms',
        'V-PIA-3S',
        'V-PPA-NMS',
        'Adj-NMS-C',
        'PPro-AF3S',
        'Number-ofsc',
        'N-fs',
        'Pn',
        'Conj-w | DirObjM',
      ];
      for (final code in codes) {
        for (final m in Morphology.fromCodes(code)) {
          for (final value in m.attributes.values) {
            expect(value.displayName, isNotEmpty, reason: '$code displayName');
            expect(value.description, isNotEmpty, reason: '$code description');
            expect(value.examples, isA<List<String>>(), reason: '$code examples');
          }
        }
      }
    });
  });

  group('attribute keys', () {
    test('Every MorphologyAttribute has a non-empty displayName and description', () {
      for (final attr in MorphologyAttribute.values) {
        expect(attr.displayName, isNotEmpty, reason: attr.name);
        expect(attr.description, isNotEmpty, reason: attr.name);
      }
    });
  });

  group('enum value coverage', () {
    test('Every enum value implementing MorphologyAttributeValue has populated text', () {
      final samples = <MorphologyAttributeValue>[
        ...Person.values,
        ...GrammaticalGender.values,
        ...GrammaticalNumber.values,
        ...GrammaticalCase.values,
        ...HebrewState.values,
        ...HebrewStem.values,
        ...HebrewAspect.values,
        ...HebrewVerbMood.values,
        ...GreekTense.values,
        ...GreekMood.values,
        ...GreekVoice.values,
        ...Degree.values,
        ...MorphologyType.values,
      ];
      for (final value in samples) {
        expect(value.displayName, isNotEmpty);
        expect(value.description, isNotEmpty);
      }
    });
  });

  group('corpus', () {
    final codes = _loadCorpusCodes();
    test('all ${codes.length} unique codes parse without producing MorphologyUnknown', () {
      final failures = <String>[];
      for (final code in codes) {
        for (final m in Morphology.fromCodes(code)) {
          if (m is MorphologyUnknown) failures.add('$code -> ${m.code}');
        }
      }
      expect(failures, isEmpty);
    });

    for (final code in codes) {
      test('parses "$code"', () {
        final result = Morphology.fromCodes(code);
        expect(result, isNotEmpty);
        for (final m in result) {
          expect(m, isNot(isA<MorphologyUnknown>()));
          expect(m.attributes[MorphologyAttribute.type], isNotNull);
        }
      });
    }
  });
}

Set<String> _loadCorpusCodes() {
  final raw = File('assets/translations/bsb.json').readAsStringSync();
  final data = json.decode(raw);
  final codes = <String>{};
  void walk(dynamic node) {
    if (node is Map) {
      final m = node['m'];
      if (m is String) codes.add(m);
      for (final v in node.values) {
        walk(v);
      }
    } else if (node is List) {
      for (final v in node) {
        walk(v);
      }
    }
  }

  walk(data);
  return codes;
}
