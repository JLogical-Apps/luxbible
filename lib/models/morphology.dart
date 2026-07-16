import 'package:collection/collection.dart';

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

  String get displayName => switch (this) {
    type => 'Type',
    grammaticalCase => 'Case',
    gender => 'Gender',
    number => 'Number',
    person => 'Person',
    state => 'State',
    tense => 'Tense',
    mood => 'Mood',
    voice => 'Voice',
    degree => 'Degree',
    stem => 'Stem',
    aspect => 'Aspect',
    prefix => 'Prefix',
    particle => 'Particle',
    code => 'Code',
  };

  String get description => switch (this) {
    type => 'The grammatical category of the word.',
    grammaticalCase => 'The case marks the syntactic role — subject, object, possession, etc.',
    gender => 'Grammatical gender — masculine, feminine, neuter (Greek), or common (Hebrew).',
    number => 'Whether the word refers to one (singular), two (dual), or many (plural).',
    person => 'Who the word refers to — 1st (I/we), 2nd (you), or 3rd (he/she/it/they).',
    state => 'The state of a noun — absolute, construct, or determined.',
    tense => 'The verb tense — combines time and aspect.',
    mood => 'How the action is expressed — fact, command, possibility, etc.',
    voice => 'The voice — active, middle, or passive.',
    degree => 'The degree of an adjective or adverb — positive, comparative, or superlative.',
    stem => 'The verb stem (binyan) — qal, niphal, piel, etc.',
    aspect => 'The verb aspect — perfect, imperfect, participle, etc.',
    prefix => 'A Hebrew prefixed preposition letter.',
    particle => 'A small uninflected word — often a conjunction or marker.',
    code => 'The raw morphology code as it appears in the source text.',
  };
}

enum Language {
  hebrew,
  greek;

  String get displayName => switch (this) {
    .hebrew => 'Hebrew',
    .greek => 'Greek',
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
  String get displayName => switch (this) {
    article => 'Article',
    conjunction => 'Conjunction',
    preposition => 'Preposition',
    adverb => 'Adverb',
    negativeAdverb => 'Negative adverb',
    adjective => 'Adjective',
    noun => 'Noun',
    properNoun => 'Proper noun',
    number => 'Number',
    ordinalNumber => 'Ordinal number',
    pronoun => 'Pronoun',
    personalPronoun => 'Personal pronoun',
    demonstrativePronoun => 'Demonstrative pronoun',
    interrogativePronoun => 'Interrogative pronoun',
    indefinitePronoun => 'Indefinite pronoun',
    reciprocalPronoun => 'Reciprocal pronoun',
    reflexivePronoun => 'Reflexive pronoun',
    relativePronoun => 'Relative pronoun',
    particle => 'Particle',
    negativeParticle => 'Negative particle',
    interrogativeParticle => 'Interrogative particle',
    demonstrativeParticle => 'Demonstrative particle',
    genericParticle => 'Generic particle',
    relativeParticle => 'Relative particle',
    verb => 'Verb',
    pronominalSuffix => 'Pronominal suffix',
    directObjectMarker => 'Direct object marker',
    punctuation => 'Punctuation',
    interjection => 'Interjection',
    indeclinable => 'Indeclinable',
    hebraism => 'Hebrew loanword',
    unknown => 'Unknown',
  };

  @override
  String get description => switch (this) {
    article => 'A definite article — "the".',
    conjunction => 'A word that joins other words or clauses.',
    preposition => 'Relates a noun or pronoun to other words.',
    adverb => 'Modifies a verb, adjective, or another adverb.',
    negativeAdverb => 'An adverb expressing negation.',
    adjective => 'A word that describes a noun.',
    noun => 'A person, place, thing, or idea.',
    properNoun => 'A specific name of a person, place, or thing.',
    number => 'A cardinal number.',
    ordinalNumber => 'An ordinal number — "first", "second", and so on.',
    pronoun => 'A word that stands in for a noun.',
    personalPronoun => 'A pronoun that refers to a specific person — I, you, he, she.',
    demonstrativePronoun => 'A pronoun that points to something — "this", "that".',
    interrogativePronoun => 'A pronoun used to ask a question — "who", "what".',
    indefinitePronoun => 'A pronoun referring to non-specific entities.',
    reciprocalPronoun => 'A pronoun expressing mutual action — "one another".',
    reflexivePronoun => 'A pronoun referring back to the subject — "himself", "themselves".',
    relativePronoun => 'A pronoun introducing a subordinate clause — "who", "which", "that".',
    particle => 'A small uninflected word.',
    negativeParticle => 'A particle that marks negation.',
    interrogativeParticle => 'A particle that marks a question.',
    demonstrativeParticle => 'A pointing particle — "behold".',
    genericParticle => 'A general-purpose particle.',
    relativeParticle => 'A particle that introduces a relative clause.',
    verb => 'A word expressing an action or state.',
    pronominalSuffix => 'A pronoun fused to the end of a verb or noun (Hebrew).',
    directObjectMarker => 'The Hebrew אֵת that marks a definite direct object.',
    punctuation => 'A punctuation mark.',
    interjection => 'A short exclamation expressing emotion.',
    indeclinable => 'A word that does not change form by inflection.',
    hebraism => 'A Hebrew or Aramaic loanword carried into Greek.',
    unknown => 'A morphology code that the parser did not recognize.',
  };

  @override
  List<String> get examples => switch (this) {
    article => ['the king', 'the Lord'],
    conjunction => ['and', 'but', 'for'],
    preposition => ['in', 'to', 'with'],
    adverb => ['quickly', 'now', 'there'],
    negativeAdverb => ['not', 'never'],
    adjective => ['great', 'holy', 'wise'],
    noun => ['city', 'water', 'love'],
    properNoun => ['David', 'Jerusalem', 'Israel'],
    number => ['three', 'twelve', 'thousand'],
    ordinalNumber => ['first', 'tenth', 'seventieth'],
    pronoun => ['he', 'she', 'they'],
    personalPronoun => ['I', 'you', 'we'],
    demonstrativePronoun => ['this', 'these', 'those'],
    interrogativePronoun => ['who?', 'what?', 'which?'],
    indefinitePronoun => ['someone', 'anyone', 'nothing'],
    reciprocalPronoun => ['one another', 'each other'],
    reflexivePronoun => ['himself', 'themselves'],
    relativePronoun => ['who', 'which', 'that'],
    particle => ['indeed', 'now'],
    negativeParticle => ['not', 'no'],
    interrogativeParticle => ['(Hebrew prefix ה, no English equivalent)'],
    demonstrativeParticle => ['behold', 'lo'],
    genericParticle => ['indeed', 'truly'],
    relativeParticle => ['that', 'which'],
    verb => ['write', 'be', 'go'],
    pronominalSuffix => ['his hand', 'their land', 'her voice'],
    directObjectMarker => ['אֵת (no English equivalent)'],
    punctuation => ['.', ',', ';'],
    interjection => ['oh!', 'alas!'],
    indeclinable => ['Hosanna', 'Hallelujah'],
    hebraism => ['Amen', 'Hosanna', 'Sabaoth'],
    unknown => [],
  };
}

enum Person implements MorphologyAttributeValue {
  first,
  second,
  third;

  @override
  String get displayName => switch (this) {
    first => '1st person',
    second => '2nd person',
    third => '3rd person',
  };

  @override
  String get description => switch (this) {
    first => 'The speaker — "I" or "we".',
    second => 'The addressee — "you" (singular or plural).',
    third => 'The party being spoken about — "he", "she", "it", "they".',
  };

  @override
  List<String> get examples => switch (this) {
    first => ['I am', 'we walk', 'I have spoken'],
    second => ['you go', 'you (pl.) listen', 'you have seen'],
    third => ['he runs', 'she speaks', 'they gathered'],
  };
}

enum GrammaticalGender implements MorphologyAttributeValue {
  masculine,
  feminine,
  neuter,
  common;

  @override
  String get displayName => switch (this) {
    masculine => 'Masculine',
    feminine => 'Feminine',
    neuter => 'Neuter',
    common => 'Common',
  };

  @override
  String get description => switch (this) {
    masculine => 'Masculine grammatical gender — used for male persons and many nouns by convention.',
    feminine => 'Feminine grammatical gender — used for female persons and many nouns by convention.',
    neuter => 'Greek neuter gender — neither masculine nor feminine.',
    common => 'Hebrew common gender — the form serves both masculine and feminine.',
  };

  @override
  List<String> get examples => switch (this) {
    masculine => ['father', 'son', 'king'],
    feminine => ['mother', 'daughter', 'queen'],
    neuter => ['child (τέκνον)', 'gift (δῶρον)'],
    common => ['cattle', 'voice'],
  };
}

enum GrammaticalNumber implements MorphologyAttributeValue {
  singular,
  plural,
  dual;

  @override
  String get displayName => switch (this) {
    singular => 'Singular',
    plural => 'Plural',
    dual => 'Dual',
  };

  @override
  String get description => switch (this) {
    singular => 'Refers to one.',
    plural => 'Refers to two or more.',
    dual => 'Refers to a natural pair (Hebrew only).',
  };

  @override
  List<String> get examples => switch (this) {
    singular => ['the book', 'a man', 'one stone'],
    plural => ['the books', 'men', 'stones'],
    dual => ['hands', 'eyes', 'two days'],
  };
}

enum GrammaticalCase implements MorphologyAttributeValue {
  nominative,
  genitive,
  dative,
  accusative,
  vocative;

  @override
  String get displayName => switch (this) {
    nominative => 'Nominative',
    genitive => 'Genitive',
    dative => 'Dative',
    accusative => 'Accusative',
    vocative => 'Vocative',
  };

  @override
  String get description => switch (this) {
    nominative => 'Marks the subject of a sentence.',
    genitive => 'Indicates possession or origin — often translated "of".',
    dative => 'Marks the indirect object — often "to" or "for".',
    accusative => 'Marks the direct object.',
    vocative => 'Used in direct address.',
  };

  @override
  List<String> get examples => switch (this) {
    nominative => ['God created', 'the king sees'],
    genitive => ['the Son of God', 'kingdom of heaven'],
    dative => ['gave to him', 'spoke to them'],
    accusative => ['saw him', 'love your neighbor'],
    vocative => ['Lord!', 'Father!', 'Friend!'],
  };
}

enum HebrewState implements MorphologyAttributeValue {
  absolute,
  construct,
  determined;

  @override
  String get displayName => switch (this) {
    absolute => 'Absolute',
    construct => 'Construct',
    determined => 'Determined',
  };

  @override
  String get description => switch (this) {
    absolute => 'The default form of a noun — independent.',
    construct => 'Bound to a following noun, expressing "X of Y".',
    determined => 'Marked as definite (often by the article).',
  };

  @override
  List<String> get examples => switch (this) {
    absolute => ['a king', 'a word'],
    construct => ['king of Israel', 'word of the LORD'],
    determined => ['the king', 'the word'],
  };
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
  String get displayName => switch (this) {
    qal => 'Qal',
    qalPassive => 'Qal passive',
    niphal => 'Niphal',
    piel => 'Piel',
    pual => 'Pual',
    hiphil => 'Hiphil',
    hophal => 'Hophal',
    hithpael => 'Hithpael',
    nithpael => 'Nithpael',
  };

  @override
  String get description => switch (this) {
    qal => 'The simple active stem — the basic action of the verb.',
    qalPassive => 'A rare passive of the simple stem.',
    niphal => 'The simple passive or reflexive stem.',
    piel => 'The intensive or factitive active stem.',
    pual => 'The passive of the piel.',
    hiphil => 'The causative active stem.',
    hophal => 'The passive of the hiphil.',
    hithpael => 'The reflexive or reciprocal of the piel.',
    nithpael => 'A rare reflexive-passive stem.',
  };

  @override
  List<String> get examples => switch (this) {
    qal => ['he wrote', 'she heard'],
    qalPassive => ['it was taken'],
    niphal => ['he was killed', 'they gathered themselves'],
    piel => ['he praised', 'he blessed', 'he shattered'],
    pual => ['he was praised'],
    hiphil => ['he caused to write', 'he led out'],
    hophal => ['he was caused to write'],
    hithpael => ['he sanctified himself', 'they walked about'],
    nithpael => ['it was atoned for'],
  };
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
  String get displayName => switch (this) {
    perfect => 'Perfect',
    imperfect => 'Imperfect',
    imperative => 'Imperative',
    infinitiveConstruct => 'Infinitive construct',
    infinitiveAbsolute => 'Infinitive absolute',
    participle => 'Participle',
    consecutiveImperfect => 'Consecutive imperfect',
    conjunctiveImperfect => 'Conjunctive imperfect',
    conjunctivePerfect => 'Conjunctive perfect',
    passiveParticiple => 'Passive participle',
  };

  @override
  String get description => switch (this) {
    perfect => 'Completed action — typically translated as past.',
    imperfect => 'Incomplete or future action — often translated as future or habitual.',
    imperative => 'A direct command.',
    infinitiveConstruct => 'A verbal noun in construct form, often used with prepositions.',
    infinitiveAbsolute => 'An independent verbal noun, often emphatic.',
    participle => 'A verbal adjective — "one who Xs", or ongoing action.',
    consecutiveImperfect => 'Past narrative form — waw + imperfect.',
    conjunctiveImperfect => 'Imperfect with conjunctive waw — future or modal sense.',
    conjunctivePerfect => 'Perfect with conjunctive waw — often future or sequential.',
    passiveParticiple => 'The passive form of the qal participle.',
  };

  @override
  List<String> get examples => switch (this) {
    perfect => ['he wrote', 'she has spoken'],
    imperfect => ['he will write', 'he writes'],
    imperative => ['Write!', 'Listen!'],
    infinitiveConstruct => ['to write', 'when writing'],
    infinitiveAbsolute => ['surely die', 'write thoroughly'],
    participle => ['writing', 'the one who hears'],
    consecutiveImperfect => ['and he said', 'and they went'],
    conjunctiveImperfect => ['and he will write'],
    conjunctivePerfect => ['and you shall do', 'and he will judge'],
    passiveParticiple => ['written', 'kept'],
  };
}

/// Sub-mood modifying a Hebrew imperfect form (jussive, cohortative, h-suffix).
enum HebrewVerbMood implements MorphologyAttributeValue {
  jussive,
  cohortative,
  hSuffix;

  @override
  String get displayName => switch (this) {
    jussive => 'Jussive',
    cohortative => 'Cohortative',
    hSuffix => 'h-suffix',
  };

  @override
  String get description => switch (this) {
    jussive => 'A 3rd-person command or wish — "let him do".',
    cohortative => 'A 1st-person volitional — "let us" or "I will".',
    hSuffix => 'An emphatic -ah ending on the imperfect, often cohortative-like.',
  };

  @override
  List<String> get examples => switch (this) {
    jussive => ['Let there be light', 'May the LORD bless you'],
    cohortative => ['Let us go', 'I will praise'],
    hSuffix => ['I will surely come', 'let me draw near'],
  };
}

enum GreekTense implements MorphologyAttributeValue {
  present,
  imperfect,
  future,
  aorist,
  perfect,
  pluperfect;

  @override
  String get displayName => switch (this) {
    present => 'Present',
    imperfect => 'Imperfect',
    future => 'Future',
    aorist => 'Aorist',
    perfect => 'Perfect',
    pluperfect => 'Pluperfect',
  };

  @override
  String get description => switch (this) {
    present => 'Ongoing or general action.',
    imperfect => 'Continuous or repeated past action.',
    future => 'Action that will happen.',
    aorist => 'Simple past action — viewed as a whole.',
    perfect => 'Past action with continuing present consequence.',
    pluperfect => 'Past action prior to another past event.',
  };

  @override
  List<String> get examples => switch (this) {
    present => ['he loves', 'they walk'],
    imperfect => ['he was teaching', 'they used to gather'],
    future => ['he will come', 'they shall see'],
    aorist => ['he said', 'they went'],
    perfect => ['has been written', 'has come'],
    pluperfect => ['had been written', 'had departed'],
  };
}

enum GreekMood implements MorphologyAttributeValue {
  indicative,
  imperative,
  subjunctive,
  optative,
  infinitive,
  participle;

  @override
  String get displayName => switch (this) {
    indicative => 'Indicative',
    imperative => 'Imperative',
    subjunctive => 'Subjunctive',
    optative => 'Optative',
    infinitive => 'Infinitive',
    participle => 'Participle',
  };

  @override
  String get description => switch (this) {
    indicative => 'States a fact.',
    imperative => 'Issues a command.',
    subjunctive => 'Expresses possibility, purpose, or contingency.',
    optative => 'Expresses a wish or remote possibility.',
    infinitive => 'A verbal noun — "to do".',
    participle => 'A verbal adjective — "doing" or "having done".',
  };

  @override
  List<String> get examples => switch (this) {
    indicative => ['he is', 'they wrote'],
    imperative => ['Go!', 'Believe!', 'Do not fear!'],
    subjunctive => ['that he might write', 'if he goes'],
    optative => ['may it be so', 'may you have grace'],
    infinitive => ['to write', 'to believe'],
    participle => ['the one writing', 'having spoken'],
  };
}

enum GreekVoice implements MorphologyAttributeValue {
  active,
  middle,
  passive,
  middleOrPassive;

  @override
  String get displayName => switch (this) {
    active => 'Active',
    middle => 'Middle',
    passive => 'Passive',
    middleOrPassive => 'Middle/Passive',
  };

  @override
  String get description => switch (this) {
    active => 'The subject performs the action.',
    middle => 'The subject acts on or for itself.',
    passive => 'The subject receives the action.',
    middleOrPassive => 'The form is ambiguous between middle and passive.',
  };

  @override
  List<String> get examples => switch (this) {
    active => ['he writes', 'they teach'],
    middle => ['he washes himself', 'they obtained for themselves'],
    passive => ['he was sent', 'they were taught'],
    middleOrPassive => ['was raised / raised himself', 'was assembled / assembled themselves'],
  };
}

enum Degree implements MorphologyAttributeValue {
  positive,
  comparative,
  superlative;

  @override
  String get displayName => switch (this) {
    positive => 'Positive',
    comparative => 'Comparative',
    superlative => 'Superlative',
  };

  @override
  String get description => switch (this) {
    positive => 'The plain form — neither comparative nor superlative.',
    comparative => 'Compares two — "X-er than".',
    superlative => 'The extreme — "most" or "-est".',
  };

  @override
  List<String> get examples => switch (this) {
    positive => ['great', 'good'],
    comparative => ['greater', 'better than'],
    superlative => ['greatest', 'best'],
  };
}

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
  final Language language;
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
  final Language language;
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
  final Language language;
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
  final Language language;
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
    .code: MorphologyAttributeLiteral(
      displayName: code,
      description: 'The raw morphology code as it appeared in the source.',
    ),
  };
}

// ---------- internal parsing helpers ----------

MorphologyAttributeValue? _conjunctionParticleValue(String? particle) => switch (particle) {
  null => null,
  'w' => MorphologyAttributeLiteral(
    displayName: 'w',
    description: 'The Hebrew waw (וְ) conjunction, meaning "and".',
    examples: ['and', 'now', 'but'],
  ),
  final p => MorphologyAttributeLiteral(displayName: p, description: 'A conjunction marker.'),
};

MorphologyAttributeValue? _prepositionPrefixValue(String? prefix) => switch (prefix) {
  null => null,
  'b' => MorphologyAttributeLiteral(
    displayName: 'b',
    description: 'The Hebrew bet (בְּ) prefix preposition, meaning "in", "at", or "with".',
    examples: ['in the beginning', 'with strength'],
  ),
  'k' => MorphologyAttributeLiteral(
    displayName: 'k',
    description: 'The Hebrew kaf (כְּ) prefix preposition, meaning "as" or "like".',
    examples: ['like a lion', 'as a shepherd'],
  ),
  'l' => MorphologyAttributeLiteral(
    displayName: 'l',
    description: 'The Hebrew lamed (לְ) prefix preposition, meaning "to", "for", or "belonging to".',
    examples: ['to David', 'for the king'],
  ),
  'm' => MorphologyAttributeLiteral(
    displayName: 'm',
    description: 'The Hebrew mem (מִן) prefix preposition, meaning "from" or "out of".',
    examples: ['from Egypt', 'out of the land'],
  ),
  final p => MorphologyAttributeLiteral(displayName: p, description: 'A prefix preposition letter.'),
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
