///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsNl extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsNl({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.nl,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <nl>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsNl _root = this; // ignore: unused_field

	@override 
	TranslationsNl $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsNl(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$languages$nl languages = _Translations$languages$nl._(_root);
	@override late final _Translations$highlightStyles$nl highlightStyles = _Translations$highlightStyles$nl._(_root);
	@override late final _Translations$colors$nl colors = _Translations$colors$nl._(_root);
	@override late final _Translations$testaments$nl testaments = _Translations$testaments$nl._(_root);
	@override late final _Translations$books$nl books = _Translations$books$nl._(_root);
	@override late final _Translations$common$nl common = _Translations$common$nl._(_root);
	@override late final _Translations$regionTypes$nl regionTypes = _Translations$regionTypes$nl._(_root);
	@override late final _Translations$mainActions$nl mainActions = _Translations$mainActions$nl._(_root);
	@override late final _Translations$verseOfTheDay$nl verseOfTheDay = _Translations$verseOfTheDay$nl._(_root);
	@override late final _Translations$studyActions$nl studyActions = _Translations$studyActions$nl._(_root);
	@override late final _Translations$selectionActions$nl selectionActions = _Translations$selectionActions$nl._(_root);
	@override late final _Translations$studyPanels$nl studyPanels = _Translations$studyPanels$nl._(_root);
	@override late final _Translations$bookmarks$nl bookmarks = _Translations$bookmarks$nl._(_root);
	@override late final _Translations$bookmarkPage$nl bookmarkPage = _Translations$bookmarkPage$nl._(_root);
	@override late final _Translations$commentaries$nl commentaries = _Translations$commentaries$nl._(_root);
	@override late final _Translations$toolbarShortcuts$nl toolbarShortcuts = _Translations$toolbarShortcuts$nl._(_root);
	@override late final _Translations$labels$nl labels = _Translations$labels$nl._(_root);
	@override late final _Translations$strongSheet$nl strongSheet = _Translations$strongSheet$nl._(_root);
	@override late final _Translations$bibleDetails$nl bibleDetails = _Translations$bibleDetails$nl._(_root);
	@override late final _Translations$emptyStates$nl emptyStates = _Translations$emptyStates$nl._(_root);
	@override late final _Translations$annotationUi$nl annotationUi = _Translations$annotationUi$nl._(_root);
	@override late final _Translations$notebookUi$nl notebookUi = _Translations$notebookUi$nl._(_root);
	@override late final _Translations$highlightStyleUi$nl highlightStyleUi = _Translations$highlightStyleUi$nl._(_root);
	@override late final _Translations$toolbarSettings$nl toolbarSettings = _Translations$toolbarSettings$nl._(_root);
	@override late final _Translations$themeSettings$nl themeSettings = _Translations$themeSettings$nl._(_root);
	@override late final _Translations$biblePlans$nl biblePlans = _Translations$biblePlans$nl._(_root);
	@override late final _Translations$searchUi$nl searchUi = _Translations$searchUi$nl._(_root);
	@override late final _Translations$onboarding$nl onboarding = _Translations$onboarding$nl._(_root);
	@override late final _Translations$analyticsNotice$nl analyticsNotice = _Translations$analyticsNotice$nl._(_root);
	@override late final _Translations$tutorials$nl tutorials = _Translations$tutorials$nl._(_root);
	@override late final _Translations$audio$nl audio = _Translations$audio$nl._(_root);
	@override late final _Translations$interlinearUi$nl interlinearUi = _Translations$interlinearUi$nl._(_root);
	@override late final _Translations$chapterUnavailable$nl chapterUnavailable = _Translations$chapterUnavailable$nl._(_root);
	@override late final _Translations$verseNumbering$nl verseNumbering = _Translations$verseNumbering$nl._(_root);
	@override late final _Translations$compare$nl compare = _Translations$compare$nl._(_root);
	@override late final _Translations$commentaryUi$nl commentaryUi = _Translations$commentaryUi$nl._(_root);
	@override late final _Translations$searchLocations$nl searchLocations = _Translations$searchLocations$nl._(_root);
	@override late final _Translations$themeOptions$nl themeOptions = _Translations$themeOptions$nl._(_root);
	@override late final _Translations$toolbarPresets$nl toolbarPresets = _Translations$toolbarPresets$nl._(_root);
	@override late final _Translations$commentaryTypes$nl commentaryTypes = _Translations$commentaryTypes$nl._(_root);
	@override late final _Translations$strongDefinition$nl strongDefinition = _Translations$strongDefinition$nl._(_root);
	@override late final _Translations$planTypes$nl planTypes = _Translations$planTypes$nl._(_root);
	@override late final _Translations$onboardingSteps$nl onboardingSteps = _Translations$onboardingSteps$nl._(_root);
	@override late final _Translations$dictionary$nl dictionary = _Translations$dictionary$nl._(_root);
	@override late final _Translations$navigation$nl navigation = _Translations$navigation$nl._(_root);
	@override late final _Translations$bibleSheet$nl bibleSheet = _Translations$bibleSheet$nl._(_root);
	@override late final _Translations$selectionUi$nl selectionUi = _Translations$selectionUi$nl._(_root);
	@override late final _Translations$errors$nl errors = _Translations$errors$nl._(_root);
	@override late final _Translations$morphology$nl morphology = _Translations$morphology$nl._(_root);
	@override late final _Translations$settings$nl settings = _Translations$settings$nl._(_root);
}

// Path: languages
class _Translations$languages$nl extends Translations$languages$en {
	_Translations$languages$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get english => 'Engels';
	@override String get dutch => 'Nederlands';
	@override String get greek => 'Grieks';
	@override String get hebrew => 'Hebreeuws';
	@override String get russian => 'Russisch';
	@override String get french => 'Frans';
	@override String get spanish => 'Spaans';
}

// Path: highlightStyles
class _Translations$highlightStyles$nl extends Translations$highlightStyles$en {
	_Translations$highlightStyles$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get red => 'Rood';
	@override String get orange => 'Oranje';
	@override String get yellow => 'Geel';
	@override String get green => 'Groen';
	@override String get blue => 'Blauw';
	@override String get violet => 'Violet';
	@override String get underline => 'Onderstrepen';
	@override String get important => 'Belangrijk';
	@override String get highlight => 'Markeren';
	@override String get squiggle => 'Golflijn';
}

// Path: colors
class _Translations$colors$nl extends Translations$colors$en {
	_Translations$colors$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get red => 'Rood';
	@override String get orange => 'Oranje';
	@override String get yellow => 'Geel';
	@override String get green => 'Groen';
	@override String get blue => 'Blauw';
	@override String get violet => 'Violet';
	@override String get silver => 'Zilver';
}

// Path: testaments
class _Translations$testaments$nl extends Translations$testaments$en {
	_Translations$testaments$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get old => 'Oude Testament';
	@override String get newTestament => 'Nieuwe Testament';
	@override String get oldOnly => 'Alleen Oude Testament';
	@override String get newOnly => 'Alleen Nieuwe Testament';
	@override String get wholeBible => 'Hele Bijbel';
	@override String get oldOnlyDescription => 'Bevat alleen boeken uit het Oude Testament.';
	@override String get newOnlyDescription => 'Bevat alleen boeken uit het Nieuwe Testament.';
	@override String get wholeBibleDescription => 'Bevat alle boeken van de Bijbel.';
}

// Path: books
class _Translations$books$nl extends Translations$books$en {
	_Translations$books$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get genesis => 'Genesis';
	@override String get exodus => 'Exodus';
	@override String get leviticus => 'Leviticus';
	@override String get numbers => 'Numeri';
	@override String get deuteronomy => 'Deuteronomium';
	@override String get joshua => 'Jozua';
	@override String get judges => 'Richteren';
	@override String get ruth => 'Ruth';
	@override String get samuel1 => '1 Samuel';
	@override String get samuel2 => '2 Samuel';
	@override String get kings1 => '1 Koningen';
	@override String get kings2 => '2 Koningen';
	@override String get chronicles1 => '1 Kronieken';
	@override String get chronicles2 => '2 Kronieken';
	@override String get ezra => 'Ezra';
	@override String get nehemiah => 'Nehemia';
	@override String get esther => 'Esther';
	@override String get job => 'Job';
	@override String get psalm => 'Psalm';
	@override String get psalms => 'Psalmen';
	@override String get proverbs => 'Spreuken';
	@override String get ecclesiastes => 'Prediker';
	@override String get songOfSolomon => 'Hooglied';
	@override String get isaiah => 'Jesaja';
	@override String get jeremiah => 'Jeremia';
	@override String get lamentations => 'Klaagliederen';
	@override String get ezekiel => 'Ezechiël';
	@override String get daniel => 'Daniël';
	@override String get hosea => 'Hosea';
	@override String get joel => 'Joël';
	@override String get amos => 'Amos';
	@override String get obadiah => 'Obadja';
	@override String get jonah => 'Jona';
	@override String get micah => 'Micha';
	@override String get nahum => 'Nahum';
	@override String get habakkuk => 'Habakuk';
	@override String get zephaniah => 'Zefanja';
	@override String get haggai => 'Haggaï';
	@override String get zechariah => 'Zacharia';
	@override String get malachi => 'Maleachi';
	@override String get matthew => 'Mattheüs';
	@override String get mark => 'Markus';
	@override String get luke => 'Lukas';
	@override String get john => 'Johannes';
	@override String get acts => 'Handelingen';
	@override String get romans => 'Romeinen';
	@override String get corinthians1 => '1 Korintiërs';
	@override String get corinthians2 => '2 Korintiërs';
	@override String get galatians => 'Galaten';
	@override String get ephesians => 'Efeziërs';
	@override String get philippians => 'Filippenzen';
	@override String get colossians => 'Kolossenzen';
	@override String get thessalonians1 => '1 Thessalonicenzen';
	@override String get thessalonians2 => '2 Thessalonicenzen';
	@override String get timothy1 => '1 Timotheüs';
	@override String get timothy2 => '2 Timotheüs';
	@override String get titus => 'Titus';
	@override String get philemon => 'Filemon';
	@override String get hebrews => 'Hebreeën';
	@override String get james => 'Jakobus';
	@override String get peter1 => '1 Petrus';
	@override String get peter2 => '2 Petrus';
	@override String get john1 => '1 Johannes';
	@override String get john2 => '2 Johannes';
	@override String get john3 => '3 Johannes';
	@override String get jude => 'Judas';
	@override String get revelation => 'Openbaring';
}

// Path: common
class _Translations$common$nl extends Translations$common$en {
	_Translations$common$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get add => 'Toevoegen';
	@override String get addNew => 'Nieuwe toevoegen';
	@override String get am => 'a.m.';
	@override String get cancel => 'Annuleren';
	@override String get close => 'Sluiten';
	@override String get copy => 'Kopiëren';
	@override String get continueLabel => 'Doorgaan';
	@override String get create => 'Maken';
	@override String get custom => 'Aangepast';
	@override String get defaultLabel => 'Standaard';
	@override String get delete => 'Verwijderen';
	@override String get done => 'Gereed';
	@override String get edit => 'Bewerken';
	@override String get finish => 'Voltooien';
	@override String get learnMore => 'Meer informatie';
	@override String get nevermind => 'Laat maar';
	@override String get next => 'Volgende';
	@override String get noMatches => 'Geen overeenkomsten';
	@override String get noNotification => 'Geen melding';
	@override String get ok => 'Oké';
	@override String get off => 'Uit';
	@override String get none => 'Geen';
	@override String get clear => 'Wissen';
	@override String get remove => 'Verwijderen';
	@override String get save => 'Opslaan';
	@override String get search => 'Zoeken';
	@override String get select => 'Selecteren';
	@override String get show => 'Tonen';
	@override String get hide => 'Verbergen';
	@override String get pm => 'p.m.';
	@override String get sort => 'Sorteren';
	@override String get stop => 'Stoppen';
	@override String get tryAgain => 'Opnieuw proberen';
	@override String switchTo({required Object translation}) => 'Overschakelen naar ${translation}';
	@override String notAvailableIn({required Object translation}) => 'Dit is niet beschikbaar in ${translation}.';
}

// Path: regionTypes
class _Translations$regionTypes$nl extends Translations$regionTypes$en {
	_Translations$regionTypes$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get chapter => 'dit hoofdstuk';
	@override String get verses => 'deze verzen';
	@override String get visibleVerses => 'de zichtbare verzen';
	@override String get text => 'deze tekst';
}

// Path: mainActions
class _Translations$mainActions$nl extends Translations$mainActions$en {
	_Translations$mainActions$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get pauseAudio => 'Bijbelaudio pauzeren';
	@override String get playAudio => 'Bijbelaudio afspelen';
	@override String get bookmark => 'Bladwijzer';
	@override String get study => 'Studie';
	@override String get verseOfTheDay => 'Vers van de dag';
	@override String get addStudyPanel => 'Studiepaneel toevoegen';
	@override String get search => 'Zoeken';
	@override String get resources => 'Bronnen';
	@override String get plans => 'Bijbelleesplannen';
	@override String get settings => 'Instellingen';
	@override String get more => 'Meer';
	@override String get audioDescription => 'Luister naar het huidige hoofdstuk met een Bijbel met audio.';
	@override String get bookmarkDescription => 'Voeg een bladwijzer aan dit hoofdstuk toe om het makkelijk terug te vinden via de zoekpagina.';
	@override String get manageBookmarkDescription => 'Beheer deze bladwijzer.';
	@override String get studyDescription => 'Bekijk studiehulpmiddelen voor dit hoofdstuk.';
	@override String get verseOfTheDayDescription => 'Bekijk het vers van vandaag.';
	@override String get verseOfTheDayLoading => 'Het vers van vandaag wordt geladen…';
	@override String get verseOfTheDayUnavailable => 'Het vers van vandaag kan niet worden geladen.';
	@override String get studyPanelDescription => 'Zet een paneel naast de tekst vast dat meeloopt en studiehulpmiddelen toont voor wat je leest.';
	@override String get searchDescription => 'Zoek naar woorden in de Bijbel.';
	@override String get resourcesDescription => 'Zoek woorden op in het woordenboek en lexicon.';
	@override String get plansDescription => 'Lees de Bijbel met begeleide leesplannen.';
	@override String get settingsDescription => 'Bekijk de instellingen van Lux.';
	@override String get moreDescription => 'Bekijk instellingen, je inhoud en links naar de community.';
}

// Path: verseOfTheDay
class _Translations$verseOfTheDay$nl extends Translations$verseOfTheDay$en {
	_Translations$verseOfTheDay$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get reminderDiscoveryTitle => 'Dagelijkse herinnering toevoegen?';
	@override String get reminderDiscoveryBody => 'Wil je dat Lux je elke dag herinnert aan het vers van de dag?';
	@override String get addReminder => 'Herinnering toevoegen';
	@override String get noReminder => 'Nee';
	@override String get dailyReminders => 'Dagelijkse herinnering';
	@override String get deleteReminder => 'Herinnering verwijderen?';
	@override String get deleteReminderConfirmation => 'Weet je zeker dat je je dagelijkse herinnering voor het vers van de dag wilt verwijderen?';
	@override String get reminderNotificationChannelName => 'Herinneringen voor vers van de dag';
	@override String get reminderNotificationChannelDescription => 'Dagelijkse herinneringen voor het vers van de dag';
	@override String get reminderNotificationTitle => 'Vers van de dag';
	@override String get reminderPermissionDeniedTitle => 'Meldingen zijn uitgeschakeld';
	@override String get reminderPermissionDeniedBody => 'Sta Lux toe om meldingen te sturen in Instellingen om deze herinnering op te slaan.';
	@override String get openNotificationSettings => 'Instellingen openen';
	@override String get reminderSchedulingFailedTitle => 'Herinnering kon niet worden ingesteld';
	@override String get reminderSchedulingFailedBody => 'Lux kon deze herinnering niet instellen. Probeer het opnieuw.';
	@override String reminderSaved({required Object time}) => 'Herinnering voor het vers van de dag opgeslagen voor dagelijks om ${time}.';
}

// Path: studyActions
class _Translations$studyActions$nl extends Translations$studyActions$en {
	_Translations$studyActions$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get quickStudy => 'Snelle studie';
	@override String get compare => 'Vergelijken';
	@override String get interlinear => 'Interlineair';
	@override String get commentary => 'Commentaar';
	@override String get crossReferences => 'Kruisverwijzingen';
	@override String compareDescription({required Object region}) => 'Vergelijk ${region} in verschillende vertalingen.';
	@override String interlinearDescription({required Object region}) => 'Bekijk een lexicale analyse van ${region} met Strong-coderingen.';
	@override String commentaryDescription({required Object region}) => 'Bekijk commentaren op ${region}.';
	@override String crossReferencesDescription({required Object region}) => 'Bekijk kruisverwijzingen voor ${region}.';
	@override String get noCrossReferences => 'Geen kruisverwijzingen gevonden';
	@override String crossReferencesUse({required Object translation}) => 'Kruisverwijzingen gebruiken ${translation}';
	@override String get onlineCrossReferencesExplanation => 'Omdat de geselecteerde vertaling alleen online beschikbaar is, worden kruisverwijzingen getoond met de meest recent gebruikte studiebijbel om prestaties en kosten te besparen. Overal elders in de app wordt de geselecteerde vertaling gebruikt.';
}

// Path: selectionActions
class _Translations$selectionActions$nl extends Translations$selectionActions$en {
	_Translations$selectionActions$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get annotate => 'Annoteren';
	@override String get study => 'Studie';
	@override String get copy => 'Kopiëren';
	@override String get highlight => 'Markeren';
	@override String get removeAnnotations => 'Annotaties verwijderen';
	@override String get interlinear => 'Interlineair';
	@override String get search => 'Zoeken';
	@override String get annotateVersesDescription => 'Annoteer deze verzen.';
	@override String get studyVersesDescription => 'Bestudeer deze verzen.';
	@override String get copyVersesDescription => 'Kopieer deze verzen naar het klembord.';
	@override String get annotateTextDescription => 'Annoteer deze tekst.';
	@override String get interlinearTextDescription => 'Bekijk een lexicale analyse van deze tekst.';
	@override String get searchTextDescription => 'Zoek in de Bijbel naar deze tekst.';
	@override String get copyTextDescription => 'Kopieer deze tekst naar het klembord.';
	@override String removeTextAnnotationsDescription({required Object region}) => 'Verwijder tekstselectie-annotaties uit ${region}.';
	@override String highlightTextDescription({required Object region}) => 'Markeer ${region} met de laatst gebruikte kleur.';
	@override String removeVerseAnnotationsDescription({required Object region}) => 'Verwijder versselectie-annotaties uit ${region}.';
	@override String highlightVersesDescription({required Object region}) => 'Markeer ${region} met de laatst gebruikte kleur.';
	@override String highlightedText({required Object reference}) => 'Tekst in ${reference} gemarkeerd.';
	@override String highlightedVerses({required Object reference}) => '${reference} gemarkeerd.';
	@override String copiedVerses({required Object reference}) => '${reference} naar het klembord gekopieerd.';
	@override String get copiedText => 'Tekstselectie naar het klembord gekopieerd.';
	@override String get interlinearUnavailable => 'Interlineair zoeken via een tekstselectie is alleen beschikbaar in studiebijbels. Deze zijn woord voor woord voorzien van Strong-coderingen en morfologische informatie. Schakel over naar een studiebijbel om deze actie te gebruiken.';
	@override String get noInterlinearWords => 'Geen interlineaire woorden gevonden in deze selectie.';
	@override String textInReference({required Object reference}) => 'Tekst in ${reference}';
}

// Path: studyPanels
class _Translations$studyPanels$nl extends Translations$studyPanels$en {
	_Translations$studyPanels$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Studiepaneel';
	@override String get pinAsStudyPanel => 'Vastzetten als studiepaneel';
	@override String compareWith({required Object translation}) => 'Vergelijken met ${translation}';
	@override String directionInterlinear({required Object direction}) => '${direction} interlineair';
	@override String commentaryName({required Object commentary}) => 'Commentaar van ${commentary}';
	@override String get notes => 'Notities';
	@override String get noNotes => 'Geen notities gevonden';
	@override String get notesDescription => 'Bekijk je notities bij de zichtbare verzen.';
}

// Path: bookmarks
class _Translations$bookmarks$nl extends Translations$bookmarks$en {
	_Translations$bookmarks$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get create => 'Bladwijzer maken';
	@override String get manage => 'Bladwijzer beheren';
	@override String get stopFollowing => 'Niet meer volgen';
	@override String get stopFollowingDescription => 'Laat deze bladwijzer je huidige positie niet meer volgen.';
	@override String get edit => 'Bladwijzer bewerken';
	@override String get delete => 'Bladwijzer verwijderen';
	@override String get deleteConfirmation => 'Weet je zeker dat je deze bladwijzer wilt verwijderen?';
	@override String deleteNamedConfirmation({required Object name}) => 'Weet je zeker dat je "${name}" wilt verwijderen?';
}

// Path: bookmarkPage
class _Translations$bookmarkPage$nl extends Translations$bookmarkPage$en {
	_Translations$bookmarkPage$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Je bladwijzers';
}

// Path: commentaries
class _Translations$commentaries$nl extends Translations$commentaries$en {
	_Translations$commentaries$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get addRemove => 'Commentaren toevoegen en verwijderen';
}

// Path: toolbarShortcuts
class _Translations$toolbarShortcuts$nl extends Translations$toolbarShortcuts$en {
	_Translations$toolbarShortcuts$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get switchBible => 'Van Bijbel wisselen';
	@override String get dictionary => 'Woordenboek';
	@override String get lexicon => 'Lexicon';
	@override String get themeAndLayout => 'Thema en indeling';
	@override String get switchBibleDescription => 'Wissel van Bijbelvertaling.';
	@override String get dictionaryDescription => 'Zoek personen, plaatsen en onderwerpen op in Easton\'s Bible Dictionary.';
	@override String get lexiconDescription => 'Bestudeer de oorspronkelijke Hebreeuwse en Griekse woorden met Strong\'s Lexicon.';
	@override String get themeAndLayoutDescription => 'Pas het thema en de indeling van de Bijbel aan.';
}

// Path: labels
class _Translations$labels$nl extends Translations$labels$en {
	_Translations$labels$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get about => 'Over';
	@override String get annotation => 'Annotatie';
	@override String get annotations => 'Annotaties';
	@override String get audioBible => 'Bijbelaudio';
	@override String get bible => 'Bijbel';
	@override String get bibles => 'Bijbels';
	@override String get biblePlans => 'Bijbelleesplannen';
	@override String get bookmarks => 'Bladwijzers';
	@override String get books => 'Boeken';
	@override String get color => 'Kleur';
	@override String get commentaries => 'Commentaren';
	@override String get commentary => 'Commentaar';
	@override String get community => 'Community';
	@override String get completed => 'Voltooid';
	@override String get crossReferences => 'Kruisverwijzingen';
	@override String get days => 'Dagen';
	@override String get dictionary => 'Woordenboek';
	@override String get discord => 'Discord';
	@override String get duration => 'Duur';
	@override String get following => 'Gevolgd';
	@override String get footnotes => 'Voetnoten';
	@override String get help => 'Help';
	@override String get highlightStyles => 'Markeerstijlen';
	@override String get instagram => 'Instagram';
	@override String get interlinear => 'Interlineair';
	@override String get language => 'Taal';
	@override String get layout => 'Indeling';
	@override String get lexicon => 'Lexicon';
	@override String get licenses => 'Licenties';
	@override String get locations => 'Locaties';
	@override String get name => 'Naam';
	@override String get note => 'Notitie';
	@override String get notebook => 'Notitieboek';
	@override String get notebooks => 'Notitieboeken';
	@override String get notes => 'Notities';
	@override String get paragraphs => 'Alinea\'s';
	@override String get resources => 'Bronnen';
	@override String get scope => 'Bereik';
	@override String get search => 'Zoeken';
	@override String get selection => 'Selectie';
	@override String get settings => 'Instellingen';
	@override String get source => 'Bron';
	@override String get study => 'Studie';
	@override String get style => 'Stijl';
	@override String get text => 'Tekst';
	@override String get toolbar => 'Werkbalk';
	@override String get toolbars => 'Werkbalken';
	@override String get type => 'Type';
	@override String get version => 'Versie';
	@override String get visibility => 'Zichtbaarheid';
}

// Path: strongSheet
class _Translations$strongSheet$nl extends Translations$strongSheet$en {
	_Translations$strongSheet$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get interlinearWord => 'Interlineair woord';
	@override String get lexicon => 'Lexicon';
	@override String get legend => 'Legenda';
	@override String get openInSearch => 'Openen in zoeken';
	@override String get usage => 'Gebruik';
	@override String get inflected => 'Verbuiging';
	@override String get transliteration => 'Transliteratie';
	@override String get root => 'Stam';
	@override String strongsId({required Object id}) => 'Strong\'s ${id}';
	@override String get rootWord => 'Stamwoord';
	@override String get pronunciation => 'Uitspraak';
	@override String get strongsDefinition => 'Strong\'s-definitie';
	@override String get biblicalUsage => 'Bijbels gebruik';
	@override String get definition => 'Definitie';
	@override String get examples => 'Voorbeelden';
	@override String get examplesPrefix => 'Voorbeelden: ';
	@override String get partOfSpeech => 'Woordsoort';
	@override String get derivation => 'Herkomst';
	@override String get morphology => 'Morfologie';
	@override String get relatedTerms => 'Verwante termen';
	@override String get morphologyInfo => 'Morfologische informatie';
	@override String get definitionLegend => 'Legenda bij Strong\'s-definitie';
	@override String get optionalWord => 'Optioneel woord';
	@override String get optionalWordDescription => 'Geeft een woord of lettergreep aan die bij het hoofdwoord kan worden aangevuld.';
	@override String get addedWord => 'Toegevoegd woord in het Hebreeuws of Grieks';
	@override String get addedWordDescription => 'Geeft een woord aan dat in de Engelse vertaling is toegevoegd, maar niet in het Hebreeuws of Grieks staat.';
	@override String get explanation => 'Uitleg';
	@override String get renderingExplanation => 'Cursieve tekst aan het einde van een weergave licht een afwijking van de gebruikelijke vorm toe.';
	@override String get concordance => 'Concordantie';
}

// Path: bibleDetails
class _Translations$bibleDetails$nl extends Translations$bibleDetails$en {
	_Translations$bibleDetails$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get onlineOnly => 'Alleen online';
	@override String onlineDescription({required Object source}) => 'Deze Bijbel wordt gestreamd via ${source} en vereist daarom een internetverbinding.';
	@override String get studyBible => 'Studiebijbel';
	@override String get audioBible => 'Bijbelaudio';
	@override String get onDevice => 'Op apparaat';
	@override String get onDeviceDescription => 'Deze Bijbel staat op je apparaat, zodat je hem offline kunt lezen en doorzoeken.';
	@override String get studyBibleDescription => 'Bevat interlineaire en morfologische gegevens. Houd tijdens het lezen een woord ingedrukt om het oorspronkelijke Griekse of Hebreeuwse woord te zien.';
	@override String get readingBible => 'Leesbijbel';
	@override String get readingBibleDescription => 'Bevat geen interlineaire of morfologische gegevens.';
	@override String get nativeHeadings => 'Eigen tussenkoppen';
	@override String get nativeHeadingsDescription => 'Deze Bijbel bevat eigen tussenkoppen.';
	@override String get syntheticHeadings => 'Toegevoegde tussenkoppen';
	@override String get syntheticHeadingsDescription => 'Tussenkoppen uit de BSB zijn aan deze Bijbel toegevoegd.';
	@override String get noHeadings => 'Geen tussenkoppen';
	@override String get noHeadingsDescription => 'Deze Bijbel bevat geen tussenkoppen.';
	@override String get audioSupportDescription => 'Of deze Bijbel bijbelaudio bevat';
	@override String get redLetters => 'Rode letters';
	@override String get redLettersDescription => 'Of deze Bijbel rode letters ondersteunt.';
	@override String get footnotesDescription => 'Of deze Bijbel voetnoten bevat.';
	@override String get paragraphsDescription => 'Of deze Bijbel alinea\'s bevat.';
	@override String get addRemoveBibles => 'Bijbels toevoegen en verwijderen';
	@override String get verseNumbering => 'Versnummering';
}

// Path: emptyStates
class _Translations$emptyStates$nl extends Translations$emptyStates$en {
	_Translations$emptyStates$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get noCommentaries => 'Geen commentaren gevonden';
	@override String get noMatchingWords => 'Geen overeenkomende woorden';
	@override String get noMatchingTerms => 'Geen overeenkomende termen';
	@override String get noMatchingPlans => 'Geen overeenkomende Bijbelleesplannen.';
	@override String get noMatchingAnnotations => 'Geen overeenkomende annotaties.';
	@override String get noSearchResults => 'Geen zoekresultaten gevonden';
	@override String get tryAnotherSearch => 'Probeer een andere zoekopdracht';
	@override String get noCommentariesAdded => 'Je hebt nog geen commentaren toegevoegd.';
	@override String get noAnnotations => 'Je hebt nog geen annotaties gemaakt.';
	@override String get noBookmarks => 'Je hebt nog geen bladwijzers gemaakt.';
	@override String get noNotebooks => 'Je hebt nog geen notitieboeken gemaakt. Met notitieboeken kun je je annotaties ordenen.';
	@override String get noPlans => 'Je volgt nog geen leesplannen. Zoek er een om met het lezen van de Bijbel te beginnen.';
}

// Path: annotationUi
class _Translations$annotationUi$nl extends Translations$annotationUi$en {
	_Translations$annotationUi$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get yourAnnotations => 'Je annotaties';
	@override String get annotate => 'Annoteren';
	@override String get withNotes => 'Met notities';
	@override String get withoutNotes => 'Zonder notities';
	@override String get mostRecent => 'Meest recent';
	@override String get location => 'Locatie';
	@override String get deleteAnnotation => 'Annotatie verwijderen';
	@override String get deleteConfirmation => 'Weet je zeker dat je deze annotatie wilt verwijderen?';
	@override String annotationCount({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('nl'))(count,
		one: '${count} annotatie',
		other: '${count} annotaties',
	);
	@override String annotatedTime({required Object time}) => '${time} geannoteerd';
}

// Path: notebookUi
class _Translations$notebookUi$nl extends Translations$notebookUi$en {
	_Translations$notebookUi$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get yourNotebooks => 'Je notitieboeken';
	@override String get hidden => 'Verborgen';
	@override String get hideDescription => 'Verberg de annotaties uit dit notitieboek in de Bijbel.';
	@override String get showDescription => 'Toon de annotaties uit dit notitieboek in de Bijbel.';
	@override String get defaultDescription => 'Het vaste notitieboek voor annotaties die nergens aan zijn toegewezen.';
	@override String get create => 'Notitieboek maken';
	@override String get edit => 'Notitieboek bewerken';
	@override String get delete => 'Notitieboek verwijderen';
	@override String deleteNamedConfirmation({required Object name}) => 'Weet je zeker dat je "${name}" wilt verwijderen?';
	@override String deleteWithAnnotations({required Object name, required Object annotations}) => '"${name}" heeft ${annotations}. Wil je ze ook verwijderen of in het standaardnotitieboek bewaren?';
	@override String get keepInDefault => 'In Standaard bewaren';
	@override String get deleteAnnotations => 'Annotaties verwijderen';
}

// Path: highlightStyleUi
class _Translations$highlightStyleUi$nl extends Translations$highlightStyleUi$en {
	_Translations$highlightStyleUi$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get yourStyles => 'Je markeerstijlen';
	@override String get create => 'Stijl maken';
	@override String get edit => 'Stijl bewerken';
	@override String get duplicate => 'Je hebt deze stijl al';
	@override String get delete => 'Stijl verwijderen';
	@override String deleteNamedConfirmation({required Object name}) => 'Weet je zeker dat je "${name}" wilt verwijderen?';
	@override String deleteWithAnnotations({required Object name, required Object annotations}) => '"${name}" heeft ${annotations}. Wil je ze ook verwijderen of bewaren?';
	@override String get keepAnnotations => 'Annotaties bewaren';
	@override String get deleteAnnotations => 'Annotaties verwijderen';
	@override String get updateAnnotations => 'Annotaties bijwerken';
	@override String updateWithAnnotations({required Object name, required Object annotations}) => '"${name}" heeft ${annotations}. Wil je ze bijwerken met de nieuwe stijl of ongewijzigd laten?';
	@override String get leaveAsIs => 'Ongewijzigd laten';
	@override String get label => 'Label';
}

// Path: toolbarSettings
class _Translations$toolbarSettings$nl extends Translations$toolbarSettings$en {
	_Translations$toolbarSettings$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get mainToolbar => 'Hoofdwerkbalk';
	@override String get verseSelection => 'Versselectie';
	@override String get textSelection => 'Tekstselectie';
	@override String get shownForMain => 'Wordt getoond wanneer niets is geselecteerd.';
	@override String get shownForVerses => 'Wordt getoond wanneer een vers is geselecteerd.';
	@override String get shownForText => 'Wordt getoond wanneer je tekst in verzen ingedrukt houdt.';
	@override String get gestures => 'Gebaren';
	@override String get longPress => 'Ingedrukt houden';
	@override String get mainLongPressDescription => 'Snelkoppeling wanneer de werkbalk wordt ingedrukt.';
	@override String get verseLongPressDescription => 'Snelkoppeling wanneer een versselectie wordt ingedrukt.';
	@override String get textLongPressDescription => 'Snelkoppeling wanneer een tekstselectie wordt ingedrukt.';
	@override String get hideToolbar => 'Verbergen';
	@override String get hideToolbarDescription => 'Verberg de werkbalk tijdens het omlaag scrollen voor een ongestoorde Bijbelweergave.';
	@override String get pinToolbar => 'Vastzetten';
	@override String get pinToolbarDescription => 'Zet de werkbalk onderaan de pagina vast.';
	@override String get expandToAnnotation => 'Uitbreiden tot annotatie';
	@override String get expandTextDescription => 'Als je een geannoteerd woord ingedrukt houdt, wordt het hele gemarkeerde bereik geselecteerd.';
	@override String get expandVerseDescription => 'Als je op een vers tikt, wordt de volledige geannoteerde versselectie geselecteerd.';
	@override String get rangeSelection => 'Bereikselectie';
	@override String get rangeSelectionDescription => 'Als je op een tweede vers tikt, worden alle verzen tussen het eerste en tweede vers geselecteerd.';
	@override String get mainShortcut => 'Snelkoppeling hoofdwerkbalk';
	@override String get verseShortcut => 'Snelkoppeling versselectie';
	@override String get textShortcut => 'Snelkoppeling tekstselectie';
}

// Path: themeSettings
class _Translations$themeSettings$nl extends Translations$themeSettings$en {
	_Translations$themeSettings$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Thema en indeling';
	@override String get brightness => 'Helderheid';
	@override String get font => 'Lettertype';
	@override String get fontSizeSpacing => 'Lettergrootte en afstand';
	@override String get greekFontSizeSpacing => 'Griekse lettergrootte en afstand';
	@override String get hebrewFontSizeSpacing => 'Hebreeuwse lettergrootte en afstand';
	@override String get system => 'Systeem';
	@override String get systemTextSizeDescription => 'Gebruik de gewenste tekstgrootte van je apparaat.';
	@override String get defaultSizeDescription => 'Gebruik de standaard lettergrootte en afstand.';
	@override String get redLetters => 'Rode letters';
	@override String get redLettersDescription => 'Toon de woorden van Jezus in rood.';
	@override String get sectionHeadings => 'Tussenkoppen';
	@override String get verseNumbers => 'Versnummers';
	@override String get paragraphsDescription => 'Geef verzen als alinea\'s weer.';
	@override String get footnotesDescription => 'Toon voetnootmarkeringen in de tekst.';
}

// Path: biblePlans
class _Translations$biblePlans$nl extends Translations$biblePlans$en {
	_Translations$biblePlans$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get find => 'Een Bijbelleesplan zoeken';
	@override String get startPlanQuestion => 'Leesplan starten?';
	@override String get reviewAndReflect => 'Terugkijken en overdenken';
	@override String get startPlan => 'Leesplan starten';
	@override String get dailyReminders => 'Dagelijkse herinneringen';
	@override String get dailyRemindersDescription => 'Stel in of wijzig hoe laat dit leesplan je dagelijks aan het lezen herinnert.';
	@override String dailyAt({required Object time}) => 'Dagelijks om ${time}';
	@override String get reminderDiscoveryTitle => 'Dagelijkse herinnering toevoegen?';
	@override String reminderDiscoveryBody({required Object name}) => 'Wil je dat Lux je er elke dag aan herinnert om verder te gaan met "${name}"?';
	@override String get addReminder => 'Herinnering toevoegen';
	@override String get noReminder => 'Nee';
	@override String get deleteReminder => 'Herinnering verwijderen?';
	@override String deleteReminderConfirmation({required Object name}) => 'Weet je zeker dat je de dagelijkse herinnering voor "${name}" wilt verwijderen?';
	@override String get reminderNotificationChannelName => 'Herinneringen voor Bijbelleesplannen';
	@override String get reminderNotificationChannelDescription => 'Dagelijkse herinneringen voor je Bijbelleesplannen';
	@override String reminderNotificationTitle({required Object name}) => 'Lees "${name}"';
	@override String reminderNotificationBody({required Object reading}) => 'De lezing van vandaag is ${reading}';
	@override String get reminderPermissionDeniedTitle => 'Meldingen zijn uitgeschakeld';
	@override String get reminderPermissionDeniedBody => 'Sta Lux toe om meldingen te sturen in Instellingen om deze herinnering op te slaan.';
	@override String get openNotificationSettings => 'Instellingen openen';
	@override String get reminderSchedulingFailedTitle => 'Herinnering kon niet worden ingesteld';
	@override String get reminderSchedulingFailedBody => 'Lux kon deze herinnering niet instellen. Probeer het opnieuw.';
	@override String reminderSaved({required Object name, required Object time}) => 'Herinnering voor "${name}" opgeslagen voor dagelijks om ${time}.';
	@override String get stopPlan => 'Leesplan stoppen';
	@override String get stopPlanDescription => 'Verwijder dit leesplan en de voortgang.';
	@override String get readEntireChapter => 'Hele hoofdstuk lezen';
	@override String get readInContext => 'In context lezen';
	@override String get startNew => 'Nieuw starten';
	@override String day({required Object day}) => 'Dag ${day}';
	@override String dayCount({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('nl'))(count,
		one: '${count} dag',
		other: '${count} dagen',
	);
	@override String stopConfirmation({required Object name}) => 'Weet je zeker dat je "${name}" wilt stoppen? Je voortgang gaat verloren.';
	@override String completed({required Object name}) => '"${name}" voltooid.';
	@override String get addPlan => 'Bijbelleesplan toevoegen';
}

// Path: searchUi
class _Translations$searchUi$nl extends Translations$searchUi$en {
	_Translations$searchUi$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get searchBible => 'Bijbel doorzoeken';
	@override String get startSearch => 'Begin met zoeken';
	@override String get searchPrompt => 'Voer een zoekwoord in, zoals licht, woord of wijsheid, en druk op Enter.';
	@override String usingTranslation({required Object translation}) => '${translation} wordt gebruikt om te zoeken';
	@override String unsupportedTranslation({required Object translation}) => '${translation} ondersteunt zoeken momenteel niet. In plaats daarvan wordt je meest recent gebruikte studiebijbel gebruikt.';
	@override String get strongSearchStudyBibleExplanation => 'Voor zoekopdrachten op Strong-nummers zijn de woord-voor-woord Strong-coderingen uit studiebijbels nodig. In plaats daarvan wordt je meest recent gebruikte studiebijbel gebruikt.';
	@override String get wordOrPhraseHint => 'Zoek naar een woord of zin';
	@override String get wordHint => 'Zoek naar een woord';
	@override String get strongNumberHint => 'Zoek naar een Strong-nummer (bijv. H125)';
	@override late final _Translations$searchUi$wordMatching$nl wordMatching = _Translations$searchUi$wordMatching$nl._(_root);
}

// Path: onboarding
class _Translations$onboarding$nl extends Translations$onboarding$en {
	_Translations$onboarding$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get skipQuestion => 'Introductie overslaan?';
	@override String get skipConfirmation => 'Weet je zeker dat je de introductie wilt overslaan? Je kunt deze opnieuw starten via Instellingen > Help.';
	@override String get getStarted => 'Aan de slag';
	@override String get learnLux => 'Leer Lux gebruiken';
	@override String get checklistDescription => 'Voltooi de onderstaande lijst om Lux te leren gebruiken.';
	@override String get skipHint => 'Weinig tijd? Tik op ✕ om over te slaan.';
}

// Path: analyticsNotice
class _Translations$analyticsNotice$nl extends Translations$analyticsNotice$en {
	_Translations$analyticsNotice$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Een opmerking over anonieme statistieken';
	@override String get description => 'Lux gebruikt nu anonieme gebruiksstatistieken en crashrapporten om te begrijpen welke functies worden gebruikt en de betrouwbaarheid te verbeteren. Deze rapporten bevatten nooit je notities, namen of leesdetails van Bijbelplannen, zoektermen of andere privé-inhoud en zijn niet gekoppeld aan een account. Door Lux te blijven gebruiken, ga je ermee akkoord dat deze informatie wordt verzonden.';
}

// Path: tutorials
class _Translations$tutorials$nl extends Translations$tutorials$en {
	_Translations$tutorials$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get dontShowAgain => 'Niet meer tonen';
}

// Path: audio
class _Translations$audio$nl extends Translations$audio$en {
	_Translations$audio$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get timer => 'Audiotimer';
	@override String get fiveMinutes => '5 minuten';
	@override String get tenMinutes => '10 minuten';
	@override String get fifteenMinutes => '15 minuten';
	@override String get thirtyMinutes => '30 minuten';
	@override String get oneHour => '1 uur';
	@override String get loadError => 'De audio kon niet worden geladen';
	@override String get connectionError => 'Controleer je internetverbinding of probeer het later opnieuw.';
	@override String get unavailable => 'Audio is niet beschikbaar voor deze Bijbel';
	@override String get chooseBible => 'Kies een Bijbel met audio om naar dit hoofdstuk te luisteren.';
	@override String get switchRequired => 'Schakel over naar een Bijbel met audio om naar dit gedeelte te luisteren.';
	@override String get rewindTenSeconds => '10 seconden terug';
	@override String get fastForwardTenSeconds => '10 seconden vooruit';
	@override String get notificationChannelName => 'Bijbelaudio afspelen';
	@override String get notificationChannelDescription => 'Bediening voor het afspelen van bijbelaudio';
}

// Path: interlinearUi
class _Translations$interlinearUi$nl extends Translations$interlinearUi$en {
	_Translations$interlinearUi$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get interlinearBible => 'Interlineaire Bijbel';
	@override String get direction => 'Interlineaire richting';
	@override String get reverse => 'Omgekeerd';
	@override String get forward => 'Voorwaarts';
	@override String get reverseDescription => 'Woorden staan in de Nederlandse leesvolgorde.';
	@override String get forwardDescription => 'Woorden staan in de oorspronkelijke Hebreeuwse of Griekse volgorde.';
	@override String get studyBibleExplanation => 'Studiebijbels zijn woord voor woord voorzien van Strong-coderingen en morfologische informatie. Daardoor is de interlineaire lexicale analyse mogelijk. In plaats daarvan wordt je meest recent gebruikte studiebijbel gebruikt.';
	@override String usingTranslation({required Object translation}) => '${translation} wordt gebruikt voor interlineair';
}

// Path: chapterUnavailable
class _Translations$chapterUnavailable$nl extends Translations$chapterUnavailable$en {
	_Translations$chapterUnavailable$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String title({required Object selectedTranslation, required Object testament}) => '${selectedTranslation} bevat het ${testament} niet.';
	@override String subtitle({required Object testament, required Object fallbackTranslation}) => 'Je meest recent gebruikte Bijbel voor het ${testament}, ${fallbackTranslation}, wordt getoond.';
}

// Path: verseNumbering
class _Translations$verseNumbering$nl extends Translations$verseNumbering$en {
	_Translations$verseNumbering$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String referenceLabel({required Object translation, required Object reference}) => '${translation} ${reference}';
	@override String explanation({required Object translation, required Object reference, required Object originalReference}) => 'De hoofdstukken en verzen van de ${translation} zijn anders genummerd dan in de meeste Engelse vertalingen.\n\nDe tekst die hier bij ${reference} wordt getoond, komt uit ${originalReference} in de ${translation} en is opnieuw gekoppeld om met de andere vertalingen overeen te komen.';
}

// Path: compare
class _Translations$compare$nl extends Translations$compare$en {
	_Translations$compare$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String unavailable({required Object translation}) => '${translation} bevat deze selectie niet.';
}

// Path: commentaryUi
class _Translations$commentaryUi$nl extends Translations$commentaryUi$en {
	_Translations$commentaryUi$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String introTo({required Object book}) => 'Inleiding tot ${book}';
}

// Path: searchLocations
class _Translations$searchLocations$nl extends Translations$searchLocations$en {
	_Translations$searchLocations$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get currentBook => 'Huidig boek';
	@override String get testaments => 'Testamenten';
	@override String get books => 'Boeken';
}

// Path: themeOptions
class _Translations$themeOptions$nl extends Translations$themeOptions$en {
	_Translations$themeOptions$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get auto => 'Automatisch';
	@override String get light => 'Licht';
	@override String get dark => 'Donker';
	@override String get extraTiny => 'Extra klein';
	@override String get tiny => 'Zeer klein';
	@override String get small => 'Klein';
	@override String get standard => 'Standaard';
	@override String get large => 'Groot';
	@override String get huge => 'Zeer groot';
	@override String get extraHuge => 'Extra groot';
	@override String get nativeAndSynthetic => 'Eigen en toegevoegd';
	@override String get native => 'Eigen';
	@override String get none => 'Geen';
	@override String get allHeadingsDescription => 'Toon tussenkoppen in vertalingen die ze ondersteunen en voeg de tussenkoppen van de BSB toe aan Engelse vertalingen die zelf geen tussenkoppen hebben.';
	@override String get nativeHeadingsDescription => 'Toon tussenkoppen in vertalingen die ze ondersteunen.';
	@override String get noHeadingsDescription => 'Toon geen tussenkoppen';
}

// Path: toolbarPresets
class _Translations$toolbarPresets$nl extends Translations$toolbarPresets$en {
	_Translations$toolbarPresets$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get reader => 'Lezer';
	@override String get noteTaker => 'Notitiemaker';
	@override String get studier => 'Bijbelstudent';
	@override String get readerDescription => 'Afgestemd op ongestoord lezen en snel navigeren.';
	@override String get noteTakerDescription => 'Afgestemd op markeren en notities maken.';
	@override String get studierDescription => 'Afgestemd op kruisverwijzingen, commentaren en diepgaande studie.';
}

// Path: commentaryTypes
class _Translations$commentaryTypes$nl extends Translations$commentaryTypes$en {
	_Translations$commentaryTypes$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get matthewHenryDescription => 'Een beknopt, devoot commentaar op de hele Bijbel vanuit de puriteinse traditie. Warm, praktisch en toegankelijk.';
	@override String get jamiesonFaussetBrownDescription => 'Een compact vers-voor-verscommentaar op de hele Bijbel. Evenwichtig en toegankelijk.';
	@override String get calvinDescription => 'De klassieke uiteenzetting van de reformator. Diepgaand en leerstellig.';
}

// Path: strongDefinition
class _Translations$strongDefinition$nl extends Translations$strongDefinition$en {
	_Translations$strongDefinition$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get addedLabel => 'toegevoegd:';
	@override String get idiomLabel => 'idioom:';
	@override String get addedWord => 'Toegevoegd woord';
	@override String get idiomaticRendering => 'Idiomatische weergave';
	@override String get addedWordDescription => 'Geeft een woord aan dat naast het gedefinieerde Hebreeuwse of Griekse woord is aangevuld.';
	@override String get idiomaticRenderingDescription => 'Geeft een vertaling aan die een Hebreeuwse of Griekse uitdrukking weergeeft.';
}

// Path: planTypes
class _Translations$planTypes$nl extends Translations$planTypes$en {
	_Translations$planTypes$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get throughTheBible => 'De Bijbel door';
	@override String get chronological => 'Chronologisch in één jaar';
	@override String get oldAndNewTestament => 'Oude en Nieuwe Testament';
	@override String get historicallyBlended => 'Historisch verweven';
	@override String get everyDayInTheWord => 'Elke dag in het Woord';
	@override String get mcheyne => 'M\'Cheyne';
	@override String get literaryStudy => 'Literaire studie';
	@override String get differentTopics => 'Verschillende onderwerpen';
	@override String get newTestamentPsalmsProverbs => 'Nieuwe Testament, Psalmen en Spreuken';
	@override String get fiveByFiveByFive => '5x5x5 Nieuwe Testament';
	@override String get gospelsAndEpistles => 'Evangeliën en brieven';
	@override String get pentateuchAndHistory => 'Pentateuch en geschiedenis van Israël';
	@override String get chroniclesAndProphets => 'Kronieken en profeten';
	@override String get psalmsAndWisdom => 'Psalmen en wijsheidsliteratuur';
	@override String get mcheyneDescription => 'Een klassiek plan met vier korte lezingen per dag. Je leest het Oude Testament eenmaal en het Nieuwe Testament en de Psalmen tweemaal in een jaar.';
	@override String get chronologicalDescription => 'Lees de hele Bijbel in één jaar, gerangschikt in de volgorde waarin de gebeurtenissen plaatsvonden.';
	@override String get throughTheBibleDescription => 'Lees de hele Bijbel in één jaar van Genesis tot Openbaring.';
	@override String get gospelsAndEpistlesDescription => 'Reis een jaar lang door het Nieuwe Testament, de evangeliën en de brieven van de apostelen.';
	@override String get everyDayInTheWordDescription => 'Vier lezingen per dag uit het Oude Testament, Nieuwe Testament, Psalmen en Spreuken. Zo lees je de hele Bijbel in één jaar en Psalmen en Spreuken tweemaal.';
	@override String get literaryStudyDescription => 'Beleef de Bijbel een jaar lang gegroepeerd naar literaire stijl, van verhalen en poëzie tot brieven.';
	@override String get chroniclesAndProphetsDescription => 'Een jaar waarin de geschiedenis uit Kronieken wordt gekoppeld aan de boodschappen van de profeten.';
	@override String get pentateuchAndHistoryDescription => 'Reis in één jaar door de vijf boeken van Mozes en de geschiedenis van Israël.';
	@override String get psalmsAndWisdomDescription => 'Breng een jaar door in de Psalmen en wijsheidsboeken zoals Spreuken, Job en Prediker.';
	@override String get oldAndNewTestamentDescription => 'Lees de hele Bijbel in één jaar en volg het Oude en Nieuwe Testament samen in de gebruikelijke Bijbelvolgorde.';
	@override String get historicallyBlendedDescription => 'Lees de hele Bijbel in één jaar, met boeken en passages gerangschikt rond verwante gebeurtenissen en historische perioden.';
	@override String get differentTopicsDescription => 'Lees elke dag een ander gedeelte van de Bijbel en verken in één jaar elk Bijbelboek.';
	@override String get newTestamentPsalmsProverbsDescription => 'Lees in één jaar het Nieuwe Testament naast Psalmen en Spreuken.';
	@override String get fiveByFiveByFiveDescription => 'Lees vijf dagen per week één hoofdstuk uit het Nieuwe Testament, gevolgd door twee dagen om terug te kijken en te overdenken.';
	@override String get oldScopeDescription => 'Leest uit boeken van het Oude Testament.';
	@override String get newScopeDescription => 'Leest uit boeken van het Nieuwe Testament.';
	@override String get wholeScopeDescription => 'Leest uit het Oude en Nieuwe Testament.';
	@override String get focused => 'Gericht';
	@override String get comprehensive => 'Volledig';
	@override String get focusedDescription => 'Behandelt een specifiek gedeelte of een specifieke verzameling binnen het bereik.';
	@override String get comprehensiveDescription => 'Behandelt elk boek binnen het bereik.';
}

// Path: onboardingSteps
class _Translations$onboardingSteps$nl extends Translations$onboardingSteps$en {
	_Translations$onboardingSteps$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get viewCrossReferences => 'Kruisverwijzingen bekijken';
	@override String get annotateVerse => 'Een vers annoteren';
	@override String get searchWord => 'Naar een woord zoeken';
	@override String get switchBible => 'Van Bijbel wisselen';
	@override String get navigateChapter => 'Naar een ander hoofdstuk gaan';
	@override String get goBack => 'Teruggaan';
	@override String get swipeChapter => 'Vegen om van hoofdstuk te wisselen';
	@override String get addStudyPanel => 'Een studiepaneel toevoegen';
	@override String get customizeToolbar => 'Je werkbalken aanpassen';
	@override String get startBiblePlan => 'Een Bijbelleesplan starten';
	@override String get selectVerse => 'Tik op een vers om het te selecteren';
	@override String get selectWord => 'Houd een woord ingedrukt';
	@override String get deselectPrefix => 'Tik op ';
	@override String get deselectSuffix => ' naast je selectie om de selectie op te heffen';
	@override String get revealToolbar => 'Scroll omhoog om de hoofdwerkbalk te tonen';
	@override String get addPanelPrefix => 'Tik op ';
	@override String get addPanelSuffix => ' → Studie → Studiepaneel toevoegen en voeg een studiepaneel toe';
	@override String get goToChapter => 'Ga naar een ander hoofdstuk';
	@override String get openPrefix => 'Open ';
	@override String get crossReferencesSuffix => ' → Studie → Kruisverwijzingen';
	@override String get annotatePrefix => 'Tik op ';
	@override String get annotateSuffix => ' om te markeren of een notitie toe te voegen';
	@override String get searchPrefix => 'Tik op ';
	@override String get searchSuffix => ' om het woord overal op te zoeken';
	@override String switchBibleDescription({required Object translation}) => 'Tik op de hoofdwerkbalk → ${translation} om van Bijbel te wisselen';
	@override String get goToChapterDescription => 'Tik op de hoofdwerkbalk om naar een ander hoofdstuk te gaan';
	@override String get goBackDescription => 'Veeg op de werkbalk naar rechts om terug te gaan';
	@override String get swipeChapterDescription => 'Veeg de Bijbel naar links of rechts om van hoofdstuk te wisselen';
	@override String get viewPanelDescription => 'Veeg dit paneel naar rechts om je studiepaneel te bekijken';
	@override String get moreSeparator => ' → Meer → ';
	@override String get customizeToolbarSuffix => 'Werkbalken en kies een werkbalkpreset of wijzig een snelkoppeling';
	@override String get startPlanSuffix => ' → Bijbelleesplannen en start een leesplan';
}

// Path: dictionary
class _Translations$dictionary$nl extends Translations$dictionary$en {
	_Translations$dictionary$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get eastons => 'Easton\'s Bible Dictionary';
}

// Path: navigation
class _Translations$navigation$nl extends Translations$navigation$en {
	_Translations$navigation$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get recents => 'Recent';
	@override String get navigate => 'Navigeren';
	@override String get book => 'Boek';
	@override String get chapter => 'Hoofdstuk';
	@override String get verse => 'Vers';
}

// Path: bibleSheet
class _Translations$bibleSheet$nl extends Translations$bibleSheet$en {
	_Translations$bibleSheet$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get allBibles => 'Alle Bijbels';
	@override String availableCount({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('nl'))(count,
		one: '${count} Bijbel beschikbaar',
		other: '${count} Bijbels beschikbaar',
	);
}

// Path: selectionUi
class _Translations$selectionUi$nl extends Translations$selectionUi$en {
	_Translations$selectionUi$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get selected => 'Geselecteerd: ';
	@override String get sourceApiBible => 'Bron: [https://api.bible](https://api.bible)';
}

// Path: errors
class _Translations$errors$nl extends Translations$errors$en {
	_Translations$errors$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get deviceVerificationFailed => 'Apparaatverificatie mislukt';
	@override String get deviceVerificationDescription => 'Voor toegang tot deze online Bijbel zijn een geldig apparaat en een legitieme installatie van Lux vereist. Controleer of je Lux vanuit een officiële appwinkel hebt geïnstalleerd en probeer het opnieuw.';
	@override String get generic => 'Er is iets misgegaan';
	@override String get connection => 'Controleer je internetverbinding of probeer het later opnieuw.';
}

// Path: morphology
class _Translations$morphology$nl extends Translations$morphology$en {
	_Translations$morphology$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$attributes$nl attributes = _Translations$morphology$attributes$nl._(_root);
	@override late final _Translations$morphology$types$nl types = _Translations$morphology$types$nl._(_root);
	@override late final _Translations$morphology$person$nl person = _Translations$morphology$person$nl._(_root);
	@override late final _Translations$morphology$gender$nl gender = _Translations$morphology$gender$nl._(_root);
	@override late final _Translations$morphology$number$nl number = _Translations$morphology$number$nl._(_root);
	@override late final _Translations$morphology$kCase$nl kCase = _Translations$morphology$kCase$nl._(_root);
	@override late final _Translations$morphology$state$nl state = _Translations$morphology$state$nl._(_root);
	@override late final _Translations$morphology$stem$nl stem = _Translations$morphology$stem$nl._(_root);
	@override late final _Translations$morphology$aspect$nl aspect = _Translations$morphology$aspect$nl._(_root);
	@override late final _Translations$morphology$hebrewMood$nl hebrewMood = _Translations$morphology$hebrewMood$nl._(_root);
	@override late final _Translations$morphology$tense$nl tense = _Translations$morphology$tense$nl._(_root);
	@override late final _Translations$morphology$mood$nl mood = _Translations$morphology$mood$nl._(_root);
	@override late final _Translations$morphology$voice$nl voice = _Translations$morphology$voice$nl._(_root);
	@override late final _Translations$morphology$degree$nl degree = _Translations$morphology$degree$nl._(_root);
	@override late final _Translations$morphology$literals$nl literals = _Translations$morphology$literals$nl._(_root);
}

// Path: settings
class _Translations$settings$nl extends Translations$settings$en {
	_Translations$settings$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Instellingen';
	@override String get customize => 'Aanpassen';
	@override String get pushNotifications => 'Pushmeldingen';
	@override String get biblePlanReminders => 'Herinneringen voor Bijbelleesplannen';
	@override String get notificationsNotRequested => 'Schakel meldingen in.';
	@override String get notificationsNotRequestedDescription => 'Sta Lux toe meldingen te sturen om je herinneringen te beheren.';
	@override String get notificationsDisabled => 'Meldingen voor Lux zijn uitgeschakeld.';
	@override String get biblePlanRemindersDisabled => 'Herinneringen voor Bijbelleesplannen zijn uitgeschakeld.';
	@override String get verseOfTheDayRemindersDisabled => 'Herinneringen voor het vers van de dag zijn uitgeschakeld.';
	@override String get notificationsDisabledDescription => 'Schakel ze in via de instellingen van je apparaat om je herinneringen te beheren.';
	@override String get language => 'Taal';
	@override String get system => 'Systeem';
	@override String get systemLanguageDescription => 'Komt overeen met de taalinstelling van je systeem.';
	@override String get toolbarPresets => 'Werkbalkpresets';
	@override String get toolbarPreset => 'Werkbalkpreset';
	@override String get presetWarning => 'Als je een preset selecteert, worden de snelkoppelingen in al je werkbalken overschreven.';
	@override String get yourContent => 'Je inhoud';
	@override String get discussionAndAnnouncements => 'Discussies en aankondigingen';
	@override String get tipsAndUpdates => 'Tips en updates';
	@override String get supportLux => 'Lux steunen';
	@override String get rateLux => 'Lux beoordelen';
	@override String get leaveReview => 'Schrijf een recensie in de App Store.';
	@override String get supportMessage => 'Lux is een passieproject vanuit de overtuiging dat de Bijbel voor iedereen vrij beschikbaar moet zijn. De beste manier om Lux te steunen is met een recensie in de App Store.\n\nAls iets je ervan weerhoudt om een vijfsterrenrecensie te schrijven, word dan lid van onze Discord en deel je feedback. Dan kunnen we er snel iets aan doen.';
	@override String get leaveRating => 'Beoordeling achterlaten';
	@override String get joinDiscord => 'Lid worden van Discord';
	@override String get restartGetStarted => 'Aan de slag opnieuw starten';
	@override String get restartGetStartedDescription => 'Toon de checklist Aan de slag opnieuw';
	@override String get resetTutorials => 'Uitleg opnieuw instellen';
	@override String get resetTutorialsDescription => 'Toon de handige tips in de app opnieuw';
	@override String get tutorialsReset => 'De uitleg is opnieuw ingesteld.';
}

// Path: searchUi.wordMatching
class _Translations$searchUi$wordMatching$nl extends Translations$searchUi$wordMatching$en {
	_Translations$searchUi$wordMatching$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Woordovereenkomst';
	@override late final _Translations$searchUi$wordMatching$wholeWord$nl wholeWord = _Translations$searchUi$wordMatching$wholeWord$nl._(_root);
	@override late final _Translations$searchUi$wordMatching$startOfWord$nl startOfWord = _Translations$searchUi$wordMatching$startOfWord$nl._(_root);
	@override late final _Translations$searchUi$wordMatching$partOfWord$nl partOfWord = _Translations$searchUi$wordMatching$partOfWord$nl._(_root);
}

// Path: morphology.attributes
class _Translations$morphology$attributes$nl extends Translations$morphology$attributes$en {
	_Translations$morphology$attributes$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$attributes$type$nl type = _Translations$morphology$attributes$type$nl._(_root);
	@override late final _Translations$morphology$attributes$grammaticalCase$nl grammaticalCase = _Translations$morphology$attributes$grammaticalCase$nl._(_root);
	@override late final _Translations$morphology$attributes$gender$nl gender = _Translations$morphology$attributes$gender$nl._(_root);
	@override late final _Translations$morphology$attributes$number$nl number = _Translations$morphology$attributes$number$nl._(_root);
	@override late final _Translations$morphology$attributes$person$nl person = _Translations$morphology$attributes$person$nl._(_root);
	@override late final _Translations$morphology$attributes$state$nl state = _Translations$morphology$attributes$state$nl._(_root);
	@override late final _Translations$morphology$attributes$tense$nl tense = _Translations$morphology$attributes$tense$nl._(_root);
	@override late final _Translations$morphology$attributes$mood$nl mood = _Translations$morphology$attributes$mood$nl._(_root);
	@override late final _Translations$morphology$attributes$voice$nl voice = _Translations$morphology$attributes$voice$nl._(_root);
	@override late final _Translations$morphology$attributes$degree$nl degree = _Translations$morphology$attributes$degree$nl._(_root);
	@override late final _Translations$morphology$attributes$stem$nl stem = _Translations$morphology$attributes$stem$nl._(_root);
	@override late final _Translations$morphology$attributes$aspect$nl aspect = _Translations$morphology$attributes$aspect$nl._(_root);
	@override late final _Translations$morphology$attributes$prefix$nl prefix = _Translations$morphology$attributes$prefix$nl._(_root);
	@override late final _Translations$morphology$attributes$particle$nl particle = _Translations$morphology$attributes$particle$nl._(_root);
	@override late final _Translations$morphology$attributes$code$nl code = _Translations$morphology$attributes$code$nl._(_root);
}

// Path: morphology.types
class _Translations$morphology$types$nl extends Translations$morphology$types$en {
	_Translations$morphology$types$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$types$article$nl article = _Translations$morphology$types$article$nl._(_root);
	@override late final _Translations$morphology$types$conjunction$nl conjunction = _Translations$morphology$types$conjunction$nl._(_root);
	@override late final _Translations$morphology$types$preposition$nl preposition = _Translations$morphology$types$preposition$nl._(_root);
	@override late final _Translations$morphology$types$adverb$nl adverb = _Translations$morphology$types$adverb$nl._(_root);
	@override late final _Translations$morphology$types$negativeAdverb$nl negativeAdverb = _Translations$morphology$types$negativeAdverb$nl._(_root);
	@override late final _Translations$morphology$types$adjective$nl adjective = _Translations$morphology$types$adjective$nl._(_root);
	@override late final _Translations$morphology$types$noun$nl noun = _Translations$morphology$types$noun$nl._(_root);
	@override late final _Translations$morphology$types$properNoun$nl properNoun = _Translations$morphology$types$properNoun$nl._(_root);
	@override late final _Translations$morphology$types$number$nl number = _Translations$morphology$types$number$nl._(_root);
	@override late final _Translations$morphology$types$ordinalNumber$nl ordinalNumber = _Translations$morphology$types$ordinalNumber$nl._(_root);
	@override late final _Translations$morphology$types$pronoun$nl pronoun = _Translations$morphology$types$pronoun$nl._(_root);
	@override late final _Translations$morphology$types$personalPronoun$nl personalPronoun = _Translations$morphology$types$personalPronoun$nl._(_root);
	@override late final _Translations$morphology$types$demonstrativePronoun$nl demonstrativePronoun = _Translations$morphology$types$demonstrativePronoun$nl._(_root);
	@override late final _Translations$morphology$types$interrogativePronoun$nl interrogativePronoun = _Translations$morphology$types$interrogativePronoun$nl._(_root);
	@override late final _Translations$morphology$types$indefinitePronoun$nl indefinitePronoun = _Translations$morphology$types$indefinitePronoun$nl._(_root);
	@override late final _Translations$morphology$types$reciprocalPronoun$nl reciprocalPronoun = _Translations$morphology$types$reciprocalPronoun$nl._(_root);
	@override late final _Translations$morphology$types$reflexivePronoun$nl reflexivePronoun = _Translations$morphology$types$reflexivePronoun$nl._(_root);
	@override late final _Translations$morphology$types$relativePronoun$nl relativePronoun = _Translations$morphology$types$relativePronoun$nl._(_root);
	@override late final _Translations$morphology$types$particle$nl particle = _Translations$morphology$types$particle$nl._(_root);
	@override late final _Translations$morphology$types$negativeParticle$nl negativeParticle = _Translations$morphology$types$negativeParticle$nl._(_root);
	@override late final _Translations$morphology$types$interrogativeParticle$nl interrogativeParticle = _Translations$morphology$types$interrogativeParticle$nl._(_root);
	@override late final _Translations$morphology$types$demonstrativeParticle$nl demonstrativeParticle = _Translations$morphology$types$demonstrativeParticle$nl._(_root);
	@override late final _Translations$morphology$types$genericParticle$nl genericParticle = _Translations$morphology$types$genericParticle$nl._(_root);
	@override late final _Translations$morphology$types$relativeParticle$nl relativeParticle = _Translations$morphology$types$relativeParticle$nl._(_root);
	@override late final _Translations$morphology$types$verb$nl verb = _Translations$morphology$types$verb$nl._(_root);
	@override late final _Translations$morphology$types$pronominalSuffix$nl pronominalSuffix = _Translations$morphology$types$pronominalSuffix$nl._(_root);
	@override late final _Translations$morphology$types$directObjectMarker$nl directObjectMarker = _Translations$morphology$types$directObjectMarker$nl._(_root);
	@override late final _Translations$morphology$types$punctuation$nl punctuation = _Translations$morphology$types$punctuation$nl._(_root);
	@override late final _Translations$morphology$types$interjection$nl interjection = _Translations$morphology$types$interjection$nl._(_root);
	@override late final _Translations$morphology$types$indeclinable$nl indeclinable = _Translations$morphology$types$indeclinable$nl._(_root);
	@override late final _Translations$morphology$types$hebraism$nl hebraism = _Translations$morphology$types$hebraism$nl._(_root);
	@override late final _Translations$morphology$types$unknown$nl unknown = _Translations$morphology$types$unknown$nl._(_root);
}

// Path: morphology.person
class _Translations$morphology$person$nl extends Translations$morphology$person$en {
	_Translations$morphology$person$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$person$first$nl first = _Translations$morphology$person$first$nl._(_root);
	@override late final _Translations$morphology$person$second$nl second = _Translations$morphology$person$second$nl._(_root);
	@override late final _Translations$morphology$person$third$nl third = _Translations$morphology$person$third$nl._(_root);
}

// Path: morphology.gender
class _Translations$morphology$gender$nl extends Translations$morphology$gender$en {
	_Translations$morphology$gender$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$gender$masculine$nl masculine = _Translations$morphology$gender$masculine$nl._(_root);
	@override late final _Translations$morphology$gender$feminine$nl feminine = _Translations$morphology$gender$feminine$nl._(_root);
	@override late final _Translations$morphology$gender$neuter$nl neuter = _Translations$morphology$gender$neuter$nl._(_root);
	@override late final _Translations$morphology$gender$common$nl common = _Translations$morphology$gender$common$nl._(_root);
}

// Path: morphology.number
class _Translations$morphology$number$nl extends Translations$morphology$number$en {
	_Translations$morphology$number$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$number$singular$nl singular = _Translations$morphology$number$singular$nl._(_root);
	@override late final _Translations$morphology$number$plural$nl plural = _Translations$morphology$number$plural$nl._(_root);
	@override late final _Translations$morphology$number$dual$nl dual = _Translations$morphology$number$dual$nl._(_root);
}

// Path: morphology.kCase
class _Translations$morphology$kCase$nl extends Translations$morphology$kCase$en {
	_Translations$morphology$kCase$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$kCase$nominative$nl nominative = _Translations$morphology$kCase$nominative$nl._(_root);
	@override late final _Translations$morphology$kCase$genitive$nl genitive = _Translations$morphology$kCase$genitive$nl._(_root);
	@override late final _Translations$morphology$kCase$dative$nl dative = _Translations$morphology$kCase$dative$nl._(_root);
	@override late final _Translations$morphology$kCase$accusative$nl accusative = _Translations$morphology$kCase$accusative$nl._(_root);
	@override late final _Translations$morphology$kCase$vocative$nl vocative = _Translations$morphology$kCase$vocative$nl._(_root);
}

// Path: morphology.state
class _Translations$morphology$state$nl extends Translations$morphology$state$en {
	_Translations$morphology$state$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$state$absolute$nl absolute = _Translations$morphology$state$absolute$nl._(_root);
	@override late final _Translations$morphology$state$construct$nl construct = _Translations$morphology$state$construct$nl._(_root);
	@override late final _Translations$morphology$state$determined$nl determined = _Translations$morphology$state$determined$nl._(_root);
}

// Path: morphology.stem
class _Translations$morphology$stem$nl extends Translations$morphology$stem$en {
	_Translations$morphology$stem$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$stem$qal$nl qal = _Translations$morphology$stem$qal$nl._(_root);
	@override late final _Translations$morphology$stem$qalPassive$nl qalPassive = _Translations$morphology$stem$qalPassive$nl._(_root);
	@override late final _Translations$morphology$stem$niphal$nl niphal = _Translations$morphology$stem$niphal$nl._(_root);
	@override late final _Translations$morphology$stem$piel$nl piel = _Translations$morphology$stem$piel$nl._(_root);
	@override late final _Translations$morphology$stem$pual$nl pual = _Translations$morphology$stem$pual$nl._(_root);
	@override late final _Translations$morphology$stem$hiphil$nl hiphil = _Translations$morphology$stem$hiphil$nl._(_root);
	@override late final _Translations$morphology$stem$hophal$nl hophal = _Translations$morphology$stem$hophal$nl._(_root);
	@override late final _Translations$morphology$stem$hithpael$nl hithpael = _Translations$morphology$stem$hithpael$nl._(_root);
	@override late final _Translations$morphology$stem$nithpael$nl nithpael = _Translations$morphology$stem$nithpael$nl._(_root);
}

// Path: morphology.aspect
class _Translations$morphology$aspect$nl extends Translations$morphology$aspect$en {
	_Translations$morphology$aspect$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$aspect$perfect$nl perfect = _Translations$morphology$aspect$perfect$nl._(_root);
	@override late final _Translations$morphology$aspect$imperfect$nl imperfect = _Translations$morphology$aspect$imperfect$nl._(_root);
	@override late final _Translations$morphology$aspect$imperative$nl imperative = _Translations$morphology$aspect$imperative$nl._(_root);
	@override late final _Translations$morphology$aspect$infinitiveConstruct$nl infinitiveConstruct = _Translations$morphology$aspect$infinitiveConstruct$nl._(_root);
	@override late final _Translations$morphology$aspect$infinitiveAbsolute$nl infinitiveAbsolute = _Translations$morphology$aspect$infinitiveAbsolute$nl._(_root);
	@override late final _Translations$morphology$aspect$participle$nl participle = _Translations$morphology$aspect$participle$nl._(_root);
	@override late final _Translations$morphology$aspect$consecutiveImperfect$nl consecutiveImperfect = _Translations$morphology$aspect$consecutiveImperfect$nl._(_root);
	@override late final _Translations$morphology$aspect$conjunctiveImperfect$nl conjunctiveImperfect = _Translations$morphology$aspect$conjunctiveImperfect$nl._(_root);
	@override late final _Translations$morphology$aspect$conjunctivePerfect$nl conjunctivePerfect = _Translations$morphology$aspect$conjunctivePerfect$nl._(_root);
	@override late final _Translations$morphology$aspect$passiveParticiple$nl passiveParticiple = _Translations$morphology$aspect$passiveParticiple$nl._(_root);
}

// Path: morphology.hebrewMood
class _Translations$morphology$hebrewMood$nl extends Translations$morphology$hebrewMood$en {
	_Translations$morphology$hebrewMood$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$hebrewMood$jussive$nl jussive = _Translations$morphology$hebrewMood$jussive$nl._(_root);
	@override late final _Translations$morphology$hebrewMood$cohortative$nl cohortative = _Translations$morphology$hebrewMood$cohortative$nl._(_root);
	@override late final _Translations$morphology$hebrewMood$hSuffix$nl hSuffix = _Translations$morphology$hebrewMood$hSuffix$nl._(_root);
}

// Path: morphology.tense
class _Translations$morphology$tense$nl extends Translations$morphology$tense$en {
	_Translations$morphology$tense$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$tense$present$nl present = _Translations$morphology$tense$present$nl._(_root);
	@override late final _Translations$morphology$tense$imperfect$nl imperfect = _Translations$morphology$tense$imperfect$nl._(_root);
	@override late final _Translations$morphology$tense$future$nl future = _Translations$morphology$tense$future$nl._(_root);
	@override late final _Translations$morphology$tense$aorist$nl aorist = _Translations$morphology$tense$aorist$nl._(_root);
	@override late final _Translations$morphology$tense$perfect$nl perfect = _Translations$morphology$tense$perfect$nl._(_root);
	@override late final _Translations$morphology$tense$pluperfect$nl pluperfect = _Translations$morphology$tense$pluperfect$nl._(_root);
}

// Path: morphology.mood
class _Translations$morphology$mood$nl extends Translations$morphology$mood$en {
	_Translations$morphology$mood$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$mood$indicative$nl indicative = _Translations$morphology$mood$indicative$nl._(_root);
	@override late final _Translations$morphology$mood$imperative$nl imperative = _Translations$morphology$mood$imperative$nl._(_root);
	@override late final _Translations$morphology$mood$subjunctive$nl subjunctive = _Translations$morphology$mood$subjunctive$nl._(_root);
	@override late final _Translations$morphology$mood$optative$nl optative = _Translations$morphology$mood$optative$nl._(_root);
	@override late final _Translations$morphology$mood$infinitive$nl infinitive = _Translations$morphology$mood$infinitive$nl._(_root);
	@override late final _Translations$morphology$mood$participle$nl participle = _Translations$morphology$mood$participle$nl._(_root);
}

// Path: morphology.voice
class _Translations$morphology$voice$nl extends Translations$morphology$voice$en {
	_Translations$morphology$voice$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$voice$active$nl active = _Translations$morphology$voice$active$nl._(_root);
	@override late final _Translations$morphology$voice$middle$nl middle = _Translations$morphology$voice$middle$nl._(_root);
	@override late final _Translations$morphology$voice$passive$nl passive = _Translations$morphology$voice$passive$nl._(_root);
	@override late final _Translations$morphology$voice$middleOrPassive$nl middleOrPassive = _Translations$morphology$voice$middleOrPassive$nl._(_root);
}

// Path: morphology.degree
class _Translations$morphology$degree$nl extends Translations$morphology$degree$en {
	_Translations$morphology$degree$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$degree$positive$nl positive = _Translations$morphology$degree$positive$nl._(_root);
	@override late final _Translations$morphology$degree$comparative$nl comparative = _Translations$morphology$degree$comparative$nl._(_root);
	@override late final _Translations$morphology$degree$superlative$nl superlative = _Translations$morphology$degree$superlative$nl._(_root);
}

// Path: morphology.literals
class _Translations$morphology$literals$nl extends Translations$morphology$literals$en {
	_Translations$morphology$literals$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get rawCode => 'De onbewerkte morfologiecode zoals die in de bron stond.';
	@override String get waw => 'Het Hebreeuwse voegwoord waw (וְ), dat "en" betekent.';
	@override String get conjunction => 'Een voegwoordmarkering.';
	@override String get bet => 'Het Hebreeuwse voorvoegsel bet (בְּ), dat "in", "bij" of "met" betekent.';
	@override String get kaf => 'Het Hebreeuwse voorvoegsel kaf (כְּ), dat "als" of "zoals" betekent.';
	@override String get lamed => 'Het Hebreeuwse voorvoegsel lamed (לְ), dat "naar", "voor" of "toebehorend aan" betekent.';
	@override String get mem => 'Het Hebreeuwse voorvoegsel mem (מִן), dat "van" of "uit" betekent.';
	@override String get preposition => 'Een voorzetselletter als voorvoegsel.';
	@override String get wawExamples => 'en|nu|maar';
	@override String get betExamples => 'in het begin|met kracht';
	@override String get kafExamples => 'als een leeuw|zoals een herder';
	@override String get lamedExamples => 'aan David|voor de koning';
	@override String get memExamples => 'uit Egypte|uit het land';
}

// Path: searchUi.wordMatching.wholeWord
class _Translations$searchUi$wordMatching$wholeWord$nl extends Translations$searchUi$wordMatching$wholeWord$en {
	_Translations$searchUi$wordMatching$wholeWord$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Volledig woord';
	@override String get description => 'Zoek alleen volledige woorden die overeenkomen met je zoekopdracht.';
	@override String get example => 'Voorbeeld: ‘licht’ vindt ‘licht’';
}

// Path: searchUi.wordMatching.startOfWord
class _Translations$searchUi$wordMatching$startOfWord$nl extends Translations$searchUi$wordMatching$startOfWord$en {
	_Translations$searchUi$wordMatching$startOfWord$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Begin van woord';
	@override String get description => 'Zoek woorden die beginnen met je zoekopdracht.';
	@override String get example => 'Voorbeeld: ‘licht’ vindt ook ‘lichten’';
}

// Path: searchUi.wordMatching.partOfWord
class _Translations$searchUi$wordMatching$partOfWord$nl extends Translations$searchUi$wordMatching$partOfWord$en {
	_Translations$searchUi$wordMatching$partOfWord$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Deel van woord';
	@override String get description => 'Zoek woorden die je zoekopdracht ergens bevatten.';
	@override String get example => 'Voorbeeld: ‘licht’ vindt ook ‘verlichting’';
}

// Path: morphology.attributes.type
class _Translations$morphology$attributes$type$nl extends Translations$morphology$attributes$type$en {
	_Translations$morphology$attributes$type$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Type';
	@override String get description => 'De grammaticale categorie van het woord.';
}

// Path: morphology.attributes.grammaticalCase
class _Translations$morphology$attributes$grammaticalCase$nl extends Translations$morphology$attributes$grammaticalCase$en {
	_Translations$morphology$attributes$grammaticalCase$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Naamval';
	@override String get description => 'De syntactische rol, zoals onderwerp, object of bezit.';
}

// Path: morphology.attributes.gender
class _Translations$morphology$attributes$gender$nl extends Translations$morphology$attributes$gender$en {
	_Translations$morphology$attributes$gender$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Geslacht';
	@override String get description => 'Grammaticaal geslacht: mannelijk, vrouwelijk, onzijdig (Grieks) of gemeenschappelijk (Hebreeuws).';
}

// Path: morphology.attributes.number
class _Translations$morphology$attributes$number$nl extends Translations$morphology$attributes$number$en {
	_Translations$morphology$attributes$number$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Getal';
	@override String get description => 'Of het woord verwijst naar één (enkelvoud), twee (dualis) of meerdere (meervoud).';
}

// Path: morphology.attributes.person
class _Translations$morphology$attributes$person$nl extends Translations$morphology$attributes$person$en {
	_Translations$morphology$attributes$person$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Persoon';
	@override String get description => 'Naar wie het woord verwijst: 1e (ik/wij), 2e (jij/jullie) of 3e (hij/zij/het/zij).';
}

// Path: morphology.attributes.state
class _Translations$morphology$attributes$state$nl extends Translations$morphology$attributes$state$en {
	_Translations$morphology$attributes$state$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Status';
	@override String get description => 'De status van een zelfstandig naamwoord: absoluut, constructus of bepaald.';
}

// Path: morphology.attributes.tense
class _Translations$morphology$attributes$tense$nl extends Translations$morphology$attributes$tense$en {
	_Translations$morphology$attributes$tense$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Tijd';
	@override String get description => 'De werkwoordstijd, een combinatie van tijd en aspect.';
}

// Path: morphology.attributes.mood
class _Translations$morphology$attributes$mood$nl extends Translations$morphology$attributes$mood$en {
	_Translations$morphology$attributes$mood$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Wijs';
	@override String get description => 'Hoe de handeling wordt uitgedrukt, bijvoorbeeld als feit, bevel of mogelijkheid.';
}

// Path: morphology.attributes.voice
class _Translations$morphology$attributes$voice$nl extends Translations$morphology$attributes$voice$en {
	_Translations$morphology$attributes$voice$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Diathese';
	@override String get description => 'De diathese: actief, medium of passief.';
}

// Path: morphology.attributes.degree
class _Translations$morphology$attributes$degree$nl extends Translations$morphology$attributes$degree$en {
	_Translations$morphology$attributes$degree$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Trap';
	@override String get description => 'De trap van een bijvoeglijk naamwoord of bijwoord: stellend, vergrotend of overtreffend.';
}

// Path: morphology.attributes.stem
class _Translations$morphology$attributes$stem$nl extends Translations$morphology$attributes$stem$en {
	_Translations$morphology$attributes$stem$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Stam';
	@override String get description => 'De werkwoordstam (binyan), zoals qal, niphal of piel.';
}

// Path: morphology.attributes.aspect
class _Translations$morphology$attributes$aspect$nl extends Translations$morphology$attributes$aspect$en {
	_Translations$morphology$attributes$aspect$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Aspect';
	@override String get description => 'Het werkwoordsaspect, zoals perfectum, imperfectum of participium.';
}

// Path: morphology.attributes.prefix
class _Translations$morphology$attributes$prefix$nl extends Translations$morphology$attributes$prefix$en {
	_Translations$morphology$attributes$prefix$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Voorvoegsel';
	@override String get description => 'Een Hebreeuwse voorzetselletter als voorvoegsel.';
}

// Path: morphology.attributes.particle
class _Translations$morphology$attributes$particle$nl extends Translations$morphology$attributes$particle$en {
	_Translations$morphology$attributes$particle$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Partikel';
	@override String get description => 'Een klein, onverbuigbaar woord, vaak een voegwoord of markeerwoord.';
}

// Path: morphology.attributes.code
class _Translations$morphology$attributes$code$nl extends Translations$morphology$attributes$code$en {
	_Translations$morphology$attributes$code$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Code';
	@override String get description => 'De onbewerkte morfologiecode zoals die in de brontekst staat.';
}

// Path: morphology.types.article
class _Translations$morphology$types$article$nl extends Translations$morphology$types$article$en {
	_Translations$morphology$types$article$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Lidwoord';
	@override String get description => 'Een bepaald lidwoord, "de" of "het".';
	@override String get examples => 'de koning|de Heer';
}

// Path: morphology.types.conjunction
class _Translations$morphology$types$conjunction$nl extends Translations$morphology$types$conjunction$en {
	_Translations$morphology$types$conjunction$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Voegwoord';
	@override String get description => 'Een woord dat andere woorden of zinnen verbindt.';
	@override String get examples => 'en|maar|want';
}

// Path: morphology.types.preposition
class _Translations$morphology$types$preposition$nl extends Translations$morphology$types$preposition$en {
	_Translations$morphology$types$preposition$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Voorzetsel';
	@override String get description => 'Verbindt een zelfstandig naamwoord of voornaamwoord met andere woorden.';
	@override String get examples => 'in|naar|met';
}

// Path: morphology.types.adverb
class _Translations$morphology$types$adverb$nl extends Translations$morphology$types$adverb$en {
	_Translations$morphology$types$adverb$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Bijwoord';
	@override String get description => 'Bepaalt een werkwoord, bijvoeglijk naamwoord of ander bijwoord nader.';
	@override String get examples => 'snel|nu|daar';
}

// Path: morphology.types.negativeAdverb
class _Translations$morphology$types$negativeAdverb$nl extends Translations$morphology$types$negativeAdverb$en {
	_Translations$morphology$types$negativeAdverb$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Ontkennend bijwoord';
	@override String get description => 'Een bijwoord dat een ontkenning uitdrukt.';
	@override String get examples => 'niet|nooit';
}

// Path: morphology.types.adjective
class _Translations$morphology$types$adjective$nl extends Translations$morphology$types$adjective$en {
	_Translations$morphology$types$adjective$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Bijvoeglijk naamwoord';
	@override String get description => 'Een woord dat een zelfstandig naamwoord beschrijft.';
	@override String get examples => 'groot|heilig|wijs';
}

// Path: morphology.types.noun
class _Translations$morphology$types$noun$nl extends Translations$morphology$types$noun$en {
	_Translations$morphology$types$noun$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Zelfstandig naamwoord';
	@override String get description => 'Een persoon, plaats, zaak of begrip.';
	@override String get examples => 'stad|water|liefde';
}

// Path: morphology.types.properNoun
class _Translations$morphology$types$properNoun$nl extends Translations$morphology$types$properNoun$en {
	_Translations$morphology$types$properNoun$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Eigennaam';
	@override String get description => 'De specifieke naam van een persoon, plaats of zaak.';
	@override String get examples => 'David|Jeruzalem|Israël';
}

// Path: morphology.types.number
class _Translations$morphology$types$number$nl extends Translations$morphology$types$number$en {
	_Translations$morphology$types$number$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Hoofdtelwoord';
	@override String get description => 'Een hoofdtelwoord.';
	@override String get examples => 'drie|twaalf|duizend';
}

// Path: morphology.types.ordinalNumber
class _Translations$morphology$types$ordinalNumber$nl extends Translations$morphology$types$ordinalNumber$en {
	_Translations$morphology$types$ordinalNumber$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Rangtelwoord';
	@override String get description => 'Een rangtelwoord, zoals "eerste" of "tweede".';
	@override String get examples => 'eerste|tiende|zeventigste';
}

// Path: morphology.types.pronoun
class _Translations$morphology$types$pronoun$nl extends Translations$morphology$types$pronoun$en {
	_Translations$morphology$types$pronoun$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Voornaamwoord';
	@override String get description => 'Een woord dat in de plaats van een zelfstandig naamwoord staat.';
	@override String get examples => 'hij|zij|ze';
}

// Path: morphology.types.personalPronoun
class _Translations$morphology$types$personalPronoun$nl extends Translations$morphology$types$personalPronoun$en {
	_Translations$morphology$types$personalPronoun$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Persoonlijk voornaamwoord';
	@override String get description => 'Een voornaamwoord dat naar een bepaalde persoon verwijst.';
	@override String get examples => 'ik|jij|wij';
}

// Path: morphology.types.demonstrativePronoun
class _Translations$morphology$types$demonstrativePronoun$nl extends Translations$morphology$types$demonstrativePronoun$en {
	_Translations$morphology$types$demonstrativePronoun$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Aanwijzend voornaamwoord';
	@override String get description => 'Een voornaamwoord dat iets aanwijst.';
	@override String get examples => 'dit|deze|die';
}

// Path: morphology.types.interrogativePronoun
class _Translations$morphology$types$interrogativePronoun$nl extends Translations$morphology$types$interrogativePronoun$en {
	_Translations$morphology$types$interrogativePronoun$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Vragend voornaamwoord';
	@override String get description => 'Een voornaamwoord waarmee een vraag wordt gesteld.';
	@override String get examples => 'wie?|wat?|welke?';
}

// Path: morphology.types.indefinitePronoun
class _Translations$morphology$types$indefinitePronoun$nl extends Translations$morphology$types$indefinitePronoun$en {
	_Translations$morphology$types$indefinitePronoun$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Onbepaald voornaamwoord';
	@override String get description => 'Een voornaamwoord dat naar niet-specifieke zaken verwijst.';
	@override String get examples => 'iemand|wie dan ook|niets';
}

// Path: morphology.types.reciprocalPronoun
class _Translations$morphology$types$reciprocalPronoun$nl extends Translations$morphology$types$reciprocalPronoun$en {
	_Translations$morphology$types$reciprocalPronoun$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Wederkerig voornaamwoord';
	@override String get description => 'Een voornaamwoord dat een wederzijdse handeling uitdrukt.';
	@override String get examples => 'elkaar|elkander';
}

// Path: morphology.types.reflexivePronoun
class _Translations$morphology$types$reflexivePronoun$nl extends Translations$morphology$types$reflexivePronoun$en {
	_Translations$morphology$types$reflexivePronoun$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Wederkerend voornaamwoord';
	@override String get description => 'Een voornaamwoord dat terugverwijst naar het onderwerp.';
	@override String get examples => 'zichzelf|henzelf';
}

// Path: morphology.types.relativePronoun
class _Translations$morphology$types$relativePronoun$nl extends Translations$morphology$types$relativePronoun$en {
	_Translations$morphology$types$relativePronoun$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Betrekkelijk voornaamwoord';
	@override String get description => 'Een voornaamwoord dat een bijzin inleidt.';
	@override String get examples => 'die|dat|welke';
}

// Path: morphology.types.particle
class _Translations$morphology$types$particle$nl extends Translations$morphology$types$particle$en {
	_Translations$morphology$types$particle$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Partikel';
	@override String get description => 'Een klein, onverbuigbaar woord.';
	@override String get examples => 'inderdaad|nu';
}

// Path: morphology.types.negativeParticle
class _Translations$morphology$types$negativeParticle$nl extends Translations$morphology$types$negativeParticle$en {
	_Translations$morphology$types$negativeParticle$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Ontkennend partikel';
	@override String get description => 'Een partikel dat een ontkenning aangeeft.';
	@override String get examples => 'niet|geen';
}

// Path: morphology.types.interrogativeParticle
class _Translations$morphology$types$interrogativeParticle$nl extends Translations$morphology$types$interrogativeParticle$en {
	_Translations$morphology$types$interrogativeParticle$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Vragend partikel';
	@override String get description => 'Een partikel dat een vraag aangeeft.';
	@override String get examples => '(Hebreeuws voorvoegsel ה, zonder Nederlands equivalent)';
}

// Path: morphology.types.demonstrativeParticle
class _Translations$morphology$types$demonstrativeParticle$nl extends Translations$morphology$types$demonstrativeParticle$en {
	_Translations$morphology$types$demonstrativeParticle$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Aanwijzend partikel';
	@override String get description => 'Een aanwijzend partikel, zoals "zie".';
	@override String get examples => 'zie|aanschouw';
}

// Path: morphology.types.genericParticle
class _Translations$morphology$types$genericParticle$nl extends Translations$morphology$types$genericParticle$en {
	_Translations$morphology$types$genericParticle$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Algemeen partikel';
	@override String get description => 'Een algemeen bruikbaar partikel.';
	@override String get examples => 'inderdaad|waarlijk';
}

// Path: morphology.types.relativeParticle
class _Translations$morphology$types$relativeParticle$nl extends Translations$morphology$types$relativeParticle$en {
	_Translations$morphology$types$relativeParticle$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Betrekkelijk partikel';
	@override String get description => 'Een partikel dat een betrekkelijke bijzin inleidt.';
	@override String get examples => 'dat|welke';
}

// Path: morphology.types.verb
class _Translations$morphology$types$verb$nl extends Translations$morphology$types$verb$en {
	_Translations$morphology$types$verb$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Werkwoord';
	@override String get description => 'Een woord dat een handeling of toestand uitdrukt.';
	@override String get examples => 'schrijven|zijn|gaan';
}

// Path: morphology.types.pronominalSuffix
class _Translations$morphology$types$pronominalSuffix$nl extends Translations$morphology$types$pronominalSuffix$en {
	_Translations$morphology$types$pronominalSuffix$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Pronominaal achtervoegsel';
	@override String get description => 'Een voornaamwoord dat aan het einde van een werkwoord of zelfstandig naamwoord is gehecht (Hebreeuws).';
	@override String get examples => 'zijn hand|hun land|haar stem';
}

// Path: morphology.types.directObjectMarker
class _Translations$morphology$types$directObjectMarker$nl extends Translations$morphology$types$directObjectMarker$en {
	_Translations$morphology$types$directObjectMarker$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Markering lijdend voorwerp';
	@override String get description => 'Het Hebreeuwse אֵת dat een bepaald lijdend voorwerp markeert.';
	@override String get examples => 'אֵת (zonder Nederlands equivalent)';
}

// Path: morphology.types.punctuation
class _Translations$morphology$types$punctuation$nl extends Translations$morphology$types$punctuation$en {
	_Translations$morphology$types$punctuation$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Leesteken';
	@override String get description => 'Een leesteken.';
	@override String get examples => '.|,|;';
}

// Path: morphology.types.interjection
class _Translations$morphology$types$interjection$nl extends Translations$morphology$types$interjection$en {
	_Translations$morphology$types$interjection$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Tussenwerpsel';
	@override String get description => 'Een korte uitroep die emotie uitdrukt.';
	@override String get examples => 'o!|helaas!';
}

// Path: morphology.types.indeclinable
class _Translations$morphology$types$indeclinable$nl extends Translations$morphology$types$indeclinable$en {
	_Translations$morphology$types$indeclinable$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Onverbuigbaar';
	@override String get description => 'Een woord waarvan de vorm niet verandert door verbuiging.';
	@override String get examples => 'Hosanna|Halleluja';
}

// Path: morphology.types.hebraism
class _Translations$morphology$types$hebraism$nl extends Translations$morphology$types$hebraism$en {
	_Translations$morphology$types$hebraism$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Hebreeuws leenwoord';
	@override String get description => 'Een Hebreeuws of Aramees leenwoord dat in het Grieks is overgenomen.';
	@override String get examples => 'Amen|Hosanna|Sabaoth';
}

// Path: morphology.types.unknown
class _Translations$morphology$types$unknown$nl extends Translations$morphology$types$unknown$en {
	_Translations$morphology$types$unknown$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Onbekend';
	@override String get description => 'Een morfologiecode die de parser niet herkende.';
	@override String get examples => '';
}

// Path: morphology.person.first
class _Translations$morphology$person$first$nl extends Translations$morphology$person$first$en {
	_Translations$morphology$person$first$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => '1e persoon';
	@override String get description => 'De spreker, "ik" of "wij".';
	@override String get examples => 'ik ben|wij lopen|ik heb gesproken';
}

// Path: morphology.person.second
class _Translations$morphology$person$second$nl extends Translations$morphology$person$second$en {
	_Translations$morphology$person$second$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => '2e persoon';
	@override String get description => 'De aangesprokene, "jij" of "jullie".';
	@override String get examples => 'jij gaat|jullie luisteren|jij hebt gezien';
}

// Path: morphology.person.third
class _Translations$morphology$person$third$nl extends Translations$morphology$person$third$en {
	_Translations$morphology$person$third$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => '3e persoon';
	@override String get description => 'De persoon over wie wordt gesproken.';
	@override String get examples => 'hij rent|zij spreekt|zij verzamelden zich';
}

// Path: morphology.gender.masculine
class _Translations$morphology$gender$masculine$nl extends Translations$morphology$gender$masculine$en {
	_Translations$morphology$gender$masculine$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Mannelijk';
	@override String get description => 'Mannelijk grammaticaal geslacht, gebruikt voor mannelijke personen en volgens afspraak voor veel zelfstandige naamwoorden.';
	@override String get examples => 'vader|zoon|koning';
}

// Path: morphology.gender.feminine
class _Translations$morphology$gender$feminine$nl extends Translations$morphology$gender$feminine$en {
	_Translations$morphology$gender$feminine$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Vrouwelijk';
	@override String get description => 'Vrouwelijk grammaticaal geslacht, gebruikt voor vrouwelijke personen en volgens afspraak voor veel zelfstandige naamwoorden.';
	@override String get examples => 'moeder|dochter|koningin';
}

// Path: morphology.gender.neuter
class _Translations$morphology$gender$neuter$nl extends Translations$morphology$gender$neuter$en {
	_Translations$morphology$gender$neuter$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Onzijdig';
	@override String get description => 'Grieks onzijdig geslacht, noch mannelijk noch vrouwelijk.';
	@override String get examples => 'kind (τέκνον)|geschenk (δῶρον)';
}

// Path: morphology.gender.common
class _Translations$morphology$gender$common$nl extends Translations$morphology$gender$common$en {
	_Translations$morphology$gender$common$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Gemeenschappelijk';
	@override String get description => 'Hebreeuws gemeenschappelijk geslacht, waarbij de vorm zowel mannelijk als vrouwelijk kan zijn.';
	@override String get examples => 'vee|stem';
}

// Path: morphology.number.singular
class _Translations$morphology$number$singular$nl extends Translations$morphology$number$singular$en {
	_Translations$morphology$number$singular$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Enkelvoud';
	@override String get description => 'Verwijst naar één.';
	@override String get examples => 'het boek|een man|één steen';
}

// Path: morphology.number.plural
class _Translations$morphology$number$plural$nl extends Translations$morphology$number$plural$en {
	_Translations$morphology$number$plural$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Meervoud';
	@override String get description => 'Verwijst naar twee of meer.';
	@override String get examples => 'de boeken|mannen|stenen';
}

// Path: morphology.number.dual
class _Translations$morphology$number$dual$nl extends Translations$morphology$number$dual$en {
	_Translations$morphology$number$dual$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Dualis';
	@override String get description => 'Verwijst naar een natuurlijk paar (alleen Hebreeuws).';
	@override String get examples => 'handen|ogen|twee dagen';
}

// Path: morphology.kCase.nominative
class _Translations$morphology$kCase$nominative$nl extends Translations$morphology$kCase$nominative$en {
	_Translations$morphology$kCase$nominative$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nominatief';
	@override String get description => 'Markeert het onderwerp van een zin.';
	@override String get examples => 'God schiep|de koning ziet';
}

// Path: morphology.kCase.genitive
class _Translations$morphology$kCase$genitive$nl extends Translations$morphology$kCase$genitive$en {
	_Translations$morphology$kCase$genitive$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Genitief';
	@override String get description => 'Geeft bezit of herkomst aan, vaak vertaald met "van".';
	@override String get examples => 'de Zoon van God|koninkrijk der hemelen';
}

// Path: morphology.kCase.dative
class _Translations$morphology$kCase$dative$nl extends Translations$morphology$kCase$dative$en {
	_Translations$morphology$kCase$dative$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Datief';
	@override String get description => 'Markeert het meewerkend voorwerp, vaak met "aan" of "voor".';
	@override String get examples => 'gaf aan hem|sprak tot hen';
}

// Path: morphology.kCase.accusative
class _Translations$morphology$kCase$accusative$nl extends Translations$morphology$kCase$accusative$en {
	_Translations$morphology$kCase$accusative$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Accusatief';
	@override String get description => 'Markeert het lijdend voorwerp.';
	@override String get examples => 'zag hem|heb je naaste lief';
}

// Path: morphology.kCase.vocative
class _Translations$morphology$kCase$vocative$nl extends Translations$morphology$kCase$vocative$en {
	_Translations$morphology$kCase$vocative$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Vocatief';
	@override String get description => 'Wordt gebruikt bij een directe aanspreking.';
	@override String get examples => 'Heer!|Vader!|Vriend!';
}

// Path: morphology.state.absolute
class _Translations$morphology$state$absolute$nl extends Translations$morphology$state$absolute$en {
	_Translations$morphology$state$absolute$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Absoluut';
	@override String get description => 'De standaard, zelfstandige vorm van een zelfstandig naamwoord.';
	@override String get examples => 'een koning|een woord';
}

// Path: morphology.state.construct
class _Translations$morphology$state$construct$nl extends Translations$morphology$state$construct$en {
	_Translations$morphology$state$construct$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Constructus';
	@override String get description => 'Verbonden met een volgend zelfstandig naamwoord en drukt "X van Y" uit.';
	@override String get examples => 'koning van Israël|woord van de HEER';
}

// Path: morphology.state.determined
class _Translations$morphology$state$determined$nl extends Translations$morphology$state$determined$en {
	_Translations$morphology$state$determined$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Bepaald';
	@override String get description => 'Als bepaald gemarkeerd, vaak door het lidwoord.';
	@override String get examples => 'de koning|het woord';
}

// Path: morphology.stem.qal
class _Translations$morphology$stem$qal$nl extends Translations$morphology$stem$qal$en {
	_Translations$morphology$stem$qal$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Qal';
	@override String get description => 'De eenvoudige actieve stam, de basishandeling van het werkwoord.';
	@override String get examples => 'hij schreef|zij hoorde';
}

// Path: morphology.stem.qalPassive
class _Translations$morphology$stem$qalPassive$nl extends Translations$morphology$stem$qalPassive$en {
	_Translations$morphology$stem$qalPassive$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Qal passief';
	@override String get description => 'Een zeldzame passieve vorm van de eenvoudige stam.';
	@override String get examples => 'het werd genomen';
}

// Path: morphology.stem.niphal
class _Translations$morphology$stem$niphal$nl extends Translations$morphology$stem$niphal$en {
	_Translations$morphology$stem$niphal$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Niphal';
	@override String get description => 'De eenvoudige passieve of wederkerende stam.';
	@override String get examples => 'hij werd gedood|zij verzamelden zich';
}

// Path: morphology.stem.piel
class _Translations$morphology$stem$piel$nl extends Translations$morphology$stem$piel$en {
	_Translations$morphology$stem$piel$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Piel';
	@override String get description => 'De intensieve of factitieve actieve stam.';
	@override String get examples => 'hij prees|hij zegende|hij verbrijzelde';
}

// Path: morphology.stem.pual
class _Translations$morphology$stem$pual$nl extends Translations$morphology$stem$pual$en {
	_Translations$morphology$stem$pual$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Pual';
	@override String get description => 'De passieve vorm van de piel.';
	@override String get examples => 'hij werd geprezen';
}

// Path: morphology.stem.hiphil
class _Translations$morphology$stem$hiphil$nl extends Translations$morphology$stem$hiphil$en {
	_Translations$morphology$stem$hiphil$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Hiphil';
	@override String get description => 'De causatieve actieve stam.';
	@override String get examples => 'hij liet schrijven|hij leidde naar buiten';
}

// Path: morphology.stem.hophal
class _Translations$morphology$stem$hophal$nl extends Translations$morphology$stem$hophal$en {
	_Translations$morphology$stem$hophal$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Hophal';
	@override String get description => 'De passieve vorm van de hiphil.';
	@override String get examples => 'hij werd tot schrijven gebracht';
}

// Path: morphology.stem.hithpael
class _Translations$morphology$stem$hithpael$nl extends Translations$morphology$stem$hithpael$en {
	_Translations$morphology$stem$hithpael$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Hithpael';
	@override String get description => 'De wederkerende of wederzijdse vorm van de piel.';
	@override String get examples => 'hij heiligde zichzelf|zij liepen rond';
}

// Path: morphology.stem.nithpael
class _Translations$morphology$stem$nithpael$nl extends Translations$morphology$stem$nithpael$en {
	_Translations$morphology$stem$nithpael$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nithpael';
	@override String get description => 'Een zeldzame wederkerend-passieve stam.';
	@override String get examples => 'er werd verzoening voor gedaan';
}

// Path: morphology.aspect.perfect
class _Translations$morphology$aspect$perfect$nl extends Translations$morphology$aspect$perfect$en {
	_Translations$morphology$aspect$perfect$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Perfectum';
	@override String get description => 'Voltooide handeling, doorgaans vertaald als verleden tijd.';
	@override String get examples => 'hij schreef|zij heeft gesproken';
}

// Path: morphology.aspect.imperfect
class _Translations$morphology$aspect$imperfect$nl extends Translations$morphology$aspect$imperfect$en {
	_Translations$morphology$aspect$imperfect$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Imperfectum';
	@override String get description => 'Onvoltooide of toekomstige handeling, vaak vertaald als toekomstig of gewoonlijk.';
	@override String get examples => 'hij zal schrijven|hij schrijft';
}

// Path: morphology.aspect.imperative
class _Translations$morphology$aspect$imperative$nl extends Translations$morphology$aspect$imperative$en {
	_Translations$morphology$aspect$imperative$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Imperatief';
	@override String get description => 'Een rechtstreeks bevel.';
	@override String get examples => 'Schrijf!|Luister!';
}

// Path: morphology.aspect.infinitiveConstruct
class _Translations$morphology$aspect$infinitiveConstruct$nl extends Translations$morphology$aspect$infinitiveConstruct$en {
	_Translations$morphology$aspect$infinitiveConstruct$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Infinitivus constructus';
	@override String get description => 'Een verbaal zelfstandig naamwoord in de constructusvorm, vaak gebruikt met voorzetsels.';
	@override String get examples => 'schrijven|bij het schrijven';
}

// Path: morphology.aspect.infinitiveAbsolute
class _Translations$morphology$aspect$infinitiveAbsolute$nl extends Translations$morphology$aspect$infinitiveAbsolute$en {
	_Translations$morphology$aspect$infinitiveAbsolute$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Infinitivus absolutus';
	@override String get description => 'Een zelfstandig verbaal naamwoord, vaak met nadruk.';
	@override String get examples => 'zeker sterven|grondig schrijven';
}

// Path: morphology.aspect.participle
class _Translations$morphology$aspect$participle$nl extends Translations$morphology$aspect$participle$en {
	_Translations$morphology$aspect$participle$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Participium';
	@override String get description => 'Een verbaal bijvoeglijk naamwoord dat een voortdurende handeling beschrijft.';
	@override String get examples => 'schrijvend|degene die hoort';
}

// Path: morphology.aspect.consecutiveImperfect
class _Translations$morphology$aspect$consecutiveImperfect$nl extends Translations$morphology$aspect$consecutiveImperfect$en {
	_Translations$morphology$aspect$consecutiveImperfect$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Consecutief imperfectum';
	@override String get description => 'Verhalende verleden vorm: waw + imperfectum.';
	@override String get examples => 'en hij zei|en zij gingen';
}

// Path: morphology.aspect.conjunctiveImperfect
class _Translations$morphology$aspect$conjunctiveImperfect$nl extends Translations$morphology$aspect$conjunctiveImperfect$en {
	_Translations$morphology$aspect$conjunctiveImperfect$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Conjunctief imperfectum';
	@override String get description => 'Imperfectum met conjunctieve waw, met een toekomstige of modale betekenis.';
	@override String get examples => 'en hij zal schrijven';
}

// Path: morphology.aspect.conjunctivePerfect
class _Translations$morphology$aspect$conjunctivePerfect$nl extends Translations$morphology$aspect$conjunctivePerfect$en {
	_Translations$morphology$aspect$conjunctivePerfect$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Conjunctief perfectum';
	@override String get description => 'Perfectum met conjunctieve waw, vaak toekomstig of opeenvolgend.';
	@override String get examples => 'en u zult doen|en hij zal oordelen';
}

// Path: morphology.aspect.passiveParticiple
class _Translations$morphology$aspect$passiveParticiple$nl extends Translations$morphology$aspect$passiveParticiple$en {
	_Translations$morphology$aspect$passiveParticiple$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Passief participium';
	@override String get description => 'De passieve vorm van het qal-participium.';
	@override String get examples => 'geschreven|bewaard';
}

// Path: morphology.hebrewMood.jussive
class _Translations$morphology$hebrewMood$jussive$nl extends Translations$morphology$hebrewMood$jussive$en {
	_Translations$morphology$hebrewMood$jussive$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Jussief';
	@override String get description => 'Een bevel of wens in de 3e persoon.';
	@override String get examples => 'Laat er licht zijn|Moge de HEER u zegenen';
}

// Path: morphology.hebrewMood.cohortative
class _Translations$morphology$hebrewMood$cohortative$nl extends Translations$morphology$hebrewMood$cohortative$en {
	_Translations$morphology$hebrewMood$cohortative$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Cohortatief';
	@override String get description => 'Een wilsvorm in de 1e persoon, zoals "laten wij" of "ik zal".';
	@override String get examples => 'Laten wij gaan|Ik zal prijzen';
}

// Path: morphology.hebrewMood.hSuffix
class _Translations$morphology$hebrewMood$hSuffix$nl extends Translations$morphology$hebrewMood$hSuffix$en {
	_Translations$morphology$hebrewMood$hSuffix$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'h-achtervoegsel';
	@override String get description => 'Een nadrukkelijke uitgang -ah bij het imperfectum, vaak cohortatief van aard.';
	@override String get examples => 'Ik zal zeker komen|laat mij naderen';
}

// Path: morphology.tense.present
class _Translations$morphology$tense$present$nl extends Translations$morphology$tense$present$en {
	_Translations$morphology$tense$present$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Praesens';
	@override String get description => 'Voortdurende of algemene handeling.';
	@override String get examples => 'hij heeft lief|zij lopen';
}

// Path: morphology.tense.imperfect
class _Translations$morphology$tense$imperfect$nl extends Translations$morphology$tense$imperfect$en {
	_Translations$morphology$tense$imperfect$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Imperfectum';
	@override String get description => 'Voortdurende of herhaalde handeling in het verleden.';
	@override String get examples => 'hij was aan het onderwijzen|zij kwamen gewoonlijk bijeen';
}

// Path: morphology.tense.future
class _Translations$morphology$tense$future$nl extends Translations$morphology$tense$future$en {
	_Translations$morphology$tense$future$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Futurum';
	@override String get description => 'Een handeling die zal plaatsvinden.';
	@override String get examples => 'hij zal komen|zij zullen zien';
}

// Path: morphology.tense.aorist
class _Translations$morphology$tense$aorist$nl extends Translations$morphology$tense$aorist$en {
	_Translations$morphology$tense$aorist$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Aoristus';
	@override String get description => 'Een eenvoudige handeling in het verleden, als geheel beschouwd.';
	@override String get examples => 'hij zei|zij gingen';
}

// Path: morphology.tense.perfect
class _Translations$morphology$tense$perfect$nl extends Translations$morphology$tense$perfect$en {
	_Translations$morphology$tense$perfect$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Perfectum';
	@override String get description => 'Een handeling in het verleden met een blijvend gevolg in het heden.';
	@override String get examples => 'is geschreven|is gekomen';
}

// Path: morphology.tense.pluperfect
class _Translations$morphology$tense$pluperfect$nl extends Translations$morphology$tense$pluperfect$en {
	_Translations$morphology$tense$pluperfect$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Plusquamperfectum';
	@override String get description => 'Een handeling vóór een andere gebeurtenis in het verleden.';
	@override String get examples => 'was geschreven|was vertrokken';
}

// Path: morphology.mood.indicative
class _Translations$morphology$mood$indicative$nl extends Translations$morphology$mood$indicative$en {
	_Translations$morphology$mood$indicative$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Indicatief';
	@override String get description => 'Drukt een feit uit.';
	@override String get examples => 'hij is|zij schreven';
}

// Path: morphology.mood.imperative
class _Translations$morphology$mood$imperative$nl extends Translations$morphology$mood$imperative$en {
	_Translations$morphology$mood$imperative$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Imperatief';
	@override String get description => 'Geeft een bevel.';
	@override String get examples => 'Ga!|Geloof!|Vrees niet!';
}

// Path: morphology.mood.subjunctive
class _Translations$morphology$mood$subjunctive$nl extends Translations$morphology$mood$subjunctive$en {
	_Translations$morphology$mood$subjunctive$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Conjunctief';
	@override String get description => 'Drukt mogelijkheid, doel of voorwaardelijkheid uit.';
	@override String get examples => 'opdat hij zou schrijven|als hij gaat';
}

// Path: morphology.mood.optative
class _Translations$morphology$mood$optative$nl extends Translations$morphology$mood$optative$en {
	_Translations$morphology$mood$optative$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Optatief';
	@override String get description => 'Drukt een wens of onwaarschijnlijke mogelijkheid uit.';
	@override String get examples => 'moge het zo zijn|moge u genade ontvangen';
}

// Path: morphology.mood.infinitive
class _Translations$morphology$mood$infinitive$nl extends Translations$morphology$mood$infinitive$en {
	_Translations$morphology$mood$infinitive$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Infinitief';
	@override String get description => 'Een verbaal zelfstandig naamwoord, zoals "doen".';
	@override String get examples => 'schrijven|geloven';
}

// Path: morphology.mood.participle
class _Translations$morphology$mood$participle$nl extends Translations$morphology$mood$participle$en {
	_Translations$morphology$mood$participle$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Participium';
	@override String get description => 'Een verbaal bijvoeglijk naamwoord, zoals "doende" of "gedaan hebbend".';
	@override String get examples => 'degene die schrijft|gesproken hebbend';
}

// Path: morphology.voice.active
class _Translations$morphology$voice$active$nl extends Translations$morphology$voice$active$en {
	_Translations$morphology$voice$active$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Actief';
	@override String get description => 'Het onderwerp voert de handeling uit.';
	@override String get examples => 'hij schrijft|zij onderwijzen';
}

// Path: morphology.voice.middle
class _Translations$morphology$voice$middle$nl extends Translations$morphology$voice$middle$en {
	_Translations$morphology$voice$middle$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Medium';
	@override String get description => 'Het onderwerp handelt op of voor zichzelf.';
	@override String get examples => 'hij wast zichzelf|zij verwierven het voor zichzelf';
}

// Path: morphology.voice.passive
class _Translations$morphology$voice$passive$nl extends Translations$morphology$voice$passive$en {
	_Translations$morphology$voice$passive$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Passief';
	@override String get description => 'Het onderwerp ondergaat de handeling.';
	@override String get examples => 'hij werd gezonden|zij werden onderwezen';
}

// Path: morphology.voice.middleOrPassive
class _Translations$morphology$voice$middleOrPassive$nl extends Translations$morphology$voice$middleOrPassive$en {
	_Translations$morphology$voice$middleOrPassive$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Medium/passief';
	@override String get description => 'De vorm kan zowel medium als passief zijn.';
	@override String get examples => 'werd opgewekt / wekte zichzelf op|werd verzameld / verzamelde zichzelf';
}

// Path: morphology.degree.positive
class _Translations$morphology$degree$positive$nl extends Translations$morphology$degree$positive$en {
	_Translations$morphology$degree$positive$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Stellende trap';
	@override String get description => 'De gewone vorm, niet vergrotend of overtreffend.';
	@override String get examples => 'groot|goed';
}

// Path: morphology.degree.comparative
class _Translations$morphology$degree$comparative$nl extends Translations$morphology$degree$comparative$en {
	_Translations$morphology$degree$comparative$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Vergrotende trap';
	@override String get description => 'Vergelijkt twee zaken.';
	@override String get examples => 'groter|beter dan';
}

// Path: morphology.degree.superlative
class _Translations$morphology$degree$superlative$nl extends Translations$morphology$degree$superlative$en {
	_Translations$morphology$degree$superlative$nl._(TranslationsNl root) : this._root = root, super.internal(root);

	final TranslationsNl _root; // ignore: unused_field

	// Translations
	@override String get name => 'Overtreffende trap';
	@override String get description => 'Drukt de hoogste graad uit.';
	@override String get examples => 'grootst|best';
}

/// The flat map containing all translations for locale <nl>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsNl {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'languages.english' => 'Engels',
			'languages.dutch' => 'Nederlands',
			'languages.greek' => 'Grieks',
			'languages.hebrew' => 'Hebreeuws',
			'languages.russian' => 'Russisch',
			'languages.french' => 'Frans',
			'languages.spanish' => 'Spaans',
			'highlightStyles.red' => 'Rood',
			'highlightStyles.orange' => 'Oranje',
			'highlightStyles.yellow' => 'Geel',
			'highlightStyles.green' => 'Groen',
			'highlightStyles.blue' => 'Blauw',
			'highlightStyles.violet' => 'Violet',
			'highlightStyles.underline' => 'Onderstrepen',
			'highlightStyles.important' => 'Belangrijk',
			'highlightStyles.highlight' => 'Markeren',
			'highlightStyles.squiggle' => 'Golflijn',
			'colors.red' => 'Rood',
			'colors.orange' => 'Oranje',
			'colors.yellow' => 'Geel',
			'colors.green' => 'Groen',
			'colors.blue' => 'Blauw',
			'colors.violet' => 'Violet',
			'colors.silver' => 'Zilver',
			'testaments.old' => 'Oude Testament',
			'testaments.newTestament' => 'Nieuwe Testament',
			'testaments.oldOnly' => 'Alleen Oude Testament',
			'testaments.newOnly' => 'Alleen Nieuwe Testament',
			'testaments.wholeBible' => 'Hele Bijbel',
			'testaments.oldOnlyDescription' => 'Bevat alleen boeken uit het Oude Testament.',
			'testaments.newOnlyDescription' => 'Bevat alleen boeken uit het Nieuwe Testament.',
			'testaments.wholeBibleDescription' => 'Bevat alle boeken van de Bijbel.',
			'books.genesis' => 'Genesis',
			'books.exodus' => 'Exodus',
			'books.leviticus' => 'Leviticus',
			'books.numbers' => 'Numeri',
			'books.deuteronomy' => 'Deuteronomium',
			'books.joshua' => 'Jozua',
			'books.judges' => 'Richteren',
			'books.ruth' => 'Ruth',
			'books.samuel1' => '1 Samuel',
			'books.samuel2' => '2 Samuel',
			'books.kings1' => '1 Koningen',
			'books.kings2' => '2 Koningen',
			'books.chronicles1' => '1 Kronieken',
			'books.chronicles2' => '2 Kronieken',
			'books.ezra' => 'Ezra',
			'books.nehemiah' => 'Nehemia',
			'books.esther' => 'Esther',
			'books.job' => 'Job',
			'books.psalm' => 'Psalm',
			'books.psalms' => 'Psalmen',
			'books.proverbs' => 'Spreuken',
			'books.ecclesiastes' => 'Prediker',
			'books.songOfSolomon' => 'Hooglied',
			'books.isaiah' => 'Jesaja',
			'books.jeremiah' => 'Jeremia',
			'books.lamentations' => 'Klaagliederen',
			'books.ezekiel' => 'Ezechiël',
			'books.daniel' => 'Daniël',
			'books.hosea' => 'Hosea',
			'books.joel' => 'Joël',
			'books.amos' => 'Amos',
			'books.obadiah' => 'Obadja',
			'books.jonah' => 'Jona',
			'books.micah' => 'Micha',
			'books.nahum' => 'Nahum',
			'books.habakkuk' => 'Habakuk',
			'books.zephaniah' => 'Zefanja',
			'books.haggai' => 'Haggaï',
			'books.zechariah' => 'Zacharia',
			'books.malachi' => 'Maleachi',
			'books.matthew' => 'Mattheüs',
			'books.mark' => 'Markus',
			'books.luke' => 'Lukas',
			'books.john' => 'Johannes',
			'books.acts' => 'Handelingen',
			'books.romans' => 'Romeinen',
			'books.corinthians1' => '1 Korintiërs',
			'books.corinthians2' => '2 Korintiërs',
			'books.galatians' => 'Galaten',
			'books.ephesians' => 'Efeziërs',
			'books.philippians' => 'Filippenzen',
			'books.colossians' => 'Kolossenzen',
			'books.thessalonians1' => '1 Thessalonicenzen',
			'books.thessalonians2' => '2 Thessalonicenzen',
			'books.timothy1' => '1 Timotheüs',
			'books.timothy2' => '2 Timotheüs',
			'books.titus' => 'Titus',
			'books.philemon' => 'Filemon',
			'books.hebrews' => 'Hebreeën',
			'books.james' => 'Jakobus',
			'books.peter1' => '1 Petrus',
			'books.peter2' => '2 Petrus',
			'books.john1' => '1 Johannes',
			'books.john2' => '2 Johannes',
			'books.john3' => '3 Johannes',
			'books.jude' => 'Judas',
			'books.revelation' => 'Openbaring',
			'common.add' => 'Toevoegen',
			'common.addNew' => 'Nieuwe toevoegen',
			'common.am' => 'a.m.',
			'common.cancel' => 'Annuleren',
			'common.close' => 'Sluiten',
			'common.copy' => 'Kopiëren',
			'common.continueLabel' => 'Doorgaan',
			'common.create' => 'Maken',
			'common.custom' => 'Aangepast',
			'common.defaultLabel' => 'Standaard',
			'common.delete' => 'Verwijderen',
			'common.done' => 'Gereed',
			'common.edit' => 'Bewerken',
			'common.finish' => 'Voltooien',
			'common.learnMore' => 'Meer informatie',
			'common.nevermind' => 'Laat maar',
			'common.next' => 'Volgende',
			'common.noMatches' => 'Geen overeenkomsten',
			'common.noNotification' => 'Geen melding',
			'common.ok' => 'Oké',
			'common.off' => 'Uit',
			'common.none' => 'Geen',
			'common.clear' => 'Wissen',
			'common.remove' => 'Verwijderen',
			'common.save' => 'Opslaan',
			'common.search' => 'Zoeken',
			'common.select' => 'Selecteren',
			'common.show' => 'Tonen',
			'common.hide' => 'Verbergen',
			'common.pm' => 'p.m.',
			'common.sort' => 'Sorteren',
			'common.stop' => 'Stoppen',
			'common.tryAgain' => 'Opnieuw proberen',
			'common.switchTo' => ({required Object translation}) => 'Overschakelen naar ${translation}',
			'common.notAvailableIn' => ({required Object translation}) => 'Dit is niet beschikbaar in ${translation}.',
			'regionTypes.chapter' => 'dit hoofdstuk',
			'regionTypes.verses' => 'deze verzen',
			'regionTypes.visibleVerses' => 'de zichtbare verzen',
			'regionTypes.text' => 'deze tekst',
			'mainActions.pauseAudio' => 'Bijbelaudio pauzeren',
			'mainActions.playAudio' => 'Bijbelaudio afspelen',
			'mainActions.bookmark' => 'Bladwijzer',
			'mainActions.study' => 'Studie',
			'mainActions.verseOfTheDay' => 'Vers van de dag',
			'mainActions.addStudyPanel' => 'Studiepaneel toevoegen',
			'mainActions.search' => 'Zoeken',
			'mainActions.resources' => 'Bronnen',
			'mainActions.plans' => 'Bijbelleesplannen',
			'mainActions.settings' => 'Instellingen',
			'mainActions.more' => 'Meer',
			'mainActions.audioDescription' => 'Luister naar het huidige hoofdstuk met een Bijbel met audio.',
			'mainActions.bookmarkDescription' => 'Voeg een bladwijzer aan dit hoofdstuk toe om het makkelijk terug te vinden via de zoekpagina.',
			'mainActions.manageBookmarkDescription' => 'Beheer deze bladwijzer.',
			'mainActions.studyDescription' => 'Bekijk studiehulpmiddelen voor dit hoofdstuk.',
			'mainActions.verseOfTheDayDescription' => 'Bekijk het vers van vandaag.',
			'mainActions.verseOfTheDayLoading' => 'Het vers van vandaag wordt geladen…',
			'mainActions.verseOfTheDayUnavailable' => 'Het vers van vandaag kan niet worden geladen.',
			'mainActions.studyPanelDescription' => 'Zet een paneel naast de tekst vast dat meeloopt en studiehulpmiddelen toont voor wat je leest.',
			'mainActions.searchDescription' => 'Zoek naar woorden in de Bijbel.',
			'mainActions.resourcesDescription' => 'Zoek woorden op in het woordenboek en lexicon.',
			'mainActions.plansDescription' => 'Lees de Bijbel met begeleide leesplannen.',
			'mainActions.settingsDescription' => 'Bekijk de instellingen van Lux.',
			'mainActions.moreDescription' => 'Bekijk instellingen, je inhoud en links naar de community.',
			'verseOfTheDay.reminderDiscoveryTitle' => 'Dagelijkse herinnering toevoegen?',
			'verseOfTheDay.reminderDiscoveryBody' => 'Wil je dat Lux je elke dag herinnert aan het vers van de dag?',
			'verseOfTheDay.addReminder' => 'Herinnering toevoegen',
			'verseOfTheDay.noReminder' => 'Nee',
			'verseOfTheDay.dailyReminders' => 'Dagelijkse herinnering',
			'verseOfTheDay.deleteReminder' => 'Herinnering verwijderen?',
			'verseOfTheDay.deleteReminderConfirmation' => 'Weet je zeker dat je je dagelijkse herinnering voor het vers van de dag wilt verwijderen?',
			'verseOfTheDay.reminderNotificationChannelName' => 'Herinneringen voor vers van de dag',
			'verseOfTheDay.reminderNotificationChannelDescription' => 'Dagelijkse herinneringen voor het vers van de dag',
			'verseOfTheDay.reminderNotificationTitle' => 'Vers van de dag',
			'verseOfTheDay.reminderPermissionDeniedTitle' => 'Meldingen zijn uitgeschakeld',
			'verseOfTheDay.reminderPermissionDeniedBody' => 'Sta Lux toe om meldingen te sturen in Instellingen om deze herinnering op te slaan.',
			'verseOfTheDay.openNotificationSettings' => 'Instellingen openen',
			'verseOfTheDay.reminderSchedulingFailedTitle' => 'Herinnering kon niet worden ingesteld',
			'verseOfTheDay.reminderSchedulingFailedBody' => 'Lux kon deze herinnering niet instellen. Probeer het opnieuw.',
			'verseOfTheDay.reminderSaved' => ({required Object time}) => 'Herinnering voor het vers van de dag opgeslagen voor dagelijks om ${time}.',
			'studyActions.quickStudy' => 'Snelle studie',
			'studyActions.compare' => 'Vergelijken',
			'studyActions.interlinear' => 'Interlineair',
			'studyActions.commentary' => 'Commentaar',
			'studyActions.crossReferences' => 'Kruisverwijzingen',
			'studyActions.compareDescription' => ({required Object region}) => 'Vergelijk ${region} in verschillende vertalingen.',
			'studyActions.interlinearDescription' => ({required Object region}) => 'Bekijk een lexicale analyse van ${region} met Strong-coderingen.',
			'studyActions.commentaryDescription' => ({required Object region}) => 'Bekijk commentaren op ${region}.',
			'studyActions.crossReferencesDescription' => ({required Object region}) => 'Bekijk kruisverwijzingen voor ${region}.',
			'studyActions.noCrossReferences' => 'Geen kruisverwijzingen gevonden',
			'studyActions.crossReferencesUse' => ({required Object translation}) => 'Kruisverwijzingen gebruiken ${translation}',
			'studyActions.onlineCrossReferencesExplanation' => 'Omdat de geselecteerde vertaling alleen online beschikbaar is, worden kruisverwijzingen getoond met de meest recent gebruikte studiebijbel om prestaties en kosten te besparen. Overal elders in de app wordt de geselecteerde vertaling gebruikt.',
			'selectionActions.annotate' => 'Annoteren',
			'selectionActions.study' => 'Studie',
			'selectionActions.copy' => 'Kopiëren',
			'selectionActions.highlight' => 'Markeren',
			'selectionActions.removeAnnotations' => 'Annotaties verwijderen',
			'selectionActions.interlinear' => 'Interlineair',
			'selectionActions.search' => 'Zoeken',
			'selectionActions.annotateVersesDescription' => 'Annoteer deze verzen.',
			'selectionActions.studyVersesDescription' => 'Bestudeer deze verzen.',
			'selectionActions.copyVersesDescription' => 'Kopieer deze verzen naar het klembord.',
			'selectionActions.annotateTextDescription' => 'Annoteer deze tekst.',
			'selectionActions.interlinearTextDescription' => 'Bekijk een lexicale analyse van deze tekst.',
			'selectionActions.searchTextDescription' => 'Zoek in de Bijbel naar deze tekst.',
			'selectionActions.copyTextDescription' => 'Kopieer deze tekst naar het klembord.',
			'selectionActions.removeTextAnnotationsDescription' => ({required Object region}) => 'Verwijder tekstselectie-annotaties uit ${region}.',
			'selectionActions.highlightTextDescription' => ({required Object region}) => 'Markeer ${region} met de laatst gebruikte kleur.',
			'selectionActions.removeVerseAnnotationsDescription' => ({required Object region}) => 'Verwijder versselectie-annotaties uit ${region}.',
			'selectionActions.highlightVersesDescription' => ({required Object region}) => 'Markeer ${region} met de laatst gebruikte kleur.',
			'selectionActions.highlightedText' => ({required Object reference}) => 'Tekst in ${reference} gemarkeerd.',
			'selectionActions.highlightedVerses' => ({required Object reference}) => '${reference} gemarkeerd.',
			'selectionActions.copiedVerses' => ({required Object reference}) => '${reference} naar het klembord gekopieerd.',
			'selectionActions.copiedText' => 'Tekstselectie naar het klembord gekopieerd.',
			'selectionActions.interlinearUnavailable' => 'Interlineair zoeken via een tekstselectie is alleen beschikbaar in studiebijbels. Deze zijn woord voor woord voorzien van Strong-coderingen en morfologische informatie. Schakel over naar een studiebijbel om deze actie te gebruiken.',
			'selectionActions.noInterlinearWords' => 'Geen interlineaire woorden gevonden in deze selectie.',
			'selectionActions.textInReference' => ({required Object reference}) => 'Tekst in ${reference}',
			'studyPanels.title' => 'Studiepaneel',
			'studyPanels.pinAsStudyPanel' => 'Vastzetten als studiepaneel',
			'studyPanels.compareWith' => ({required Object translation}) => 'Vergelijken met ${translation}',
			'studyPanels.directionInterlinear' => ({required Object direction}) => '${direction} interlineair',
			'studyPanels.commentaryName' => ({required Object commentary}) => 'Commentaar van ${commentary}',
			'studyPanels.notes' => 'Notities',
			'studyPanels.noNotes' => 'Geen notities gevonden',
			'studyPanels.notesDescription' => 'Bekijk je notities bij de zichtbare verzen.',
			'bookmarks.create' => 'Bladwijzer maken',
			'bookmarks.manage' => 'Bladwijzer beheren',
			'bookmarks.stopFollowing' => 'Niet meer volgen',
			'bookmarks.stopFollowingDescription' => 'Laat deze bladwijzer je huidige positie niet meer volgen.',
			'bookmarks.edit' => 'Bladwijzer bewerken',
			'bookmarks.delete' => 'Bladwijzer verwijderen',
			'bookmarks.deleteConfirmation' => 'Weet je zeker dat je deze bladwijzer wilt verwijderen?',
			'bookmarks.deleteNamedConfirmation' => ({required Object name}) => 'Weet je zeker dat je "${name}" wilt verwijderen?',
			'bookmarkPage.title' => 'Je bladwijzers',
			'commentaries.addRemove' => 'Commentaren toevoegen en verwijderen',
			'toolbarShortcuts.switchBible' => 'Van Bijbel wisselen',
			'toolbarShortcuts.dictionary' => 'Woordenboek',
			'toolbarShortcuts.lexicon' => 'Lexicon',
			'toolbarShortcuts.themeAndLayout' => 'Thema en indeling',
			'toolbarShortcuts.switchBibleDescription' => 'Wissel van Bijbelvertaling.',
			'toolbarShortcuts.dictionaryDescription' => 'Zoek personen, plaatsen en onderwerpen op in Easton\'s Bible Dictionary.',
			'toolbarShortcuts.lexiconDescription' => 'Bestudeer de oorspronkelijke Hebreeuwse en Griekse woorden met Strong\'s Lexicon.',
			'toolbarShortcuts.themeAndLayoutDescription' => 'Pas het thema en de indeling van de Bijbel aan.',
			'labels.about' => 'Over',
			'labels.annotation' => 'Annotatie',
			'labels.annotations' => 'Annotaties',
			'labels.audioBible' => 'Bijbelaudio',
			'labels.bible' => 'Bijbel',
			'labels.bibles' => 'Bijbels',
			'labels.biblePlans' => 'Bijbelleesplannen',
			'labels.bookmarks' => 'Bladwijzers',
			'labels.books' => 'Boeken',
			'labels.color' => 'Kleur',
			'labels.commentaries' => 'Commentaren',
			'labels.commentary' => 'Commentaar',
			'labels.community' => 'Community',
			'labels.completed' => 'Voltooid',
			'labels.crossReferences' => 'Kruisverwijzingen',
			'labels.days' => 'Dagen',
			'labels.dictionary' => 'Woordenboek',
			'labels.discord' => 'Discord',
			'labels.duration' => 'Duur',
			'labels.following' => 'Gevolgd',
			'labels.footnotes' => 'Voetnoten',
			'labels.help' => 'Help',
			'labels.highlightStyles' => 'Markeerstijlen',
			'labels.instagram' => 'Instagram',
			'labels.interlinear' => 'Interlineair',
			'labels.language' => 'Taal',
			'labels.layout' => 'Indeling',
			'labels.lexicon' => 'Lexicon',
			'labels.licenses' => 'Licenties',
			'labels.locations' => 'Locaties',
			'labels.name' => 'Naam',
			'labels.note' => 'Notitie',
			'labels.notebook' => 'Notitieboek',
			'labels.notebooks' => 'Notitieboeken',
			'labels.notes' => 'Notities',
			'labels.paragraphs' => 'Alinea\'s',
			'labels.resources' => 'Bronnen',
			'labels.scope' => 'Bereik',
			'labels.search' => 'Zoeken',
			'labels.selection' => 'Selectie',
			'labels.settings' => 'Instellingen',
			'labels.source' => 'Bron',
			'labels.study' => 'Studie',
			'labels.style' => 'Stijl',
			'labels.text' => 'Tekst',
			'labels.toolbar' => 'Werkbalk',
			'labels.toolbars' => 'Werkbalken',
			'labels.type' => 'Type',
			'labels.version' => 'Versie',
			'labels.visibility' => 'Zichtbaarheid',
			'strongSheet.interlinearWord' => 'Interlineair woord',
			'strongSheet.lexicon' => 'Lexicon',
			'strongSheet.legend' => 'Legenda',
			'strongSheet.openInSearch' => 'Openen in zoeken',
			'strongSheet.usage' => 'Gebruik',
			'strongSheet.inflected' => 'Verbuiging',
			'strongSheet.transliteration' => 'Transliteratie',
			'strongSheet.root' => 'Stam',
			'strongSheet.strongsId' => ({required Object id}) => 'Strong\'s ${id}',
			'strongSheet.rootWord' => 'Stamwoord',
			'strongSheet.pronunciation' => 'Uitspraak',
			'strongSheet.strongsDefinition' => 'Strong\'s-definitie',
			'strongSheet.biblicalUsage' => 'Bijbels gebruik',
			'strongSheet.definition' => 'Definitie',
			'strongSheet.examples' => 'Voorbeelden',
			'strongSheet.examplesPrefix' => 'Voorbeelden: ',
			'strongSheet.partOfSpeech' => 'Woordsoort',
			'strongSheet.derivation' => 'Herkomst',
			'strongSheet.morphology' => 'Morfologie',
			'strongSheet.relatedTerms' => 'Verwante termen',
			'strongSheet.morphologyInfo' => 'Morfologische informatie',
			'strongSheet.definitionLegend' => 'Legenda bij Strong\'s-definitie',
			'strongSheet.optionalWord' => 'Optioneel woord',
			'strongSheet.optionalWordDescription' => 'Geeft een woord of lettergreep aan die bij het hoofdwoord kan worden aangevuld.',
			'strongSheet.addedWord' => 'Toegevoegd woord in het Hebreeuws of Grieks',
			'strongSheet.addedWordDescription' => 'Geeft een woord aan dat in de Engelse vertaling is toegevoegd, maar niet in het Hebreeuws of Grieks staat.',
			'strongSheet.explanation' => 'Uitleg',
			'strongSheet.renderingExplanation' => 'Cursieve tekst aan het einde van een weergave licht een afwijking van de gebruikelijke vorm toe.',
			'strongSheet.concordance' => 'Concordantie',
			'bibleDetails.onlineOnly' => 'Alleen online',
			'bibleDetails.onlineDescription' => ({required Object source}) => 'Deze Bijbel wordt gestreamd via ${source} en vereist daarom een internetverbinding.',
			'bibleDetails.studyBible' => 'Studiebijbel',
			'bibleDetails.audioBible' => 'Bijbelaudio',
			'bibleDetails.onDevice' => 'Op apparaat',
			'bibleDetails.onDeviceDescription' => 'Deze Bijbel staat op je apparaat, zodat je hem offline kunt lezen en doorzoeken.',
			'bibleDetails.studyBibleDescription' => 'Bevat interlineaire en morfologische gegevens. Houd tijdens het lezen een woord ingedrukt om het oorspronkelijke Griekse of Hebreeuwse woord te zien.',
			'bibleDetails.readingBible' => 'Leesbijbel',
			'bibleDetails.readingBibleDescription' => 'Bevat geen interlineaire of morfologische gegevens.',
			'bibleDetails.nativeHeadings' => 'Eigen tussenkoppen',
			'bibleDetails.nativeHeadingsDescription' => 'Deze Bijbel bevat eigen tussenkoppen.',
			'bibleDetails.syntheticHeadings' => 'Toegevoegde tussenkoppen',
			'bibleDetails.syntheticHeadingsDescription' => 'Tussenkoppen uit de BSB zijn aan deze Bijbel toegevoegd.',
			'bibleDetails.noHeadings' => 'Geen tussenkoppen',
			'bibleDetails.noHeadingsDescription' => 'Deze Bijbel bevat geen tussenkoppen.',
			'bibleDetails.audioSupportDescription' => 'Of deze Bijbel bijbelaudio bevat',
			'bibleDetails.redLetters' => 'Rode letters',
			'bibleDetails.redLettersDescription' => 'Of deze Bijbel rode letters ondersteunt.',
			'bibleDetails.footnotesDescription' => 'Of deze Bijbel voetnoten bevat.',
			'bibleDetails.paragraphsDescription' => 'Of deze Bijbel alinea\'s bevat.',
			'bibleDetails.addRemoveBibles' => 'Bijbels toevoegen en verwijderen',
			'bibleDetails.verseNumbering' => 'Versnummering',
			'emptyStates.noCommentaries' => 'Geen commentaren gevonden',
			'emptyStates.noMatchingWords' => 'Geen overeenkomende woorden',
			'emptyStates.noMatchingTerms' => 'Geen overeenkomende termen',
			'emptyStates.noMatchingPlans' => 'Geen overeenkomende Bijbelleesplannen.',
			'emptyStates.noMatchingAnnotations' => 'Geen overeenkomende annotaties.',
			'emptyStates.noSearchResults' => 'Geen zoekresultaten gevonden',
			'emptyStates.tryAnotherSearch' => 'Probeer een andere zoekopdracht',
			'emptyStates.noCommentariesAdded' => 'Je hebt nog geen commentaren toegevoegd.',
			'emptyStates.noAnnotations' => 'Je hebt nog geen annotaties gemaakt.',
			'emptyStates.noBookmarks' => 'Je hebt nog geen bladwijzers gemaakt.',
			'emptyStates.noNotebooks' => 'Je hebt nog geen notitieboeken gemaakt. Met notitieboeken kun je je annotaties ordenen.',
			'emptyStates.noPlans' => 'Je volgt nog geen leesplannen. Zoek er een om met het lezen van de Bijbel te beginnen.',
			'annotationUi.yourAnnotations' => 'Je annotaties',
			'annotationUi.annotate' => 'Annoteren',
			'annotationUi.withNotes' => 'Met notities',
			'annotationUi.withoutNotes' => 'Zonder notities',
			'annotationUi.mostRecent' => 'Meest recent',
			'annotationUi.location' => 'Locatie',
			'annotationUi.deleteAnnotation' => 'Annotatie verwijderen',
			'annotationUi.deleteConfirmation' => 'Weet je zeker dat je deze annotatie wilt verwijderen?',
			'annotationUi.annotationCount' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('nl'))(count, one: '${count} annotatie', other: '${count} annotaties', ), 
			'annotationUi.annotatedTime' => ({required Object time}) => '${time} geannoteerd',
			'notebookUi.yourNotebooks' => 'Je notitieboeken',
			'notebookUi.hidden' => 'Verborgen',
			'notebookUi.hideDescription' => 'Verberg de annotaties uit dit notitieboek in de Bijbel.',
			'notebookUi.showDescription' => 'Toon de annotaties uit dit notitieboek in de Bijbel.',
			'notebookUi.defaultDescription' => 'Het vaste notitieboek voor annotaties die nergens aan zijn toegewezen.',
			'notebookUi.create' => 'Notitieboek maken',
			'notebookUi.edit' => 'Notitieboek bewerken',
			'notebookUi.delete' => 'Notitieboek verwijderen',
			'notebookUi.deleteNamedConfirmation' => ({required Object name}) => 'Weet je zeker dat je "${name}" wilt verwijderen?',
			'notebookUi.deleteWithAnnotations' => ({required Object name, required Object annotations}) => '"${name}" heeft ${annotations}. Wil je ze ook verwijderen of in het standaardnotitieboek bewaren?',
			'notebookUi.keepInDefault' => 'In Standaard bewaren',
			'notebookUi.deleteAnnotations' => 'Annotaties verwijderen',
			'highlightStyleUi.yourStyles' => 'Je markeerstijlen',
			'highlightStyleUi.create' => 'Stijl maken',
			'highlightStyleUi.edit' => 'Stijl bewerken',
			'highlightStyleUi.duplicate' => 'Je hebt deze stijl al',
			'highlightStyleUi.delete' => 'Stijl verwijderen',
			'highlightStyleUi.deleteNamedConfirmation' => ({required Object name}) => 'Weet je zeker dat je "${name}" wilt verwijderen?',
			'highlightStyleUi.deleteWithAnnotations' => ({required Object name, required Object annotations}) => '"${name}" heeft ${annotations}. Wil je ze ook verwijderen of bewaren?',
			'highlightStyleUi.keepAnnotations' => 'Annotaties bewaren',
			'highlightStyleUi.deleteAnnotations' => 'Annotaties verwijderen',
			'highlightStyleUi.updateAnnotations' => 'Annotaties bijwerken',
			'highlightStyleUi.updateWithAnnotations' => ({required Object name, required Object annotations}) => '"${name}" heeft ${annotations}. Wil je ze bijwerken met de nieuwe stijl of ongewijzigd laten?',
			'highlightStyleUi.leaveAsIs' => 'Ongewijzigd laten',
			'highlightStyleUi.label' => 'Label',
			'toolbarSettings.mainToolbar' => 'Hoofdwerkbalk',
			'toolbarSettings.verseSelection' => 'Versselectie',
			'toolbarSettings.textSelection' => 'Tekstselectie',
			'toolbarSettings.shownForMain' => 'Wordt getoond wanneer niets is geselecteerd.',
			'toolbarSettings.shownForVerses' => 'Wordt getoond wanneer een vers is geselecteerd.',
			'toolbarSettings.shownForText' => 'Wordt getoond wanneer je tekst in verzen ingedrukt houdt.',
			'toolbarSettings.gestures' => 'Gebaren',
			'toolbarSettings.longPress' => 'Ingedrukt houden',
			'toolbarSettings.mainLongPressDescription' => 'Snelkoppeling wanneer de werkbalk wordt ingedrukt.',
			'toolbarSettings.verseLongPressDescription' => 'Snelkoppeling wanneer een versselectie wordt ingedrukt.',
			'toolbarSettings.textLongPressDescription' => 'Snelkoppeling wanneer een tekstselectie wordt ingedrukt.',
			'toolbarSettings.hideToolbar' => 'Verbergen',
			'toolbarSettings.hideToolbarDescription' => 'Verberg de werkbalk tijdens het omlaag scrollen voor een ongestoorde Bijbelweergave.',
			'toolbarSettings.pinToolbar' => 'Vastzetten',
			'toolbarSettings.pinToolbarDescription' => 'Zet de werkbalk onderaan de pagina vast.',
			'toolbarSettings.expandToAnnotation' => 'Uitbreiden tot annotatie',
			'toolbarSettings.expandTextDescription' => 'Als je een geannoteerd woord ingedrukt houdt, wordt het hele gemarkeerde bereik geselecteerd.',
			'toolbarSettings.expandVerseDescription' => 'Als je op een vers tikt, wordt de volledige geannoteerde versselectie geselecteerd.',
			'toolbarSettings.rangeSelection' => 'Bereikselectie',
			'toolbarSettings.rangeSelectionDescription' => 'Als je op een tweede vers tikt, worden alle verzen tussen het eerste en tweede vers geselecteerd.',
			'toolbarSettings.mainShortcut' => 'Snelkoppeling hoofdwerkbalk',
			'toolbarSettings.verseShortcut' => 'Snelkoppeling versselectie',
			'toolbarSettings.textShortcut' => 'Snelkoppeling tekstselectie',
			'themeSettings.title' => 'Thema en indeling',
			'themeSettings.brightness' => 'Helderheid',
			'themeSettings.font' => 'Lettertype',
			'themeSettings.fontSizeSpacing' => 'Lettergrootte en afstand',
			'themeSettings.greekFontSizeSpacing' => 'Griekse lettergrootte en afstand',
			'themeSettings.hebrewFontSizeSpacing' => 'Hebreeuwse lettergrootte en afstand',
			'themeSettings.system' => 'Systeem',
			'themeSettings.systemTextSizeDescription' => 'Gebruik de gewenste tekstgrootte van je apparaat.',
			'themeSettings.defaultSizeDescription' => 'Gebruik de standaard lettergrootte en afstand.',
			'themeSettings.redLetters' => 'Rode letters',
			'themeSettings.redLettersDescription' => 'Toon de woorden van Jezus in rood.',
			'themeSettings.sectionHeadings' => 'Tussenkoppen',
			'themeSettings.verseNumbers' => 'Versnummers',
			'themeSettings.paragraphsDescription' => 'Geef verzen als alinea\'s weer.',
			'themeSettings.footnotesDescription' => 'Toon voetnootmarkeringen in de tekst.',
			'biblePlans.find' => 'Een Bijbelleesplan zoeken',
			'biblePlans.startPlanQuestion' => 'Leesplan starten?',
			'biblePlans.reviewAndReflect' => 'Terugkijken en overdenken',
			'biblePlans.startPlan' => 'Leesplan starten',
			'biblePlans.dailyReminders' => 'Dagelijkse herinneringen',
			'biblePlans.dailyRemindersDescription' => 'Stel in of wijzig hoe laat dit leesplan je dagelijks aan het lezen herinnert.',
			'biblePlans.dailyAt' => ({required Object time}) => 'Dagelijks om ${time}',
			'biblePlans.reminderDiscoveryTitle' => 'Dagelijkse herinnering toevoegen?',
			'biblePlans.reminderDiscoveryBody' => ({required Object name}) => 'Wil je dat Lux je er elke dag aan herinnert om verder te gaan met "${name}"?',
			'biblePlans.addReminder' => 'Herinnering toevoegen',
			'biblePlans.noReminder' => 'Nee',
			'biblePlans.deleteReminder' => 'Herinnering verwijderen?',
			'biblePlans.deleteReminderConfirmation' => ({required Object name}) => 'Weet je zeker dat je de dagelijkse herinnering voor "${name}" wilt verwijderen?',
			'biblePlans.reminderNotificationChannelName' => 'Herinneringen voor Bijbelleesplannen',
			'biblePlans.reminderNotificationChannelDescription' => 'Dagelijkse herinneringen voor je Bijbelleesplannen',
			'biblePlans.reminderNotificationTitle' => ({required Object name}) => 'Lees "${name}"',
			'biblePlans.reminderNotificationBody' => ({required Object reading}) => 'De lezing van vandaag is ${reading}',
			'biblePlans.reminderPermissionDeniedTitle' => 'Meldingen zijn uitgeschakeld',
			'biblePlans.reminderPermissionDeniedBody' => 'Sta Lux toe om meldingen te sturen in Instellingen om deze herinnering op te slaan.',
			'biblePlans.openNotificationSettings' => 'Instellingen openen',
			'biblePlans.reminderSchedulingFailedTitle' => 'Herinnering kon niet worden ingesteld',
			'biblePlans.reminderSchedulingFailedBody' => 'Lux kon deze herinnering niet instellen. Probeer het opnieuw.',
			'biblePlans.reminderSaved' => ({required Object name, required Object time}) => 'Herinnering voor "${name}" opgeslagen voor dagelijks om ${time}.',
			'biblePlans.stopPlan' => 'Leesplan stoppen',
			'biblePlans.stopPlanDescription' => 'Verwijder dit leesplan en de voortgang.',
			'biblePlans.readEntireChapter' => 'Hele hoofdstuk lezen',
			'biblePlans.readInContext' => 'In context lezen',
			'biblePlans.startNew' => 'Nieuw starten',
			'biblePlans.day' => ({required Object day}) => 'Dag ${day}',
			'biblePlans.dayCount' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('nl'))(count, one: '${count} dag', other: '${count} dagen', ), 
			'biblePlans.stopConfirmation' => ({required Object name}) => 'Weet je zeker dat je "${name}" wilt stoppen? Je voortgang gaat verloren.',
			'biblePlans.completed' => ({required Object name}) => '"${name}" voltooid.',
			'biblePlans.addPlan' => 'Bijbelleesplan toevoegen',
			'searchUi.searchBible' => 'Bijbel doorzoeken',
			'searchUi.startSearch' => 'Begin met zoeken',
			'searchUi.searchPrompt' => 'Voer een zoekwoord in, zoals licht, woord of wijsheid, en druk op Enter.',
			'searchUi.usingTranslation' => ({required Object translation}) => '${translation} wordt gebruikt om te zoeken',
			'searchUi.unsupportedTranslation' => ({required Object translation}) => '${translation} ondersteunt zoeken momenteel niet. In plaats daarvan wordt je meest recent gebruikte studiebijbel gebruikt.',
			'searchUi.strongSearchStudyBibleExplanation' => 'Voor zoekopdrachten op Strong-nummers zijn de woord-voor-woord Strong-coderingen uit studiebijbels nodig. In plaats daarvan wordt je meest recent gebruikte studiebijbel gebruikt.',
			'searchUi.wordOrPhraseHint' => 'Zoek naar een woord of zin',
			'searchUi.wordHint' => 'Zoek naar een woord',
			'searchUi.strongNumberHint' => 'Zoek naar een Strong-nummer (bijv. H125)',
			'searchUi.wordMatching.title' => 'Woordovereenkomst',
			'searchUi.wordMatching.wholeWord.title' => 'Volledig woord',
			'searchUi.wordMatching.wholeWord.description' => 'Zoek alleen volledige woorden die overeenkomen met je zoekopdracht.',
			'searchUi.wordMatching.wholeWord.example' => 'Voorbeeld: ‘licht’ vindt ‘licht’',
			'searchUi.wordMatching.startOfWord.title' => 'Begin van woord',
			'searchUi.wordMatching.startOfWord.description' => 'Zoek woorden die beginnen met je zoekopdracht.',
			'searchUi.wordMatching.startOfWord.example' => 'Voorbeeld: ‘licht’ vindt ook ‘lichten’',
			'searchUi.wordMatching.partOfWord.title' => 'Deel van woord',
			'searchUi.wordMatching.partOfWord.description' => 'Zoek woorden die je zoekopdracht ergens bevatten.',
			'searchUi.wordMatching.partOfWord.example' => 'Voorbeeld: ‘licht’ vindt ook ‘verlichting’',
			'onboarding.skipQuestion' => 'Introductie overslaan?',
			'onboarding.skipConfirmation' => 'Weet je zeker dat je de introductie wilt overslaan? Je kunt deze opnieuw starten via Instellingen > Help.',
			'onboarding.getStarted' => 'Aan de slag',
			'onboarding.learnLux' => 'Leer Lux gebruiken',
			'onboarding.checklistDescription' => 'Voltooi de onderstaande lijst om Lux te leren gebruiken.',
			'onboarding.skipHint' => 'Weinig tijd? Tik op ✕ om over te slaan.',
			'analyticsNotice.title' => 'Een opmerking over anonieme statistieken',
			'analyticsNotice.description' => 'Lux gebruikt nu anonieme gebruiksstatistieken en crashrapporten om te begrijpen welke functies worden gebruikt en de betrouwbaarheid te verbeteren. Deze rapporten bevatten nooit je notities, namen of leesdetails van Bijbelplannen, zoektermen of andere privé-inhoud en zijn niet gekoppeld aan een account. Door Lux te blijven gebruiken, ga je ermee akkoord dat deze informatie wordt verzonden.',
			'tutorials.dontShowAgain' => 'Niet meer tonen',
			'audio.timer' => 'Audiotimer',
			'audio.fiveMinutes' => '5 minuten',
			'audio.tenMinutes' => '10 minuten',
			'audio.fifteenMinutes' => '15 minuten',
			'audio.thirtyMinutes' => '30 minuten',
			'audio.oneHour' => '1 uur',
			'audio.loadError' => 'De audio kon niet worden geladen',
			'audio.connectionError' => 'Controleer je internetverbinding of probeer het later opnieuw.',
			'audio.unavailable' => 'Audio is niet beschikbaar voor deze Bijbel',
			'audio.chooseBible' => 'Kies een Bijbel met audio om naar dit hoofdstuk te luisteren.',
			'audio.switchRequired' => 'Schakel over naar een Bijbel met audio om naar dit gedeelte te luisteren.',
			'audio.rewindTenSeconds' => '10 seconden terug',
			'audio.fastForwardTenSeconds' => '10 seconden vooruit',
			'audio.notificationChannelName' => 'Bijbelaudio afspelen',
			'audio.notificationChannelDescription' => 'Bediening voor het afspelen van bijbelaudio',
			'interlinearUi.interlinearBible' => 'Interlineaire Bijbel',
			'interlinearUi.direction' => 'Interlineaire richting',
			'interlinearUi.reverse' => 'Omgekeerd',
			'interlinearUi.forward' => 'Voorwaarts',
			'interlinearUi.reverseDescription' => 'Woorden staan in de Nederlandse leesvolgorde.',
			'interlinearUi.forwardDescription' => 'Woorden staan in de oorspronkelijke Hebreeuwse of Griekse volgorde.',
			'interlinearUi.studyBibleExplanation' => 'Studiebijbels zijn woord voor woord voorzien van Strong-coderingen en morfologische informatie. Daardoor is de interlineaire lexicale analyse mogelijk. In plaats daarvan wordt je meest recent gebruikte studiebijbel gebruikt.',
			'interlinearUi.usingTranslation' => ({required Object translation}) => '${translation} wordt gebruikt voor interlineair',
			'chapterUnavailable.title' => ({required Object selectedTranslation, required Object testament}) => '${selectedTranslation} bevat het ${testament} niet.',
			_ => null,
		} ?? switch (path) {
			'chapterUnavailable.subtitle' => ({required Object testament, required Object fallbackTranslation}) => 'Je meest recent gebruikte Bijbel voor het ${testament}, ${fallbackTranslation}, wordt getoond.',
			'verseNumbering.referenceLabel' => ({required Object translation, required Object reference}) => '${translation} ${reference}',
			'verseNumbering.explanation' => ({required Object translation, required Object reference, required Object originalReference}) => 'De hoofdstukken en verzen van de ${translation} zijn anders genummerd dan in de meeste Engelse vertalingen.\n\nDe tekst die hier bij ${reference} wordt getoond, komt uit ${originalReference} in de ${translation} en is opnieuw gekoppeld om met de andere vertalingen overeen te komen.',
			'compare.unavailable' => ({required Object translation}) => '${translation} bevat deze selectie niet.',
			'commentaryUi.introTo' => ({required Object book}) => 'Inleiding tot ${book}',
			'searchLocations.currentBook' => 'Huidig boek',
			'searchLocations.testaments' => 'Testamenten',
			'searchLocations.books' => 'Boeken',
			'themeOptions.auto' => 'Automatisch',
			'themeOptions.light' => 'Licht',
			'themeOptions.dark' => 'Donker',
			'themeOptions.extraTiny' => 'Extra klein',
			'themeOptions.tiny' => 'Zeer klein',
			'themeOptions.small' => 'Klein',
			'themeOptions.standard' => 'Standaard',
			'themeOptions.large' => 'Groot',
			'themeOptions.huge' => 'Zeer groot',
			'themeOptions.extraHuge' => 'Extra groot',
			'themeOptions.nativeAndSynthetic' => 'Eigen en toegevoegd',
			'themeOptions.native' => 'Eigen',
			'themeOptions.none' => 'Geen',
			'themeOptions.allHeadingsDescription' => 'Toon tussenkoppen in vertalingen die ze ondersteunen en voeg de tussenkoppen van de BSB toe aan Engelse vertalingen die zelf geen tussenkoppen hebben.',
			'themeOptions.nativeHeadingsDescription' => 'Toon tussenkoppen in vertalingen die ze ondersteunen.',
			'themeOptions.noHeadingsDescription' => 'Toon geen tussenkoppen',
			'toolbarPresets.reader' => 'Lezer',
			'toolbarPresets.noteTaker' => 'Notitiemaker',
			'toolbarPresets.studier' => 'Bijbelstudent',
			'toolbarPresets.readerDescription' => 'Afgestemd op ongestoord lezen en snel navigeren.',
			'toolbarPresets.noteTakerDescription' => 'Afgestemd op markeren en notities maken.',
			'toolbarPresets.studierDescription' => 'Afgestemd op kruisverwijzingen, commentaren en diepgaande studie.',
			'commentaryTypes.matthewHenryDescription' => 'Een beknopt, devoot commentaar op de hele Bijbel vanuit de puriteinse traditie. Warm, praktisch en toegankelijk.',
			'commentaryTypes.jamiesonFaussetBrownDescription' => 'Een compact vers-voor-verscommentaar op de hele Bijbel. Evenwichtig en toegankelijk.',
			'commentaryTypes.calvinDescription' => 'De klassieke uiteenzetting van de reformator. Diepgaand en leerstellig.',
			'strongDefinition.addedLabel' => 'toegevoegd:',
			'strongDefinition.idiomLabel' => 'idioom:',
			'strongDefinition.addedWord' => 'Toegevoegd woord',
			'strongDefinition.idiomaticRendering' => 'Idiomatische weergave',
			'strongDefinition.addedWordDescription' => 'Geeft een woord aan dat naast het gedefinieerde Hebreeuwse of Griekse woord is aangevuld.',
			'strongDefinition.idiomaticRenderingDescription' => 'Geeft een vertaling aan die een Hebreeuwse of Griekse uitdrukking weergeeft.',
			'planTypes.throughTheBible' => 'De Bijbel door',
			'planTypes.chronological' => 'Chronologisch in één jaar',
			'planTypes.oldAndNewTestament' => 'Oude en Nieuwe Testament',
			'planTypes.historicallyBlended' => 'Historisch verweven',
			'planTypes.everyDayInTheWord' => 'Elke dag in het Woord',
			'planTypes.mcheyne' => 'M\'Cheyne',
			'planTypes.literaryStudy' => 'Literaire studie',
			'planTypes.differentTopics' => 'Verschillende onderwerpen',
			'planTypes.newTestamentPsalmsProverbs' => 'Nieuwe Testament, Psalmen en Spreuken',
			'planTypes.fiveByFiveByFive' => '5x5x5 Nieuwe Testament',
			'planTypes.gospelsAndEpistles' => 'Evangeliën en brieven',
			'planTypes.pentateuchAndHistory' => 'Pentateuch en geschiedenis van Israël',
			'planTypes.chroniclesAndProphets' => 'Kronieken en profeten',
			'planTypes.psalmsAndWisdom' => 'Psalmen en wijsheidsliteratuur',
			'planTypes.mcheyneDescription' => 'Een klassiek plan met vier korte lezingen per dag. Je leest het Oude Testament eenmaal en het Nieuwe Testament en de Psalmen tweemaal in een jaar.',
			'planTypes.chronologicalDescription' => 'Lees de hele Bijbel in één jaar, gerangschikt in de volgorde waarin de gebeurtenissen plaatsvonden.',
			'planTypes.throughTheBibleDescription' => 'Lees de hele Bijbel in één jaar van Genesis tot Openbaring.',
			'planTypes.gospelsAndEpistlesDescription' => 'Reis een jaar lang door het Nieuwe Testament, de evangeliën en de brieven van de apostelen.',
			'planTypes.everyDayInTheWordDescription' => 'Vier lezingen per dag uit het Oude Testament, Nieuwe Testament, Psalmen en Spreuken. Zo lees je de hele Bijbel in één jaar en Psalmen en Spreuken tweemaal.',
			'planTypes.literaryStudyDescription' => 'Beleef de Bijbel een jaar lang gegroepeerd naar literaire stijl, van verhalen en poëzie tot brieven.',
			'planTypes.chroniclesAndProphetsDescription' => 'Een jaar waarin de geschiedenis uit Kronieken wordt gekoppeld aan de boodschappen van de profeten.',
			'planTypes.pentateuchAndHistoryDescription' => 'Reis in één jaar door de vijf boeken van Mozes en de geschiedenis van Israël.',
			'planTypes.psalmsAndWisdomDescription' => 'Breng een jaar door in de Psalmen en wijsheidsboeken zoals Spreuken, Job en Prediker.',
			'planTypes.oldAndNewTestamentDescription' => 'Lees de hele Bijbel in één jaar en volg het Oude en Nieuwe Testament samen in de gebruikelijke Bijbelvolgorde.',
			'planTypes.historicallyBlendedDescription' => 'Lees de hele Bijbel in één jaar, met boeken en passages gerangschikt rond verwante gebeurtenissen en historische perioden.',
			'planTypes.differentTopicsDescription' => 'Lees elke dag een ander gedeelte van de Bijbel en verken in één jaar elk Bijbelboek.',
			'planTypes.newTestamentPsalmsProverbsDescription' => 'Lees in één jaar het Nieuwe Testament naast Psalmen en Spreuken.',
			'planTypes.fiveByFiveByFiveDescription' => 'Lees vijf dagen per week één hoofdstuk uit het Nieuwe Testament, gevolgd door twee dagen om terug te kijken en te overdenken.',
			'planTypes.oldScopeDescription' => 'Leest uit boeken van het Oude Testament.',
			'planTypes.newScopeDescription' => 'Leest uit boeken van het Nieuwe Testament.',
			'planTypes.wholeScopeDescription' => 'Leest uit het Oude en Nieuwe Testament.',
			'planTypes.focused' => 'Gericht',
			'planTypes.comprehensive' => 'Volledig',
			'planTypes.focusedDescription' => 'Behandelt een specifiek gedeelte of een specifieke verzameling binnen het bereik.',
			'planTypes.comprehensiveDescription' => 'Behandelt elk boek binnen het bereik.',
			'onboardingSteps.viewCrossReferences' => 'Kruisverwijzingen bekijken',
			'onboardingSteps.annotateVerse' => 'Een vers annoteren',
			'onboardingSteps.searchWord' => 'Naar een woord zoeken',
			'onboardingSteps.switchBible' => 'Van Bijbel wisselen',
			'onboardingSteps.navigateChapter' => 'Naar een ander hoofdstuk gaan',
			'onboardingSteps.goBack' => 'Teruggaan',
			'onboardingSteps.swipeChapter' => 'Vegen om van hoofdstuk te wisselen',
			'onboardingSteps.addStudyPanel' => 'Een studiepaneel toevoegen',
			'onboardingSteps.customizeToolbar' => 'Je werkbalken aanpassen',
			'onboardingSteps.startBiblePlan' => 'Een Bijbelleesplan starten',
			'onboardingSteps.selectVerse' => 'Tik op een vers om het te selecteren',
			'onboardingSteps.selectWord' => 'Houd een woord ingedrukt',
			'onboardingSteps.deselectPrefix' => 'Tik op ',
			'onboardingSteps.deselectSuffix' => ' naast je selectie om de selectie op te heffen',
			'onboardingSteps.revealToolbar' => 'Scroll omhoog om de hoofdwerkbalk te tonen',
			'onboardingSteps.addPanelPrefix' => 'Tik op ',
			'onboardingSteps.addPanelSuffix' => ' → Studie → Studiepaneel toevoegen en voeg een studiepaneel toe',
			'onboardingSteps.goToChapter' => 'Ga naar een ander hoofdstuk',
			'onboardingSteps.openPrefix' => 'Open ',
			'onboardingSteps.crossReferencesSuffix' => ' → Studie → Kruisverwijzingen',
			'onboardingSteps.annotatePrefix' => 'Tik op ',
			'onboardingSteps.annotateSuffix' => ' om te markeren of een notitie toe te voegen',
			'onboardingSteps.searchPrefix' => 'Tik op ',
			'onboardingSteps.searchSuffix' => ' om het woord overal op te zoeken',
			'onboardingSteps.switchBibleDescription' => ({required Object translation}) => 'Tik op de hoofdwerkbalk → ${translation} om van Bijbel te wisselen',
			'onboardingSteps.goToChapterDescription' => 'Tik op de hoofdwerkbalk om naar een ander hoofdstuk te gaan',
			'onboardingSteps.goBackDescription' => 'Veeg op de werkbalk naar rechts om terug te gaan',
			'onboardingSteps.swipeChapterDescription' => 'Veeg de Bijbel naar links of rechts om van hoofdstuk te wisselen',
			'onboardingSteps.viewPanelDescription' => 'Veeg dit paneel naar rechts om je studiepaneel te bekijken',
			'onboardingSteps.moreSeparator' => ' → Meer → ',
			'onboardingSteps.customizeToolbarSuffix' => 'Werkbalken en kies een werkbalkpreset of wijzig een snelkoppeling',
			'onboardingSteps.startPlanSuffix' => ' → Bijbelleesplannen en start een leesplan',
			'dictionary.eastons' => 'Easton\'s Bible Dictionary',
			'navigation.recents' => 'Recent',
			'navigation.navigate' => 'Navigeren',
			'navigation.book' => 'Boek',
			'navigation.chapter' => 'Hoofdstuk',
			'navigation.verse' => 'Vers',
			'bibleSheet.allBibles' => 'Alle Bijbels',
			'bibleSheet.availableCount' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('nl'))(count, one: '${count} Bijbel beschikbaar', other: '${count} Bijbels beschikbaar', ), 
			'selectionUi.selected' => 'Geselecteerd: ',
			'selectionUi.sourceApiBible' => 'Bron: [https://api.bible](https://api.bible)',
			'errors.deviceVerificationFailed' => 'Apparaatverificatie mislukt',
			'errors.deviceVerificationDescription' => 'Voor toegang tot deze online Bijbel zijn een geldig apparaat en een legitieme installatie van Lux vereist. Controleer of je Lux vanuit een officiële appwinkel hebt geïnstalleerd en probeer het opnieuw.',
			'errors.generic' => 'Er is iets misgegaan',
			'errors.connection' => 'Controleer je internetverbinding of probeer het later opnieuw.',
			'morphology.attributes.type.name' => 'Type',
			'morphology.attributes.type.description' => 'De grammaticale categorie van het woord.',
			'morphology.attributes.grammaticalCase.name' => 'Naamval',
			'morphology.attributes.grammaticalCase.description' => 'De syntactische rol, zoals onderwerp, object of bezit.',
			'morphology.attributes.gender.name' => 'Geslacht',
			'morphology.attributes.gender.description' => 'Grammaticaal geslacht: mannelijk, vrouwelijk, onzijdig (Grieks) of gemeenschappelijk (Hebreeuws).',
			'morphology.attributes.number.name' => 'Getal',
			'morphology.attributes.number.description' => 'Of het woord verwijst naar één (enkelvoud), twee (dualis) of meerdere (meervoud).',
			'morphology.attributes.person.name' => 'Persoon',
			'morphology.attributes.person.description' => 'Naar wie het woord verwijst: 1e (ik/wij), 2e (jij/jullie) of 3e (hij/zij/het/zij).',
			'morphology.attributes.state.name' => 'Status',
			'morphology.attributes.state.description' => 'De status van een zelfstandig naamwoord: absoluut, constructus of bepaald.',
			'morphology.attributes.tense.name' => 'Tijd',
			'morphology.attributes.tense.description' => 'De werkwoordstijd, een combinatie van tijd en aspect.',
			'morphology.attributes.mood.name' => 'Wijs',
			'morphology.attributes.mood.description' => 'Hoe de handeling wordt uitgedrukt, bijvoorbeeld als feit, bevel of mogelijkheid.',
			'morphology.attributes.voice.name' => 'Diathese',
			'morphology.attributes.voice.description' => 'De diathese: actief, medium of passief.',
			'morphology.attributes.degree.name' => 'Trap',
			'morphology.attributes.degree.description' => 'De trap van een bijvoeglijk naamwoord of bijwoord: stellend, vergrotend of overtreffend.',
			'morphology.attributes.stem.name' => 'Stam',
			'morphology.attributes.stem.description' => 'De werkwoordstam (binyan), zoals qal, niphal of piel.',
			'morphology.attributes.aspect.name' => 'Aspect',
			'morphology.attributes.aspect.description' => 'Het werkwoordsaspect, zoals perfectum, imperfectum of participium.',
			'morphology.attributes.prefix.name' => 'Voorvoegsel',
			'morphology.attributes.prefix.description' => 'Een Hebreeuwse voorzetselletter als voorvoegsel.',
			'morphology.attributes.particle.name' => 'Partikel',
			'morphology.attributes.particle.description' => 'Een klein, onverbuigbaar woord, vaak een voegwoord of markeerwoord.',
			'morphology.attributes.code.name' => 'Code',
			'morphology.attributes.code.description' => 'De onbewerkte morfologiecode zoals die in de brontekst staat.',
			'morphology.types.article.name' => 'Lidwoord',
			'morphology.types.article.description' => 'Een bepaald lidwoord, "de" of "het".',
			'morphology.types.article.examples' => 'de koning|de Heer',
			'morphology.types.conjunction.name' => 'Voegwoord',
			'morphology.types.conjunction.description' => 'Een woord dat andere woorden of zinnen verbindt.',
			'morphology.types.conjunction.examples' => 'en|maar|want',
			'morphology.types.preposition.name' => 'Voorzetsel',
			'morphology.types.preposition.description' => 'Verbindt een zelfstandig naamwoord of voornaamwoord met andere woorden.',
			'morphology.types.preposition.examples' => 'in|naar|met',
			'morphology.types.adverb.name' => 'Bijwoord',
			'morphology.types.adverb.description' => 'Bepaalt een werkwoord, bijvoeglijk naamwoord of ander bijwoord nader.',
			'morphology.types.adverb.examples' => 'snel|nu|daar',
			'morphology.types.negativeAdverb.name' => 'Ontkennend bijwoord',
			'morphology.types.negativeAdverb.description' => 'Een bijwoord dat een ontkenning uitdrukt.',
			'morphology.types.negativeAdverb.examples' => 'niet|nooit',
			'morphology.types.adjective.name' => 'Bijvoeglijk naamwoord',
			'morphology.types.adjective.description' => 'Een woord dat een zelfstandig naamwoord beschrijft.',
			'morphology.types.adjective.examples' => 'groot|heilig|wijs',
			'morphology.types.noun.name' => 'Zelfstandig naamwoord',
			'morphology.types.noun.description' => 'Een persoon, plaats, zaak of begrip.',
			'morphology.types.noun.examples' => 'stad|water|liefde',
			'morphology.types.properNoun.name' => 'Eigennaam',
			'morphology.types.properNoun.description' => 'De specifieke naam van een persoon, plaats of zaak.',
			'morphology.types.properNoun.examples' => 'David|Jeruzalem|Israël',
			'morphology.types.number.name' => 'Hoofdtelwoord',
			'morphology.types.number.description' => 'Een hoofdtelwoord.',
			'morphology.types.number.examples' => 'drie|twaalf|duizend',
			'morphology.types.ordinalNumber.name' => 'Rangtelwoord',
			'morphology.types.ordinalNumber.description' => 'Een rangtelwoord, zoals "eerste" of "tweede".',
			'morphology.types.ordinalNumber.examples' => 'eerste|tiende|zeventigste',
			'morphology.types.pronoun.name' => 'Voornaamwoord',
			'morphology.types.pronoun.description' => 'Een woord dat in de plaats van een zelfstandig naamwoord staat.',
			'morphology.types.pronoun.examples' => 'hij|zij|ze',
			'morphology.types.personalPronoun.name' => 'Persoonlijk voornaamwoord',
			'morphology.types.personalPronoun.description' => 'Een voornaamwoord dat naar een bepaalde persoon verwijst.',
			'morphology.types.personalPronoun.examples' => 'ik|jij|wij',
			'morphology.types.demonstrativePronoun.name' => 'Aanwijzend voornaamwoord',
			'morphology.types.demonstrativePronoun.description' => 'Een voornaamwoord dat iets aanwijst.',
			'morphology.types.demonstrativePronoun.examples' => 'dit|deze|die',
			'morphology.types.interrogativePronoun.name' => 'Vragend voornaamwoord',
			'morphology.types.interrogativePronoun.description' => 'Een voornaamwoord waarmee een vraag wordt gesteld.',
			'morphology.types.interrogativePronoun.examples' => 'wie?|wat?|welke?',
			'morphology.types.indefinitePronoun.name' => 'Onbepaald voornaamwoord',
			'morphology.types.indefinitePronoun.description' => 'Een voornaamwoord dat naar niet-specifieke zaken verwijst.',
			'morphology.types.indefinitePronoun.examples' => 'iemand|wie dan ook|niets',
			'morphology.types.reciprocalPronoun.name' => 'Wederkerig voornaamwoord',
			'morphology.types.reciprocalPronoun.description' => 'Een voornaamwoord dat een wederzijdse handeling uitdrukt.',
			'morphology.types.reciprocalPronoun.examples' => 'elkaar|elkander',
			'morphology.types.reflexivePronoun.name' => 'Wederkerend voornaamwoord',
			'morphology.types.reflexivePronoun.description' => 'Een voornaamwoord dat terugverwijst naar het onderwerp.',
			'morphology.types.reflexivePronoun.examples' => 'zichzelf|henzelf',
			'morphology.types.relativePronoun.name' => 'Betrekkelijk voornaamwoord',
			'morphology.types.relativePronoun.description' => 'Een voornaamwoord dat een bijzin inleidt.',
			'morphology.types.relativePronoun.examples' => 'die|dat|welke',
			'morphology.types.particle.name' => 'Partikel',
			'morphology.types.particle.description' => 'Een klein, onverbuigbaar woord.',
			'morphology.types.particle.examples' => 'inderdaad|nu',
			'morphology.types.negativeParticle.name' => 'Ontkennend partikel',
			'morphology.types.negativeParticle.description' => 'Een partikel dat een ontkenning aangeeft.',
			'morphology.types.negativeParticle.examples' => 'niet|geen',
			'morphology.types.interrogativeParticle.name' => 'Vragend partikel',
			'morphology.types.interrogativeParticle.description' => 'Een partikel dat een vraag aangeeft.',
			'morphology.types.interrogativeParticle.examples' => '(Hebreeuws voorvoegsel ה, zonder Nederlands equivalent)',
			'morphology.types.demonstrativeParticle.name' => 'Aanwijzend partikel',
			'morphology.types.demonstrativeParticle.description' => 'Een aanwijzend partikel, zoals "zie".',
			'morphology.types.demonstrativeParticle.examples' => 'zie|aanschouw',
			'morphology.types.genericParticle.name' => 'Algemeen partikel',
			'morphology.types.genericParticle.description' => 'Een algemeen bruikbaar partikel.',
			'morphology.types.genericParticle.examples' => 'inderdaad|waarlijk',
			'morphology.types.relativeParticle.name' => 'Betrekkelijk partikel',
			'morphology.types.relativeParticle.description' => 'Een partikel dat een betrekkelijke bijzin inleidt.',
			'morphology.types.relativeParticle.examples' => 'dat|welke',
			'morphology.types.verb.name' => 'Werkwoord',
			'morphology.types.verb.description' => 'Een woord dat een handeling of toestand uitdrukt.',
			'morphology.types.verb.examples' => 'schrijven|zijn|gaan',
			'morphology.types.pronominalSuffix.name' => 'Pronominaal achtervoegsel',
			'morphology.types.pronominalSuffix.description' => 'Een voornaamwoord dat aan het einde van een werkwoord of zelfstandig naamwoord is gehecht (Hebreeuws).',
			'morphology.types.pronominalSuffix.examples' => 'zijn hand|hun land|haar stem',
			'morphology.types.directObjectMarker.name' => 'Markering lijdend voorwerp',
			'morphology.types.directObjectMarker.description' => 'Het Hebreeuwse אֵת dat een bepaald lijdend voorwerp markeert.',
			'morphology.types.directObjectMarker.examples' => 'אֵת (zonder Nederlands equivalent)',
			'morphology.types.punctuation.name' => 'Leesteken',
			'morphology.types.punctuation.description' => 'Een leesteken.',
			'morphology.types.punctuation.examples' => '.|,|;',
			'morphology.types.interjection.name' => 'Tussenwerpsel',
			'morphology.types.interjection.description' => 'Een korte uitroep die emotie uitdrukt.',
			'morphology.types.interjection.examples' => 'o!|helaas!',
			'morphology.types.indeclinable.name' => 'Onverbuigbaar',
			'morphology.types.indeclinable.description' => 'Een woord waarvan de vorm niet verandert door verbuiging.',
			'morphology.types.indeclinable.examples' => 'Hosanna|Halleluja',
			'morphology.types.hebraism.name' => 'Hebreeuws leenwoord',
			'morphology.types.hebraism.description' => 'Een Hebreeuws of Aramees leenwoord dat in het Grieks is overgenomen.',
			'morphology.types.hebraism.examples' => 'Amen|Hosanna|Sabaoth',
			'morphology.types.unknown.name' => 'Onbekend',
			'morphology.types.unknown.description' => 'Een morfologiecode die de parser niet herkende.',
			'morphology.types.unknown.examples' => '',
			'morphology.person.first.name' => '1e persoon',
			'morphology.person.first.description' => 'De spreker, "ik" of "wij".',
			'morphology.person.first.examples' => 'ik ben|wij lopen|ik heb gesproken',
			'morphology.person.second.name' => '2e persoon',
			'morphology.person.second.description' => 'De aangesprokene, "jij" of "jullie".',
			'morphology.person.second.examples' => 'jij gaat|jullie luisteren|jij hebt gezien',
			'morphology.person.third.name' => '3e persoon',
			'morphology.person.third.description' => 'De persoon over wie wordt gesproken.',
			'morphology.person.third.examples' => 'hij rent|zij spreekt|zij verzamelden zich',
			'morphology.gender.masculine.name' => 'Mannelijk',
			'morphology.gender.masculine.description' => 'Mannelijk grammaticaal geslacht, gebruikt voor mannelijke personen en volgens afspraak voor veel zelfstandige naamwoorden.',
			'morphology.gender.masculine.examples' => 'vader|zoon|koning',
			'morphology.gender.feminine.name' => 'Vrouwelijk',
			'morphology.gender.feminine.description' => 'Vrouwelijk grammaticaal geslacht, gebruikt voor vrouwelijke personen en volgens afspraak voor veel zelfstandige naamwoorden.',
			'morphology.gender.feminine.examples' => 'moeder|dochter|koningin',
			'morphology.gender.neuter.name' => 'Onzijdig',
			'morphology.gender.neuter.description' => 'Grieks onzijdig geslacht, noch mannelijk noch vrouwelijk.',
			'morphology.gender.neuter.examples' => 'kind (τέκνον)|geschenk (δῶρον)',
			'morphology.gender.common.name' => 'Gemeenschappelijk',
			'morphology.gender.common.description' => 'Hebreeuws gemeenschappelijk geslacht, waarbij de vorm zowel mannelijk als vrouwelijk kan zijn.',
			'morphology.gender.common.examples' => 'vee|stem',
			'morphology.number.singular.name' => 'Enkelvoud',
			'morphology.number.singular.description' => 'Verwijst naar één.',
			'morphology.number.singular.examples' => 'het boek|een man|één steen',
			'morphology.number.plural.name' => 'Meervoud',
			'morphology.number.plural.description' => 'Verwijst naar twee of meer.',
			'morphology.number.plural.examples' => 'de boeken|mannen|stenen',
			'morphology.number.dual.name' => 'Dualis',
			'morphology.number.dual.description' => 'Verwijst naar een natuurlijk paar (alleen Hebreeuws).',
			'morphology.number.dual.examples' => 'handen|ogen|twee dagen',
			'morphology.kCase.nominative.name' => 'Nominatief',
			'morphology.kCase.nominative.description' => 'Markeert het onderwerp van een zin.',
			'morphology.kCase.nominative.examples' => 'God schiep|de koning ziet',
			'morphology.kCase.genitive.name' => 'Genitief',
			'morphology.kCase.genitive.description' => 'Geeft bezit of herkomst aan, vaak vertaald met "van".',
			'morphology.kCase.genitive.examples' => 'de Zoon van God|koninkrijk der hemelen',
			'morphology.kCase.dative.name' => 'Datief',
			'morphology.kCase.dative.description' => 'Markeert het meewerkend voorwerp, vaak met "aan" of "voor".',
			'morphology.kCase.dative.examples' => 'gaf aan hem|sprak tot hen',
			'morphology.kCase.accusative.name' => 'Accusatief',
			'morphology.kCase.accusative.description' => 'Markeert het lijdend voorwerp.',
			'morphology.kCase.accusative.examples' => 'zag hem|heb je naaste lief',
			'morphology.kCase.vocative.name' => 'Vocatief',
			'morphology.kCase.vocative.description' => 'Wordt gebruikt bij een directe aanspreking.',
			'morphology.kCase.vocative.examples' => 'Heer!|Vader!|Vriend!',
			'morphology.state.absolute.name' => 'Absoluut',
			'morphology.state.absolute.description' => 'De standaard, zelfstandige vorm van een zelfstandig naamwoord.',
			'morphology.state.absolute.examples' => 'een koning|een woord',
			'morphology.state.construct.name' => 'Constructus',
			'morphology.state.construct.description' => 'Verbonden met een volgend zelfstandig naamwoord en drukt "X van Y" uit.',
			'morphology.state.construct.examples' => 'koning van Israël|woord van de HEER',
			'morphology.state.determined.name' => 'Bepaald',
			'morphology.state.determined.description' => 'Als bepaald gemarkeerd, vaak door het lidwoord.',
			'morphology.state.determined.examples' => 'de koning|het woord',
			'morphology.stem.qal.name' => 'Qal',
			'morphology.stem.qal.description' => 'De eenvoudige actieve stam, de basishandeling van het werkwoord.',
			'morphology.stem.qal.examples' => 'hij schreef|zij hoorde',
			'morphology.stem.qalPassive.name' => 'Qal passief',
			'morphology.stem.qalPassive.description' => 'Een zeldzame passieve vorm van de eenvoudige stam.',
			'morphology.stem.qalPassive.examples' => 'het werd genomen',
			'morphology.stem.niphal.name' => 'Niphal',
			'morphology.stem.niphal.description' => 'De eenvoudige passieve of wederkerende stam.',
			'morphology.stem.niphal.examples' => 'hij werd gedood|zij verzamelden zich',
			'morphology.stem.piel.name' => 'Piel',
			'morphology.stem.piel.description' => 'De intensieve of factitieve actieve stam.',
			'morphology.stem.piel.examples' => 'hij prees|hij zegende|hij verbrijzelde',
			'morphology.stem.pual.name' => 'Pual',
			'morphology.stem.pual.description' => 'De passieve vorm van de piel.',
			'morphology.stem.pual.examples' => 'hij werd geprezen',
			'morphology.stem.hiphil.name' => 'Hiphil',
			'morphology.stem.hiphil.description' => 'De causatieve actieve stam.',
			'morphology.stem.hiphil.examples' => 'hij liet schrijven|hij leidde naar buiten',
			'morphology.stem.hophal.name' => 'Hophal',
			'morphology.stem.hophal.description' => 'De passieve vorm van de hiphil.',
			'morphology.stem.hophal.examples' => 'hij werd tot schrijven gebracht',
			'morphology.stem.hithpael.name' => 'Hithpael',
			'morphology.stem.hithpael.description' => 'De wederkerende of wederzijdse vorm van de piel.',
			'morphology.stem.hithpael.examples' => 'hij heiligde zichzelf|zij liepen rond',
			'morphology.stem.nithpael.name' => 'Nithpael',
			'morphology.stem.nithpael.description' => 'Een zeldzame wederkerend-passieve stam.',
			'morphology.stem.nithpael.examples' => 'er werd verzoening voor gedaan',
			'morphology.aspect.perfect.name' => 'Perfectum',
			'morphology.aspect.perfect.description' => 'Voltooide handeling, doorgaans vertaald als verleden tijd.',
			'morphology.aspect.perfect.examples' => 'hij schreef|zij heeft gesproken',
			'morphology.aspect.imperfect.name' => 'Imperfectum',
			'morphology.aspect.imperfect.description' => 'Onvoltooide of toekomstige handeling, vaak vertaald als toekomstig of gewoonlijk.',
			'morphology.aspect.imperfect.examples' => 'hij zal schrijven|hij schrijft',
			'morphology.aspect.imperative.name' => 'Imperatief',
			'morphology.aspect.imperative.description' => 'Een rechtstreeks bevel.',
			'morphology.aspect.imperative.examples' => 'Schrijf!|Luister!',
			'morphology.aspect.infinitiveConstruct.name' => 'Infinitivus constructus',
			'morphology.aspect.infinitiveConstruct.description' => 'Een verbaal zelfstandig naamwoord in de constructusvorm, vaak gebruikt met voorzetsels.',
			'morphology.aspect.infinitiveConstruct.examples' => 'schrijven|bij het schrijven',
			'morphology.aspect.infinitiveAbsolute.name' => 'Infinitivus absolutus',
			'morphology.aspect.infinitiveAbsolute.description' => 'Een zelfstandig verbaal naamwoord, vaak met nadruk.',
			'morphology.aspect.infinitiveAbsolute.examples' => 'zeker sterven|grondig schrijven',
			'morphology.aspect.participle.name' => 'Participium',
			'morphology.aspect.participle.description' => 'Een verbaal bijvoeglijk naamwoord dat een voortdurende handeling beschrijft.',
			'morphology.aspect.participle.examples' => 'schrijvend|degene die hoort',
			'morphology.aspect.consecutiveImperfect.name' => 'Consecutief imperfectum',
			'morphology.aspect.consecutiveImperfect.description' => 'Verhalende verleden vorm: waw + imperfectum.',
			'morphology.aspect.consecutiveImperfect.examples' => 'en hij zei|en zij gingen',
			'morphology.aspect.conjunctiveImperfect.name' => 'Conjunctief imperfectum',
			'morphology.aspect.conjunctiveImperfect.description' => 'Imperfectum met conjunctieve waw, met een toekomstige of modale betekenis.',
			'morphology.aspect.conjunctiveImperfect.examples' => 'en hij zal schrijven',
			'morphology.aspect.conjunctivePerfect.name' => 'Conjunctief perfectum',
			'morphology.aspect.conjunctivePerfect.description' => 'Perfectum met conjunctieve waw, vaak toekomstig of opeenvolgend.',
			'morphology.aspect.conjunctivePerfect.examples' => 'en u zult doen|en hij zal oordelen',
			'morphology.aspect.passiveParticiple.name' => 'Passief participium',
			'morphology.aspect.passiveParticiple.description' => 'De passieve vorm van het qal-participium.',
			'morphology.aspect.passiveParticiple.examples' => 'geschreven|bewaard',
			'morphology.hebrewMood.jussive.name' => 'Jussief',
			'morphology.hebrewMood.jussive.description' => 'Een bevel of wens in de 3e persoon.',
			'morphology.hebrewMood.jussive.examples' => 'Laat er licht zijn|Moge de HEER u zegenen',
			'morphology.hebrewMood.cohortative.name' => 'Cohortatief',
			'morphology.hebrewMood.cohortative.description' => 'Een wilsvorm in de 1e persoon, zoals "laten wij" of "ik zal".',
			'morphology.hebrewMood.cohortative.examples' => 'Laten wij gaan|Ik zal prijzen',
			'morphology.hebrewMood.hSuffix.name' => 'h-achtervoegsel',
			'morphology.hebrewMood.hSuffix.description' => 'Een nadrukkelijke uitgang -ah bij het imperfectum, vaak cohortatief van aard.',
			'morphology.hebrewMood.hSuffix.examples' => 'Ik zal zeker komen|laat mij naderen',
			'morphology.tense.present.name' => 'Praesens',
			'morphology.tense.present.description' => 'Voortdurende of algemene handeling.',
			'morphology.tense.present.examples' => 'hij heeft lief|zij lopen',
			'morphology.tense.imperfect.name' => 'Imperfectum',
			'morphology.tense.imperfect.description' => 'Voortdurende of herhaalde handeling in het verleden.',
			'morphology.tense.imperfect.examples' => 'hij was aan het onderwijzen|zij kwamen gewoonlijk bijeen',
			'morphology.tense.future.name' => 'Futurum',
			'morphology.tense.future.description' => 'Een handeling die zal plaatsvinden.',
			'morphology.tense.future.examples' => 'hij zal komen|zij zullen zien',
			'morphology.tense.aorist.name' => 'Aoristus',
			'morphology.tense.aorist.description' => 'Een eenvoudige handeling in het verleden, als geheel beschouwd.',
			'morphology.tense.aorist.examples' => 'hij zei|zij gingen',
			'morphology.tense.perfect.name' => 'Perfectum',
			'morphology.tense.perfect.description' => 'Een handeling in het verleden met een blijvend gevolg in het heden.',
			'morphology.tense.perfect.examples' => 'is geschreven|is gekomen',
			'morphology.tense.pluperfect.name' => 'Plusquamperfectum',
			'morphology.tense.pluperfect.description' => 'Een handeling vóór een andere gebeurtenis in het verleden.',
			'morphology.tense.pluperfect.examples' => 'was geschreven|was vertrokken',
			'morphology.mood.indicative.name' => 'Indicatief',
			'morphology.mood.indicative.description' => 'Drukt een feit uit.',
			'morphology.mood.indicative.examples' => 'hij is|zij schreven',
			'morphology.mood.imperative.name' => 'Imperatief',
			'morphology.mood.imperative.description' => 'Geeft een bevel.',
			'morphology.mood.imperative.examples' => 'Ga!|Geloof!|Vrees niet!',
			'morphology.mood.subjunctive.name' => 'Conjunctief',
			'morphology.mood.subjunctive.description' => 'Drukt mogelijkheid, doel of voorwaardelijkheid uit.',
			'morphology.mood.subjunctive.examples' => 'opdat hij zou schrijven|als hij gaat',
			'morphology.mood.optative.name' => 'Optatief',
			'morphology.mood.optative.description' => 'Drukt een wens of onwaarschijnlijke mogelijkheid uit.',
			'morphology.mood.optative.examples' => 'moge het zo zijn|moge u genade ontvangen',
			'morphology.mood.infinitive.name' => 'Infinitief',
			'morphology.mood.infinitive.description' => 'Een verbaal zelfstandig naamwoord, zoals "doen".',
			'morphology.mood.infinitive.examples' => 'schrijven|geloven',
			'morphology.mood.participle.name' => 'Participium',
			'morphology.mood.participle.description' => 'Een verbaal bijvoeglijk naamwoord, zoals "doende" of "gedaan hebbend".',
			'morphology.mood.participle.examples' => 'degene die schrijft|gesproken hebbend',
			'morphology.voice.active.name' => 'Actief',
			'morphology.voice.active.description' => 'Het onderwerp voert de handeling uit.',
			'morphology.voice.active.examples' => 'hij schrijft|zij onderwijzen',
			'morphology.voice.middle.name' => 'Medium',
			'morphology.voice.middle.description' => 'Het onderwerp handelt op of voor zichzelf.',
			'morphology.voice.middle.examples' => 'hij wast zichzelf|zij verwierven het voor zichzelf',
			'morphology.voice.passive.name' => 'Passief',
			'morphology.voice.passive.description' => 'Het onderwerp ondergaat de handeling.',
			'morphology.voice.passive.examples' => 'hij werd gezonden|zij werden onderwezen',
			'morphology.voice.middleOrPassive.name' => 'Medium/passief',
			'morphology.voice.middleOrPassive.description' => 'De vorm kan zowel medium als passief zijn.',
			'morphology.voice.middleOrPassive.examples' => 'werd opgewekt / wekte zichzelf op|werd verzameld / verzamelde zichzelf',
			'morphology.degree.positive.name' => 'Stellende trap',
			'morphology.degree.positive.description' => 'De gewone vorm, niet vergrotend of overtreffend.',
			'morphology.degree.positive.examples' => 'groot|goed',
			'morphology.degree.comparative.name' => 'Vergrotende trap',
			'morphology.degree.comparative.description' => 'Vergelijkt twee zaken.',
			'morphology.degree.comparative.examples' => 'groter|beter dan',
			'morphology.degree.superlative.name' => 'Overtreffende trap',
			'morphology.degree.superlative.description' => 'Drukt de hoogste graad uit.',
			'morphology.degree.superlative.examples' => 'grootst|best',
			'morphology.literals.rawCode' => 'De onbewerkte morfologiecode zoals die in de bron stond.',
			'morphology.literals.waw' => 'Het Hebreeuwse voegwoord waw (וְ), dat "en" betekent.',
			'morphology.literals.conjunction' => 'Een voegwoordmarkering.',
			'morphology.literals.bet' => 'Het Hebreeuwse voorvoegsel bet (בְּ), dat "in", "bij" of "met" betekent.',
			'morphology.literals.kaf' => 'Het Hebreeuwse voorvoegsel kaf (כְּ), dat "als" of "zoals" betekent.',
			'morphology.literals.lamed' => 'Het Hebreeuwse voorvoegsel lamed (לְ), dat "naar", "voor" of "toebehorend aan" betekent.',
			'morphology.literals.mem' => 'Het Hebreeuwse voorvoegsel mem (מִן), dat "van" of "uit" betekent.',
			'morphology.literals.preposition' => 'Een voorzetselletter als voorvoegsel.',
			'morphology.literals.wawExamples' => 'en|nu|maar',
			'morphology.literals.betExamples' => 'in het begin|met kracht',
			'morphology.literals.kafExamples' => 'als een leeuw|zoals een herder',
			'morphology.literals.lamedExamples' => 'aan David|voor de koning',
			'morphology.literals.memExamples' => 'uit Egypte|uit het land',
			'settings.title' => 'Instellingen',
			'settings.customize' => 'Aanpassen',
			'settings.pushNotifications' => 'Pushmeldingen',
			'settings.biblePlanReminders' => 'Herinneringen voor Bijbelleesplannen',
			'settings.notificationsNotRequested' => 'Schakel meldingen in.',
			'settings.notificationsNotRequestedDescription' => 'Sta Lux toe meldingen te sturen om je herinneringen te beheren.',
			'settings.notificationsDisabled' => 'Meldingen voor Lux zijn uitgeschakeld.',
			'settings.biblePlanRemindersDisabled' => 'Herinneringen voor Bijbelleesplannen zijn uitgeschakeld.',
			'settings.verseOfTheDayRemindersDisabled' => 'Herinneringen voor het vers van de dag zijn uitgeschakeld.',
			'settings.notificationsDisabledDescription' => 'Schakel ze in via de instellingen van je apparaat om je herinneringen te beheren.',
			'settings.language' => 'Taal',
			'settings.system' => 'Systeem',
			'settings.systemLanguageDescription' => 'Komt overeen met de taalinstelling van je systeem.',
			'settings.toolbarPresets' => 'Werkbalkpresets',
			'settings.toolbarPreset' => 'Werkbalkpreset',
			'settings.presetWarning' => 'Als je een preset selecteert, worden de snelkoppelingen in al je werkbalken overschreven.',
			'settings.yourContent' => 'Je inhoud',
			'settings.discussionAndAnnouncements' => 'Discussies en aankondigingen',
			'settings.tipsAndUpdates' => 'Tips en updates',
			'settings.supportLux' => 'Lux steunen',
			'settings.rateLux' => 'Lux beoordelen',
			'settings.leaveReview' => 'Schrijf een recensie in de App Store.',
			'settings.supportMessage' => 'Lux is een passieproject vanuit de overtuiging dat de Bijbel voor iedereen vrij beschikbaar moet zijn. De beste manier om Lux te steunen is met een recensie in de App Store.\n\nAls iets je ervan weerhoudt om een vijfsterrenrecensie te schrijven, word dan lid van onze Discord en deel je feedback. Dan kunnen we er snel iets aan doen.',
			'settings.leaveRating' => 'Beoordeling achterlaten',
			'settings.joinDiscord' => 'Lid worden van Discord',
			'settings.restartGetStarted' => 'Aan de slag opnieuw starten',
			'settings.restartGetStartedDescription' => 'Toon de checklist Aan de slag opnieuw',
			'settings.resetTutorials' => 'Uitleg opnieuw instellen',
			'settings.resetTutorialsDescription' => 'Toon de handige tips in de app opnieuw',
			'settings.tutorialsReset' => 'De uitleg is opnieuw ingesteld.',
			_ => null,
		};
	}
}
