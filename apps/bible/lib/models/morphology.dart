import 'package:collection/collection.dart';
import 'package:lux/i18n.dart';

typedef MorphologyTranslation = ({String name, String description, String examples});
typedef MorphologyAttributeTranslation = ({String name, String description});

List<String> morphologyExamples(String examples) => examples.split('|');

/// A value rendered as the right-hand side of a [Morphology.attributes] entry.
/// Provides everything a UI needs to show a labeled, explained chip or list item.
abstract interface class MorphologyAttributeValue {
  String get displayName;
  String get description;
  List<String> get examples;
}

/// A free-form attribute value used for literals (preposition prefix letters,
/// the `w` on `Conj-w`, raw codes for unknown morphologies).
class MorphologyAttributeLiteral implements MorphologyAttributeValue {
  @override
  final String displayName;

  @override
  final String description;

  @override
  final List<String> examples;

  const MorphologyAttributeLiteral({required this.displayName, required this.description, this.examples = const []});
}

/// Keys used by [Morphology.attributes] for UI rendering as key/value pairs.
enum MorphologyAttribute {
  type,
  grammaticalCase,
  gender,
  number,
  person,
  state,
  tense,
  mood,
  voice,
  degree,
  stem,
  aspect,
  prefix,
  particle,
  code;

  String get displayName => morphologyAttributeTranslation(this).name;

  String get description => morphologyAttributeTranslation(this).description;
}

enum MorphologyLanguage {
  hebrew,
  greek;

  String get displayName => switch (this) {
    .hebrew => t.languages.hebrew,
    .greek => t.languages.greek,
  };
}

/// The top-level grammatical kind of a morphology entry.
enum MorphologyType implements MorphologyAttributeValue {
  article,
  conjunction,
  preposition,
  adverb,
  negativeAdverb,
  adjective,
  noun,
  properNoun,
  number,
  ordinalNumber,
  pronoun,
  personalPronoun,
  demonstrativePronoun,
  interrogativePronoun,
  indefinitePronoun,
  reciprocalPronoun,
  reflexivePronoun,
  relativePronoun,
  particle,
  negativeParticle,
  interrogativeParticle,
  demonstrativeParticle,
  genericParticle,
  relativeParticle,
  verb,
  pronominalSuffix,
  directObjectMarker,
  punctuation,
  interjection,
  indeclinable,
  hebraism,
  unknown;

  @override
  String get displayName => morphologyTypeTranslation(this).name;

  @override
  String get description => morphologyTypeTranslation(this).description;

  @override
  List<String> get examples => this == unknown ? [] : morphologyExamples(morphologyTypeTranslation(this).examples);
}

enum Person implements MorphologyAttributeValue {
  first,
  second,
  third;

  @override
  String get displayName => morphologyPersonTranslation(this).name;

  @override
  String get description => morphologyPersonTranslation(this).description;

  @override
  List<String> get examples => morphologyExamples(morphologyPersonTranslation(this).examples);
}

enum GrammaticalGender implements MorphologyAttributeValue {
  masculine,
  feminine,
  neuter,
  common;

  @override
  String get displayName => morphologyGenderTranslation(this).name;

  @override
  String get description => morphologyGenderTranslation(this).description;

  @override
  List<String> get examples => morphologyExamples(morphologyGenderTranslation(this).examples);
}

enum GrammaticalNumber implements MorphologyAttributeValue {
  singular,
  plural,
  dual;

  @override
  String get displayName => morphologyNumberTranslation(this).name;

  @override
  String get description => morphologyNumberTranslation(this).description;

  @override
  List<String> get examples => morphologyExamples(morphologyNumberTranslation(this).examples);
}

enum GrammaticalCase implements MorphologyAttributeValue {
  nominative,
  genitive,
  dative,
  accusative,
  vocative;

  @override
  String get displayName => morphologyCaseTranslation(this).name;

  @override
  String get description => morphologyCaseTranslation(this).description;

  @override
  List<String> get examples => morphologyExamples(morphologyCaseTranslation(this).examples);
}

enum HebrewState implements MorphologyAttributeValue {
  absolute,
  construct,
  determined;

  @override
  String get displayName => morphologyStateTranslation(this).name;

  @override
  String get description => morphologyStateTranslation(this).description;

  @override
  List<String> get examples => morphologyExamples(morphologyStateTranslation(this).examples);
}

/// Hebrew verb stem (binyan).
enum HebrewStem implements MorphologyAttributeValue {
  qal,
  qalPassive,
  niphal,
  piel,
  pual,
  hiphil,
  hophal,
  hithpael,
  nithpael;

  static HebrewStem? fromLinkTarget(String target) => values.firstWhereOrNull((stem) => stem.linkTarget == target);

  static HebrewStem? fromDisplayName(String displayName) =>
      values.firstWhereOrNull((stem) => stem.displayName.toLowerCase() == displayName.toLowerCase());

  String get linkTarget => 'morphology:stem:$name';

  @override
  String get displayName => morphologyStemTranslation(this).name;

  @override
  String get description => morphologyStemTranslation(this).description;

  @override
  List<String> get examples => morphologyExamples(morphologyStemTranslation(this).examples);
}

enum HebrewAspect implements MorphologyAttributeValue {
  perfect,
  imperfect,
  imperative,
  infinitiveConstruct,
  infinitiveAbsolute,
  participle,
  consecutiveImperfect,
  conjunctiveImperfect,
  conjunctivePerfect,
  passiveParticiple;

  @override
  String get displayName => morphologyAspectTranslation(this).name;

  @override
  String get description => morphologyAspectTranslation(this).description;

  @override
  List<String> get examples => morphologyExamples(morphologyAspectTranslation(this).examples);
}

/// Sub-mood modifying a Hebrew imperfect form (jussive, cohortative, h-suffix).
enum HebrewVerbMood implements MorphologyAttributeValue {
  jussive,
  cohortative,
  hSuffix;

  @override
  String get displayName => morphologyHebrewMoodTranslation(this).name;

  @override
  String get description => morphologyHebrewMoodTranslation(this).description;

  @override
  List<String> get examples => morphologyExamples(morphologyHebrewMoodTranslation(this).examples);
}

enum GreekTense implements MorphologyAttributeValue {
  present,
  imperfect,
  future,
  aorist,
  perfect,
  pluperfect;

  @override
  String get displayName => morphologyTenseTranslation(this).name;

  @override
  String get description => morphologyTenseTranslation(this).description;

  @override
  List<String> get examples => morphologyExamples(morphologyTenseTranslation(this).examples);
}

enum GreekMood implements MorphologyAttributeValue {
  indicative,
  imperative,
  subjunctive,
  optative,
  infinitive,
  participle;

  @override
  String get displayName => morphologyMoodTranslation(this).name;

  @override
  String get description => morphologyMoodTranslation(this).description;

  @override
  List<String> get examples => morphologyExamples(morphologyMoodTranslation(this).examples);
}

enum GreekVoice implements MorphologyAttributeValue {
  active,
  middle,
  passive,
  middleOrPassive;

  @override
  String get displayName => morphologyVoiceTranslation(this).name;

  @override
  String get description => morphologyVoiceTranslation(this).description;

  @override
  List<String> get examples => morphologyExamples(morphologyVoiceTranslation(this).examples);
}

enum Degree implements MorphologyAttributeValue {
  positive,
  comparative,
  superlative;

  @override
  String get displayName => morphologyDegreeTranslation(this).name;

  @override
  String get description => morphologyDegreeTranslation(this).description;

  @override
  List<String> get examples => morphologyExamples(morphologyDegreeTranslation(this).examples);
}

MorphologyAttributeTranslation morphologyAttributeTranslation(MorphologyAttribute attribute) => switch (attribute) {
  .type => (name: t.morphology.attributes.type.name, description: t.morphology.attributes.type.description),
  .grammaticalCase => (
    name: t.morphology.attributes.grammaticalCase.name,
    description: t.morphology.attributes.grammaticalCase.description,
  ),
  .gender => (name: t.morphology.attributes.gender.name, description: t.morphology.attributes.gender.description),
  .number => (name: t.morphology.attributes.number.name, description: t.morphology.attributes.number.description),
  .person => (name: t.morphology.attributes.person.name, description: t.morphology.attributes.person.description),
  .state => (name: t.morphology.attributes.state.name, description: t.morphology.attributes.state.description),
  .tense => (name: t.morphology.attributes.tense.name, description: t.morphology.attributes.tense.description),
  .mood => (name: t.morphology.attributes.mood.name, description: t.morphology.attributes.mood.description),
  .voice => (name: t.morphology.attributes.voice.name, description: t.morphology.attributes.voice.description),
  .degree => (name: t.morphology.attributes.degree.name, description: t.morphology.attributes.degree.description),
  .stem => (name: t.morphology.attributes.stem.name, description: t.morphology.attributes.stem.description),
  .aspect => (name: t.morphology.attributes.aspect.name, description: t.morphology.attributes.aspect.description),
  .prefix => (name: t.morphology.attributes.prefix.name, description: t.morphology.attributes.prefix.description),
  .particle => (name: t.morphology.attributes.particle.name, description: t.morphology.attributes.particle.description),
  .code => (name: t.morphology.attributes.code.name, description: t.morphology.attributes.code.description),
};

MorphologyTranslation morphologyTypeTranslation(MorphologyType type) => switch (type) {
  .article => (
    name: t.morphology.types.article.name,
    description: t.morphology.types.article.description,
    examples: t.morphology.types.article.examples,
  ),
  .conjunction => (
    name: t.morphology.types.conjunction.name,
    description: t.morphology.types.conjunction.description,
    examples: t.morphology.types.conjunction.examples,
  ),
  .preposition => (
    name: t.morphology.types.preposition.name,
    description: t.morphology.types.preposition.description,
    examples: t.morphology.types.preposition.examples,
  ),
  .adverb => (
    name: t.morphology.types.adverb.name,
    description: t.morphology.types.adverb.description,
    examples: t.morphology.types.adverb.examples,
  ),
  .negativeAdverb => (
    name: t.morphology.types.negativeAdverb.name,
    description: t.morphology.types.negativeAdverb.description,
    examples: t.morphology.types.negativeAdverb.examples,
  ),
  .adjective => (
    name: t.morphology.types.adjective.name,
    description: t.morphology.types.adjective.description,
    examples: t.morphology.types.adjective.examples,
  ),
  .noun => (
    name: t.morphology.types.noun.name,
    description: t.morphology.types.noun.description,
    examples: t.morphology.types.noun.examples,
  ),
  .properNoun => (
    name: t.morphology.types.properNoun.name,
    description: t.morphology.types.properNoun.description,
    examples: t.morphology.types.properNoun.examples,
  ),
  .number => (
    name: t.morphology.types.number.name,
    description: t.morphology.types.number.description,
    examples: t.morphology.types.number.examples,
  ),
  .ordinalNumber => (
    name: t.morphology.types.ordinalNumber.name,
    description: t.morphology.types.ordinalNumber.description,
    examples: t.morphology.types.ordinalNumber.examples,
  ),
  .pronoun => (
    name: t.morphology.types.pronoun.name,
    description: t.morphology.types.pronoun.description,
    examples: t.morphology.types.pronoun.examples,
  ),
  .personalPronoun => (
    name: t.morphology.types.personalPronoun.name,
    description: t.morphology.types.personalPronoun.description,
    examples: t.morphology.types.personalPronoun.examples,
  ),
  .demonstrativePronoun => (
    name: t.morphology.types.demonstrativePronoun.name,
    description: t.morphology.types.demonstrativePronoun.description,
    examples: t.morphology.types.demonstrativePronoun.examples,
  ),
  .interrogativePronoun => (
    name: t.morphology.types.interrogativePronoun.name,
    description: t.morphology.types.interrogativePronoun.description,
    examples: t.morphology.types.interrogativePronoun.examples,
  ),
  .indefinitePronoun => (
    name: t.morphology.types.indefinitePronoun.name,
    description: t.morphology.types.indefinitePronoun.description,
    examples: t.morphology.types.indefinitePronoun.examples,
  ),
  .reciprocalPronoun => (
    name: t.morphology.types.reciprocalPronoun.name,
    description: t.morphology.types.reciprocalPronoun.description,
    examples: t.morphology.types.reciprocalPronoun.examples,
  ),
  .reflexivePronoun => (
    name: t.morphology.types.reflexivePronoun.name,
    description: t.morphology.types.reflexivePronoun.description,
    examples: t.morphology.types.reflexivePronoun.examples,
  ),
  .relativePronoun => (
    name: t.morphology.types.relativePronoun.name,
    description: t.morphology.types.relativePronoun.description,
    examples: t.morphology.types.relativePronoun.examples,
  ),
  .particle => (
    name: t.morphology.types.particle.name,
    description: t.morphology.types.particle.description,
    examples: t.morphology.types.particle.examples,
  ),
  .negativeParticle => (
    name: t.morphology.types.negativeParticle.name,
    description: t.morphology.types.negativeParticle.description,
    examples: t.morphology.types.negativeParticle.examples,
  ),
  .interrogativeParticle => (
    name: t.morphology.types.interrogativeParticle.name,
    description: t.morphology.types.interrogativeParticle.description,
    examples: t.morphology.types.interrogativeParticle.examples,
  ),
  .demonstrativeParticle => (
    name: t.morphology.types.demonstrativeParticle.name,
    description: t.morphology.types.demonstrativeParticle.description,
    examples: t.morphology.types.demonstrativeParticle.examples,
  ),
  .genericParticle => (
    name: t.morphology.types.genericParticle.name,
    description: t.morphology.types.genericParticle.description,
    examples: t.morphology.types.genericParticle.examples,
  ),
  .relativeParticle => (
    name: t.morphology.types.relativeParticle.name,
    description: t.morphology.types.relativeParticle.description,
    examples: t.morphology.types.relativeParticle.examples,
  ),
  .verb => (
    name: t.morphology.types.verb.name,
    description: t.morphology.types.verb.description,
    examples: t.morphology.types.verb.examples,
  ),
  .pronominalSuffix => (
    name: t.morphology.types.pronominalSuffix.name,
    description: t.morphology.types.pronominalSuffix.description,
    examples: t.morphology.types.pronominalSuffix.examples,
  ),
  .directObjectMarker => (
    name: t.morphology.types.directObjectMarker.name,
    description: t.morphology.types.directObjectMarker.description,
    examples: t.morphology.types.directObjectMarker.examples,
  ),
  .punctuation => (
    name: t.morphology.types.punctuation.name,
    description: t.morphology.types.punctuation.description,
    examples: t.morphology.types.punctuation.examples,
  ),
  .interjection => (
    name: t.morphology.types.interjection.name,
    description: t.morphology.types.interjection.description,
    examples: t.morphology.types.interjection.examples,
  ),
  .indeclinable => (
    name: t.morphology.types.indeclinable.name,
    description: t.morphology.types.indeclinable.description,
    examples: t.morphology.types.indeclinable.examples,
  ),
  .hebraism => (
    name: t.morphology.types.hebraism.name,
    description: t.morphology.types.hebraism.description,
    examples: t.morphology.types.hebraism.examples,
  ),
  .unknown => (
    name: t.morphology.types.unknown.name,
    description: t.morphology.types.unknown.description,
    examples: t.morphology.types.unknown.examples,
  ),
};

MorphologyTranslation morphologyPersonTranslation(Person person) => switch (person) {
  .first => (
    name: t.morphology.person.first.name,
    description: t.morphology.person.first.description,
    examples: t.morphology.person.first.examples,
  ),
  .second => (
    name: t.morphology.person.second.name,
    description: t.morphology.person.second.description,
    examples: t.morphology.person.second.examples,
  ),
  .third => (
    name: t.morphology.person.third.name,
    description: t.morphology.person.third.description,
    examples: t.morphology.person.third.examples,
  ),
};

MorphologyTranslation morphologyGenderTranslation(GrammaticalGender gender) => switch (gender) {
  .masculine => (
    name: t.morphology.gender.masculine.name,
    description: t.morphology.gender.masculine.description,
    examples: t.morphology.gender.masculine.examples,
  ),
  .feminine => (
    name: t.morphology.gender.feminine.name,
    description: t.morphology.gender.feminine.description,
    examples: t.morphology.gender.feminine.examples,
  ),
  .neuter => (
    name: t.morphology.gender.neuter.name,
    description: t.morphology.gender.neuter.description,
    examples: t.morphology.gender.neuter.examples,
  ),
  .common => (
    name: t.morphology.gender.common.name,
    description: t.morphology.gender.common.description,
    examples: t.morphology.gender.common.examples,
  ),
};

MorphologyTranslation morphologyNumberTranslation(GrammaticalNumber number) => switch (number) {
  .singular => (
    name: t.morphology.number.singular.name,
    description: t.morphology.number.singular.description,
    examples: t.morphology.number.singular.examples,
  ),
  .plural => (
    name: t.morphology.number.plural.name,
    description: t.morphology.number.plural.description,
    examples: t.morphology.number.plural.examples,
  ),
  .dual => (
    name: t.morphology.number.dual.name,
    description: t.morphology.number.dual.description,
    examples: t.morphology.number.dual.examples,
  ),
};

MorphologyTranslation morphologyCaseTranslation(GrammaticalCase grammaticalCase) => switch (grammaticalCase) {
  .nominative => (
    name: t.morphology.kCase.nominative.name,
    description: t.morphology.kCase.nominative.description,
    examples: t.morphology.kCase.nominative.examples,
  ),
  .genitive => (
    name: t.morphology.kCase.genitive.name,
    description: t.morphology.kCase.genitive.description,
    examples: t.morphology.kCase.genitive.examples,
  ),
  .dative => (
    name: t.morphology.kCase.dative.name,
    description: t.morphology.kCase.dative.description,
    examples: t.morphology.kCase.dative.examples,
  ),
  .accusative => (
    name: t.morphology.kCase.accusative.name,
    description: t.morphology.kCase.accusative.description,
    examples: t.morphology.kCase.accusative.examples,
  ),
  .vocative => (
    name: t.morphology.kCase.vocative.name,
    description: t.morphology.kCase.vocative.description,
    examples: t.morphology.kCase.vocative.examples,
  ),
};

MorphologyTranslation morphologyStateTranslation(HebrewState state) => switch (state) {
  .absolute => (
    name: t.morphology.state.absolute.name,
    description: t.morphology.state.absolute.description,
    examples: t.morphology.state.absolute.examples,
  ),
  .construct => (
    name: t.morphology.state.construct.name,
    description: t.morphology.state.construct.description,
    examples: t.morphology.state.construct.examples,
  ),
  .determined => (
    name: t.morphology.state.determined.name,
    description: t.morphology.state.determined.description,
    examples: t.morphology.state.determined.examples,
  ),
};

MorphologyTranslation morphologyStemTranslation(HebrewStem stem) => switch (stem) {
  .qal => (
    name: t.morphology.stem.qal.name,
    description: t.morphology.stem.qal.description,
    examples: t.morphology.stem.qal.examples,
  ),
  .qalPassive => (
    name: t.morphology.stem.qalPassive.name,
    description: t.morphology.stem.qalPassive.description,
    examples: t.morphology.stem.qalPassive.examples,
  ),
  .niphal => (
    name: t.morphology.stem.niphal.name,
    description: t.morphology.stem.niphal.description,
    examples: t.morphology.stem.niphal.examples,
  ),
  .piel => (
    name: t.morphology.stem.piel.name,
    description: t.morphology.stem.piel.description,
    examples: t.morphology.stem.piel.examples,
  ),
  .pual => (
    name: t.morphology.stem.pual.name,
    description: t.morphology.stem.pual.description,
    examples: t.morphology.stem.pual.examples,
  ),
  .hiphil => (
    name: t.morphology.stem.hiphil.name,
    description: t.morphology.stem.hiphil.description,
    examples: t.morphology.stem.hiphil.examples,
  ),
  .hophal => (
    name: t.morphology.stem.hophal.name,
    description: t.morphology.stem.hophal.description,
    examples: t.morphology.stem.hophal.examples,
  ),
  .hithpael => (
    name: t.morphology.stem.hithpael.name,
    description: t.morphology.stem.hithpael.description,
    examples: t.morphology.stem.hithpael.examples,
  ),
  .nithpael => (
    name: t.morphology.stem.nithpael.name,
    description: t.morphology.stem.nithpael.description,
    examples: t.morphology.stem.nithpael.examples,
  ),
};

MorphologyTranslation morphologyAspectTranslation(HebrewAspect aspect) => switch (aspect) {
  .perfect => (
    name: t.morphology.aspect.perfect.name,
    description: t.morphology.aspect.perfect.description,
    examples: t.morphology.aspect.perfect.examples,
  ),
  .imperfect => (
    name: t.morphology.aspect.imperfect.name,
    description: t.morphology.aspect.imperfect.description,
    examples: t.morphology.aspect.imperfect.examples,
  ),
  .imperative => (
    name: t.morphology.aspect.imperative.name,
    description: t.morphology.aspect.imperative.description,
    examples: t.morphology.aspect.imperative.examples,
  ),
  .infinitiveConstruct => (
    name: t.morphology.aspect.infinitiveConstruct.name,
    description: t.morphology.aspect.infinitiveConstruct.description,
    examples: t.morphology.aspect.infinitiveConstruct.examples,
  ),
  .infinitiveAbsolute => (
    name: t.morphology.aspect.infinitiveAbsolute.name,
    description: t.morphology.aspect.infinitiveAbsolute.description,
    examples: t.morphology.aspect.infinitiveAbsolute.examples,
  ),
  .participle => (
    name: t.morphology.aspect.participle.name,
    description: t.morphology.aspect.participle.description,
    examples: t.morphology.aspect.participle.examples,
  ),
  .consecutiveImperfect => (
    name: t.morphology.aspect.consecutiveImperfect.name,
    description: t.morphology.aspect.consecutiveImperfect.description,
    examples: t.morphology.aspect.consecutiveImperfect.examples,
  ),
  .conjunctiveImperfect => (
    name: t.morphology.aspect.conjunctiveImperfect.name,
    description: t.morphology.aspect.conjunctiveImperfect.description,
    examples: t.morphology.aspect.conjunctiveImperfect.examples,
  ),
  .conjunctivePerfect => (
    name: t.morphology.aspect.conjunctivePerfect.name,
    description: t.morphology.aspect.conjunctivePerfect.description,
    examples: t.morphology.aspect.conjunctivePerfect.examples,
  ),
  .passiveParticiple => (
    name: t.morphology.aspect.passiveParticiple.name,
    description: t.morphology.aspect.passiveParticiple.description,
    examples: t.morphology.aspect.passiveParticiple.examples,
  ),
};

MorphologyTranslation morphologyHebrewMoodTranslation(HebrewVerbMood mood) => switch (mood) {
  .jussive => (
    name: t.morphology.hebrewMood.jussive.name,
    description: t.morphology.hebrewMood.jussive.description,
    examples: t.morphology.hebrewMood.jussive.examples,
  ),
  .cohortative => (
    name: t.morphology.hebrewMood.cohortative.name,
    description: t.morphology.hebrewMood.cohortative.description,
    examples: t.morphology.hebrewMood.cohortative.examples,
  ),
  .hSuffix => (
    name: t.morphology.hebrewMood.hSuffix.name,
    description: t.morphology.hebrewMood.hSuffix.description,
    examples: t.morphology.hebrewMood.hSuffix.examples,
  ),
};

MorphologyTranslation morphologyTenseTranslation(GreekTense tense) => switch (tense) {
  .present => (
    name: t.morphology.tense.present.name,
    description: t.morphology.tense.present.description,
    examples: t.morphology.tense.present.examples,
  ),
  .imperfect => (
    name: t.morphology.tense.imperfect.name,
    description: t.morphology.tense.imperfect.description,
    examples: t.morphology.tense.imperfect.examples,
  ),
  .future => (
    name: t.morphology.tense.future.name,
    description: t.morphology.tense.future.description,
    examples: t.morphology.tense.future.examples,
  ),
  .aorist => (
    name: t.morphology.tense.aorist.name,
    description: t.morphology.tense.aorist.description,
    examples: t.morphology.tense.aorist.examples,
  ),
  .perfect => (
    name: t.morphology.tense.perfect.name,
    description: t.morphology.tense.perfect.description,
    examples: t.morphology.tense.perfect.examples,
  ),
  .pluperfect => (
    name: t.morphology.tense.pluperfect.name,
    description: t.morphology.tense.pluperfect.description,
    examples: t.morphology.tense.pluperfect.examples,
  ),
};

MorphologyTranslation morphologyMoodTranslation(GreekMood mood) => switch (mood) {
  .indicative => (
    name: t.morphology.mood.indicative.name,
    description: t.morphology.mood.indicative.description,
    examples: t.morphology.mood.indicative.examples,
  ),
  .imperative => (
    name: t.morphology.mood.imperative.name,
    description: t.morphology.mood.imperative.description,
    examples: t.morphology.mood.imperative.examples,
  ),
  .subjunctive => (
    name: t.morphology.mood.subjunctive.name,
    description: t.morphology.mood.subjunctive.description,
    examples: t.morphology.mood.subjunctive.examples,
  ),
  .optative => (
    name: t.morphology.mood.optative.name,
    description: t.morphology.mood.optative.description,
    examples: t.morphology.mood.optative.examples,
  ),
  .infinitive => (
    name: t.morphology.mood.infinitive.name,
    description: t.morphology.mood.infinitive.description,
    examples: t.morphology.mood.infinitive.examples,
  ),
  .participle => (
    name: t.morphology.mood.participle.name,
    description: t.morphology.mood.participle.description,
    examples: t.morphology.mood.participle.examples,
  ),
};

MorphologyTranslation morphologyVoiceTranslation(GreekVoice voice) => switch (voice) {
  .active => (
    name: t.morphology.voice.active.name,
    description: t.morphology.voice.active.description,
    examples: t.morphology.voice.active.examples,
  ),
  .middle => (
    name: t.morphology.voice.middle.name,
    description: t.morphology.voice.middle.description,
    examples: t.morphology.voice.middle.examples,
  ),
  .passive => (
    name: t.morphology.voice.passive.name,
    description: t.morphology.voice.passive.description,
    examples: t.morphology.voice.passive.examples,
  ),
  .middleOrPassive => (
    name: t.morphology.voice.middleOrPassive.name,
    description: t.morphology.voice.middleOrPassive.description,
    examples: t.morphology.voice.middleOrPassive.examples,
  ),
};

MorphologyTranslation morphologyDegreeTranslation(Degree degree) => switch (degree) {
  .positive => (
    name: t.morphology.degree.positive.name,
    description: t.morphology.degree.positive.description,
    examples: t.morphology.degree.positive.examples,
  ),
  .comparative => (
    name: t.morphology.degree.comparative.name,
    description: t.morphology.degree.comparative.description,
    examples: t.morphology.degree.comparative.examples,
  ),
  .superlative => (
    name: t.morphology.degree.superlative.name,
    description: t.morphology.degree.superlative.description,
    examples: t.morphology.degree.superlative.examples,
  ),
};

sealed class Morphology {
  const Morphology();

  static List<String> splitCode(String code) =>
      code.split(RegExp(r'\s*[|,]\s*')).map((s) => s.trim()).where((s) => s.isNotEmpty).toList();

  /// Parses a full morphology code. Components are separated by `|` or `,`.
  static List<Morphology> fromCodes(String code) => splitCode(code).map(_parseOne).toList();

  /// Parses a single component (no separators).
  static Morphology parse(String part) => _parseOne(part);

  /// Structured key/value pairs intended for UI display.
  Map<MorphologyAttribute, MorphologyAttributeValue> get attributes;

  /// Concise human-readable summary (e.g. "Noun, Feminine, Singular").
  String get description => attributes.values.map((v) => v.displayName).join(', ');

  @override
  String toString() => description;

  static Morphology _parseOne(String part) {
    final tokens = part.split('-');
    final head = tokens.first;
    final rest = tokens.sublist(1);
    return switch (head) {
      'Adj' => MorphologyAdjective._parse(rest),
      'Adv' => MorphologyAdverb._parse(rest),
      'Art' => MorphologyArticle._parse(rest),
      'Conj' => MorphologyConjunction._parse(rest),
      'N' || 'Noun' => MorphologyNoun._parse(rest),
      'Number' => MorphologyNumber._parse(rest),
      'V' || 'Verb' => MorphologyVerb._parse(rest),
      'Prep' => MorphologyPreposition._parse(rest),
      'DirObjM' => MorphologyDirectObjectMarker(),
      'Punc' => MorphologyPunctuation(),
      'I' || 'Interjection' => MorphologyInterjection(),
      'Indec' => MorphologyIndeclinable(),
      'Heb' => MorphologyHebraism(),
      'Interrog' || 'IntPrtcl' || 'Pi' => MorphologyParticle(kind: .interrogativeParticle),
      'Pn' => MorphologyParticle(kind: .negativeParticle),
      'Pd' => MorphologyParticle(kind: .demonstrativeParticle),
      'Pg' => MorphologyParticle(kind: .genericParticle),
      'Pr' => MorphologyParticle(kind: .relativeParticle),
      'Prtcl' => MorphologyParticle(),
      'Pro' => MorphologyPronoun._parse(rest, kind: .pronoun),
      'PPro' => MorphologyPronoun._parse(rest, kind: .personalPronoun),
      'DPro' => MorphologyPronoun._parse(rest, kind: .demonstrativePronoun),
      'IPro' => MorphologyPronoun._parse(rest, kind: .interrogativePronoun),
      'RecPro' => MorphologyPronoun._parse(rest, kind: .reciprocalPronoun),
      'RefPro' => MorphologyPronoun._parse(rest, kind: .reflexivePronoun),
      'RelPro' => MorphologyPronoun._parse(rest, kind: .relativePronoun),
      _ => MorphologyPronominalSuffix._tryParse(part) ?? MorphologyUnknown(part),
    };
  }
}

class MorphologyArticle extends Morphology {
  final MorphologyLanguage language;
  final GrammaticalCase? grammaticalCase;
  final GrammaticalGender? gender;
  final GrammaticalNumber? number;

  const MorphologyArticle({this.language = .hebrew, this.grammaticalCase, this.gender, this.number});

  factory MorphologyArticle._parse(List<String> tokens) {
    if (tokens.isEmpty) return MorphologyArticle();
    final cgn = _GreekCgn.tryParse(tokens.first);
    if (cgn == null) return MorphologyArticle();
    return MorphologyArticle(
      language: .greek,
      grammaticalCase: cgn.grammaticalCase,
      gender: cgn.gender,
      number: cgn.number,
    );
  }

  @override
  Map<MorphologyAttribute, MorphologyAttributeValue> get attributes => {
    .type: MorphologyType.article,
    .grammaticalCase: ?grammaticalCase,
    .gender: ?gender,
    .number: ?number,
  };
}

class MorphologyConjunction extends Morphology {
  /// `w` for the Hebrew waw conjunction; null for the generic Greek conjunction.
  final String? particle;

  const MorphologyConjunction({this.particle});

  factory MorphologyConjunction._parse(List<String> tokens) => MorphologyConjunction(particle: tokens.firstOrNull);

  @override
  Map<MorphologyAttribute, MorphologyAttributeValue> get attributes => {
    .type: MorphologyType.conjunction,
    .particle: ?_conjunctionParticleValue(particle),
  };
}

class MorphologyPreposition extends Morphology {
  /// Hebrew prefix preposition letter (`b`, `k`, `l`, `m`); null for a standalone preposition.
  final String? prefix;

  const MorphologyPreposition({this.prefix});

  factory MorphologyPreposition._parse(List<String> tokens) => MorphologyPreposition(prefix: tokens.firstOrNull);

  @override
  Map<MorphologyAttribute, MorphologyAttributeValue> get attributes => {
    .type: MorphologyType.preposition,
    .prefix: ?_prepositionPrefixValue(prefix),
  };
}

class MorphologyAdverb extends Morphology {
  /// Optional flag from BibleHub Greek codes:
  /// `C` (comparative), `S` (superlative), `NegPrt` (negative particle).
  final String? modifier;

  const MorphologyAdverb({this.modifier});

  factory MorphologyAdverb._parse(List<String> tokens) => MorphologyAdverb(modifier: tokens.firstOrNull);

  MorphologyType get _type => switch (modifier) {
    'NegPrt' => .negativeAdverb,
    _ => .adverb,
  };

  Degree? get _degree => switch (modifier) {
    'C' => .comparative,
    'S' => .superlative,
    _ => null,
  };

  @override
  Map<MorphologyAttribute, MorphologyAttributeValue> get attributes => {.type: _type, .degree: ?_degree};
}

class MorphologyAdjective extends Morphology {
  final MorphologyLanguage language;
  final GrammaticalCase? grammaticalCase;
  final GrammaticalGender? gender;
  final GrammaticalNumber? number;
  final HebrewState? state;
  final Degree degree;

  const MorphologyAdjective({
    required this.language,
    this.grammaticalCase,
    this.gender,
    this.number,
    this.state,
    this.degree = .positive,
  });

  factory MorphologyAdjective._parse(List<String> tokens) {
    if (tokens.isEmpty) return MorphologyAdjective(language: .hebrew);
    final first = tokens.first;
    final cgn = _GreekCgn.tryParse(first);
    if (cgn != null) {
      return MorphologyAdjective(
        language: .greek,
        grammaticalCase: cgn.grammaticalCase,
        gender: cgn.gender,
        number: cgn.number,
        degree: tokens.length > 1
            ? switch (tokens[1]) {
                'C' => .comparative,
                'S' => .superlative,
                _ => .positive,
              }
            : .positive,
      );
    }
    final hebrew = _HebrewGns.tryParse(first);
    return MorphologyAdjective(language: .hebrew, gender: hebrew?.gender, number: hebrew?.number, state: hebrew?.state);
  }

  @override
  Map<MorphologyAttribute, MorphologyAttributeValue> get attributes => {
    .type: MorphologyType.adjective,
    .grammaticalCase: ?grammaticalCase,
    .gender: ?gender,
    .number: ?number,
    if (state != .absolute) .state: ?state,
    if (degree != .positive) .degree: degree,
  };
}

class MorphologyNoun extends Morphology {
  final MorphologyLanguage language;
  final GrammaticalCase? grammaticalCase;
  final GrammaticalGender? gender;
  final GrammaticalNumber? number;
  final HebrewState? state;
  final bool proper;

  const MorphologyNoun({
    required this.language,
    this.grammaticalCase,
    this.gender,
    this.number,
    this.state,
    this.proper = false,
  });

  factory MorphologyNoun._parse(List<String> tokens) {
    if (tokens.isEmpty) return MorphologyNoun(language: .hebrew);
    var rest = tokens;
    var proper = false;
    if (rest.first == 'proper') {
      proper = true;
      rest = rest.sublist(1);
    }
    if (rest.isEmpty) return MorphologyNoun(language: .hebrew, proper: proper);
    final cgn = _GreekCgn.tryParse(rest.first);
    if (cgn != null) {
      return MorphologyNoun(
        language: .greek,
        grammaticalCase: cgn.grammaticalCase,
        gender: cgn.gender,
        number: cgn.number,
        proper: proper,
      );
    }
    final hebrew = _HebrewGns.tryParse(rest.first);
    return MorphologyNoun(
      language: .hebrew,
      gender: hebrew?.gender,
      number: hebrew?.number,
      state: hebrew?.state,
      proper: proper,
    );
  }

  @override
  Map<MorphologyAttribute, MorphologyAttributeValue> get attributes => {
    .type: proper ? MorphologyType.properNoun : MorphologyType.noun,
    .grammaticalCase: ?grammaticalCase,
    .gender: ?gender,
    .number: ?number,
    if (state != HebrewState.absolute) .state: ?state,
  };
}

class MorphologyNumber extends Morphology {
  final GrammaticalGender? gender;
  final GrammaticalNumber? number;
  final HebrewState? state;
  final bool ordinal;

  const MorphologyNumber({this.gender, this.number, this.state, this.ordinal = false});

  factory MorphologyNumber._parse(List<String> tokens) {
    if (tokens.isEmpty) return MorphologyNumber();
    var raw = tokens.first;
    var ordinal = false;
    if (raw.startsWith('o') && raw.length > 1) {
      ordinal = true;
      raw = raw.substring(1);
    }
    final hebrew = _HebrewGns.tryParse(raw);
    return MorphologyNumber(gender: hebrew?.gender, number: hebrew?.number, state: hebrew?.state, ordinal: ordinal);
  }

  @override
  Map<MorphologyAttribute, MorphologyAttributeValue> get attributes => {
    .type: ordinal ? MorphologyType.ordinalNumber : MorphologyType.number,
    .gender: ?gender,
    .number: ?number,
    if (state != .absolute) .state: ?state,
  };
}

class MorphologyPronoun extends Morphology {
  /// One of the pronoun [MorphologyType] variants — `pronoun`, `personalPronoun`,
  /// `demonstrativePronoun`, `interrogativePronoun`, `indefinitePronoun`,
  /// `reciprocalPronoun`, `reflexivePronoun`, `relativePronoun`.
  final MorphologyType kind;
  final MorphologyLanguage language;
  final Person? person;
  final GrammaticalCase? grammaticalCase;
  final GrammaticalGender? gender;
  final GrammaticalNumber? number;

  const MorphologyPronoun({
    this.kind = .pronoun,
    this.language = .hebrew,
    this.person,
    this.grammaticalCase,
    this.gender,
    this.number,
  });

  factory MorphologyPronoun._parse(List<String> tokens, {required MorphologyType kind}) {
    if (tokens.isEmpty) return MorphologyPronoun(kind: kind);
    final raw = tokens.first;
    final greek = _GreekPronoun.tryParse(raw);
    if (greek != null) {
      return MorphologyPronoun(
        kind: kind,
        language: .greek,
        person: greek.person,
        grammaticalCase: greek.grammaticalCase,
        gender: greek.gender,
        number: greek.number,
      );
    }
    final hebrew = _HebrewPronoun.tryParse(raw);
    if (hebrew != null) {
      return MorphologyPronoun(
        kind: kind,
        language: .hebrew,
        person: hebrew.person,
        gender: hebrew.gender,
        number: hebrew.number,
      );
    }
    return MorphologyPronoun(kind: kind);
  }

  @override
  Map<MorphologyAttribute, MorphologyAttributeValue> get attributes => {
    .type: kind,
    .grammaticalCase: ?grammaticalCase,
    .gender: ?gender,
    .person: ?person,
    .number: ?number,
  };
}

class MorphologyParticle extends Morphology {
  /// One of the particle [MorphologyType] variants — `particle`,
  /// `negativeParticle`, `interrogativeParticle`, `demonstrativeParticle`,
  /// `genericParticle`, `relativeParticle`.
  final MorphologyType kind;

  const MorphologyParticle({this.kind = .particle});

  @override
  Map<MorphologyAttribute, MorphologyAttributeValue> get attributes => {.type: kind};
}

sealed class MorphologyVerb extends Morphology {
  const MorphologyVerb();

  factory MorphologyVerb._parse(List<String> tokens) {
    if (tokens.isEmpty) return MorphologyGreekVerb();
    return _hebrewStem(tokens.first) != null ? MorphologyHebrewVerb._parse(tokens) : MorphologyGreekVerb._parse(tokens);
  }
}

class MorphologyHebrewVerb extends MorphologyVerb {
  final HebrewStem stem;
  final HebrewAspect aspect;
  final HebrewVerbMood? mood;
  final Person? person;
  final GrammaticalGender? gender;
  final GrammaticalNumber? number;
  final HebrewState? state;

  const MorphologyHebrewVerb({
    required this.stem,
    required this.aspect,
    this.mood,
    this.person,
    this.gender,
    this.number,
    this.state,
  });

  factory MorphologyHebrewVerb._parse(List<String> tokens) {
    final stem = _hebrewStem(tokens.first) ?? HebrewStem.qal;
    var aspect = HebrewAspect.perfect;
    HebrewVerbMood? mood;

    if (tokens.length > 1) {
      final aspectToken = tokens[1];
      final dot = aspectToken.indexOf('.');
      final base = dot == -1 ? aspectToken : aspectToken.substring(0, dot);
      final modifier = dot == -1 ? null : aspectToken.substring(dot + 1);
      aspect = _hebrewAspect(base) ?? HebrewAspect.perfect;
      mood = switch (modifier) {
        'Jus' => .jussive,
        'Cohort' => .cohortative,
        'h' => .hSuffix,
        _ => null,
      };
    }

    Person? person;
    GrammaticalGender? gender;
    GrammaticalNumber? number;
    HebrewState? state;

    for (final token in tokens.skip(2)) {
      final pgn = _hebrewPgn(token);
      if (pgn != null) {
        person = pgn.person;
        gender = pgn.gender;
        number = pgn.number;
        continue;
      }
      final gns = _HebrewGns.tryParse(token);
      if (gns != null) {
        gender = gns.gender;
        number = gns.number;
        state = gns.state;
      }
    }

    return MorphologyHebrewVerb(
      stem: stem,
      aspect: aspect,
      mood: mood,
      person: person,
      gender: gender,
      number: number,
      state: state,
    );
  }

  @override
  Map<MorphologyAttribute, MorphologyAttributeValue> get attributes => {
    .type: MorphologyType.verb,
    .stem: stem,
    .aspect: aspect,
    .mood: ?mood,
    .person: ?person,
    .gender: ?gender,
    .number: ?number,
    if (state != HebrewState.absolute) MorphologyAttribute.state: ?state,
  };
}

class MorphologyGreekVerb extends MorphologyVerb {
  final GreekTense? tense;
  final GreekMood? mood;
  final GreekVoice? voice;
  final Person? person;
  final GrammaticalNumber? number;
  final GrammaticalCase? grammaticalCase;
  final GrammaticalGender? gender;

  const MorphologyGreekVerb({
    this.tense,
    this.mood,
    this.voice,
    this.person,
    this.number,
    this.grammaticalCase,
    this.gender,
  });

  factory MorphologyGreekVerb._parse(List<String> tokens) {
    GreekTense? tense;
    GreekMood? mood;
    GreekVoice? voice;
    Person? person;
    GrammaticalNumber? number;
    GrammaticalCase? grammaticalCase;
    GrammaticalGender? gender;

    if (tokens.isNotEmpty) {
      final code = tokens.first;
      final slash = code.indexOf('/');
      final voiceCode = slash == -1 ? (code.isEmpty ? '' : code.substring(code.length - 1)) : code.substring(slash - 1);
      final core = slash == -1 ? code : code.substring(0, slash - 1);
      voice = _greekVoice(voiceCode);
      if (core.isNotEmpty) tense = _greekTense(core[0]);
      if (core.length >= 2) mood = _greekMood(core[1]);
    }

    if (tokens.length > 1) {
      final suffix = tokens[1];
      final pn = _GreekPersonNumber.tryParse(suffix);
      if (pn != null) {
        person = pn.person;
        number = pn.number;
      } else {
        final cgn = _GreekCgn.tryParse(suffix);
        if (cgn != null) {
          grammaticalCase = cgn.grammaticalCase;
          gender = cgn.gender;
          number = cgn.number;
        }
      }
    }

    return MorphologyGreekVerb(
      tense: tense,
      mood: mood,
      voice: voice,
      person: person,
      number: number,
      grammaticalCase: grammaticalCase,
      gender: gender,
    );
  }

  @override
  Map<MorphologyAttribute, MorphologyAttributeValue> get attributes {
    final isParticiple = mood == .participle;
    return {
      .type: MorphologyType.verb,
      .tense: ?tense,
      .mood: ?mood,
      .voice: ?voice,
      if (isParticiple) .grammaticalCase: ?grammaticalCase,
      if (isParticiple) .gender: ?gender,
      if (!isParticiple) .person: ?person,
      .number: ?number,
    };
  }
}

/// A pronominal suffix attached to a verb or noun (Hebrew).
/// E.g., the trailing `3ms` in `V-Qal-Imperf-3ms | 3ms`.
class MorphologyPronominalSuffix extends Morphology {
  final Person? person;
  final GrammaticalGender? gender;
  final GrammaticalNumber? number;

  const MorphologyPronominalSuffix({this.person, this.gender, this.number});

  static MorphologyPronominalSuffix? _tryParse(String raw) {
    final match = RegExp(r'^([123])([cmf])([sp])[\w.]*$').firstMatch(raw);
    if (match == null) return null;
    return MorphologyPronominalSuffix(
      person: switch (match.group(1)) {
        '1' => .first,
        '2' => .second,
        '3' => .third,
        _ => null,
      },
      gender: switch (match.group(2)) {
        'm' => .masculine,
        'f' => .feminine,
        'c' => .common,
        _ => null,
      },
      number: switch (match.group(3)) {
        's' => .singular,
        'p' => .plural,
        _ => null,
      },
    );
  }

  @override
  Map<MorphologyAttribute, MorphologyAttributeValue> get attributes => {
    .type: MorphologyType.pronominalSuffix,
    .person: ?person,
    .gender: ?gender,
    .number: ?number,
  };
}

class MorphologyDirectObjectMarker extends Morphology {
  const MorphologyDirectObjectMarker();

  @override
  Map<MorphologyAttribute, MorphologyAttributeValue> get attributes => {.type: MorphologyType.directObjectMarker};
}

class MorphologyPunctuation extends Morphology {
  const MorphologyPunctuation();

  @override
  Map<MorphologyAttribute, MorphologyAttributeValue> get attributes => {.type: MorphologyType.punctuation};
}

class MorphologyInterjection extends Morphology {
  const MorphologyInterjection();

  @override
  Map<MorphologyAttribute, MorphologyAttributeValue> get attributes => {.type: MorphologyType.interjection};
}

class MorphologyIndeclinable extends Morphology {
  const MorphologyIndeclinable();

  @override
  Map<MorphologyAttribute, MorphologyAttributeValue> get attributes => {.type: MorphologyType.indeclinable};
}

class MorphologyHebraism extends Morphology {
  const MorphologyHebraism();

  @override
  Map<MorphologyAttribute, MorphologyAttributeValue> get attributes => {.type: MorphologyType.hebraism};
}

/// Fallback for codes that don't match any known pattern.
class MorphologyUnknown extends Morphology {
  final String code;

  const MorphologyUnknown(this.code);

  @override
  Map<MorphologyAttribute, MorphologyAttributeValue> get attributes => {
    .type: MorphologyType.unknown,
    .code: MorphologyAttributeLiteral(displayName: code, description: t.morphology.literals.rawCode),
  };
}

// ---------- internal parsing helpers ----------

MorphologyAttributeValue? _conjunctionParticleValue(String? particle) => switch (particle) {
  null => null,
  'w' => MorphologyAttributeLiteral(
    displayName: 'w',
    description: t.morphology.literals.waw,
    examples: morphologyExamples(t.morphology.literals.wawExamples),
  ),
  final p => MorphologyAttributeLiteral(displayName: p, description: t.morphology.literals.conjunction),
};

MorphologyAttributeValue? _prepositionPrefixValue(String? prefix) => switch (prefix) {
  null => null,
  'b' => MorphologyAttributeLiteral(
    displayName: 'b',
    description: t.morphology.literals.bet,
    examples: morphologyExamples(t.morphology.literals.betExamples),
  ),
  'k' => MorphologyAttributeLiteral(
    displayName: 'k',
    description: t.morphology.literals.kaf,
    examples: morphologyExamples(t.morphology.literals.kafExamples),
  ),
  'l' => MorphologyAttributeLiteral(
    displayName: 'l',
    description: t.morphology.literals.lamed,
    examples: morphologyExamples(t.morphology.literals.lamedExamples),
  ),
  'm' => MorphologyAttributeLiteral(
    displayName: 'm',
    description: t.morphology.literals.mem,
    examples: morphologyExamples(t.morphology.literals.memExamples),
  ),
  final p => MorphologyAttributeLiteral(displayName: p, description: t.morphology.literals.preposition),
};

class _GreekCgn {
  final GrammaticalCase grammaticalCase;
  final GrammaticalGender gender;
  final GrammaticalNumber number;

  const _GreekCgn(this.grammaticalCase, this.gender, this.number);

  static _GreekCgn? tryParse(String raw) {
    if (raw.length != 3) return null;
    final c = _greekCase(raw[0]);
    final g = _greekGender(raw[1]);
    final n = _greekNumber(raw[2]);
    if (c == null || g == null || n == null) return null;
    return _GreekCgn(c, g, n);
  }
}

class _GreekPersonNumber {
  final Person person;
  final GrammaticalNumber number;

  const _GreekPersonNumber(this.person, this.number);

  static _GreekPersonNumber? tryParse(String raw) {
    if (raw.length != 2) return null;
    final p = switch (raw[0]) {
      '1' => Person.first,
      '2' => Person.second,
      '3' => Person.third,
      _ => null,
    };
    final n = _greekNumber(raw[1]);
    if (p == null || n == null) return null;
    return _GreekPersonNumber(p, n);
  }
}

class _GreekPronoun {
  final Person? person;
  final GrammaticalCase? grammaticalCase;
  final GrammaticalGender? gender;
  final GrammaticalNumber? number;

  const _GreekPronoun({this.person, this.grammaticalCase, this.gender, this.number});

  /// Parses Greek pronoun suffixes such as `A1S`, `AF3P`, `D2P`.
  static _GreekPronoun? tryParse(String raw) {
    final m = RegExp(r'^([NGDAV])([MFN])?([123])?([SP])$').firstMatch(raw);
    if (m == null) return null;
    return _GreekPronoun(
      grammaticalCase: _greekCase(m.group(1)!),
      gender: m.group(2) == null ? null : _greekGender(m.group(2)!),
      person: switch (m.group(3)) {
        '1' => .first,
        '2' => .second,
        '3' => .third,
        _ => null,
      },
      number: _greekNumber(m.group(4)!),
    );
  }
}

class _HebrewGns {
  final GrammaticalGender? gender;
  final GrammaticalNumber? number;
  final HebrewState? state;

  const _HebrewGns({this.gender, this.number, this.state});

  /// Parses lowercase Hebrew gender/number/state codes:
  /// `fs`, `mp`, `cd`, `fsc`, `msd`, etc.
  static _HebrewGns? tryParse(String raw) {
    final m = RegExp(r'^([mfc])([spd])([cd])?$').firstMatch(raw);
    if (m == null) return null;
    return _HebrewGns(
      gender: switch (m.group(1)) {
        'm' => .masculine,
        'f' => .feminine,
        'c' => .common,
        _ => null,
      },
      number: switch (m.group(2)) {
        's' => .singular,
        'p' => .plural,
        'd' => .dual,
        _ => null,
      },
      state: switch (m.group(3)) {
        'c' => .construct,
        'd' => .determined,
        _ => .absolute,
      },
    );
  }
}

class _HebrewPronoun {
  final Person? person;
  final GrammaticalGender? gender;
  final GrammaticalNumber? number;

  const _HebrewPronoun({this.person, this.gender, this.number});

  /// Parses hebrew pronoun codes such as `1cs`, `3ms`, `cp`, `r`, `fs`.
  static _HebrewPronoun? tryParse(String raw) {
    if (raw == 'r') return _HebrewPronoun();
    final pgn = _hebrewPgn(raw);
    if (pgn != null) return _HebrewPronoun(person: pgn.person, gender: pgn.gender, number: pgn.number);
    final gn = _HebrewGns.tryParse(raw);
    if (gn != null) return _HebrewPronoun(gender: gn.gender, number: gn.number);
    return null;
  }
}

class _HebrewPgn {
  final Person person;
  final GrammaticalGender gender;
  final GrammaticalNumber number;

  const _HebrewPgn(this.person, this.gender, this.number);
}

_HebrewPgn? _hebrewPgn(String raw) {
  final m = RegExp(r'^([123])([cmf])([sp])[\w.]*$').firstMatch(raw);
  if (m == null) return null;
  final p = switch (m.group(1)) {
    '1' => Person.first,
    '2' => Person.second,
    '3' => Person.third,
    _ => null,
  };
  final g = switch (m.group(2)) {
    'm' => GrammaticalGender.masculine,
    'f' => GrammaticalGender.feminine,
    'c' => GrammaticalGender.common,
    _ => null,
  };
  final n = switch (m.group(3)) {
    's' => GrammaticalNumber.singular,
    'p' => GrammaticalNumber.plural,
    _ => null,
  };
  if (p == null || g == null || n == null) return null;
  return _HebrewPgn(p, g, n);
}

GrammaticalCase? _greekCase(String c) => switch (c) {
  'N' => .nominative,
  'G' => .genitive,
  'D' => .dative,
  'A' => .accusative,
  'V' => .vocative,
  _ => null,
};

GrammaticalGender? _greekGender(String c) => switch (c) {
  'M' => .masculine,
  'F' => .feminine,
  'N' => .neuter,
  _ => null,
};

GrammaticalNumber? _greekNumber(String c) => switch (c) {
  'S' => .singular,
  'P' => .plural,
  'D' => .dual,
  _ => null,
};

GreekTense? _greekTense(String c) => switch (c) {
  'P' => .present,
  'I' => .imperfect,
  'F' => .future,
  'A' => .aorist,
  'R' => .perfect,
  'L' => .pluperfect,
  _ => null,
};

GreekMood? _greekMood(String c) => switch (c) {
  'I' => .indicative,
  'M' => .imperative,
  'S' => .subjunctive,
  'O' => .optative,
  'N' => .infinitive,
  'P' => .participle,
  _ => null,
};

GreekVoice? _greekVoice(String code) => switch (code) {
  'A' => .active,
  'M' => .middle,
  'P' => .passive,
  'M/P' => .middleOrPassive,
  _ => null,
};

HebrewStem? _hebrewStem(String s) => switch (s) {
  'Qal' => .qal,
  'QalPass' => .qalPassive,
  'Nifal' || 'Niphal' => .niphal,
  'Piel' => .piel,
  'Pual' => .pual,
  'Hifil' || 'Hiphil' => .hiphil,
  'Hofal' || 'Hophal' => .hophal,
  'Hitpael' || 'Hithpael' => .hithpael,
  'Nithpael' => .nithpael,
  _ => null,
};

HebrewAspect? _hebrewAspect(String s) => switch (s) {
  'Perf' => .perfect,
  'Imperf' => .imperfect,
  'Imp' => .imperative,
  'Inf' => .infinitiveConstruct,
  'InfAbs' => .infinitiveAbsolute,
  'Prtcpl' => .participle,
  'ConsecImperf' => .consecutiveImperfect,
  'ConjImperf' => .conjunctiveImperfect,
  'ConjPerf' => .conjunctivePerfect,
  'QalPassPrtcpl' => .passiveParticiple,
  _ => null,
};
