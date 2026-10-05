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
class TranslationsDe extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsDe _root = this; // ignore: unused_field

	@override 
	TranslationsDe $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsDe(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$languages$de languages = _Translations$languages$de._(_root);
	@override late final _Translations$highlightStyles$de highlightStyles = _Translations$highlightStyles$de._(_root);
	@override late final _Translations$colors$de colors = _Translations$colors$de._(_root);
	@override late final _Translations$testaments$de testaments = _Translations$testaments$de._(_root);
	@override late final _Translations$books$de books = _Translations$books$de._(_root);
	@override late final _Translations$common$de common = _Translations$common$de._(_root);
	@override late final _Translations$copySheet$de copySheet = _Translations$copySheet$de._(_root);
	@override late final _Translations$regionTypes$de regionTypes = _Translations$regionTypes$de._(_root);
	@override late final _Translations$mainActions$de mainActions = _Translations$mainActions$de._(_root);
	@override late final _Translations$verseOfTheDay$de verseOfTheDay = _Translations$verseOfTheDay$de._(_root);
	@override late final _Translations$studyActions$de studyActions = _Translations$studyActions$de._(_root);
	@override late final _Translations$selectionActions$de selectionActions = _Translations$selectionActions$de._(_root);
	@override late final _Translations$studyPanels$de studyPanels = _Translations$studyPanels$de._(_root);
	@override late final _Translations$bookmarks$de bookmarks = _Translations$bookmarks$de._(_root);
	@override late final _Translations$bookmarkPage$de bookmarkPage = _Translations$bookmarkPage$de._(_root);
	@override late final _Translations$commentaries$de commentaries = _Translations$commentaries$de._(_root);
	@override late final _Translations$toolbarShortcuts$de toolbarShortcuts = _Translations$toolbarShortcuts$de._(_root);
	@override late final _Translations$labels$de labels = _Translations$labels$de._(_root);
	@override late final _Translations$strongSheet$de strongSheet = _Translations$strongSheet$de._(_root);
	@override late final _Translations$bibleDetails$de bibleDetails = _Translations$bibleDetails$de._(_root);
	@override late final _Translations$emptyStates$de emptyStates = _Translations$emptyStates$de._(_root);
	@override late final _Translations$annotationUi$de annotationUi = _Translations$annotationUi$de._(_root);
	@override late final _Translations$notebookUi$de notebookUi = _Translations$notebookUi$de._(_root);
	@override late final _Translations$highlightStyleUi$de highlightStyleUi = _Translations$highlightStyleUi$de._(_root);
	@override late final _Translations$toolbarSettings$de toolbarSettings = _Translations$toolbarSettings$de._(_root);
	@override late final _Translations$themeSettings$de themeSettings = _Translations$themeSettings$de._(_root);
	@override late final _Translations$biblePlans$de biblePlans = _Translations$biblePlans$de._(_root);
	@override late final _Translations$searchUi$de searchUi = _Translations$searchUi$de._(_root);
	@override late final _Translations$onboarding$de onboarding = _Translations$onboarding$de._(_root);
	@override late final _Translations$analyticsNotice$de analyticsNotice = _Translations$analyticsNotice$de._(_root);
	@override late final _Translations$renamedBiblePlansNotice$de renamedBiblePlansNotice = _Translations$renamedBiblePlansNotice$de._(_root);
	@override late final _Translations$tutorials$de tutorials = _Translations$tutorials$de._(_root);
	@override late final _Translations$audio$de audio = _Translations$audio$de._(_root);
	@override late final _Translations$interlinearUi$de interlinearUi = _Translations$interlinearUi$de._(_root);
	@override late final _Translations$chapterUnavailable$de chapterUnavailable = _Translations$chapterUnavailable$de._(_root);
	@override late final _Translations$verseNumbering$de verseNumbering = _Translations$verseNumbering$de._(_root);
	@override late final _Translations$compare$de compare = _Translations$compare$de._(_root);
	@override late final _Translations$commentaryUi$de commentaryUi = _Translations$commentaryUi$de._(_root);
	@override late final _Translations$searchLocations$de searchLocations = _Translations$searchLocations$de._(_root);
	@override late final _Translations$themeOptions$de themeOptions = _Translations$themeOptions$de._(_root);
	@override late final _Translations$toolbarPresets$de toolbarPresets = _Translations$toolbarPresets$de._(_root);
	@override late final _Translations$commentaryTypes$de commentaryTypes = _Translations$commentaryTypes$de._(_root);
	@override late final _Translations$strongDefinition$de strongDefinition = _Translations$strongDefinition$de._(_root);
	@override late final _Translations$planTypes$de planTypes = _Translations$planTypes$de._(_root);
	@override late final _Translations$onboardingSteps$de onboardingSteps = _Translations$onboardingSteps$de._(_root);
	@override late final _Translations$dictionary$de dictionary = _Translations$dictionary$de._(_root);
	@override late final _Translations$articles$de articles = _Translations$articles$de._(_root);
	@override late final _Translations$maps$de maps = _Translations$maps$de._(_root);
	@override late final _Translations$navigation$de navigation = _Translations$navigation$de._(_root);
	@override late final _Translations$bibleSheet$de bibleSheet = _Translations$bibleSheet$de._(_root);
	@override late final _Translations$passageSelection$de passageSelection = _Translations$passageSelection$de._(_root);
	@override late final _Translations$selectionUi$de selectionUi = _Translations$selectionUi$de._(_root);
	@override late final _Translations$errors$de errors = _Translations$errors$de._(_root);
	@override late final _Translations$morphology$de morphology = _Translations$morphology$de._(_root);
	@override late final _Translations$settings$de settings = _Translations$settings$de._(_root);
}

// Path: languages
class _Translations$languages$de extends Translations$languages$en {
	_Translations$languages$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get english => 'Englisch';
	@override String get dutch => 'Niederländisch';
	@override String get greek => 'Griechisch';
	@override String get hebrew => 'Hebräisch';
	@override String get russian => 'Russisch';
	@override String get french => 'Französisch';
	@override String get spanish => 'Spanisch';
	@override String get german => 'Deutsch';
	@override String get romanian => 'Rumänisch';
}

// Path: highlightStyles
class _Translations$highlightStyles$de extends Translations$highlightStyles$en {
	_Translations$highlightStyles$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get red => 'Rot';
	@override String get orange => 'Orange';
	@override String get yellow => 'Gelb';
	@override String get green => 'Grün';
	@override String get blue => 'Blau';
	@override String get violet => 'Violett';
	@override String get underline => 'Unterstreichen';
	@override String get important => 'Wichtig';
	@override String get highlight => 'Markieren';
	@override String get squiggle => 'Wellenlinie';
}

// Path: colors
class _Translations$colors$de extends Translations$colors$en {
	_Translations$colors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get red => 'Rot';
	@override String get orange => 'Orange';
	@override String get yellow => 'Gelb';
	@override String get green => 'Grün';
	@override String get blue => 'Blau';
	@override String get violet => 'Violett';
	@override String get silver => 'Silber';
}

// Path: testaments
class _Translations$testaments$de extends Translations$testaments$en {
	_Translations$testaments$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get old => 'Altes Testament';
	@override String get newTestament => 'Neues Testament';
	@override String get oldOnly => 'Nur Altes Testament';
	@override String get newOnly => 'Nur Neues Testament';
	@override String get wholeBible => 'Ganze Bibel';
	@override String get oldOnlyDescription => 'Enthält nur die Bücher des Alten Testaments.';
	@override String get newOnlyDescription => 'Enthält nur die Bücher des Neuen Testaments.';
	@override String get wholeBibleDescription => 'Enthält alle Bücher der Bibel.';
}

// Path: books
class _Translations$books$de extends Translations$books$en {
	_Translations$books$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get genesis => '1. Mose';
	@override String get exodus => '2. Mose';
	@override String get leviticus => '3. Mose';
	@override String get numbers => '4. Mose';
	@override String get deuteronomy => '5. Mose';
	@override String get joshua => 'Josua';
	@override String get judges => 'Richter';
	@override String get ruth => 'Rut';
	@override String get samuel1 => '1. Samuel';
	@override String get samuel2 => '2. Samuel';
	@override String get kings1 => '1. Könige';
	@override String get kings2 => '2. Könige';
	@override String get chronicles1 => '1. Chronik';
	@override String get chronicles2 => '2. Chronik';
	@override String get ezra => 'Esra';
	@override String get nehemiah => 'Nehemia';
	@override String get esther => 'Ester';
	@override String get job => 'Hiob';
	@override String get psalm => 'Psalm';
	@override String get psalms => 'Psalmen';
	@override String get proverbs => 'Sprüche';
	@override String get ecclesiastes => 'Prediger';
	@override String get songOfSolomon => 'Hoheslied';
	@override String get isaiah => 'Jesaja';
	@override String get jeremiah => 'Jeremia';
	@override String get lamentations => 'Klagelieder';
	@override String get ezekiel => 'Hesekiel';
	@override String get daniel => 'Daniel';
	@override String get hosea => 'Hosea';
	@override String get joel => 'Joel';
	@override String get amos => 'Amos';
	@override String get obadiah => 'Obadja';
	@override String get jonah => 'Jona';
	@override String get micah => 'Micha';
	@override String get nahum => 'Nahum';
	@override String get habakkuk => 'Habakuk';
	@override String get zephaniah => 'Zefanja';
	@override String get haggai => 'Haggai';
	@override String get zechariah => 'Sacharja';
	@override String get malachi => 'Maleachi';
	@override String get matthew => 'Matthäus';
	@override String get mark => 'Markus';
	@override String get luke => 'Lukas';
	@override String get john => 'Johannes';
	@override String get acts => 'Apostelgeschichte';
	@override String get romans => 'Römer';
	@override String get corinthians1 => '1. Korinther';
	@override String get corinthians2 => '2. Korinther';
	@override String get galatians => 'Galater';
	@override String get ephesians => 'Epheser';
	@override String get philippians => 'Philipper';
	@override String get colossians => 'Kolosser';
	@override String get thessalonians1 => '1. Thessalonicher';
	@override String get thessalonians2 => '2. Thessalonicher';
	@override String get timothy1 => '1. Timotheus';
	@override String get timothy2 => '2. Timotheus';
	@override String get titus => 'Titus';
	@override String get philemon => 'Philemon';
	@override String get hebrews => 'Hebräer';
	@override String get james => 'Jakobus';
	@override String get peter1 => '1. Petrus';
	@override String get peter2 => '2. Petrus';
	@override String get john1 => '1. Johannes';
	@override String get john2 => '2. Johannes';
	@override String get john3 => '3. Johannes';
	@override String get jude => 'Judas';
	@override String get revelation => 'Offenbarung';
}

// Path: common
class _Translations$common$de extends Translations$common$en {
	_Translations$common$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get add => 'Hinzufügen';
	@override String get addNew => 'Neu hinzufügen';
	@override String get am => 'AM';
	@override String get cancel => 'Abbrechen';
	@override String get close => 'Schließen';
	@override String get copy => 'Kopieren';
	@override String get continueLabel => 'Weiter';
	@override String get create => 'Erstellen';
	@override String get custom => 'Eigene';
	@override String get defaultLabel => 'Standard';
	@override String get delete => 'Löschen';
	@override String get done => 'Fertig';
	@override String get edit => 'Bearbeiten';
	@override String get finish => 'Abschließen';
	@override String get join => 'Beitreten';
	@override String get learnMore => 'Mehr erfahren';
	@override String get nevermind => 'Doch nicht';
	@override String get next => 'Weiter';
	@override String get noMatches => 'Keine Treffer';
	@override String get noNotification => 'Keine Benachrichtigung';
	@override String get ok => 'OK';
	@override String get off => 'Aus';
	@override String get none => 'Keine';
	@override String get clear => 'Leeren';
	@override String get remove => 'Entfernen';
	@override String get save => 'Speichern';
	@override String get search => 'Suchen';
	@override String get select => 'Auswählen';
	@override String get show => 'Anzeigen';
	@override String get hide => 'Ausblenden';
	@override String get pm => 'PM';
	@override String get sort => 'Sortieren';
	@override String get stop => 'Beenden';
	@override String get tryAgain => 'Erneut versuchen';
	@override String switchTo({required Object translation}) => 'Zu ${translation} wechseln';
	@override String notAvailableIn({required Object translation}) => 'Das ist in ${translation} nicht verfügbar.';
}

// Path: copySheet
class _Translations$copySheet$de extends Translations$copySheet$en {
	_Translations$copySheet$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get preview => 'Vorschau';
	@override String get citation => 'Quellenangabe';
	@override String get citationRequired => 'Bei Online-Übersetzungen ist die Quellenangabe erforderlich.';
	@override String get textIn => 'Text in';
	@override String get includeReference => 'Bibelstelle angeben?';
	@override String get includeTranslation => 'Übersetzung angeben?';
}

// Path: regionTypes
class _Translations$regionTypes$de extends Translations$regionTypes$en {
	_Translations$regionTypes$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get chapter => 'dieses Kapitel';
	@override String get verses => 'diese Verse';
	@override String get visibleVerses => 'die sichtbaren Verse';
	@override String get text => 'diesen Text';
}

// Path: mainActions
class _Translations$mainActions$de extends Translations$mainActions$en {
	_Translations$mainActions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get pauseAudio => 'Hörbibel pausieren';
	@override String get playAudio => 'Hörbibel abspielen';
	@override String get bookmark => 'Lesezeichen';
	@override String get study => 'Studieren';
	@override String get verseOfTheDay => 'Vers des Tages';
	@override String get addStudyPanel => 'Studienpanel hinzufügen';
	@override String get search => 'Suchen';
	@override String get resources => 'Ressourcen';
	@override String get plans => 'Lesepläne';
	@override String get settings => 'Einstellungen';
	@override String get more => 'Mehr';
	@override String get audioDescription => 'Hör dir das aktuelle Kapitel mit einer Bibel mit Audio an.';
	@override String get bookmarkDescription => 'Setze ein Lesezeichen für dieses Kapitel, um es auf der Suchseite schnell wiederzufinden.';
	@override String get manageBookmarkDescription => 'Dieses Lesezeichen verwalten.';
	@override String get studyDescription => 'Studienwerkzeuge für dieses Kapitel anzeigen.';
	@override String get verseOfTheDayDescription => 'Den Vers des Tages anzeigen.';
	@override String get studyPanelDescription => 'Hefte ein Panel neben den Text, das mitläuft und Studienwerkzeuge für das zeigt, was du gerade liest.';
	@override String get searchDescription => 'Suche nach Wörtern in der ganzen Bibel.';
	@override String get resourcesDescription => 'Entdecke Studienressourcen wie Wörterbuch, Lexikon, Personen und Themen.';
	@override String get plansDescription => 'Lies die Bibel mit geführten Leseplänen.';
	@override String get settingsDescription => 'Die Einstellungen von Lux anzeigen.';
	@override String get moreDescription => 'Einstellungen, deine Inhalte und Community-Links anzeigen.';
}

// Path: verseOfTheDay
class _Translations$verseOfTheDay$de extends Translations$verseOfTheDay$en {
	_Translations$verseOfTheDay$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get reminderDiscoveryTitle => 'Tägliche Erinnerung hinzufügen?';
	@override String get reminderDiscoveryBody => 'Möchtest du, dass Lux dich jeden Tag mit dem Vers des Tages benachrichtigt?';
	@override String get addReminder => 'Erinnerung hinzufügen';
	@override String get noReminder => 'Nein';
	@override String get dailyReminders => 'Tägliche Erinnerung';
	@override String get deleteReminder => 'Erinnerung löschen?';
	@override String get deleteReminderConfirmation => 'Möchtest du deine tägliche Erinnerung an den Vers des Tages wirklich löschen?';
	@override String get reminderNotificationChannelName => 'Erinnerungen an den Vers des Tages';
	@override String get reminderNotificationChannelDescription => 'Tägliche Erinnerungen an den Vers des Tages';
	@override String get reminderNotificationTitle => 'Vers des Tages';
	@override String get reminderPermissionDeniedTitle => 'Benachrichtigungen sind aus';
	@override String get reminderPermissionDeniedBody => 'Erlaube Lux in den Einstellungen, Benachrichtigungen zu senden, um diese Erinnerung zu speichern.';
	@override String get openNotificationSettings => 'Einstellungen öffnen';
	@override String get reminderSchedulingFailedTitle => 'Erinnerung konnte nicht geplant werden';
	@override String get reminderSchedulingFailedBody => 'Lux konnte diese Erinnerung nicht planen. Bitte versuche es erneut.';
	@override String reminderSaved({required Object time}) => 'Erinnerung an den Vers des Tages für täglich um ${time} gespeichert.';
}

// Path: studyActions
class _Translations$studyActions$de extends Translations$studyActions$en {
	_Translations$studyActions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get quickStudy => 'Schnellstudium';
	@override String get compare => 'Vergleichen';
	@override String get interlinear => 'Interlinear';
	@override String get commentary => 'Kommentar';
	@override String get crossReferences => 'Querverweise';
	@override String get linkedResources => 'Verknüpfte Ressourcen';
	@override String compareDescription({required Object region}) => 'Vergleiche ${region} in verschiedenen Übersetzungen.';
	@override String interlinearDescription({required Object region}) => 'Zeige eine lexikalische Aufschlüsselung für ${region} mit Strong\'s.';
	@override String commentaryDescription({required Object region}) => 'Zeige Kommentare für ${region}.';
	@override String crossReferencesDescription({required Object region}) => 'Zeige Querverweise für ${region}.';
	@override String linkedResourcesDescription({required Object region}) => 'Zeige verknüpfte Personen, Themen und Karten für ${region}.';
	@override String get noCrossReferences => 'Keine Querverweise gefunden';
	@override String get noLinkedResources => 'Keine verknüpften Ressourcen gefunden';
	@override String crossReferencesUse({required Object translation}) => 'Querverweise aus ${translation}';
	@override String get onlineCrossReferencesExplanation => 'Da deine gewählte Übersetzung nur online verfügbar ist, werden Querverweise mit der zuletzt verwendeten Studienbibel angezeigt, um Leistung und Kosten zu sparen. Überall sonst in der App wird deine gewählte Übersetzung verwendet.';
}

// Path: selectionActions
class _Translations$selectionActions$de extends Translations$selectionActions$en {
	_Translations$selectionActions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get annotate => 'Annotieren';
	@override String get study => 'Studieren';
	@override String get share => 'Teilen';
	@override String get copy => 'Kopieren';
	@override String get highlight => 'Markieren';
	@override String get removeAnnotations => 'Annotationen entfernen';
	@override String get interlinear => 'Interlinear';
	@override String get search => 'Suchen';
	@override String get annotateVersesDescription => 'Diese Verse annotieren.';
	@override String get studyVersesDescription => 'Diese Verse studieren.';
	@override String get shareVersesDescription => 'Einen Link zu diesen Versen teilen.';
	@override String get copyVersesDescription => 'Diese Verse in die Zwischenablage kopieren.';
	@override String get annotateTextDescription => 'Diesen Text annotieren.';
	@override String get interlinearTextDescription => 'Eine lexikalische Aufschlüsselung dieses Textes anzeigen.';
	@override String get searchTextDescription => 'Die Bibel nach diesem Text durchsuchen.';
	@override String get copyTextDescription => 'Diesen Text in die Zwischenablage kopieren.';
	@override String removeTextAnnotationsDescription({required Object region}) => 'Entferne Annotationen der Textauswahl für ${region}.';
	@override String highlightTextDescription({required Object region}) => 'Markiere ${region} mit der zuletzt verwendeten Farbe.';
	@override String removeVerseAnnotationsDescription({required Object region}) => 'Entferne Annotationen der Versauswahl für ${region}.';
	@override String highlightVersesDescription({required Object region}) => 'Markiere ${region} mit der zuletzt verwendeten Farbe.';
	@override String highlightedText({required Object reference}) => 'Text in ${reference} markiert.';
	@override String highlightedVerses({required Object reference}) => '${reference} markiert.';
	@override String copiedVerses({required Object reference}) => '${reference} in die Zwischenablage kopiert.';
	@override String get copiedText => 'Textauswahl in die Zwischenablage kopiert.';
	@override String get interlinearUnavailable => 'Interlinear per Textauswahl ist nur in Studienbibeln verfügbar, die Wort für Wort mit Strong-Nummern und Morphologie ausgezeichnet sind. Wechsle zu einer Studienbibel, um diese Aktion zu nutzen.';
	@override String get noInterlinearWords => 'In dieser Auswahl wurden keine Interlinear-Wörter gefunden.';
	@override String textInReference({required Object reference}) => 'Text in ${reference}';
}

// Path: studyPanels
class _Translations$studyPanels$de extends Translations$studyPanels$en {
	_Translations$studyPanels$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Studienpanel';
	@override String get pinAsStudyPanel => 'Als Studienpanel anheften';
	@override String compareWith({required Object translation}) => 'Mit ${translation} vergleichen';
	@override String directionInterlinear({required Object direction}) => 'Interlinear (${direction})';
	@override String commentaryName({required Object commentary}) => 'Kommentar von ${commentary}';
	@override String get notes => 'Notizen';
	@override String get noNotes => 'Keine Notizen gefunden';
	@override String get notesDescription => 'Zeige deine Notizen in den sichtbaren Versen.';
	@override String get swapBible => 'Bibel wechseln';
	@override String get swapDirection => 'Richtung wechseln';
	@override String get swapCommentary => 'Kommentar wechseln';
}

// Path: bookmarks
class _Translations$bookmarks$de extends Translations$bookmarks$en {
	_Translations$bookmarks$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get create => 'Lesezeichen erstellen';
	@override String get manage => 'Lesezeichen verwalten';
	@override String get stopFollowing => 'Nicht mehr folgen';
	@override String get stopFollowingDescription => 'Dieses Lesezeichen folgt dir nicht mehr.';
	@override String get edit => 'Lesezeichen bearbeiten';
	@override String get delete => 'Lesezeichen löschen';
	@override String get deleteConfirmation => 'Möchtest du dieses Lesezeichen wirklich löschen?';
	@override String deleteNamedConfirmation({required Object name}) => 'Möchtest du „${name}“ wirklich löschen?';
}

// Path: bookmarkPage
class _Translations$bookmarkPage$de extends Translations$bookmarkPage$en {
	_Translations$bookmarkPage$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Deine Lesezeichen';
}

// Path: commentaries
class _Translations$commentaries$de extends Translations$commentaries$en {
	_Translations$commentaries$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get addRemove => 'Kommentare hinzufügen & entfernen';
}

// Path: toolbarShortcuts
class _Translations$toolbarShortcuts$de extends Translations$toolbarShortcuts$en {
	_Translations$toolbarShortcuts$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get switchBible => 'Bibel wechseln';
	@override String get dictionary => 'Wörterbuch';
	@override String get lexicon => 'Lexikon';
	@override String get themeAndLayout => 'Design & Layout';
	@override String get switchBibleDescription => 'Die Bibelübersetzung wechseln.';
	@override String get dictionaryDescription => 'Schlage Personen, Orte und Themen im Tyndale Open Bible Dictionary nach.';
	@override String get lexiconDescription => 'Studiere die hebräischen und griechischen Grundwörter mit dem Strong-Lexikon.';
	@override String get peopleDescription => 'Lies Porträts biblischer Personen.';
	@override String get themesDescription => 'Lies Artikel zu zentralen Themen der Bibel.';
	@override String get mapsDescription => 'Erkunde Karten der Orte und Reisen in der Bibel.';
	@override String get themeAndLayoutDescription => 'Passe Design & Layout der Bibel an.';
}

// Path: labels
class _Translations$labels$de extends Translations$labels$en {
	_Translations$labels$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get about => 'Über';
	@override String get annotation => 'Annotation';
	@override String get annotations => 'Annotationen';
	@override String get audioBible => 'Hörbibel';
	@override String get bible => 'Bibel';
	@override String get bibles => 'Bibeln';
	@override String get biblePlans => 'Lesepläne';
	@override String get bookmarks => 'Lesezeichen';
	@override String get books => 'Bücher';
	@override String get color => 'Farbe';
	@override String get commentaries => 'Kommentare';
	@override String get commentary => 'Kommentar';
	@override String get community => 'Community';
	@override String get completed => 'Abgeschlossen';
	@override String get crossReferences => 'Querverweise';
	@override String get days => 'Tage';
	@override String get dictionary => 'Wörterbuch';
	@override String get discord => 'Discord';
	@override String get duration => 'Dauer';
	@override String get following => 'Folgt';
	@override String get footnotes => 'Fußnoten';
	@override String get help => 'Hilfe';
	@override String get highlightStyles => 'Markierungsstile';
	@override String get instagram => 'Instagram';
	@override String get facebook => 'Facebook';
	@override String get tiktok => 'TikTok';
	@override String get youtube => 'YouTube';
	@override String get interlinear => 'Interlinear';
	@override String get language => 'Sprache';
	@override String get layout => 'Layout';
	@override String get lexicon => 'Lexikon';
	@override String get licenses => 'Lizenzen';
	@override String get locations => 'Bereiche';
	@override String get maps => 'Karten';
	@override String get name => 'Name';
	@override String get note => 'Notiz';
	@override String get notebook => 'Notizbuch';
	@override String get notebooks => 'Notizbücher';
	@override String get notes => 'Notizen';
	@override String get paragraphs => 'Absätze';
	@override String get people => 'Personen';
	@override String get resources => 'Ressourcen';
	@override String get scope => 'Umfang';
	@override String get search => 'Suche';
	@override String get selection => 'Auswahl';
	@override String get settings => 'Einstellungen';
	@override String get source => 'Quelle';
	@override String get study => 'Studium';
	@override String get style => 'Stil';
	@override String get text => 'Text';
	@override String get themes => 'Themen';
	@override String get toolbar => 'Symbolleiste';
	@override String get toolbars => 'Symbolleisten';
	@override String get type => 'Art';
	@override String get version => 'Version';
	@override String get visibility => 'Sichtbarkeit';
}

// Path: strongSheet
class _Translations$strongSheet$de extends Translations$strongSheet$en {
	_Translations$strongSheet$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get interlinearWord => 'Interlinear-Wort';
	@override String get lexicon => 'Lexikon';
	@override String get legend => 'Legende';
	@override String get openInSearch => 'In der Suche öffnen';
	@override String get usage => 'Verwendung';
	@override String get inflected => 'Flektiert';
	@override String get transliteration => 'Transliteration';
	@override String get root => 'Grundform';
	@override String strongsId({required Object id}) => 'Strong\'s ${id}';
	@override String get rootWord => 'Grundwort';
	@override String get pronunciation => 'Aussprache';
	@override String get strongsDefinition => 'Strong-Definition';
	@override String get biblicalUsage => 'Biblischer Gebrauch';
	@override String get definition => 'Definition';
	@override String get examples => 'Beispiele';
	@override String get examplesPrefix => 'Beispiele: ';
	@override String get partOfSpeech => 'Wortart';
	@override String get derivation => 'Herleitung';
	@override String get morphology => 'Morphologie';
	@override String get relatedTerms => 'Verwandte Begriffe';
	@override String get morphologyInfo => 'Morphologie-Info';
	@override String get definitionLegend => 'Legende zur Strong-Definition';
	@override String get optionalWord => 'Optionales Wort';
	@override String get optionalWordDescription => 'Kennzeichnet ein Wort oder eine Silbe, die zum Hauptwort ergänzt werden kann.';
	@override String get addedWord => 'Ergänztes Wort im Hebräischen oder Griechischen';
	@override String get addedWordDescription => 'Kennzeichnet ein Wort, das in der englischen Wiedergabe steht, obwohl es im Hebräischen oder Griechischen fehlt.';
	@override String get explanation => 'Erklärung';
	@override String get renderingExplanation => 'Kursiver Text am Ende einer Wiedergabe erklärt eine Abweichung von der üblichen Form.';
	@override String get concordance => 'Konkordanz';
}

// Path: bibleDetails
class _Translations$bibleDetails$de extends Translations$bibleDetails$en {
	_Translations$bibleDetails$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get onlineOnly => 'Nur online';
	@override String onlineDescription({required Object source}) => 'Diese Bibel wird von ${source} gestreamt und benötigt daher eine Internetverbindung.';
	@override String get studyBible => 'Studienbibel';
	@override String get audioBible => 'Hörbibel';
	@override String get onDevice => 'Auf dem Gerät';
	@override String get onDeviceDescription => 'Diese Bibel ist auf dein Gerät heruntergeladen, sodass du sie durchsuchen und offline lesen kannst.';
	@override String get studyBibleDescription => 'Enthält Interlinear- und Morphologiedaten. Drücke beim Lesen lange auf ein Wort, um das griechische oder hebräische Original zu sehen.';
	@override String get readingBible => 'Lesebibel';
	@override String get readingBibleDescription => 'Enthält keine Interlinear- oder Morphologiedaten.';
	@override String get nativeHeadings => 'Eigene Überschriften';
	@override String get nativeHeadingsDescription => 'Diese Bibel enthält Überschriften.';
	@override String get syntheticHeadings => 'Ergänzte Überschriften';
	@override String get syntheticHeadingsDescription => 'Überschriften werden aus der BSB in diese Bibel eingefügt.';
	@override String get noHeadings => 'Keine Überschriften';
	@override String get noHeadingsDescription => 'Diese Bibel enthält keine Überschriften.';
	@override String get audioSupportDescription => 'Ob diese Bibel eine Hörbibel enthält';
	@override String get redLetters => 'Rote Worte Jesu';
	@override String get redLettersDescription => 'Ob diese Bibel die Worte Jesu in Rot unterstützt.';
	@override String get footnotesDescription => 'Ob diese Bibel Fußnoten enthält.';
	@override String get paragraphsDescription => 'Ob diese Bibel Absätze enthält.';
	@override String get addRemoveBibles => 'Bibeln hinzufügen & entfernen';
	@override String get verseNumbering => 'Verszählung';
}

// Path: emptyStates
class _Translations$emptyStates$de extends Translations$emptyStates$en {
	_Translations$emptyStates$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get noCommentaries => 'Keine Kommentare gefunden';
	@override String get noMatchingWords => 'Keine passenden Wörter';
	@override String get noMatchingTerms => 'Keine passenden Begriffe';
	@override String get noMatchingPlans => 'Keine passenden Lesepläne.';
	@override String get noMatchingAnnotations => 'Keine passenden Annotationen.';
	@override String get noSearchResults => 'Keine Suchergebnisse gefunden';
	@override String get tryAnotherSearch => 'Versuche eine andere Suche';
	@override String get noCommentariesAdded => 'Du hast noch keine Kommentare hinzugefügt.';
	@override String get noAnnotations => 'Du hast noch keine Annotationen erstellt.';
	@override String get noBookmarks => 'Du hast noch keine Lesezeichen erstellt.';
	@override String get noNotebooks => 'Du hast noch keine Notizbücher erstellt. Mit Notizbüchern kannst du deine Annotationen ordnen.';
	@override String get noPlans => 'Du folgst noch keinem Leseplan. Starte einen, um die Bibel durchzulesen.';
}

// Path: annotationUi
class _Translations$annotationUi$de extends Translations$annotationUi$en {
	_Translations$annotationUi$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get yourAnnotations => 'Deine Annotationen';
	@override String get annotate => 'Annotieren';
	@override String get withNotes => 'Mit Notizen';
	@override String get withoutNotes => 'Ohne Notizen';
	@override String get mostRecent => 'Neueste';
	@override String get location => 'Bibelstelle';
	@override String get deleteAnnotation => 'Annotation löschen';
	@override String get deleteConfirmation => 'Möchtest du diese Annotation wirklich löschen?';
	@override String annotationCount({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(count,
		one: '${count} Annotation',
		other: '${count} Annotationen',
	);
	@override String annotatedTime({required Object time}) => 'Annotiert ${time}';
}

// Path: notebookUi
class _Translations$notebookUi$de extends Translations$notebookUi$en {
	_Translations$notebookUi$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get yourNotebooks => 'Deine Notizbücher';
	@override String get hidden => 'Ausgeblendet';
	@override String get hideDescription => 'Die Annotationen in diesem Notizbuch in der Bibel ausblenden.';
	@override String get showDescription => 'Die Annotationen aus diesem Notizbuch in der Bibel anzeigen.';
	@override String get defaultDescription => 'Das feste Notizbuch für nicht zugeordnete Annotationen.';
	@override String get create => 'Notizbuch erstellen';
	@override String get edit => 'Notizbuch bearbeiten';
	@override String get delete => 'Notizbuch löschen';
	@override String deleteNamedConfirmation({required Object name}) => 'Möchtest du „${name}“ wirklich löschen?';
	@override String deleteWithAnnotations({required Object name, required Object annotations}) => '„${name}“ enthält ${annotations}. Möchtest du sie ebenfalls löschen oder im Standard-Notizbuch behalten?';
	@override String get keepInDefault => 'Im Standard behalten';
	@override String get deleteAnnotations => 'Annotationen löschen';
}

// Path: highlightStyleUi
class _Translations$highlightStyleUi$de extends Translations$highlightStyleUi$en {
	_Translations$highlightStyleUi$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get yourStyles => 'Deine Markierungsstile';
	@override String get create => 'Stil erstellen';
	@override String get edit => 'Stil bearbeiten';
	@override String get duplicate => 'Diesen Stil hast du bereits';
	@override String get delete => 'Stil löschen';
	@override String deleteNamedConfirmation({required Object name}) => 'Möchtest du „${name}“ wirklich löschen?';
	@override String deleteWithAnnotations({required Object name, required Object annotations}) => '„${name}“ wird von ${annotations} verwendet. Möchtest du sie ebenfalls löschen oder behalten?';
	@override String get keepAnnotations => 'Annotationen behalten';
	@override String get deleteAnnotations => 'Annotationen löschen';
	@override String get updateAnnotations => 'Annotationen aktualisieren';
	@override String updateWithAnnotations({required Object name, required Object annotations}) => '„${name}“ wird von ${annotations} verwendet. Möchtest du sie auf den neuen Stil aktualisieren oder unverändert lassen?';
	@override String get leaveAsIs => 'Unverändert lassen';
	@override String get label => 'Bezeichnung';
}

// Path: toolbarSettings
class _Translations$toolbarSettings$de extends Translations$toolbarSettings$en {
	_Translations$toolbarSettings$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get mainToolbar => 'Hauptleiste';
	@override String get verseSelection => 'Versauswahl';
	@override String get textSelection => 'Textauswahl';
	@override String get shownForMain => 'Wird angezeigt, wenn nichts ausgewählt ist.';
	@override String get shownForVerses => 'Wird angezeigt, wenn ein Vers ausgewählt ist.';
	@override String get shownForText => 'Wird angezeigt, wenn du lange auf Text in Versen drückst.';
	@override String get gestures => 'Gesten';
	@override String get longPress => 'Langes Drücken';
	@override String get mainLongPressDescription => 'Kurzbefehl, wenn lange auf die Symbolleiste gedrückt wird.';
	@override String get verseLongPressDescription => 'Kurzbefehl, wenn lange auf eine Versauswahl gedrückt wird.';
	@override String get textLongPressDescription => 'Kurzbefehl, wenn lange auf eine Textauswahl gedrückt wird.';
	@override String get hideToolbar => 'Ausblenden';
	@override String get hideToolbarDescription => 'Blende die Symbolleiste beim Herunterscrollen aus, um ungestört in der Bibel zu lesen.';
	@override String get pinToolbar => 'Anheften';
	@override String get pinToolbarDescription => 'Hefte die Symbolleiste unten auf der Seite an.';
	@override String get expandToAnnotation => 'Auf Annotation erweitern';
	@override String get expandTextDescription => 'Langes Drücken auf ein annotiertes Wort wählt den ganzen markierten Bereich aus.';
	@override String get expandVerseDescription => 'Tippen auf einen Vers wählt die ganze annotierte Versauswahl aus.';
	@override String get rangeSelection => 'Bereichsauswahl';
	@override String get rangeSelectionDescription => 'Tippen auf einen zweiten Vers wählt alle Verse zwischen ihm und dem ersten aus.';
	@override String get mainShortcut => 'Kurzbefehl der Hauptleiste';
	@override String get verseShortcut => 'Kurzbefehl der Versauswahl';
	@override String get textShortcut => 'Kurzbefehl der Textauswahl';
}

// Path: themeSettings
class _Translations$themeSettings$de extends Translations$themeSettings$en {
	_Translations$themeSettings$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Design & Layout';
	@override String get brightness => 'Helligkeit';
	@override String get font => 'Schriftart';
	@override String get fontSizeSpacing => 'Schriftgröße & Abstand';
	@override String get greekFontSizeSpacing => 'Griechisch: Schriftgröße & Abstand';
	@override String get hebrewFontSizeSpacing => 'Hebräisch: Schriftgröße & Abstand';
	@override String get system => 'System';
	@override String get systemTextSizeDescription => 'Die bevorzugte Textgröße deines Geräts verwenden.';
	@override String get defaultSizeDescription => 'Die Standardwerte für Schriftgröße & Abstand verwenden.';
	@override String get redLetters => 'Rote Worte Jesu';
	@override String get redLettersDescription => 'Die Worte Jesu in Rot anzeigen.';
	@override String get sectionHeadings => 'Zwischenüberschriften';
	@override String get verseNumbers => 'Versnummern';
	@override String get paragraphsDescription => 'Verse in Absätzen darstellen.';
	@override String get footnotesDescription => 'Fußnotenzeichen im Text anzeigen.';
}

// Path: biblePlans
class _Translations$biblePlans$de extends Translations$biblePlans$en {
	_Translations$biblePlans$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get startABiblePlan => 'Leseplan starten';
	@override String get includedPlans => 'Enthaltene Pläne';
	@override String get includedPlansDescription => 'Pläne, die in Lux enthalten sind.';
	@override String get customPlansDescription => 'Pläne, die du erstellt hast.';
	@override String get createCustomPlan => 'Eigenen Plan erstellen';
	@override String get creationMethodQuestion => 'Wie möchtest du deinen Plan erstellen?';
	@override String get createWithAi => 'Mit KI erstellen';
	@override String get createWithAiDescription => 'Erhalte einen Prompt für deine eigene KI und importiere dann den Plan, den sie erstellt.';
	@override String get describeYourPlan => 'Beschreibe deinen Plan';
	@override String get planDescription => 'Planbeschreibung';
	@override String get describeYourPlanHint => 'Beschreibe deinen Plan';
	@override String get descriptionRequired => 'Beschreibe den Plan, den du erstellen möchtest.';
	@override String get examples => 'Beispiele';
	@override String get aiExamples => 'Planbeispiele';
	@override List<String> get aiExampleList => [
		'Lies den Römerbrief in 30 Tagen.',
		'Lies das Neue Testament in einem Monat.',
		'Lies Psalmen und Sprüche in 90 Tagen, mit einem Tag zum Nachdenken pro Woche.',
		'Lies die vier Evangelien in 60 Tagen und wechsle jeden Tag zwischen ihnen.',
		'Wechsle jeden Tag zwischen Lesungen aus dem Alten und dem Neuen Testament. Jeder Sonntag ist ein Tag zum Nachdenken. Lies die ganze Bibel in einem Jahr.',
	];
	@override String get aiImportTitle => 'Mit KI erstellen & importieren';
	@override String get aiImportInstructions => 'Kopiere den Prompt in die KI, die du nutzt, und importiere dann den Plan, den sie erstellt.';
	@override String get copyPrompt => 'Prompt kopieren';
	@override String get promptCopied => 'Prompt in die Zwischenablage kopiert.';
	@override String get importAction => 'Importieren';
	@override String get importDescription => 'Einen Leseplan importieren.';
	@override String get importPlan => 'Leseplan importieren';
	@override String get importPlanTitle => 'Plan importieren';
	@override String get importInstructions => 'Importiere eine von Lux exportierte Leseplan-Datei oder füge kompatible Planinhalte ein.';
	@override String get importOptionsHintPrefix => 'Importiere eine ';
	@override String get importOptionsHintSuffix => '-Datei oder füge ihren Inhalt ein.';
	@override String get aiImportOptionsHintPrefix => 'Lux kann eine ';
	@override String get aiImportOptionsHintSuffix => '-Datei oder eingefügte Dateiinhalte importieren, je nachdem, was deine KI liefert.';
	@override String get importSource => 'Wie möchtest du den Plan importieren?';
	@override String get importFromFile => 'Aus Datei importieren';
	@override String get importFromFileDescription => 'Wähle eine heruntergeladene .lxbp-Datei.';
	@override String get pasteToImport => 'Zum Importieren einfügen';
	@override String get pasteToImportDescription => 'Füge den Inhalt einer .lxbp-Datei oder eines kompatiblen Plans ein.';
	@override String get pastePlan => 'Leseplan einfügen';
	@override String get fileContents => 'Dateiinhalt';
	@override String get fileContentsHint => 'Füge den Dateiinhalt hier ein';
	@override String get biblePlanFile => 'Lux-Leseplan';
	@override String importSucceeded({required Object name}) => '„${name}“ ist bereit zum Importieren.';
	@override String get share => 'Teilen';
	@override String get shareDescription => 'Diese Leseplan-Datei mit einer anderen App oder Person teilen.';
	@override String get download => 'Herunterladen';
	@override String get downloadDescription => 'Diese Leseplan-Datei auf deinem Gerät speichern.';
	@override late final _Translations$biblePlans$importErrors$de importErrors = _Translations$biblePlans$importErrors$de._(_root);
	@override String get manual => 'Manuell';
	@override String get manualDescription => 'Füge jeden Abschnitt selbst hinzu.';
	@override String get chooseBooksAndDuration => 'Bücher & Dauer wählen';
	@override String get chooseBooksAndDurationDescription => 'Lies Bücher über einen festgelegten Zeitraum.';
	@override String get chooseBooks => 'Bücher wählen';
	@override String get filterBooks => 'Bücher filtern';
	@override String get chooseDuration => 'Dauer wählen';
	@override String get durationInstructions => 'Wie viele Tage soll dein Plan dauern?';
	@override String durationDayCount({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(count,
		one: '${count} Tag',
		other: '${count} Tage',
	);
	@override late final _Translations$biblePlans$generatedNames$de generatedNames = _Translations$biblePlans$generatedNames$de._(_root);
	@override String get nameAndColor => 'Name & Farbe';
	@override String get review => 'Plan prüfen';
	@override String get createAndStart => 'Erstellen & starten';
	@override String get myBiblePlan => 'Mein Leseplan';
	@override String get nameRequired => 'Gib einen Namen für deinen Plan ein.';
	@override String get nameAlreadyExists => 'Ein Leseplan mit diesem Namen existiert bereits.';
	@override String get discardPlanQuestion => 'Änderungen verwerfen?';
	@override String get discardPlanConfirmation => 'Deine Änderungen gehen verloren.';
	@override String get discard => 'Verwerfen';
	@override String get addDay => 'Tag hinzufügen';
	@override String get addPassage => 'Abschnitt hinzufügen';
	@override String get removeDay => 'Tag entfernen';
	@override String get removeDayQuestion => 'Diesen Tag entfernen?';
	@override String removeDayConfirmation({required Object day}) => 'Tag ${day} und seine Abschnitte werden entfernt.';
	@override String get moveToAnotherDay => 'Auf einen anderen Tag verschieben';
	@override String get deletePlan => 'Plan löschen';
	@override String get deletePlanQuestion => 'Diesen Plan löschen?';
	@override String deletePlanConfirmation({required Object name}) => 'Möchtest du „${name}“ wirklich löschen?';
	@override String get mixed => 'Gemischt';
	@override String get mixedScopeDescription => 'Liest ausgewählte Bücher aus beiden Testamenten.';
	@override String get startPlanQuestion => 'Plan starten?';
	@override String get reviewAndReflect => 'Wiederholen & nachdenken';
	@override String get startPlan => 'Plan starten';
	@override String get dailyReminders => 'Tägliche Erinnerungen';
	@override String get dailyRemindersDescription => 'Lege fest, wann dich dieser Plan täglich ans Lesen erinnert.';
	@override String dailyAt({required Object time}) => 'Täglich um ${time}';
	@override String get reminderDiscoveryTitle => 'Tägliche Erinnerung hinzufügen?';
	@override String reminderDiscoveryBody({required Object name}) => 'Möchtest du, dass Lux dich jeden Tag daran erinnert, „${name}“ weiterzulesen?';
	@override String get addReminder => 'Erinnerung hinzufügen';
	@override String get noReminder => 'Nein';
	@override String get deleteReminder => 'Erinnerung löschen?';
	@override String deleteReminderConfirmation({required Object name}) => 'Möchtest du die tägliche Erinnerung für „${name}“ wirklich löschen?';
	@override String get reminderNotificationChannelName => 'Erinnerungen an Lesepläne';
	@override String get reminderNotificationChannelDescription => 'Tägliche Erinnerungen an deine Lesepläne';
	@override String reminderNotificationTitle({required Object name}) => '„${name}“ lesen';
	@override String reminderNotificationBody({required Object reading}) => 'Die heutige Lesung ist ${reading}';
	@override String get reminderPermissionDeniedTitle => 'Benachrichtigungen sind aus';
	@override String get reminderPermissionDeniedBody => 'Erlaube Lux in den Einstellungen, Benachrichtigungen zu senden, um diese Erinnerung zu speichern.';
	@override String get openNotificationSettings => 'Einstellungen öffnen';
	@override String get reminderSchedulingFailedTitle => 'Erinnerung konnte nicht geplant werden';
	@override String get reminderSchedulingFailedBody => 'Lux konnte diese Erinnerung nicht planen. Bitte versuche es erneut.';
	@override String reminderSaved({required Object name, required Object time}) => 'Erinnerung für „${name}“ täglich um ${time} gespeichert.';
	@override String get stopPlan => 'Plan beenden';
	@override String get stopPlanDescription => 'Diesen Plan und seinen Fortschritt in den Verlauf verschieben.';
	@override String get readEntireChapter => 'Ganzes Kapitel lesen';
	@override String get pace => 'Tempo';
	@override String get choosePace => 'Wähle dein Tempo';
	@override String get relaxed => 'Entspannt';
	@override String get relaxedDescription => 'Lies, wann immer du möchtest, ohne Zeitplan, mit dem du Schritt halten musst.';
	@override String get paced => 'Mit Zeitplan';
	@override String get pacedDescription => 'Lege ein Zielenddatum fest und sieh, ob du im Plan liegst.';
	@override String pacedToEnd({required Object date}) => 'Ziel: Ende am ${date}';
	@override String get targetEndDate => 'Zielenddatum';
	@override String get onTrack => 'Im Plan';
	@override String daysBehind({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(count,
		one: '${count} Tag im Rückstand',
		other: '${count} Tage im Rückstand',
	);
	@override String daysAhead({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(count,
		one: '${count} Tag voraus',
		other: '${count} Tage voraus',
	);
	@override String get catchUp => 'Aufholen';
	@override String get reviewDayAnnotations => 'Annotationen des Tages ansehen';
	@override String get history => 'Verlauf';
	@override String get historyDescription => 'Früheren Fortschritt ansehen oder einen beendeten Plan fortsetzen.';
	@override String get resume => 'Fortsetzen';
	@override String get resumeDescription => 'Diesen Plan dort fortsetzen, wo du aufgehört hast.';
	@override String get replace => 'Ersetzen';
	@override String get replacePlanQuestion => 'Aktuellen Plan ersetzen?';
	@override String replacePlanConfirmation({required Object name}) => 'Du folgst bereits „${name}“. Wenn du diesen Plan fortsetzt, wird dein aktueller Fortschritt in den Verlauf dieses Plans verschoben.';
	@override String get viewAllAnnotations => 'Alle Annotationen des Plans ansehen';
	@override String get viewAllAnnotationsDescription => 'Sieh dir jede Annotation an, die du beim Lesen dieses Plans erstellt hast.';
	@override String stoppedOn({required Object date}) => 'Beendet am ${date}';
	@override String finishedOn({required Object date}) => 'Abgeschlossen am ${date}';
	@override String get deleteFromHistoryDescription => 'Diesen Fortschritt aus dem Verlauf entfernen.';
	@override String get deleteFromHistoryQuestion => 'Aus dem Verlauf löschen?';
	@override String deleteFromHistoryConfirmation({required Object name}) => 'Dieser Fortschritt bei „${name}“ wird gelöscht. Seine Annotationen bleiben unter Annotationen erhalten.';
	@override String deletePlanWithHistoryConfirmation({required Object name}) => 'Möchtest du „${name}“ wirklich löschen? Der Verlauf des Plans wird ebenfalls gelöscht.';
	@override String get readInContext => 'Im Zusammenhang lesen';
	@override String get startNew => 'Neu starten';
	@override String day({required Object day}) => 'Tag ${day}';
	@override String dayCount({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(count,
		one: '${count} Tag',
		other: '${count} Tage',
	);
	@override String stopConfirmation({required Object name}) => '„${name}“ beenden? Du kannst den Plan später über den Verlauf dieses Plans unter „Leseplan starten“ fortsetzen.';
	@override String completed({required Object name}) => '„${name}“ abgeschlossen.';
	@override String get addPlan => 'Leseplan hinzufügen';
}

// Path: searchUi
class _Translations$searchUi$de extends Translations$searchUi$en {
	_Translations$searchUi$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get searchBible => 'Bibel durchsuchen';
	@override String get startSearch => 'Starte eine Suche';
	@override String get searchPrompt => 'Gib ein Stichwort wie Licht, Wort oder Weisheit ein und drücke dann auf der Tastatur Enter.';
	@override String usingTranslation({required Object translation}) => 'Suche in ${translation}';
	@override String unsupportedTranslation({required Object translation}) => '${translation} unterstützt die Suche derzeit nicht. Stattdessen wird deine zuletzt verwendete Studienbibel genutzt.';
	@override String get strongSearchStudyBibleExplanation => 'Die Suche nach Strong-Nummern benötigt die Strong-Auszeichnung auf Wortebene, die Studienbibeln enthalten. Stattdessen wird deine zuletzt verwendete Studienbibel genutzt.';
	@override String get wordOrPhraseHint => 'Nach einem Wort oder Ausdruck suchen';
	@override String get wordHint => 'Nach einem Wort suchen';
	@override String get strongNumberHint => 'Nach einer Strong-Nummer suchen (z. B. H125)';
	@override late final _Translations$searchUi$wordMatching$de wordMatching = _Translations$searchUi$wordMatching$de._(_root);
}

// Path: onboarding
class _Translations$onboarding$de extends Translations$onboarding$en {
	_Translations$onboarding$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get skipQuestion => 'Einführung überspringen?';
	@override String get skipConfirmation => 'Möchtest du die Einführung wirklich überspringen? Du kannst sie unter Einstellungen > Hilfe erneut starten.';
	@override String get getStarted => 'Erste Schritte';
	@override String get learnLux => 'Lerne Lux kennen';
	@override String get checklistDescription => 'Arbeite die Checkliste unten ab, um Lux kennenzulernen.';
	@override String get skipHint => 'Keine Zeit? Tippe auf ✕, um zu überspringen.';
	@override String get joinDiscord => 'Tritt unserer Discord-Community bei';
	@override String get discordInvitation => 'Stell Fragen, gib Feedback und vernetze dich mit anderen, die Lux nutzen.';
}

// Path: analyticsNotice
class _Translations$analyticsNotice$de extends Translations$analyticsNotice$en {
	_Translations$analyticsNotice$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ein Hinweis zu anonymen Analysen';
	@override String get description => 'Lux verwendet jetzt anonyme Analysen und Absturzberichte, um zu verstehen, welche Funktionen genutzt werden, und die Zuverlässigkeit zu verbessern.\n\nDiese Berichte enthalten niemals deine Notizen, Namen von Leseplänen oder Lesedetails, Suchbegriffe oder andere private Inhalte und sind nicht mit einem Konto verknüpft.\n\nWenn du Lux weiter nutzt, stimmst du der Übermittlung dieser Informationen zu.';
}

// Path: renamedBiblePlansNotice
class _Translations$renamedBiblePlansNotice$de extends Translations$renamedBiblePlansNotice$en {
	_Translations$renamedBiblePlansNotice$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Lesepläne wurden aktualisiert';
	@override String get description => 'Um Genauigkeit und Benennung der Lesepläne zu verbessern, wurden einige deiner Lesepläne umbenannt.';
}

// Path: tutorials
class _Translations$tutorials$de extends Translations$tutorials$en {
	_Translations$tutorials$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get dontShowAgain => 'Nicht mehr anzeigen';
}

// Path: audio
class _Translations$audio$de extends Translations$audio$en {
	_Translations$audio$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get timer => 'Audio-Timer';
	@override String get fiveMinutes => '5 Minuten';
	@override String get tenMinutes => '10 Minuten';
	@override String get fifteenMinutes => '15 Minuten';
	@override String get thirtyMinutes => '30 Minuten';
	@override String get oneHour => '1 Stunde';
	@override String get loadError => 'Das Audio konnte nicht geladen werden';
	@override String get connectionError => 'Prüfe deine Internetverbindung oder versuche es später erneut.';
	@override String get initializationError => 'Ein Fehler ist aufgetreten';
	@override String get initializationErrorDescription => 'Beim Einrichten des Audios für dieses Gerät ist ein Fehler aufgetreten. Versuche, die App vollständig zu schließen und neu zu öffnen.';
	@override String get unavailable => 'Für diese Bibel ist kein Audio verfügbar';
	@override String get chooseBible => 'Wähle eine Bibel mit Audio, um dir dieses Kapitel anzuhören.';
	@override String get switchRequired => 'Wechsle zu einer Bibel mit Audio, um dir diesen Abschnitt anzuhören.';
	@override String get rewindTenSeconds => '10 Sekunden zurück';
	@override String get fastForwardTenSeconds => '10 Sekunden vor';
	@override String get notificationChannelName => 'Wiedergabe der Hörbibel';
	@override String get notificationChannelDescription => 'Steuerung für die Wiedergabe der Hörbibel';
}

// Path: interlinearUi
class _Translations$interlinearUi$de extends Translations$interlinearUi$en {
	_Translations$interlinearUi$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get interlinearBible => 'Interlinearbibel';
	@override String get direction => 'Interlinear-Richtung';
	@override String get reverse => 'Umgekehrt';
	@override String get forward => 'Vorwärts';
	@override String get reverseDescription => 'Die Wörter erscheinen in englischer Lesereihenfolge.';
	@override String get forwardDescription => 'Die Wörter erscheinen in der ursprünglichen hebräischen oder griechischen Reihenfolge.';
	@override String get studyBibleExplanation => 'Studienbibeln sind Wort für Wort mit Strong-Nummern und Morphologie ausgezeichnet. Erst das macht die lexikalische Aufschlüsselung im Interlinear möglich. Stattdessen wird deine zuletzt verwendete Studienbibel genutzt.';
	@override String usingTranslation({required Object translation}) => 'Interlinear mit ${translation}';
}

// Path: chapterUnavailable
class _Translations$chapterUnavailable$de extends Translations$chapterUnavailable$en {
	_Translations$chapterUnavailable$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object selectedTranslation, required Object testament}) => '${selectedTranslation} enthält kein ${testament}.';
	@override String subtitle({required Object testament, required Object fallbackTranslation}) => 'Stattdessen wird deine zuletzt verwendete Bibel für diesen Teil (${testament}) angezeigt: ${fallbackTranslation}.';
}

// Path: verseNumbering
class _Translations$verseNumbering$de extends Translations$verseNumbering$en {
	_Translations$verseNumbering$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String referenceLabel({required Object translation, required Object reference}) => '${translation} ${reference}';
	@override String explanation({required Object translation, required Object reference, required Object originalReference}) => '${translation} zählt Kapitel und Verse anders als die meisten englischen Übersetzungen.\n\nDer hier bei ${reference} angezeigte Text stammt aus ${originalReference} in ${translation} und wurde so zugeordnet, dass er zu den anderen Übersetzungen passt.';
}

// Path: compare
class _Translations$compare$de extends Translations$compare$en {
	_Translations$compare$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String unavailable({required Object translation}) => '${translation} enthält diese Auswahl nicht.';
}

// Path: commentaryUi
class _Translations$commentaryUi$de extends Translations$commentaryUi$en {
	_Translations$commentaryUi$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String atAGlance({required Object book}) => '${book} auf einen Blick';
	@override String introTo({required Object book}) => 'Einleitung zu ${book}';
	@override String get chapterOutline => 'Kapitelübersicht';
	@override String get previousSection => 'Vorheriger Abschnitt';
	@override String get nextSection => 'Nächster Abschnitt';
}

// Path: searchLocations
class _Translations$searchLocations$de extends Translations$searchLocations$en {
	_Translations$searchLocations$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get currentBook => 'Aktuelles Buch';
	@override String get testaments => 'Testamente';
	@override String get books => 'Bücher';
}

// Path: themeOptions
class _Translations$themeOptions$de extends Translations$themeOptions$en {
	_Translations$themeOptions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get auto => 'Automatisch';
	@override String get light => 'Hell';
	@override String get dark => 'Dunkel';
	@override String get extraTiny => 'Extrem klein';
	@override String get tiny => 'Sehr klein';
	@override String get small => 'Klein';
	@override String get standard => 'Standard';
	@override String get large => 'Groß';
	@override String get huge => 'Sehr groß';
	@override String get extraHuge => 'Extrem groß';
	@override String get nativeAndSynthetic => 'Eigene & ergänzte';
	@override String get native => 'Eigene';
	@override String get none => 'Keine';
	@override String get allHeadingsDescription => 'Überschriften in Übersetzungen anzeigen, die sie enthalten, und die Zwischenüberschriften der BSB in englische Übersetzungen ohne eigene Überschriften einfügen.';
	@override String get nativeHeadingsDescription => 'Überschriften in Übersetzungen anzeigen, die sie enthalten.';
	@override String get noHeadingsDescription => 'Keine Zwischenüberschriften anzeigen';
}

// Path: toolbarPresets
class _Translations$toolbarPresets$de extends Translations$toolbarPresets$en {
	_Translations$toolbarPresets$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get reader => 'Leser';
	@override String get noteTaker => 'Notizenschreiber';
	@override String get studier => 'Bibelstudent';
	@override String get readerDescription => 'Abgestimmt auf ungestörtes Lesen und schnelle Navigation.';
	@override String get noteTakerDescription => 'Abgestimmt auf Markieren und Notizen.';
	@override String get studierDescription => 'Abgestimmt auf Querverweise, Kommentare und tiefes Studium.';
}

// Path: commentaryTypes
class _Translations$commentaryTypes$de extends Translations$commentaryTypes$en {
	_Translations$commentaryTypes$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get tyndaleDescription => 'Vers-für-Vers-Studienanmerkungen zur ganzen Bibel, verfasst für die New Living Translation (NLT). Klar, fundiert und praxisnah.';
	@override String get matthewHenryDescription => 'Ein knapper, erbaulicher Kommentar zur ganzen Bibel aus der puritanischen Tradition. Warmherzig, praktisch und leicht zu lesen.';
	@override String get jamiesonFaussetBrownDescription => 'Ein kompakter Vers-für-Vers-Kommentar zur ganzen Bibel. Ausgewogen und zugänglich.';
	@override String get calvinDescription => 'Die klassische Auslegung des Reformators. Tiefgründig und lehrmäßig.';
}

// Path: strongDefinition
class _Translations$strongDefinition$de extends Translations$strongDefinition$en {
	_Translations$strongDefinition$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get addedLabel => 'ergänzt:';
	@override String get idiomLabel => 'Idiom:';
	@override String get addedWord => 'Ergänztes Wort';
	@override String get idiomaticRendering => 'Idiomatische Wiedergabe';
	@override String get addedWordDescription => 'Kennzeichnet ein Wort, das neben dem definierten hebräischen oder griechischen Wort ergänzt wird.';
	@override String get idiomaticRenderingDescription => 'Kennzeichnet eine Wiedergabe, die eine typisch hebräische oder griechische Redewendung widerspiegelt.';
}

// Path: planTypes
class _Translations$planTypes$de extends Translations$planTypes$en {
	_Translations$planTypes$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get throughTheBible => 'Durch die Bibel';
	@override String get chronological => 'Chronologisch in einem Jahr';
	@override String get oldAndNewTestament => 'Altes und Neues Testament';
	@override String get historicallyBlended => 'Historisch verflochten';
	@override String get everyDayInTheWord => 'Jeden Tag im Wort';
	@override String get mcheyne => 'M\'Cheyne';
	@override String get literaryStudy => 'Literarisches Studium';
	@override String get differentTopics => 'Verschiedene Themen';
	@override String get newTestamentPsalmsProverbs => 'Neues Testament, Psalmen & Sprüche';
	@override String get fiveByFiveByFive => '5x5x5 Neues Testament';
	@override String get gospelsAndEpistles => 'Evangelien und Briefe';
	@override String get pentateuchAndHistory => 'Pentateuch und Geschichte Israels';
	@override String get chroniclesAndProphets => 'Chronik und Propheten';
	@override String get psalmsAndWisdom => 'Psalmen und Weisheitsliteratur';
	@override String get mcheyneDescription => 'Ein klassischer Plan mit vier kurzen Lesungen am Tag. In einem Jahr liest du das Alte Testament einmal und das Neue Testament und die Psalmen zweimal.';
	@override String get chronologicalDescription => 'Lies die ganze Bibel in einem Jahr, geordnet nach der Reihenfolge, in der die Ereignisse tatsächlich geschahen.';
	@override String get throughTheBibleDescription => 'Lies die ganze Bibel in einem Jahr von vorne bis hinten, von 1. Mose bis Offenbarung.';
	@override String get gospelsAndEpistlesDescription => 'Verbringe das Jahr im Neuen Testament mit den Evangelien und den Briefen der Apostel.';
	@override String get everyDayInTheWordDescription => 'Vier Lesungen am Tag aus dem Alten Testament, dem Neuen Testament, den Psalmen und den Sprüchen. Die ganze Bibel in einem Jahr, Psalmen & Sprüche zweimal.';
	@override String get literaryStudyDescription => 'Erlebe die Bibel in einem Jahr nach literarischen Gattungen geordnet, von Erzählungen über Poesie bis zu Briefen.';
	@override String get chroniclesAndProphetsDescription => 'Ein Jahr, das die Geschichte der Chronikbücher mit den Botschaften der Propheten verbindet.';
	@override String get pentateuchAndHistoryDescription => 'Geh in einem Jahr durch die fünf Bücher Mose und die Geschichte Israels.';
	@override String get psalmsAndWisdomDescription => 'Verbringe das Jahr in den Psalmen und Weisheitsbüchern wie Sprüche, Hiob und Prediger.';
	@override String get oldAndNewTestamentDescription => 'Lies die ganze Bibel in einem Jahr und folge dabei dem Alten und Neuen Testament gemeinsam in kanonischer Reihenfolge.';
	@override String get historicallyBlendedDescription => 'Lies die ganze Bibel in einem Jahr, mit Büchern und Abschnitten, die um zusammenhängende Ereignisse und Epochen angeordnet sind.';
	@override String get differentTopicsDescription => 'Lies jeden Tag einen anderen Teil der Schrift und entdecke in einem Jahr jedes Buch der Bibel.';
	@override String get newTestamentPsalmsProverbsDescription => 'Lies im Laufe eines Jahres das Neue Testament zusammen mit Psalmen und Sprüchen.';
	@override String get fiveByFiveByFiveDescription => 'Lies an fünf Tagen pro Woche ein Kapitel aus dem Neuen Testament, gefolgt von zwei Tagen zum Wiederholen und Nachdenken.';
	@override String get oldScopeDescription => 'Liest Bücher aus dem Alten Testament.';
	@override String get newScopeDescription => 'Liest Bücher aus dem Neuen Testament.';
	@override String get wholeScopeDescription => 'Liest jedes Buch des Alten und Neuen Testaments.';
	@override String get focused => 'Fokussiert';
	@override String get comprehensive => 'Vollständig';
	@override String get focusedDescription => 'Deckt einen bestimmten Teil oder eine Sammlung innerhalb seines Umfangs ab.';
	@override String get comprehensiveDescription => 'Deckt jedes Buch innerhalb seines Umfangs ab.';
}

// Path: onboardingSteps
class _Translations$onboardingSteps$de extends Translations$onboardingSteps$en {
	_Translations$onboardingSteps$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get viewCrossReferences => 'Querverweise ansehen';
	@override String get annotateVerse => 'Einen Vers annotieren';
	@override String get searchWord => 'Nach einem Wort suchen';
	@override String get switchBible => 'Bibel wechseln';
	@override String get navigateChapter => 'Zu einem anderen Kapitel gehen';
	@override String get goBack => 'Zurückgehen';
	@override String get swipeChapter => 'Wischen, um das Kapitel zu wechseln';
	@override String get addStudyPanel => 'Ein Studienpanel hinzufügen';
	@override String get customizeToolbar => 'Symbolleisten anpassen';
	@override String get startBiblePlan => 'Einen Leseplan starten';
	@override String get selectVerse => 'Tippe auf einen Vers, um ihn auszuwählen';
	@override String get selectWord => 'Drücke lange auf ein Wort';
	@override String get deselectPrefix => 'Tippe auf ';
	@override String get deselectSuffix => ' neben deiner Auswahl, um sie aufzuheben';
	@override String get revealToolbar => 'Scrolle nach oben, um die Hauptleiste einzublenden';
	@override String get addPanelPrefix => 'Tippe auf ';
	@override String get addPanelSuffix => ' → Studieren → Studienpanel hinzufügen und füge ein beliebiges Studienpanel hinzu';
	@override String get goToChapter => 'Zu einem anderen Kapitel gehen';
	@override String get openPrefix => 'Öffne ';
	@override String get crossReferencesSuffix => ' → Studieren → Querverweise';
	@override String get annotatePrefix => 'Tippe auf ';
	@override String get annotateSuffix => ', um zu markieren oder eine Notiz hinzuzufügen';
	@override String get searchPrefix => 'Tippe auf ';
	@override String get searchSuffix => ', um das Wort überall nachzuschlagen';
	@override String switchBibleDescription({required Object translation}) => 'Tippe auf die Hauptleiste → ${translation}, um die Bibel zu wechseln';
	@override String get goToChapterDescription => 'Tippe auf die Hauptleiste, um zu einem anderen Kapitel zu gehen';
	@override String get goBackDescription => 'Wische auf der Symbolleiste nach rechts, um zurückzugehen';
	@override String get swipeChapterDescription => 'Wische die Bibel nach links oder rechts, um das Kapitel zu wechseln';
	@override String get viewPanelDescription => 'Wische dieses Panel nach rechts, um dein Studienpanel zu sehen';
	@override String get moreSeparator => ' → Mehr → ';
	@override String get customizeToolbarSuffix => 'Symbolleisten und wähle eine Vorlage oder ändere deine Kurzbefehle';
	@override String get startPlanSuffix => ' → Lesepläne und starte einen beliebigen Leseplan';
}

// Path: dictionary
class _Translations$dictionary$de extends Translations$dictionary$en {
	_Translations$dictionary$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get tyndale => 'Tyndale Open Bible Dictionary';
}

// Path: articles
class _Translations$articles$de extends Translations$articles$en {
	_Translations$articles$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get personHint => 'Nach einer Person suchen';
	@override String get themeHint => 'Nach einem Thema suchen';
	@override String get noMatchingPeople => 'Keine passenden Personen';
	@override String get noMatchingThemes => 'Keine passenden Themen';
	@override String get passagesForFurtherStudy => 'Stellen zum Weiterstudieren';
	@override String get relatedDictionaryEntry => 'Der vollständige Eintrag im Bibelwörterbuch, mit mehr Hintergrund und Details';
	@override String get relatedProfile => 'Ein kürzeres Profil aus den Tyndale Study Notes, mit Stellen zum Weiterstudieren';
	@override String get relatedTheme => 'Ein kürzerer Artikel aus den Tyndale Study Notes, mit Stellen zum Weiterstudieren';
}

// Path: maps
class _Translations$maps$de extends Translations$maps$en {
	_Translations$maps$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get searchHint => 'Nach einer Karte suchen';
	@override String get noMatchingMaps => 'Keine passenden Karten';
}

// Path: navigation
class _Translations$navigation$de extends Translations$navigation$en {
	_Translations$navigation$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get recents => 'Zuletzt';
	@override String get navigate => 'Navigieren';
	@override String get book => 'Buch';
	@override String get chapter => 'Kapitel';
	@override String get verse => 'Vers';
}

// Path: bibleSheet
class _Translations$bibleSheet$de extends Translations$bibleSheet$en {
	_Translations$bibleSheet$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get allBibles => 'Alle Bibeln';
	@override String availableCount({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(count,
		one: '${count} Bibel verfügbar',
		other: '${count} Bibeln verfügbar',
	);
	@override String get wantAnotherTranslation => 'Fehlt dir eine Übersetzung?';
	@override String get proposeOnDiscord => 'Tritt unserem Discord bei, um eine vorzuschlagen';
}

// Path: passageSelection
class _Translations$passageSelection$de extends Translations$passageSelection$en {
	_Translations$passageSelection$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get findInBible => 'In der Bibel finden';
	@override String get selectEntireChapter => 'Ganzes Kapitel auswählen';
	@override String get selectVerses => 'Verse auswählen';
	@override String addPassage({required Object reference}) => '${reference} hinzufügen';
}

// Path: selectionUi
class _Translations$selectionUi$de extends Translations$selectionUi$en {
	_Translations$selectionUi$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get selected => 'Ausgewählt: ';
	@override String get sourceApiBible => 'Quelle: [https://api.bible](https://api.bible)';
}

// Path: errors
class _Translations$errors$de extends Translations$errors$en {
	_Translations$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get deviceVerificationFailed => 'Geräteprüfung fehlgeschlagen';
	@override String get deviceVerificationDescription => 'Für den Zugriff auf diese Online-Bibel sind ein gültiges Gerät und eine rechtmäßige Installation von Lux nötig. Stelle sicher, dass du Lux aus einem offiziellen App Store installiert hast, und versuche es dann erneut.';
	@override String get generic => 'Etwas ist schiefgelaufen';
	@override String get connection => 'Prüfe deine Internetverbindung oder versuche es später erneut.';
}

// Path: morphology
class _Translations$morphology$de extends Translations$morphology$en {
	_Translations$morphology$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$attributes$de attributes = _Translations$morphology$attributes$de._(_root);
	@override late final _Translations$morphology$types$de types = _Translations$morphology$types$de._(_root);
	@override late final _Translations$morphology$person$de person = _Translations$morphology$person$de._(_root);
	@override late final _Translations$morphology$gender$de gender = _Translations$morphology$gender$de._(_root);
	@override late final _Translations$morphology$number$de number = _Translations$morphology$number$de._(_root);
	@override late final _Translations$morphology$kCase$de kCase = _Translations$morphology$kCase$de._(_root);
	@override late final _Translations$morphology$state$de state = _Translations$morphology$state$de._(_root);
	@override late final _Translations$morphology$stem$de stem = _Translations$morphology$stem$de._(_root);
	@override late final _Translations$morphology$aspect$de aspect = _Translations$morphology$aspect$de._(_root);
	@override late final _Translations$morphology$hebrewMood$de hebrewMood = _Translations$morphology$hebrewMood$de._(_root);
	@override late final _Translations$morphology$tense$de tense = _Translations$morphology$tense$de._(_root);
	@override late final _Translations$morphology$mood$de mood = _Translations$morphology$mood$de._(_root);
	@override late final _Translations$morphology$voice$de voice = _Translations$morphology$voice$de._(_root);
	@override late final _Translations$morphology$degree$de degree = _Translations$morphology$degree$de._(_root);
	@override late final _Translations$morphology$literals$de literals = _Translations$morphology$literals$de._(_root);
}

// Path: settings
class _Translations$settings$de extends Translations$settings$en {
	_Translations$settings$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Einstellungen';
	@override String get customize => 'Anpassen';
	@override String get pushNotifications => 'Push-Benachrichtigungen';
	@override String get biblePlanReminders => 'Erinnerungen an Lesepläne';
	@override String get notificationsNotRequested => 'Benachrichtigungen aktivieren';
	@override String get notificationsNotRequestedDescription => 'Erlaube Lux, Benachrichtigungen zu senden, um deine Erinnerungen zu verwalten.';
	@override String get notificationsDisabled => 'Benachrichtigungen sind deaktiviert';
	@override String get biblePlanRemindersDisabled => 'Erinnerungen an Lesepläne sind ausgeschaltet.';
	@override String get verseOfTheDayRemindersDisabled => 'Erinnerungen an den Vers des Tages sind ausgeschaltet.';
	@override String get notificationsDisabledDescription => 'Aktiviere sie in den Geräteeinstellungen, um deine Erinnerungen zu verwalten.';
	@override String get language => 'Sprache';
	@override String get system => 'System';
	@override String get systemLanguageDescription => 'Der Systemsprache folgen.';
	@override String get toolbarPresets => 'Symbolleisten-Vorlagen';
	@override String get toolbarPreset => 'Symbolleisten-Vorlage';
	@override String get presetWarning => 'Wenn du eine Vorlage auswählst, werden die Kurzbefehle in all deinen Symbolleisten überschrieben.';
	@override String get yourContent => 'Deine Inhalte';
	@override String get discussionAndAnnouncements => 'Austausch und Ankündigungen';
	@override String get supportLux => 'Lux unterstützen';
	@override String get rateLux => 'Lux bewerten';
	@override String leaveReview({required Object store}) => 'Hinterlasse eine Bewertung im ${store}.';
	@override String get followLux => 'Lux folgen';
	@override String get socialMediaAndVideo => 'Social Media und Videos';
	@override String get shareLux => 'Lux teilen';
	@override String get shareLuxDescription => 'Lux mit jemandem teilen.';
	@override String get reportProblem => 'Problem melden';
	@override String get reportProblemDescription => 'Hilfe bei Fehlern und anderen Problemen erhalten.';
	@override String get recommended => 'Empfohlen';
	@override String get emailSupport => 'E-Mail-Support';
	@override String get restartGetStarted => 'Erste Schritte neu starten';
	@override String get restartGetStartedDescription => 'Die Checkliste „Erste Schritte“ erneut anzeigen.';
	@override String get resetTutorials => 'Tipps zurücksetzen';
	@override String get resetTutorialsDescription => 'Hilfreiche Hinweise in der ganzen App wieder anzeigen.';
	@override String get tutorialsReset => 'Tipps wurden zurückgesetzt.';
}

// Path: biblePlans.importErrors
class _Translations$biblePlans$importErrors$de extends Translations$biblePlans$importErrors$en {
	_Translations$biblePlans$importErrors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get readFailed => 'Lux konnte diese Datei nicht lesen. Versuche, sie erneut auszuwählen.';
	@override String get malformedJson => 'Diese Datei ist nicht richtig formatiert.';
	@override String get invalidStructure => 'Diese Datei ist kein gültiger Leseplan.';
	@override String get nameRequired => 'Der importierte Plan braucht einen Namen.';
	@override String get invalidDayCount => 'Der importierte Plan muss 1 bis 365 Tage enthalten.';
	@override String get readingRequired => 'Der importierte Plan braucht mindestens einen Lesetag.';
	@override String get invalidPassage => 'Der importierte Plan enthält eine ungültige Bibelstelle.';
	@override String get duplicatePassage => 'Ein Tag im importierten Plan enthält denselben Abschnitt mehrmals.';
}

// Path: biblePlans.generatedNames
class _Translations$biblePlans$generatedNames$de extends Translations$biblePlans$generatedNames$en {
	_Translations$biblePlans$generatedNames$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String twoBooks({required Object first, required Object second}) => '${first} & ${second}';
	@override String bookCount({required Object count}) => '${count} Bücher';
	@override String get bible => 'Bibel';
	@override String inOneDay({required Object books}) => '${books} in 1 Tag';
	@override String inDays({required Object books, required Object count}) => '${books} in ${count} Tagen';
	@override String inAYear({required Object books}) => '${books} in einem Jahr';
}

// Path: searchUi.wordMatching
class _Translations$searchUi$wordMatching$de extends Translations$searchUi$wordMatching$en {
	_Translations$searchUi$wordMatching$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wortabgleich';
	@override late final _Translations$searchUi$wordMatching$wholeWord$de wholeWord = _Translations$searchUi$wordMatching$wholeWord$de._(_root);
	@override late final _Translations$searchUi$wordMatching$startOfWord$de startOfWord = _Translations$searchUi$wordMatching$startOfWord$de._(_root);
	@override late final _Translations$searchUi$wordMatching$partOfWord$de partOfWord = _Translations$searchUi$wordMatching$partOfWord$de._(_root);
}

// Path: morphology.attributes
class _Translations$morphology$attributes$de extends Translations$morphology$attributes$en {
	_Translations$morphology$attributes$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$attributes$type$de type = _Translations$morphology$attributes$type$de._(_root);
	@override late final _Translations$morphology$attributes$grammaticalCase$de grammaticalCase = _Translations$morphology$attributes$grammaticalCase$de._(_root);
	@override late final _Translations$morphology$attributes$gender$de gender = _Translations$morphology$attributes$gender$de._(_root);
	@override late final _Translations$morphology$attributes$number$de number = _Translations$morphology$attributes$number$de._(_root);
	@override late final _Translations$morphology$attributes$person$de person = _Translations$morphology$attributes$person$de._(_root);
	@override late final _Translations$morphology$attributes$state$de state = _Translations$morphology$attributes$state$de._(_root);
	@override late final _Translations$morphology$attributes$tense$de tense = _Translations$morphology$attributes$tense$de._(_root);
	@override late final _Translations$morphology$attributes$mood$de mood = _Translations$morphology$attributes$mood$de._(_root);
	@override late final _Translations$morphology$attributes$voice$de voice = _Translations$morphology$attributes$voice$de._(_root);
	@override late final _Translations$morphology$attributes$degree$de degree = _Translations$morphology$attributes$degree$de._(_root);
	@override late final _Translations$morphology$attributes$stem$de stem = _Translations$morphology$attributes$stem$de._(_root);
	@override late final _Translations$morphology$attributes$aspect$de aspect = _Translations$morphology$attributes$aspect$de._(_root);
	@override late final _Translations$morphology$attributes$prefix$de prefix = _Translations$morphology$attributes$prefix$de._(_root);
	@override late final _Translations$morphology$attributes$particle$de particle = _Translations$morphology$attributes$particle$de._(_root);
	@override late final _Translations$morphology$attributes$code$de code = _Translations$morphology$attributes$code$de._(_root);
}

// Path: morphology.types
class _Translations$morphology$types$de extends Translations$morphology$types$en {
	_Translations$morphology$types$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$types$article$de article = _Translations$morphology$types$article$de._(_root);
	@override late final _Translations$morphology$types$conjunction$de conjunction = _Translations$morphology$types$conjunction$de._(_root);
	@override late final _Translations$morphology$types$preposition$de preposition = _Translations$morphology$types$preposition$de._(_root);
	@override late final _Translations$morphology$types$adverb$de adverb = _Translations$morphology$types$adverb$de._(_root);
	@override late final _Translations$morphology$types$negativeAdverb$de negativeAdverb = _Translations$morphology$types$negativeAdverb$de._(_root);
	@override late final _Translations$morphology$types$adjective$de adjective = _Translations$morphology$types$adjective$de._(_root);
	@override late final _Translations$morphology$types$noun$de noun = _Translations$morphology$types$noun$de._(_root);
	@override late final _Translations$morphology$types$properNoun$de properNoun = _Translations$morphology$types$properNoun$de._(_root);
	@override late final _Translations$morphology$types$number$de number = _Translations$morphology$types$number$de._(_root);
	@override late final _Translations$morphology$types$ordinalNumber$de ordinalNumber = _Translations$morphology$types$ordinalNumber$de._(_root);
	@override late final _Translations$morphology$types$pronoun$de pronoun = _Translations$morphology$types$pronoun$de._(_root);
	@override late final _Translations$morphology$types$personalPronoun$de personalPronoun = _Translations$morphology$types$personalPronoun$de._(_root);
	@override late final _Translations$morphology$types$demonstrativePronoun$de demonstrativePronoun = _Translations$morphology$types$demonstrativePronoun$de._(_root);
	@override late final _Translations$morphology$types$interrogativePronoun$de interrogativePronoun = _Translations$morphology$types$interrogativePronoun$de._(_root);
	@override late final _Translations$morphology$types$indefinitePronoun$de indefinitePronoun = _Translations$morphology$types$indefinitePronoun$de._(_root);
	@override late final _Translations$morphology$types$reciprocalPronoun$de reciprocalPronoun = _Translations$morphology$types$reciprocalPronoun$de._(_root);
	@override late final _Translations$morphology$types$reflexivePronoun$de reflexivePronoun = _Translations$morphology$types$reflexivePronoun$de._(_root);
	@override late final _Translations$morphology$types$relativePronoun$de relativePronoun = _Translations$morphology$types$relativePronoun$de._(_root);
	@override late final _Translations$morphology$types$particle$de particle = _Translations$morphology$types$particle$de._(_root);
	@override late final _Translations$morphology$types$negativeParticle$de negativeParticle = _Translations$morphology$types$negativeParticle$de._(_root);
	@override late final _Translations$morphology$types$interrogativeParticle$de interrogativeParticle = _Translations$morphology$types$interrogativeParticle$de._(_root);
	@override late final _Translations$morphology$types$demonstrativeParticle$de demonstrativeParticle = _Translations$morphology$types$demonstrativeParticle$de._(_root);
	@override late final _Translations$morphology$types$genericParticle$de genericParticle = _Translations$morphology$types$genericParticle$de._(_root);
	@override late final _Translations$morphology$types$relativeParticle$de relativeParticle = _Translations$morphology$types$relativeParticle$de._(_root);
	@override late final _Translations$morphology$types$verb$de verb = _Translations$morphology$types$verb$de._(_root);
	@override late final _Translations$morphology$types$pronominalSuffix$de pronominalSuffix = _Translations$morphology$types$pronominalSuffix$de._(_root);
	@override late final _Translations$morphology$types$directObjectMarker$de directObjectMarker = _Translations$morphology$types$directObjectMarker$de._(_root);
	@override late final _Translations$morphology$types$punctuation$de punctuation = _Translations$morphology$types$punctuation$de._(_root);
	@override late final _Translations$morphology$types$interjection$de interjection = _Translations$morphology$types$interjection$de._(_root);
	@override late final _Translations$morphology$types$indeclinable$de indeclinable = _Translations$morphology$types$indeclinable$de._(_root);
	@override late final _Translations$morphology$types$hebraism$de hebraism = _Translations$morphology$types$hebraism$de._(_root);
	@override late final _Translations$morphology$types$unknown$de unknown = _Translations$morphology$types$unknown$de._(_root);
}

// Path: morphology.person
class _Translations$morphology$person$de extends Translations$morphology$person$en {
	_Translations$morphology$person$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$person$first$de first = _Translations$morphology$person$first$de._(_root);
	@override late final _Translations$morphology$person$second$de second = _Translations$morphology$person$second$de._(_root);
	@override late final _Translations$morphology$person$third$de third = _Translations$morphology$person$third$de._(_root);
}

// Path: morphology.gender
class _Translations$morphology$gender$de extends Translations$morphology$gender$en {
	_Translations$morphology$gender$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$gender$masculine$de masculine = _Translations$morphology$gender$masculine$de._(_root);
	@override late final _Translations$morphology$gender$feminine$de feminine = _Translations$morphology$gender$feminine$de._(_root);
	@override late final _Translations$morphology$gender$neuter$de neuter = _Translations$morphology$gender$neuter$de._(_root);
	@override late final _Translations$morphology$gender$common$de common = _Translations$morphology$gender$common$de._(_root);
}

// Path: morphology.number
class _Translations$morphology$number$de extends Translations$morphology$number$en {
	_Translations$morphology$number$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$number$singular$de singular = _Translations$morphology$number$singular$de._(_root);
	@override late final _Translations$morphology$number$plural$de plural = _Translations$morphology$number$plural$de._(_root);
	@override late final _Translations$morphology$number$dual$de dual = _Translations$morphology$number$dual$de._(_root);
}

// Path: morphology.kCase
class _Translations$morphology$kCase$de extends Translations$morphology$kCase$en {
	_Translations$morphology$kCase$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$kCase$nominative$de nominative = _Translations$morphology$kCase$nominative$de._(_root);
	@override late final _Translations$morphology$kCase$genitive$de genitive = _Translations$morphology$kCase$genitive$de._(_root);
	@override late final _Translations$morphology$kCase$dative$de dative = _Translations$morphology$kCase$dative$de._(_root);
	@override late final _Translations$morphology$kCase$accusative$de accusative = _Translations$morphology$kCase$accusative$de._(_root);
	@override late final _Translations$morphology$kCase$vocative$de vocative = _Translations$morphology$kCase$vocative$de._(_root);
}

// Path: morphology.state
class _Translations$morphology$state$de extends Translations$morphology$state$en {
	_Translations$morphology$state$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$state$absolute$de absolute = _Translations$morphology$state$absolute$de._(_root);
	@override late final _Translations$morphology$state$construct$de construct = _Translations$morphology$state$construct$de._(_root);
	@override late final _Translations$morphology$state$determined$de determined = _Translations$morphology$state$determined$de._(_root);
}

// Path: morphology.stem
class _Translations$morphology$stem$de extends Translations$morphology$stem$en {
	_Translations$morphology$stem$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$stem$qal$de qal = _Translations$morphology$stem$qal$de._(_root);
	@override late final _Translations$morphology$stem$qalPassive$de qalPassive = _Translations$morphology$stem$qalPassive$de._(_root);
	@override late final _Translations$morphology$stem$niphal$de niphal = _Translations$morphology$stem$niphal$de._(_root);
	@override late final _Translations$morphology$stem$piel$de piel = _Translations$morphology$stem$piel$de._(_root);
	@override late final _Translations$morphology$stem$pual$de pual = _Translations$morphology$stem$pual$de._(_root);
	@override late final _Translations$morphology$stem$hiphil$de hiphil = _Translations$morphology$stem$hiphil$de._(_root);
	@override late final _Translations$morphology$stem$hophal$de hophal = _Translations$morphology$stem$hophal$de._(_root);
	@override late final _Translations$morphology$stem$hithpael$de hithpael = _Translations$morphology$stem$hithpael$de._(_root);
	@override late final _Translations$morphology$stem$nithpael$de nithpael = _Translations$morphology$stem$nithpael$de._(_root);
}

// Path: morphology.aspect
class _Translations$morphology$aspect$de extends Translations$morphology$aspect$en {
	_Translations$morphology$aspect$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$aspect$perfect$de perfect = _Translations$morphology$aspect$perfect$de._(_root);
	@override late final _Translations$morphology$aspect$imperfect$de imperfect = _Translations$morphology$aspect$imperfect$de._(_root);
	@override late final _Translations$morphology$aspect$imperative$de imperative = _Translations$morphology$aspect$imperative$de._(_root);
	@override late final _Translations$morphology$aspect$infinitiveConstruct$de infinitiveConstruct = _Translations$morphology$aspect$infinitiveConstruct$de._(_root);
	@override late final _Translations$morphology$aspect$infinitiveAbsolute$de infinitiveAbsolute = _Translations$morphology$aspect$infinitiveAbsolute$de._(_root);
	@override late final _Translations$morphology$aspect$participle$de participle = _Translations$morphology$aspect$participle$de._(_root);
	@override late final _Translations$morphology$aspect$consecutiveImperfect$de consecutiveImperfect = _Translations$morphology$aspect$consecutiveImperfect$de._(_root);
	@override late final _Translations$morphology$aspect$conjunctiveImperfect$de conjunctiveImperfect = _Translations$morphology$aspect$conjunctiveImperfect$de._(_root);
	@override late final _Translations$morphology$aspect$conjunctivePerfect$de conjunctivePerfect = _Translations$morphology$aspect$conjunctivePerfect$de._(_root);
	@override late final _Translations$morphology$aspect$passiveParticiple$de passiveParticiple = _Translations$morphology$aspect$passiveParticiple$de._(_root);
}

// Path: morphology.hebrewMood
class _Translations$morphology$hebrewMood$de extends Translations$morphology$hebrewMood$en {
	_Translations$morphology$hebrewMood$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$hebrewMood$jussive$de jussive = _Translations$morphology$hebrewMood$jussive$de._(_root);
	@override late final _Translations$morphology$hebrewMood$cohortative$de cohortative = _Translations$morphology$hebrewMood$cohortative$de._(_root);
	@override late final _Translations$morphology$hebrewMood$hSuffix$de hSuffix = _Translations$morphology$hebrewMood$hSuffix$de._(_root);
}

// Path: morphology.tense
class _Translations$morphology$tense$de extends Translations$morphology$tense$en {
	_Translations$morphology$tense$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$tense$present$de present = _Translations$morphology$tense$present$de._(_root);
	@override late final _Translations$morphology$tense$imperfect$de imperfect = _Translations$morphology$tense$imperfect$de._(_root);
	@override late final _Translations$morphology$tense$future$de future = _Translations$morphology$tense$future$de._(_root);
	@override late final _Translations$morphology$tense$aorist$de aorist = _Translations$morphology$tense$aorist$de._(_root);
	@override late final _Translations$morphology$tense$perfect$de perfect = _Translations$morphology$tense$perfect$de._(_root);
	@override late final _Translations$morphology$tense$pluperfect$de pluperfect = _Translations$morphology$tense$pluperfect$de._(_root);
}

// Path: morphology.mood
class _Translations$morphology$mood$de extends Translations$morphology$mood$en {
	_Translations$morphology$mood$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$mood$indicative$de indicative = _Translations$morphology$mood$indicative$de._(_root);
	@override late final _Translations$morphology$mood$imperative$de imperative = _Translations$morphology$mood$imperative$de._(_root);
	@override late final _Translations$morphology$mood$subjunctive$de subjunctive = _Translations$morphology$mood$subjunctive$de._(_root);
	@override late final _Translations$morphology$mood$optative$de optative = _Translations$morphology$mood$optative$de._(_root);
	@override late final _Translations$morphology$mood$infinitive$de infinitive = _Translations$morphology$mood$infinitive$de._(_root);
	@override late final _Translations$morphology$mood$participle$de participle = _Translations$morphology$mood$participle$de._(_root);
}

// Path: morphology.voice
class _Translations$morphology$voice$de extends Translations$morphology$voice$en {
	_Translations$morphology$voice$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$voice$active$de active = _Translations$morphology$voice$active$de._(_root);
	@override late final _Translations$morphology$voice$middle$de middle = _Translations$morphology$voice$middle$de._(_root);
	@override late final _Translations$morphology$voice$passive$de passive = _Translations$morphology$voice$passive$de._(_root);
	@override late final _Translations$morphology$voice$middleOrPassive$de middleOrPassive = _Translations$morphology$voice$middleOrPassive$de._(_root);
}

// Path: morphology.degree
class _Translations$morphology$degree$de extends Translations$morphology$degree$en {
	_Translations$morphology$degree$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$degree$positive$de positive = _Translations$morphology$degree$positive$de._(_root);
	@override late final _Translations$morphology$degree$comparative$de comparative = _Translations$morphology$degree$comparative$de._(_root);
	@override late final _Translations$morphology$degree$superlative$de superlative = _Translations$morphology$degree$superlative$de._(_root);
}

// Path: morphology.literals
class _Translations$morphology$literals$de extends Translations$morphology$literals$en {
	_Translations$morphology$literals$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get rawCode => 'Der unveränderte Morphologiecode, wie er in der Quelle stand.';
	@override String get waw => 'Die hebräische Konjunktion Waw (וְ), „und“.';
	@override String get conjunction => 'Ein Konjunktionsmarker.';
	@override String get bet => 'Die hebräische Präfix-Präposition Bet (בְּ), „in“, „an“ oder „mit“.';
	@override String get kaf => 'Die hebräische Präfix-Präposition Kaf (כְּ), „wie“ oder „gleich“.';
	@override String get lamed => 'Die hebräische Präfix-Präposition Lamed (לְ), „zu“, „für“ oder „gehörend zu“.';
	@override String get mem => 'Die hebräische Präfix-Präposition Mem (מִן), „von“ oder „aus“.';
	@override String get preposition => 'Ein Präpositionsbuchstabe als Präfix.';
	@override String get wawExamples => 'und|nun|aber';
	@override String get betExamples => 'im Anfang|mit Kraft';
	@override String get kafExamples => 'wie ein Löwe|wie ein Hirte';
	@override String get lamedExamples => 'für David|für den König';
	@override String get memExamples => 'aus Ägypten|aus dem Land';
}

// Path: searchUi.wordMatching.wholeWord
class _Translations$searchUi$wordMatching$wholeWord$de extends Translations$searchUi$wordMatching$wholeWord$en {
	_Translations$searchUi$wordMatching$wholeWord$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ganzes Wort';
	@override String get description => 'Findet nur vollständige Wörter, die deiner Suche entsprechen.';
	@override String get example => 'Beispiel: „Licht“ findet „Licht“';
}

// Path: searchUi.wordMatching.startOfWord
class _Translations$searchUi$wordMatching$startOfWord$de extends Translations$searchUi$wordMatching$startOfWord$en {
	_Translations$searchUi$wordMatching$startOfWord$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wortanfang';
	@override String get description => 'Findet Wörter, die mit deiner Suche beginnen.';
	@override String get example => 'Beispiel: „Licht“ findet auch „Lichter“';
}

// Path: searchUi.wordMatching.partOfWord
class _Translations$searchUi$wordMatching$partOfWord$de extends Translations$searchUi$wordMatching$partOfWord$en {
	_Translations$searchUi$wordMatching$partOfWord$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wortteil';
	@override String get description => 'Findet Wörter, die deine Suche irgendwo enthalten.';
	@override String get example => 'Beispiel: „Licht“ findet auch „Tageslicht“';
}

// Path: morphology.attributes.type
class _Translations$morphology$attributes$type$de extends Translations$morphology$attributes$type$en {
	_Translations$morphology$attributes$type$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Wortart';
	@override String get description => 'Die grammatische Kategorie des Wortes.';
}

// Path: morphology.attributes.grammaticalCase
class _Translations$morphology$attributes$grammaticalCase$de extends Translations$morphology$attributes$grammaticalCase$en {
	_Translations$morphology$attributes$grammaticalCase$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Kasus';
	@override String get description => 'Die syntaktische Rolle, etwa Subjekt, Objekt oder Besitz.';
}

// Path: morphology.attributes.gender
class _Translations$morphology$attributes$gender$de extends Translations$morphology$attributes$gender$en {
	_Translations$morphology$attributes$gender$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Genus';
	@override String get description => 'Grammatisches Geschlecht: maskulin, feminin, neutrum (Griechisch) oder communis (Hebräisch).';
}

// Path: morphology.attributes.number
class _Translations$morphology$attributes$number$de extends Translations$morphology$attributes$number$en {
	_Translations$morphology$attributes$number$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Numerus';
	@override String get description => 'Ob sich das Wort auf eins (Singular), zwei (Dual) oder viele (Plural) bezieht.';
}

// Path: morphology.attributes.person
class _Translations$morphology$attributes$person$de extends Translations$morphology$attributes$person$en {
	_Translations$morphology$attributes$person$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Person';
	@override String get description => 'Auf wen sich das Wort bezieht: 1. (ich/wir), 2. (du/ihr) oder 3. (er/sie/es/sie).';
}

// Path: morphology.attributes.state
class _Translations$morphology$attributes$state$de extends Translations$morphology$attributes$state$en {
	_Translations$morphology$attributes$state$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Status';
	@override String get description => 'Der Status eines Substantivs: absolutus, constructus oder determinatus.';
}

// Path: morphology.attributes.tense
class _Translations$morphology$attributes$tense$de extends Translations$morphology$attributes$tense$en {
	_Translations$morphology$attributes$tense$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Tempus';
	@override String get description => 'Die Zeitform des Verbs, die Zeit und Aspekt verbindet.';
}

// Path: morphology.attributes.mood
class _Translations$morphology$attributes$mood$de extends Translations$morphology$attributes$mood$en {
	_Translations$morphology$attributes$mood$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Modus';
	@override String get description => 'Wie die Handlung ausgedrückt wird, etwa als Tatsache, Befehl oder Möglichkeit.';
}

// Path: morphology.attributes.voice
class _Translations$morphology$attributes$voice$de extends Translations$morphology$attributes$voice$en {
	_Translations$morphology$attributes$voice$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Diathese';
	@override String get description => 'Die Diathese: Aktiv, Medium oder Passiv.';
}

// Path: morphology.attributes.degree
class _Translations$morphology$attributes$degree$de extends Translations$morphology$attributes$degree$en {
	_Translations$morphology$attributes$degree$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Steigerung';
	@override String get description => 'Die Steigerungsstufe eines Adjektivs oder Adverbs: Positiv, Komparativ oder Superlativ.';
}

// Path: morphology.attributes.stem
class _Translations$morphology$attributes$stem$de extends Translations$morphology$attributes$stem$en {
	_Translations$morphology$attributes$stem$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Stamm';
	@override String get description => 'Der Verbalstamm (Binjan), etwa Qal, Nifal oder Piel.';
}

// Path: morphology.attributes.aspect
class _Translations$morphology$attributes$aspect$de extends Translations$morphology$attributes$aspect$en {
	_Translations$morphology$attributes$aspect$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Aspekt';
	@override String get description => 'Der Verbalaspekt, etwa Perfekt, Imperfekt oder Partizip.';
}

// Path: morphology.attributes.prefix
class _Translations$morphology$attributes$prefix$de extends Translations$morphology$attributes$prefix$en {
	_Translations$morphology$attributes$prefix$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Präfix';
	@override String get description => 'Ein hebräischer Präpositionsbuchstabe als Präfix.';
}

// Path: morphology.attributes.particle
class _Translations$morphology$attributes$particle$de extends Translations$morphology$attributes$particle$en {
	_Translations$morphology$attributes$particle$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Partikel';
	@override String get description => 'Ein kleines, unflektiertes Wort, oft eine Konjunktion oder ein Marker.';
}

// Path: morphology.attributes.code
class _Translations$morphology$attributes$code$de extends Translations$morphology$attributes$code$en {
	_Translations$morphology$attributes$code$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Code';
	@override String get description => 'Der unveränderte Morphologiecode, wie er im Quelltext steht.';
}

// Path: morphology.types.article
class _Translations$morphology$types$article$de extends Translations$morphology$types$article$en {
	_Translations$morphology$types$article$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Artikel';
	@override String get description => 'Ein bestimmter Artikel, „der“, „die“ oder „das“.';
	@override String get examples => 'der König|der Herr';
}

// Path: morphology.types.conjunction
class _Translations$morphology$types$conjunction$de extends Translations$morphology$types$conjunction$en {
	_Translations$morphology$types$conjunction$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Konjunktion';
	@override String get description => 'Ein Wort, das andere Wörter oder Sätze verbindet.';
	@override String get examples => 'und|aber|denn';
}

// Path: morphology.types.preposition
class _Translations$morphology$types$preposition$de extends Translations$morphology$types$preposition$en {
	_Translations$morphology$types$preposition$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Präposition';
	@override String get description => 'Setzt ein Substantiv oder Pronomen in Beziehung zu anderen Wörtern.';
	@override String get examples => 'in|zu|mit';
}

// Path: morphology.types.adverb
class _Translations$morphology$types$adverb$de extends Translations$morphology$types$adverb$en {
	_Translations$morphology$types$adverb$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Adverb';
	@override String get description => 'Bestimmt ein Verb, Adjektiv oder anderes Adverb näher.';
	@override String get examples => 'schnell|jetzt|dort';
}

// Path: morphology.types.negativeAdverb
class _Translations$morphology$types$negativeAdverb$de extends Translations$morphology$types$negativeAdverb$en {
	_Translations$morphology$types$negativeAdverb$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Verneinendes Adverb';
	@override String get description => 'Ein Adverb, das eine Verneinung ausdrückt.';
	@override String get examples => 'nicht|niemals';
}

// Path: morphology.types.adjective
class _Translations$morphology$types$adjective$de extends Translations$morphology$types$adjective$en {
	_Translations$morphology$types$adjective$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Adjektiv';
	@override String get description => 'Ein Wort, das ein Substantiv beschreibt.';
	@override String get examples => 'groß|heilig|weise';
}

// Path: morphology.types.noun
class _Translations$morphology$types$noun$de extends Translations$morphology$types$noun$en {
	_Translations$morphology$types$noun$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Substantiv';
	@override String get description => 'Eine Person, ein Ort, eine Sache oder ein Begriff.';
	@override String get examples => 'Stadt|Wasser|Liebe';
}

// Path: morphology.types.properNoun
class _Translations$morphology$types$properNoun$de extends Translations$morphology$types$properNoun$en {
	_Translations$morphology$types$properNoun$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Eigenname';
	@override String get description => 'Der Name einer bestimmten Person, eines Ortes oder einer Sache.';
	@override String get examples => 'David|Jerusalem|Israel';
}

// Path: morphology.types.number
class _Translations$morphology$types$number$de extends Translations$morphology$types$number$en {
	_Translations$morphology$types$number$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Kardinalzahl';
	@override String get description => 'Eine Grundzahl.';
	@override String get examples => 'drei|zwölf|tausend';
}

// Path: morphology.types.ordinalNumber
class _Translations$morphology$types$ordinalNumber$de extends Translations$morphology$types$ordinalNumber$en {
	_Translations$morphology$types$ordinalNumber$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Ordinalzahl';
	@override String get description => 'Eine Ordnungszahl, etwa „erste“ oder „zweite“.';
	@override String get examples => 'erste|zehnte|siebzigste';
}

// Path: morphology.types.pronoun
class _Translations$morphology$types$pronoun$de extends Translations$morphology$types$pronoun$en {
	_Translations$morphology$types$pronoun$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Pronomen';
	@override String get description => 'Ein Wort, das für ein Substantiv steht.';
	@override String get examples => 'er|sie|sie (Pl.)';
}

// Path: morphology.types.personalPronoun
class _Translations$morphology$types$personalPronoun$de extends Translations$morphology$types$personalPronoun$en {
	_Translations$morphology$types$personalPronoun$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Personalpronomen';
	@override String get description => 'Ein Pronomen, das sich auf eine bestimmte Person bezieht.';
	@override String get examples => 'ich|du|wir';
}

// Path: morphology.types.demonstrativePronoun
class _Translations$morphology$types$demonstrativePronoun$de extends Translations$morphology$types$demonstrativePronoun$en {
	_Translations$morphology$types$demonstrativePronoun$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Demonstrativpronomen';
	@override String get description => 'Ein Pronomen, das auf etwas hinweist.';
	@override String get examples => 'dieser|diese|jene';
}

// Path: morphology.types.interrogativePronoun
class _Translations$morphology$types$interrogativePronoun$de extends Translations$morphology$types$interrogativePronoun$en {
	_Translations$morphology$types$interrogativePronoun$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Interrogativpronomen';
	@override String get description => 'Ein Pronomen, mit dem man eine Frage stellt.';
	@override String get examples => 'wer?|was?|welcher?';
}

// Path: morphology.types.indefinitePronoun
class _Translations$morphology$types$indefinitePronoun$de extends Translations$morphology$types$indefinitePronoun$en {
	_Translations$morphology$types$indefinitePronoun$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Indefinitpronomen';
	@override String get description => 'Ein Pronomen, das sich auf nicht bestimmte Personen oder Dinge bezieht.';
	@override String get examples => 'jemand|irgendwer|nichts';
}

// Path: morphology.types.reciprocalPronoun
class _Translations$morphology$types$reciprocalPronoun$de extends Translations$morphology$types$reciprocalPronoun$en {
	_Translations$morphology$types$reciprocalPronoun$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Reziprokpronomen';
	@override String get description => 'Ein Pronomen, das eine wechselseitige Handlung ausdrückt.';
	@override String get examples => 'einander|gegenseitig';
}

// Path: morphology.types.reflexivePronoun
class _Translations$morphology$types$reflexivePronoun$de extends Translations$morphology$types$reflexivePronoun$en {
	_Translations$morphology$types$reflexivePronoun$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Reflexivpronomen';
	@override String get description => 'Ein Pronomen, das sich auf das Subjekt zurückbezieht.';
	@override String get examples => 'sich|sich selbst';
}

// Path: morphology.types.relativePronoun
class _Translations$morphology$types$relativePronoun$de extends Translations$morphology$types$relativePronoun$en {
	_Translations$morphology$types$relativePronoun$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Relativpronomen';
	@override String get description => 'Ein Pronomen, das einen Nebensatz einleitet.';
	@override String get examples => 'der|welcher|das';
}

// Path: morphology.types.particle
class _Translations$morphology$types$particle$de extends Translations$morphology$types$particle$en {
	_Translations$morphology$types$particle$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Partikel';
	@override String get description => 'Ein kleines, unflektiertes Wort.';
	@override String get examples => 'doch|nun';
}

// Path: morphology.types.negativeParticle
class _Translations$morphology$types$negativeParticle$de extends Translations$morphology$types$negativeParticle$en {
	_Translations$morphology$types$negativeParticle$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Verneinungspartikel';
	@override String get description => 'Eine Partikel, die eine Verneinung anzeigt.';
	@override String get examples => 'nicht|kein';
}

// Path: morphology.types.interrogativeParticle
class _Translations$morphology$types$interrogativeParticle$de extends Translations$morphology$types$interrogativeParticle$en {
	_Translations$morphology$types$interrogativeParticle$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Fragepartikel';
	@override String get description => 'Eine Partikel, die eine Frage anzeigt.';
	@override String get examples => '(hebräisches Präfix ה, ohne deutsche Entsprechung)';
}

// Path: morphology.types.demonstrativeParticle
class _Translations$morphology$types$demonstrativeParticle$de extends Translations$morphology$types$demonstrativeParticle$en {
	_Translations$morphology$types$demonstrativeParticle$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Hinweispartikel';
	@override String get description => 'Eine hinweisende Partikel, etwa „siehe“.';
	@override String get examples => 'siehe|sieh';
}

// Path: morphology.types.genericParticle
class _Translations$morphology$types$genericParticle$de extends Translations$morphology$types$genericParticle$en {
	_Translations$morphology$types$genericParticle$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Allgemeine Partikel';
	@override String get description => 'Eine vielseitig verwendete Partikel.';
	@override String get examples => 'doch|wahrlich';
}

// Path: morphology.types.relativeParticle
class _Translations$morphology$types$relativeParticle$de extends Translations$morphology$types$relativeParticle$en {
	_Translations$morphology$types$relativeParticle$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Relativpartikel';
	@override String get description => 'Eine Partikel, die einen Relativsatz einleitet.';
	@override String get examples => 'dass|welcher';
}

// Path: morphology.types.verb
class _Translations$morphology$types$verb$de extends Translations$morphology$types$verb$en {
	_Translations$morphology$types$verb$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Verb';
	@override String get description => 'Ein Wort, das eine Handlung oder einen Zustand ausdrückt.';
	@override String get examples => 'schreiben|sein|gehen';
}

// Path: morphology.types.pronominalSuffix
class _Translations$morphology$types$pronominalSuffix$de extends Translations$morphology$types$pronominalSuffix$en {
	_Translations$morphology$types$pronominalSuffix$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Pronominalsuffix';
	@override String get description => 'Ein Pronomen, das an das Ende eines Verbs oder Substantivs angehängt ist (Hebräisch).';
	@override String get examples => 'seine Hand|ihr Land|ihre Stimme';
}

// Path: morphology.types.directObjectMarker
class _Translations$morphology$types$directObjectMarker$de extends Translations$morphology$types$directObjectMarker$en {
	_Translations$morphology$types$directObjectMarker$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Objektmarker';
	@override String get description => 'Das hebräische אֵת, das ein bestimmtes direktes Objekt kennzeichnet.';
	@override String get examples => 'אֵת (ohne deutsche Entsprechung)';
}

// Path: morphology.types.punctuation
class _Translations$morphology$types$punctuation$de extends Translations$morphology$types$punctuation$en {
	_Translations$morphology$types$punctuation$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Satzzeichen';
	@override String get description => 'Ein Satzzeichen.';
	@override String get examples => '.|,|;';
}

// Path: morphology.types.interjection
class _Translations$morphology$types$interjection$de extends Translations$morphology$types$interjection$en {
	_Translations$morphology$types$interjection$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Interjektion';
	@override String get description => 'Ein kurzer Ausruf, der ein Gefühl ausdrückt.';
	@override String get examples => 'o!|ach!';
}

// Path: morphology.types.indeclinable
class _Translations$morphology$types$indeclinable$de extends Translations$morphology$types$indeclinable$en {
	_Translations$morphology$types$indeclinable$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Indeklinabel';
	@override String get description => 'Ein Wort, dessen Form sich durch Flexion nicht ändert.';
	@override String get examples => 'Hosianna|Halleluja';
}

// Path: morphology.types.hebraism
class _Translations$morphology$types$hebraism$de extends Translations$morphology$types$hebraism$en {
	_Translations$morphology$types$hebraism$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Hebräisches Lehnwort';
	@override String get description => 'Ein hebräisches oder aramäisches Lehnwort, das ins Griechische übernommen wurde.';
	@override String get examples => 'Amen|Hosianna|Zebaoth';
}

// Path: morphology.types.unknown
class _Translations$morphology$types$unknown$de extends Translations$morphology$types$unknown$en {
	_Translations$morphology$types$unknown$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Unbekannt';
	@override String get description => 'Ein Morphologiecode, den der Parser nicht erkannt hat.';
	@override String get examples => '';
}

// Path: morphology.person.first
class _Translations$morphology$person$first$de extends Translations$morphology$person$first$en {
	_Translations$morphology$person$first$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => '1. Person';
	@override String get description => 'Der Sprecher, „ich“ oder „wir“.';
	@override String get examples => 'ich bin|wir gehen|ich habe geredet';
}

// Path: morphology.person.second
class _Translations$morphology$person$second$de extends Translations$morphology$person$second$en {
	_Translations$morphology$person$second$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => '2. Person';
	@override String get description => 'Der Angesprochene, „du“ oder „ihr“.';
	@override String get examples => 'du gehst|ihr hört|du hast gesehen';
}

// Path: morphology.person.third
class _Translations$morphology$person$third$de extends Translations$morphology$person$third$en {
	_Translations$morphology$person$third$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => '3. Person';
	@override String get description => 'Diejenigen, über die gesprochen wird.';
	@override String get examples => 'er läuft|sie spricht|sie versammelten sich';
}

// Path: morphology.gender.masculine
class _Translations$morphology$gender$masculine$de extends Translations$morphology$gender$masculine$en {
	_Translations$morphology$gender$masculine$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Maskulin';
	@override String get description => 'Männliches grammatisches Geschlecht, verwendet für männliche Personen und per Konvention für viele Substantive.';
	@override String get examples => 'Vater|Sohn|König';
}

// Path: morphology.gender.feminine
class _Translations$morphology$gender$feminine$de extends Translations$morphology$gender$feminine$en {
	_Translations$morphology$gender$feminine$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Feminin';
	@override String get description => 'Weibliches grammatisches Geschlecht, verwendet für weibliche Personen und per Konvention für viele Substantive.';
	@override String get examples => 'Mutter|Tochter|Königin';
}

// Path: morphology.gender.neuter
class _Translations$morphology$gender$neuter$de extends Translations$morphology$gender$neuter$en {
	_Translations$morphology$gender$neuter$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Neutrum';
	@override String get description => 'Griechisches sächliches Geschlecht, weder männlich noch weiblich.';
	@override String get examples => 'Kind (τέκνον)|Gabe (δῶρον)';
}

// Path: morphology.gender.common
class _Translations$morphology$gender$common$de extends Translations$morphology$gender$common$en {
	_Translations$morphology$gender$common$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Communis';
	@override String get description => 'Hebräisches gemeinsames Geschlecht, bei dem die Form sowohl männlich als auch weiblich sein kann.';
	@override String get examples => 'Vieh|Stimme';
}

// Path: morphology.number.singular
class _Translations$morphology$number$singular$de extends Translations$morphology$number$singular$en {
	_Translations$morphology$number$singular$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Singular';
	@override String get description => 'Bezieht sich auf eins.';
	@override String get examples => 'das Buch|ein Mann|ein Stein';
}

// Path: morphology.number.plural
class _Translations$morphology$number$plural$de extends Translations$morphology$number$plural$en {
	_Translations$morphology$number$plural$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Plural';
	@override String get description => 'Bezieht sich auf zwei oder mehr.';
	@override String get examples => 'die Bücher|Männer|Steine';
}

// Path: morphology.number.dual
class _Translations$morphology$number$dual$de extends Translations$morphology$number$dual$en {
	_Translations$morphology$number$dual$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Dual';
	@override String get description => 'Bezieht sich auf ein natürliches Paar (nur Hebräisch).';
	@override String get examples => 'Hände|Augen|zwei Tage';
}

// Path: morphology.kCase.nominative
class _Translations$morphology$kCase$nominative$de extends Translations$morphology$kCase$nominative$en {
	_Translations$morphology$kCase$nominative$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nominativ';
	@override String get description => 'Kennzeichnet das Subjekt eines Satzes.';
	@override String get examples => 'Gott schuf|der König sieht';
}

// Path: morphology.kCase.genitive
class _Translations$morphology$kCase$genitive$de extends Translations$morphology$kCase$genitive$en {
	_Translations$morphology$kCase$genitive$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Genitiv';
	@override String get description => 'Zeigt Besitz oder Herkunft an, oft mit „von“ oder „des“ übersetzt.';
	@override String get examples => 'der Sohn Gottes|Reich der Himmel';
}

// Path: morphology.kCase.dative
class _Translations$morphology$kCase$dative$de extends Translations$morphology$kCase$dative$en {
	_Translations$morphology$kCase$dative$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Dativ';
	@override String get description => 'Kennzeichnet das indirekte Objekt, oft „zu“ oder „für“.';
	@override String get examples => 'gab ihm|sprach zu ihnen';
}

// Path: morphology.kCase.accusative
class _Translations$morphology$kCase$accusative$de extends Translations$morphology$kCase$accusative$en {
	_Translations$morphology$kCase$accusative$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Akkusativ';
	@override String get description => 'Kennzeichnet das direkte Objekt.';
	@override String get examples => 'sah ihn|liebe deinen Nächsten';
}

// Path: morphology.kCase.vocative
class _Translations$morphology$kCase$vocative$de extends Translations$morphology$kCase$vocative$en {
	_Translations$morphology$kCase$vocative$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Vokativ';
	@override String get description => 'Wird bei direkter Anrede verwendet.';
	@override String get examples => 'Herr!|Vater!|Freund!';
}

// Path: morphology.state.absolute
class _Translations$morphology$state$absolute$de extends Translations$morphology$state$absolute$en {
	_Translations$morphology$state$absolute$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Absolutus';
	@override String get description => 'Die übliche, selbstständige Form eines Substantivs.';
	@override String get examples => 'ein König|ein Wort';
}

// Path: morphology.state.construct
class _Translations$morphology$state$construct$de extends Translations$morphology$state$construct$en {
	_Translations$morphology$state$construct$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Constructus';
	@override String get description => 'An ein folgendes Substantiv gebunden, drückt „X von Y“ aus.';
	@override String get examples => 'König von Israel|Wort des HERRN';
}

// Path: morphology.state.determined
class _Translations$morphology$state$determined$de extends Translations$morphology$state$determined$en {
	_Translations$morphology$state$determined$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Determinatus';
	@override String get description => 'Als bestimmt gekennzeichnet, oft durch den Artikel.';
	@override String get examples => 'der König|das Wort';
}

// Path: morphology.stem.qal
class _Translations$morphology$stem$qal$de extends Translations$morphology$stem$qal$en {
	_Translations$morphology$stem$qal$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Qal';
	@override String get description => 'Der einfache aktive Stamm, die Grundhandlung des Verbs.';
	@override String get examples => 'er schrieb|sie hörte';
}

// Path: morphology.stem.qalPassive
class _Translations$morphology$stem$qalPassive$de extends Translations$morphology$stem$qalPassive$en {
	_Translations$morphology$stem$qalPassive$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Qal Passiv';
	@override String get description => 'Ein seltenes Passiv des einfachen Stammes.';
	@override String get examples => 'es wurde genommen';
}

// Path: morphology.stem.niphal
class _Translations$morphology$stem$niphal$de extends Translations$morphology$stem$niphal$en {
	_Translations$morphology$stem$niphal$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nifal';
	@override String get description => 'Der einfache passive oder reflexive Stamm.';
	@override String get examples => 'er wurde getötet|sie versammelten sich';
}

// Path: morphology.stem.piel
class _Translations$morphology$stem$piel$de extends Translations$morphology$stem$piel$en {
	_Translations$morphology$stem$piel$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Piel';
	@override String get description => 'Der intensive oder faktitive aktive Stamm.';
	@override String get examples => 'er lobte|er segnete|er zerschmetterte';
}

// Path: morphology.stem.pual
class _Translations$morphology$stem$pual$de extends Translations$morphology$stem$pual$en {
	_Translations$morphology$stem$pual$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Pual';
	@override String get description => 'Das Passiv des Piel.';
	@override String get examples => 'er wurde gelobt';
}

// Path: morphology.stem.hiphil
class _Translations$morphology$stem$hiphil$de extends Translations$morphology$stem$hiphil$en {
	_Translations$morphology$stem$hiphil$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Hifil';
	@override String get description => 'Der kausative aktive Stamm.';
	@override String get examples => 'er ließ schreiben|er führte heraus';
}

// Path: morphology.stem.hophal
class _Translations$morphology$stem$hophal$de extends Translations$morphology$stem$hophal$en {
	_Translations$morphology$stem$hophal$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Hofal';
	@override String get description => 'Das Passiv des Hifil.';
	@override String get examples => 'er wurde zum Schreiben veranlasst';
}

// Path: morphology.stem.hithpael
class _Translations$morphology$stem$hithpael$de extends Translations$morphology$stem$hithpael$en {
	_Translations$morphology$stem$hithpael$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Hitpael';
	@override String get description => 'Das Reflexiv oder Reziprok des Piel.';
	@override String get examples => 'er heiligte sich|sie gingen umher';
}

// Path: morphology.stem.nithpael
class _Translations$morphology$stem$nithpael$de extends Translations$morphology$stem$nithpael$en {
	_Translations$morphology$stem$nithpael$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Nitpael';
	@override String get description => 'Ein seltener reflexiv-passiver Stamm.';
	@override String get examples => 'es wurde gesühnt';
}

// Path: morphology.aspect.perfect
class _Translations$morphology$aspect$perfect$de extends Translations$morphology$aspect$perfect$en {
	_Translations$morphology$aspect$perfect$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Perfekt';
	@override String get description => 'Abgeschlossene Handlung, meist mit Vergangenheit übersetzt.';
	@override String get examples => 'er schrieb|sie hat geredet';
}

// Path: morphology.aspect.imperfect
class _Translations$morphology$aspect$imperfect$de extends Translations$morphology$aspect$imperfect$en {
	_Translations$morphology$aspect$imperfect$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Imperfekt';
	@override String get description => 'Unabgeschlossene oder zukünftige Handlung, oft mit Futur oder als Gewohnheit übersetzt.';
	@override String get examples => 'er wird schreiben|er schreibt';
}

// Path: morphology.aspect.imperative
class _Translations$morphology$aspect$imperative$de extends Translations$morphology$aspect$imperative$en {
	_Translations$morphology$aspect$imperative$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Imperativ';
	@override String get description => 'Ein direkter Befehl.';
	@override String get examples => 'Schreib!|Höre!';
}

// Path: morphology.aspect.infinitiveConstruct
class _Translations$morphology$aspect$infinitiveConstruct$de extends Translations$morphology$aspect$infinitiveConstruct$en {
	_Translations$morphology$aspect$infinitiveConstruct$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Infinitivus constructus';
	@override String get description => 'Ein Verbalsubstantiv in der Constructus-Form, oft mit Präpositionen verwendet.';
	@override String get examples => 'zu schreiben|beim Schreiben';
}

// Path: morphology.aspect.infinitiveAbsolute
class _Translations$morphology$aspect$infinitiveAbsolute$de extends Translations$morphology$aspect$infinitiveAbsolute$en {
	_Translations$morphology$aspect$infinitiveAbsolute$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Infinitivus absolutus';
	@override String get description => 'Ein selbstständiges Verbalsubstantiv, oft zur Betonung.';
	@override String get examples => 'gewiss sterben|gründlich schreiben';
}

// Path: morphology.aspect.participle
class _Translations$morphology$aspect$participle$de extends Translations$morphology$aspect$participle$en {
	_Translations$morphology$aspect$participle$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Partizip';
	@override String get description => 'Ein Verbaladjektiv, das eine andauernde Handlung beschreibt.';
	@override String get examples => 'schreibend|der Hörende';
}

// Path: morphology.aspect.consecutiveImperfect
class _Translations$morphology$aspect$consecutiveImperfect$de extends Translations$morphology$aspect$consecutiveImperfect$en {
	_Translations$morphology$aspect$consecutiveImperfect$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Imperfectum consecutivum';
	@override String get description => 'Erzählform der Vergangenheit: Waw + Imperfekt.';
	@override String get examples => 'und er sprach|und sie gingen';
}

// Path: morphology.aspect.conjunctiveImperfect
class _Translations$morphology$aspect$conjunctiveImperfect$de extends Translations$morphology$aspect$conjunctiveImperfect$en {
	_Translations$morphology$aspect$conjunctiveImperfect$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Imperfekt mit Waw';
	@override String get description => 'Imperfekt mit verbindendem Waw, mit zukünftigem oder modalem Sinn.';
	@override String get examples => 'und er wird schreiben';
}

// Path: morphology.aspect.conjunctivePerfect
class _Translations$morphology$aspect$conjunctivePerfect$de extends Translations$morphology$aspect$conjunctivePerfect$en {
	_Translations$morphology$aspect$conjunctivePerfect$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Perfekt mit Waw';
	@override String get description => 'Perfekt mit verbindendem Waw, oft zukünftig oder fortführend.';
	@override String get examples => 'und du sollst tun|und er wird richten';
}

// Path: morphology.aspect.passiveParticiple
class _Translations$morphology$aspect$passiveParticiple$de extends Translations$morphology$aspect$passiveParticiple$en {
	_Translations$morphology$aspect$passiveParticiple$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Passives Partizip';
	@override String get description => 'Die passive Form des Qal-Partizips.';
	@override String get examples => 'geschrieben|bewahrt';
}

// Path: morphology.hebrewMood.jussive
class _Translations$morphology$hebrewMood$jussive$de extends Translations$morphology$hebrewMood$jussive$en {
	_Translations$morphology$hebrewMood$jussive$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Jussiv';
	@override String get description => 'Ein Befehl oder Wunsch in der 3. Person.';
	@override String get examples => 'Es werde Licht|Der HERR segne dich';
}

// Path: morphology.hebrewMood.cohortative
class _Translations$morphology$hebrewMood$cohortative$de extends Translations$morphology$hebrewMood$cohortative$en {
	_Translations$morphology$hebrewMood$cohortative$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Kohortativ';
	@override String get description => 'Eine Willensform der 1. Person, etwa „lasst uns“ oder „ich will“.';
	@override String get examples => 'Lasst uns gehen|Ich will loben';
}

// Path: morphology.hebrewMood.hSuffix
class _Translations$morphology$hebrewMood$hSuffix$de extends Translations$morphology$hebrewMood$hSuffix$en {
	_Translations$morphology$hebrewMood$hSuffix$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'h-Suffix';
	@override String get description => 'Eine betonte Endung -ah am Imperfekt, oft ähnlich dem Kohortativ.';
	@override String get examples => 'ich will gewiss kommen|lass mich nahen';
}

// Path: morphology.tense.present
class _Translations$morphology$tense$present$de extends Translations$morphology$tense$present$en {
	_Translations$morphology$tense$present$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Präsens';
	@override String get description => 'Andauernde oder allgemeine Handlung.';
	@override String get examples => 'er liebt|sie gehen';
}

// Path: morphology.tense.imperfect
class _Translations$morphology$tense$imperfect$de extends Translations$morphology$tense$imperfect$en {
	_Translations$morphology$tense$imperfect$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Imperfekt';
	@override String get description => 'Andauernde oder wiederholte Handlung in der Vergangenheit.';
	@override String get examples => 'er lehrte|sie pflegten sich zu versammeln';
}

// Path: morphology.tense.future
class _Translations$morphology$tense$future$de extends Translations$morphology$tense$future$en {
	_Translations$morphology$tense$future$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Futur';
	@override String get description => 'Handlung, die geschehen wird.';
	@override String get examples => 'er wird kommen|sie werden sehen';
}

// Path: morphology.tense.aorist
class _Translations$morphology$tense$aorist$de extends Translations$morphology$tense$aorist$en {
	_Translations$morphology$tense$aorist$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Aorist';
	@override String get description => 'Einfache vergangene Handlung als Ganzes betrachtet.';
	@override String get examples => 'er sagte|sie gingen';
}

// Path: morphology.tense.perfect
class _Translations$morphology$tense$perfect$de extends Translations$morphology$tense$perfect$en {
	_Translations$morphology$tense$perfect$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Perfekt';
	@override String get description => 'Vergangene Handlung mit fortdauernder Wirkung in der Gegenwart.';
	@override String get examples => 'ist geschrieben|ist gekommen';
}

// Path: morphology.tense.pluperfect
class _Translations$morphology$tense$pluperfect$de extends Translations$morphology$tense$pluperfect$en {
	_Translations$morphology$tense$pluperfect$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Plusquamperfekt';
	@override String get description => 'Vergangene Handlung vor einem anderen vergangenen Ereignis.';
	@override String get examples => 'war geschrieben|war fortgegangen';
}

// Path: morphology.mood.indicative
class _Translations$morphology$mood$indicative$de extends Translations$morphology$mood$indicative$en {
	_Translations$morphology$mood$indicative$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Indikativ';
	@override String get description => 'Stellt eine Tatsache fest.';
	@override String get examples => 'er ist|sie schrieben';
}

// Path: morphology.mood.imperative
class _Translations$morphology$mood$imperative$de extends Translations$morphology$mood$imperative$en {
	_Translations$morphology$mood$imperative$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Imperativ';
	@override String get description => 'Erteilt einen Befehl.';
	@override String get examples => 'Geh!|Glaube!|Fürchte dich nicht!';
}

// Path: morphology.mood.subjunctive
class _Translations$morphology$mood$subjunctive$de extends Translations$morphology$mood$subjunctive$en {
	_Translations$morphology$mood$subjunctive$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Konjunktiv';
	@override String get description => 'Drückt Möglichkeit, Zweck oder Bedingung aus.';
	@override String get examples => 'damit er schreibe|wenn er geht';
}

// Path: morphology.mood.optative
class _Translations$morphology$mood$optative$de extends Translations$morphology$mood$optative$en {
	_Translations$morphology$mood$optative$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Optativ';
	@override String get description => 'Drückt einen Wunsch oder eine entfernte Möglichkeit aus.';
	@override String get examples => 'so sei es|Gnade sei mit dir';
}

// Path: morphology.mood.infinitive
class _Translations$morphology$mood$infinitive$de extends Translations$morphology$mood$infinitive$en {
	_Translations$morphology$mood$infinitive$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Infinitiv';
	@override String get description => 'Ein Verbalsubstantiv, etwa „tun“.';
	@override String get examples => 'schreiben|glauben';
}

// Path: morphology.mood.participle
class _Translations$morphology$mood$participle$de extends Translations$morphology$mood$participle$en {
	_Translations$morphology$mood$participle$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Partizip';
	@override String get description => 'Ein Verbaladjektiv, etwa „tuend“ oder „getan habend“.';
	@override String get examples => 'der Schreibende|nachdem er geredet hatte';
}

// Path: morphology.voice.active
class _Translations$morphology$voice$active$de extends Translations$morphology$voice$active$en {
	_Translations$morphology$voice$active$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Aktiv';
	@override String get description => 'Das Subjekt führt die Handlung aus.';
	@override String get examples => 'er schreibt|sie lehren';
}

// Path: morphology.voice.middle
class _Translations$morphology$voice$middle$de extends Translations$morphology$voice$middle$en {
	_Translations$morphology$voice$middle$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Medium';
	@override String get description => 'Das Subjekt handelt an sich selbst oder für sich selbst.';
	@override String get examples => 'er wäscht sich|sie verschafften sich';
}

// Path: morphology.voice.passive
class _Translations$morphology$voice$passive$de extends Translations$morphology$voice$passive$en {
	_Translations$morphology$voice$passive$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Passiv';
	@override String get description => 'Das Subjekt erfährt die Handlung.';
	@override String get examples => 'er wurde gesandt|sie wurden gelehrt';
}

// Path: morphology.voice.middleOrPassive
class _Translations$morphology$voice$middleOrPassive$de extends Translations$morphology$voice$middleOrPassive$en {
	_Translations$morphology$voice$middleOrPassive$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Medium/Passiv';
	@override String get description => 'Die Form kann Medium oder Passiv sein.';
	@override String get examples => 'wurde auferweckt / erhob sich|wurden versammelt / versammelten sich';
}

// Path: morphology.degree.positive
class _Translations$morphology$degree$positive$de extends Translations$morphology$degree$positive$en {
	_Translations$morphology$degree$positive$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Positiv';
	@override String get description => 'Die Grundform, weder Komparativ noch Superlativ.';
	@override String get examples => 'groß|gut';
}

// Path: morphology.degree.comparative
class _Translations$morphology$degree$comparative$de extends Translations$morphology$degree$comparative$en {
	_Translations$morphology$degree$comparative$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Komparativ';
	@override String get description => 'Vergleicht zwei Dinge.';
	@override String get examples => 'größer|besser als';
}

// Path: morphology.degree.superlative
class _Translations$morphology$degree$superlative$de extends Translations$morphology$degree$superlative$en {
	_Translations$morphology$degree$superlative$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get name => 'Superlativ';
	@override String get description => 'Drückt den höchsten Grad aus.';
	@override String get examples => 'am größten|am besten';
}

/// The flat map containing all translations for locale <de>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'languages.english' => 'Englisch',
			'languages.dutch' => 'Niederländisch',
			'languages.greek' => 'Griechisch',
			'languages.hebrew' => 'Hebräisch',
			'languages.russian' => 'Russisch',
			'languages.french' => 'Französisch',
			'languages.spanish' => 'Spanisch',
			'languages.german' => 'Deutsch',
			'languages.romanian' => 'Rumänisch',
			'highlightStyles.red' => 'Rot',
			'highlightStyles.orange' => 'Orange',
			'highlightStyles.yellow' => 'Gelb',
			'highlightStyles.green' => 'Grün',
			'highlightStyles.blue' => 'Blau',
			'highlightStyles.violet' => 'Violett',
			'highlightStyles.underline' => 'Unterstreichen',
			'highlightStyles.important' => 'Wichtig',
			'highlightStyles.highlight' => 'Markieren',
			'highlightStyles.squiggle' => 'Wellenlinie',
			'colors.red' => 'Rot',
			'colors.orange' => 'Orange',
			'colors.yellow' => 'Gelb',
			'colors.green' => 'Grün',
			'colors.blue' => 'Blau',
			'colors.violet' => 'Violett',
			'colors.silver' => 'Silber',
			'testaments.old' => 'Altes Testament',
			'testaments.newTestament' => 'Neues Testament',
			'testaments.oldOnly' => 'Nur Altes Testament',
			'testaments.newOnly' => 'Nur Neues Testament',
			'testaments.wholeBible' => 'Ganze Bibel',
			'testaments.oldOnlyDescription' => 'Enthält nur die Bücher des Alten Testaments.',
			'testaments.newOnlyDescription' => 'Enthält nur die Bücher des Neuen Testaments.',
			'testaments.wholeBibleDescription' => 'Enthält alle Bücher der Bibel.',
			'books.genesis' => '1. Mose',
			'books.exodus' => '2. Mose',
			'books.leviticus' => '3. Mose',
			'books.numbers' => '4. Mose',
			'books.deuteronomy' => '5. Mose',
			'books.joshua' => 'Josua',
			'books.judges' => 'Richter',
			'books.ruth' => 'Rut',
			'books.samuel1' => '1. Samuel',
			'books.samuel2' => '2. Samuel',
			'books.kings1' => '1. Könige',
			'books.kings2' => '2. Könige',
			'books.chronicles1' => '1. Chronik',
			'books.chronicles2' => '2. Chronik',
			'books.ezra' => 'Esra',
			'books.nehemiah' => 'Nehemia',
			'books.esther' => 'Ester',
			'books.job' => 'Hiob',
			'books.psalm' => 'Psalm',
			'books.psalms' => 'Psalmen',
			'books.proverbs' => 'Sprüche',
			'books.ecclesiastes' => 'Prediger',
			'books.songOfSolomon' => 'Hoheslied',
			'books.isaiah' => 'Jesaja',
			'books.jeremiah' => 'Jeremia',
			'books.lamentations' => 'Klagelieder',
			'books.ezekiel' => 'Hesekiel',
			'books.daniel' => 'Daniel',
			'books.hosea' => 'Hosea',
			'books.joel' => 'Joel',
			'books.amos' => 'Amos',
			'books.obadiah' => 'Obadja',
			'books.jonah' => 'Jona',
			'books.micah' => 'Micha',
			'books.nahum' => 'Nahum',
			'books.habakkuk' => 'Habakuk',
			'books.zephaniah' => 'Zefanja',
			'books.haggai' => 'Haggai',
			'books.zechariah' => 'Sacharja',
			'books.malachi' => 'Maleachi',
			'books.matthew' => 'Matthäus',
			'books.mark' => 'Markus',
			'books.luke' => 'Lukas',
			'books.john' => 'Johannes',
			'books.acts' => 'Apostelgeschichte',
			'books.romans' => 'Römer',
			'books.corinthians1' => '1. Korinther',
			'books.corinthians2' => '2. Korinther',
			'books.galatians' => 'Galater',
			'books.ephesians' => 'Epheser',
			'books.philippians' => 'Philipper',
			'books.colossians' => 'Kolosser',
			'books.thessalonians1' => '1. Thessalonicher',
			'books.thessalonians2' => '2. Thessalonicher',
			'books.timothy1' => '1. Timotheus',
			'books.timothy2' => '2. Timotheus',
			'books.titus' => 'Titus',
			'books.philemon' => 'Philemon',
			'books.hebrews' => 'Hebräer',
			'books.james' => 'Jakobus',
			'books.peter1' => '1. Petrus',
			'books.peter2' => '2. Petrus',
			'books.john1' => '1. Johannes',
			'books.john2' => '2. Johannes',
			'books.john3' => '3. Johannes',
			'books.jude' => 'Judas',
			'books.revelation' => 'Offenbarung',
			'common.add' => 'Hinzufügen',
			'common.addNew' => 'Neu hinzufügen',
			'common.am' => 'AM',
			'common.cancel' => 'Abbrechen',
			'common.close' => 'Schließen',
			'common.copy' => 'Kopieren',
			'common.continueLabel' => 'Weiter',
			'common.create' => 'Erstellen',
			'common.custom' => 'Eigene',
			'common.defaultLabel' => 'Standard',
			'common.delete' => 'Löschen',
			'common.done' => 'Fertig',
			'common.edit' => 'Bearbeiten',
			'common.finish' => 'Abschließen',
			'common.join' => 'Beitreten',
			'common.learnMore' => 'Mehr erfahren',
			'common.nevermind' => 'Doch nicht',
			'common.next' => 'Weiter',
			'common.noMatches' => 'Keine Treffer',
			'common.noNotification' => 'Keine Benachrichtigung',
			'common.ok' => 'OK',
			'common.off' => 'Aus',
			'common.none' => 'Keine',
			'common.clear' => 'Leeren',
			'common.remove' => 'Entfernen',
			'common.save' => 'Speichern',
			'common.search' => 'Suchen',
			'common.select' => 'Auswählen',
			'common.show' => 'Anzeigen',
			'common.hide' => 'Ausblenden',
			'common.pm' => 'PM',
			'common.sort' => 'Sortieren',
			'common.stop' => 'Beenden',
			'common.tryAgain' => 'Erneut versuchen',
			'common.switchTo' => ({required Object translation}) => 'Zu ${translation} wechseln',
			'common.notAvailableIn' => ({required Object translation}) => 'Das ist in ${translation} nicht verfügbar.',
			'copySheet.preview' => 'Vorschau',
			'copySheet.citation' => 'Quellenangabe',
			'copySheet.citationRequired' => 'Bei Online-Übersetzungen ist die Quellenangabe erforderlich.',
			'copySheet.textIn' => 'Text in',
			'copySheet.includeReference' => 'Bibelstelle angeben?',
			'copySheet.includeTranslation' => 'Übersetzung angeben?',
			'regionTypes.chapter' => 'dieses Kapitel',
			'regionTypes.verses' => 'diese Verse',
			'regionTypes.visibleVerses' => 'die sichtbaren Verse',
			'regionTypes.text' => 'diesen Text',
			'mainActions.pauseAudio' => 'Hörbibel pausieren',
			'mainActions.playAudio' => 'Hörbibel abspielen',
			'mainActions.bookmark' => 'Lesezeichen',
			'mainActions.study' => 'Studieren',
			'mainActions.verseOfTheDay' => 'Vers des Tages',
			'mainActions.addStudyPanel' => 'Studienpanel hinzufügen',
			'mainActions.search' => 'Suchen',
			'mainActions.resources' => 'Ressourcen',
			'mainActions.plans' => 'Lesepläne',
			'mainActions.settings' => 'Einstellungen',
			'mainActions.more' => 'Mehr',
			'mainActions.audioDescription' => 'Hör dir das aktuelle Kapitel mit einer Bibel mit Audio an.',
			'mainActions.bookmarkDescription' => 'Setze ein Lesezeichen für dieses Kapitel, um es auf der Suchseite schnell wiederzufinden.',
			'mainActions.manageBookmarkDescription' => 'Dieses Lesezeichen verwalten.',
			'mainActions.studyDescription' => 'Studienwerkzeuge für dieses Kapitel anzeigen.',
			'mainActions.verseOfTheDayDescription' => 'Den Vers des Tages anzeigen.',
			'mainActions.studyPanelDescription' => 'Hefte ein Panel neben den Text, das mitläuft und Studienwerkzeuge für das zeigt, was du gerade liest.',
			'mainActions.searchDescription' => 'Suche nach Wörtern in der ganzen Bibel.',
			'mainActions.resourcesDescription' => 'Entdecke Studienressourcen wie Wörterbuch, Lexikon, Personen und Themen.',
			'mainActions.plansDescription' => 'Lies die Bibel mit geführten Leseplänen.',
			'mainActions.settingsDescription' => 'Die Einstellungen von Lux anzeigen.',
			'mainActions.moreDescription' => 'Einstellungen, deine Inhalte und Community-Links anzeigen.',
			'verseOfTheDay.reminderDiscoveryTitle' => 'Tägliche Erinnerung hinzufügen?',
			'verseOfTheDay.reminderDiscoveryBody' => 'Möchtest du, dass Lux dich jeden Tag mit dem Vers des Tages benachrichtigt?',
			'verseOfTheDay.addReminder' => 'Erinnerung hinzufügen',
			'verseOfTheDay.noReminder' => 'Nein',
			'verseOfTheDay.dailyReminders' => 'Tägliche Erinnerung',
			'verseOfTheDay.deleteReminder' => 'Erinnerung löschen?',
			'verseOfTheDay.deleteReminderConfirmation' => 'Möchtest du deine tägliche Erinnerung an den Vers des Tages wirklich löschen?',
			'verseOfTheDay.reminderNotificationChannelName' => 'Erinnerungen an den Vers des Tages',
			'verseOfTheDay.reminderNotificationChannelDescription' => 'Tägliche Erinnerungen an den Vers des Tages',
			'verseOfTheDay.reminderNotificationTitle' => 'Vers des Tages',
			'verseOfTheDay.reminderPermissionDeniedTitle' => 'Benachrichtigungen sind aus',
			'verseOfTheDay.reminderPermissionDeniedBody' => 'Erlaube Lux in den Einstellungen, Benachrichtigungen zu senden, um diese Erinnerung zu speichern.',
			'verseOfTheDay.openNotificationSettings' => 'Einstellungen öffnen',
			'verseOfTheDay.reminderSchedulingFailedTitle' => 'Erinnerung konnte nicht geplant werden',
			'verseOfTheDay.reminderSchedulingFailedBody' => 'Lux konnte diese Erinnerung nicht planen. Bitte versuche es erneut.',
			'verseOfTheDay.reminderSaved' => ({required Object time}) => 'Erinnerung an den Vers des Tages für täglich um ${time} gespeichert.',
			'studyActions.quickStudy' => 'Schnellstudium',
			'studyActions.compare' => 'Vergleichen',
			'studyActions.interlinear' => 'Interlinear',
			'studyActions.commentary' => 'Kommentar',
			'studyActions.crossReferences' => 'Querverweise',
			'studyActions.linkedResources' => 'Verknüpfte Ressourcen',
			'studyActions.compareDescription' => ({required Object region}) => 'Vergleiche ${region} in verschiedenen Übersetzungen.',
			'studyActions.interlinearDescription' => ({required Object region}) => 'Zeige eine lexikalische Aufschlüsselung für ${region} mit Strong\'s.',
			'studyActions.commentaryDescription' => ({required Object region}) => 'Zeige Kommentare für ${region}.',
			'studyActions.crossReferencesDescription' => ({required Object region}) => 'Zeige Querverweise für ${region}.',
			'studyActions.linkedResourcesDescription' => ({required Object region}) => 'Zeige verknüpfte Personen, Themen und Karten für ${region}.',
			'studyActions.noCrossReferences' => 'Keine Querverweise gefunden',
			'studyActions.noLinkedResources' => 'Keine verknüpften Ressourcen gefunden',
			'studyActions.crossReferencesUse' => ({required Object translation}) => 'Querverweise aus ${translation}',
			'studyActions.onlineCrossReferencesExplanation' => 'Da deine gewählte Übersetzung nur online verfügbar ist, werden Querverweise mit der zuletzt verwendeten Studienbibel angezeigt, um Leistung und Kosten zu sparen. Überall sonst in der App wird deine gewählte Übersetzung verwendet.',
			'selectionActions.annotate' => 'Annotieren',
			'selectionActions.study' => 'Studieren',
			'selectionActions.share' => 'Teilen',
			'selectionActions.copy' => 'Kopieren',
			'selectionActions.highlight' => 'Markieren',
			'selectionActions.removeAnnotations' => 'Annotationen entfernen',
			'selectionActions.interlinear' => 'Interlinear',
			'selectionActions.search' => 'Suchen',
			'selectionActions.annotateVersesDescription' => 'Diese Verse annotieren.',
			'selectionActions.studyVersesDescription' => 'Diese Verse studieren.',
			'selectionActions.shareVersesDescription' => 'Einen Link zu diesen Versen teilen.',
			'selectionActions.copyVersesDescription' => 'Diese Verse in die Zwischenablage kopieren.',
			'selectionActions.annotateTextDescription' => 'Diesen Text annotieren.',
			'selectionActions.interlinearTextDescription' => 'Eine lexikalische Aufschlüsselung dieses Textes anzeigen.',
			'selectionActions.searchTextDescription' => 'Die Bibel nach diesem Text durchsuchen.',
			'selectionActions.copyTextDescription' => 'Diesen Text in die Zwischenablage kopieren.',
			'selectionActions.removeTextAnnotationsDescription' => ({required Object region}) => 'Entferne Annotationen der Textauswahl für ${region}.',
			'selectionActions.highlightTextDescription' => ({required Object region}) => 'Markiere ${region} mit der zuletzt verwendeten Farbe.',
			'selectionActions.removeVerseAnnotationsDescription' => ({required Object region}) => 'Entferne Annotationen der Versauswahl für ${region}.',
			'selectionActions.highlightVersesDescription' => ({required Object region}) => 'Markiere ${region} mit der zuletzt verwendeten Farbe.',
			'selectionActions.highlightedText' => ({required Object reference}) => 'Text in ${reference} markiert.',
			'selectionActions.highlightedVerses' => ({required Object reference}) => '${reference} markiert.',
			'selectionActions.copiedVerses' => ({required Object reference}) => '${reference} in die Zwischenablage kopiert.',
			'selectionActions.copiedText' => 'Textauswahl in die Zwischenablage kopiert.',
			'selectionActions.interlinearUnavailable' => 'Interlinear per Textauswahl ist nur in Studienbibeln verfügbar, die Wort für Wort mit Strong-Nummern und Morphologie ausgezeichnet sind. Wechsle zu einer Studienbibel, um diese Aktion zu nutzen.',
			'selectionActions.noInterlinearWords' => 'In dieser Auswahl wurden keine Interlinear-Wörter gefunden.',
			'selectionActions.textInReference' => ({required Object reference}) => 'Text in ${reference}',
			'studyPanels.title' => 'Studienpanel',
			'studyPanels.pinAsStudyPanel' => 'Als Studienpanel anheften',
			'studyPanels.compareWith' => ({required Object translation}) => 'Mit ${translation} vergleichen',
			'studyPanels.directionInterlinear' => ({required Object direction}) => 'Interlinear (${direction})',
			'studyPanels.commentaryName' => ({required Object commentary}) => 'Kommentar von ${commentary}',
			'studyPanels.notes' => 'Notizen',
			'studyPanels.noNotes' => 'Keine Notizen gefunden',
			'studyPanels.notesDescription' => 'Zeige deine Notizen in den sichtbaren Versen.',
			'studyPanels.swapBible' => 'Bibel wechseln',
			'studyPanels.swapDirection' => 'Richtung wechseln',
			'studyPanels.swapCommentary' => 'Kommentar wechseln',
			'bookmarks.create' => 'Lesezeichen erstellen',
			'bookmarks.manage' => 'Lesezeichen verwalten',
			'bookmarks.stopFollowing' => 'Nicht mehr folgen',
			'bookmarks.stopFollowingDescription' => 'Dieses Lesezeichen folgt dir nicht mehr.',
			'bookmarks.edit' => 'Lesezeichen bearbeiten',
			'bookmarks.delete' => 'Lesezeichen löschen',
			'bookmarks.deleteConfirmation' => 'Möchtest du dieses Lesezeichen wirklich löschen?',
			'bookmarks.deleteNamedConfirmation' => ({required Object name}) => 'Möchtest du „${name}“ wirklich löschen?',
			'bookmarkPage.title' => 'Deine Lesezeichen',
			'commentaries.addRemove' => 'Kommentare hinzufügen & entfernen',
			'toolbarShortcuts.switchBible' => 'Bibel wechseln',
			'toolbarShortcuts.dictionary' => 'Wörterbuch',
			'toolbarShortcuts.lexicon' => 'Lexikon',
			'toolbarShortcuts.themeAndLayout' => 'Design & Layout',
			'toolbarShortcuts.switchBibleDescription' => 'Die Bibelübersetzung wechseln.',
			'toolbarShortcuts.dictionaryDescription' => 'Schlage Personen, Orte und Themen im Tyndale Open Bible Dictionary nach.',
			'toolbarShortcuts.lexiconDescription' => 'Studiere die hebräischen und griechischen Grundwörter mit dem Strong-Lexikon.',
			'toolbarShortcuts.peopleDescription' => 'Lies Porträts biblischer Personen.',
			'toolbarShortcuts.themesDescription' => 'Lies Artikel zu zentralen Themen der Bibel.',
			'toolbarShortcuts.mapsDescription' => 'Erkunde Karten der Orte und Reisen in der Bibel.',
			'toolbarShortcuts.themeAndLayoutDescription' => 'Passe Design & Layout der Bibel an.',
			'labels.about' => 'Über',
			'labels.annotation' => 'Annotation',
			'labels.annotations' => 'Annotationen',
			'labels.audioBible' => 'Hörbibel',
			'labels.bible' => 'Bibel',
			'labels.bibles' => 'Bibeln',
			'labels.biblePlans' => 'Lesepläne',
			'labels.bookmarks' => 'Lesezeichen',
			'labels.books' => 'Bücher',
			'labels.color' => 'Farbe',
			'labels.commentaries' => 'Kommentare',
			'labels.commentary' => 'Kommentar',
			'labels.community' => 'Community',
			'labels.completed' => 'Abgeschlossen',
			'labels.crossReferences' => 'Querverweise',
			'labels.days' => 'Tage',
			'labels.dictionary' => 'Wörterbuch',
			'labels.discord' => 'Discord',
			'labels.duration' => 'Dauer',
			'labels.following' => 'Folgt',
			'labels.footnotes' => 'Fußnoten',
			'labels.help' => 'Hilfe',
			'labels.highlightStyles' => 'Markierungsstile',
			'labels.instagram' => 'Instagram',
			'labels.facebook' => 'Facebook',
			'labels.tiktok' => 'TikTok',
			'labels.youtube' => 'YouTube',
			'labels.interlinear' => 'Interlinear',
			'labels.language' => 'Sprache',
			'labels.layout' => 'Layout',
			'labels.lexicon' => 'Lexikon',
			'labels.licenses' => 'Lizenzen',
			'labels.locations' => 'Bereiche',
			'labels.maps' => 'Karten',
			'labels.name' => 'Name',
			'labels.note' => 'Notiz',
			'labels.notebook' => 'Notizbuch',
			'labels.notebooks' => 'Notizbücher',
			'labels.notes' => 'Notizen',
			'labels.paragraphs' => 'Absätze',
			'labels.people' => 'Personen',
			'labels.resources' => 'Ressourcen',
			'labels.scope' => 'Umfang',
			'labels.search' => 'Suche',
			'labels.selection' => 'Auswahl',
			'labels.settings' => 'Einstellungen',
			'labels.source' => 'Quelle',
			'labels.study' => 'Studium',
			'labels.style' => 'Stil',
			'labels.text' => 'Text',
			'labels.themes' => 'Themen',
			'labels.toolbar' => 'Symbolleiste',
			'labels.toolbars' => 'Symbolleisten',
			'labels.type' => 'Art',
			'labels.version' => 'Version',
			'labels.visibility' => 'Sichtbarkeit',
			'strongSheet.interlinearWord' => 'Interlinear-Wort',
			'strongSheet.lexicon' => 'Lexikon',
			'strongSheet.legend' => 'Legende',
			'strongSheet.openInSearch' => 'In der Suche öffnen',
			'strongSheet.usage' => 'Verwendung',
			'strongSheet.inflected' => 'Flektiert',
			'strongSheet.transliteration' => 'Transliteration',
			'strongSheet.root' => 'Grundform',
			'strongSheet.strongsId' => ({required Object id}) => 'Strong\'s ${id}',
			'strongSheet.rootWord' => 'Grundwort',
			'strongSheet.pronunciation' => 'Aussprache',
			'strongSheet.strongsDefinition' => 'Strong-Definition',
			'strongSheet.biblicalUsage' => 'Biblischer Gebrauch',
			'strongSheet.definition' => 'Definition',
			'strongSheet.examples' => 'Beispiele',
			'strongSheet.examplesPrefix' => 'Beispiele: ',
			'strongSheet.partOfSpeech' => 'Wortart',
			'strongSheet.derivation' => 'Herleitung',
			'strongSheet.morphology' => 'Morphologie',
			'strongSheet.relatedTerms' => 'Verwandte Begriffe',
			'strongSheet.morphologyInfo' => 'Morphologie-Info',
			'strongSheet.definitionLegend' => 'Legende zur Strong-Definition',
			'strongSheet.optionalWord' => 'Optionales Wort',
			'strongSheet.optionalWordDescription' => 'Kennzeichnet ein Wort oder eine Silbe, die zum Hauptwort ergänzt werden kann.',
			'strongSheet.addedWord' => 'Ergänztes Wort im Hebräischen oder Griechischen',
			'strongSheet.addedWordDescription' => 'Kennzeichnet ein Wort, das in der englischen Wiedergabe steht, obwohl es im Hebräischen oder Griechischen fehlt.',
			'strongSheet.explanation' => 'Erklärung',
			'strongSheet.renderingExplanation' => 'Kursiver Text am Ende einer Wiedergabe erklärt eine Abweichung von der üblichen Form.',
			'strongSheet.concordance' => 'Konkordanz',
			'bibleDetails.onlineOnly' => 'Nur online',
			'bibleDetails.onlineDescription' => ({required Object source}) => 'Diese Bibel wird von ${source} gestreamt und benötigt daher eine Internetverbindung.',
			'bibleDetails.studyBible' => 'Studienbibel',
			'bibleDetails.audioBible' => 'Hörbibel',
			'bibleDetails.onDevice' => 'Auf dem Gerät',
			'bibleDetails.onDeviceDescription' => 'Diese Bibel ist auf dein Gerät heruntergeladen, sodass du sie durchsuchen und offline lesen kannst.',
			'bibleDetails.studyBibleDescription' => 'Enthält Interlinear- und Morphologiedaten. Drücke beim Lesen lange auf ein Wort, um das griechische oder hebräische Original zu sehen.',
			'bibleDetails.readingBible' => 'Lesebibel',
			'bibleDetails.readingBibleDescription' => 'Enthält keine Interlinear- oder Morphologiedaten.',
			'bibleDetails.nativeHeadings' => 'Eigene Überschriften',
			'bibleDetails.nativeHeadingsDescription' => 'Diese Bibel enthält Überschriften.',
			'bibleDetails.syntheticHeadings' => 'Ergänzte Überschriften',
			'bibleDetails.syntheticHeadingsDescription' => 'Überschriften werden aus der BSB in diese Bibel eingefügt.',
			'bibleDetails.noHeadings' => 'Keine Überschriften',
			'bibleDetails.noHeadingsDescription' => 'Diese Bibel enthält keine Überschriften.',
			'bibleDetails.audioSupportDescription' => 'Ob diese Bibel eine Hörbibel enthält',
			'bibleDetails.redLetters' => 'Rote Worte Jesu',
			'bibleDetails.redLettersDescription' => 'Ob diese Bibel die Worte Jesu in Rot unterstützt.',
			'bibleDetails.footnotesDescription' => 'Ob diese Bibel Fußnoten enthält.',
			'bibleDetails.paragraphsDescription' => 'Ob diese Bibel Absätze enthält.',
			'bibleDetails.addRemoveBibles' => 'Bibeln hinzufügen & entfernen',
			'bibleDetails.verseNumbering' => 'Verszählung',
			'emptyStates.noCommentaries' => 'Keine Kommentare gefunden',
			'emptyStates.noMatchingWords' => 'Keine passenden Wörter',
			'emptyStates.noMatchingTerms' => 'Keine passenden Begriffe',
			'emptyStates.noMatchingPlans' => 'Keine passenden Lesepläne.',
			'emptyStates.noMatchingAnnotations' => 'Keine passenden Annotationen.',
			'emptyStates.noSearchResults' => 'Keine Suchergebnisse gefunden',
			'emptyStates.tryAnotherSearch' => 'Versuche eine andere Suche',
			'emptyStates.noCommentariesAdded' => 'Du hast noch keine Kommentare hinzugefügt.',
			'emptyStates.noAnnotations' => 'Du hast noch keine Annotationen erstellt.',
			'emptyStates.noBookmarks' => 'Du hast noch keine Lesezeichen erstellt.',
			'emptyStates.noNotebooks' => 'Du hast noch keine Notizbücher erstellt. Mit Notizbüchern kannst du deine Annotationen ordnen.',
			'emptyStates.noPlans' => 'Du folgst noch keinem Leseplan. Starte einen, um die Bibel durchzulesen.',
			'annotationUi.yourAnnotations' => 'Deine Annotationen',
			'annotationUi.annotate' => 'Annotieren',
			'annotationUi.withNotes' => 'Mit Notizen',
			'annotationUi.withoutNotes' => 'Ohne Notizen',
			'annotationUi.mostRecent' => 'Neueste',
			'annotationUi.location' => 'Bibelstelle',
			'annotationUi.deleteAnnotation' => 'Annotation löschen',
			'annotationUi.deleteConfirmation' => 'Möchtest du diese Annotation wirklich löschen?',
			'annotationUi.annotationCount' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(count, one: '${count} Annotation', other: '${count} Annotationen', ), 
			'annotationUi.annotatedTime' => ({required Object time}) => 'Annotiert ${time}',
			'notebookUi.yourNotebooks' => 'Deine Notizbücher',
			'notebookUi.hidden' => 'Ausgeblendet',
			'notebookUi.hideDescription' => 'Die Annotationen in diesem Notizbuch in der Bibel ausblenden.',
			'notebookUi.showDescription' => 'Die Annotationen aus diesem Notizbuch in der Bibel anzeigen.',
			'notebookUi.defaultDescription' => 'Das feste Notizbuch für nicht zugeordnete Annotationen.',
			'notebookUi.create' => 'Notizbuch erstellen',
			'notebookUi.edit' => 'Notizbuch bearbeiten',
			'notebookUi.delete' => 'Notizbuch löschen',
			'notebookUi.deleteNamedConfirmation' => ({required Object name}) => 'Möchtest du „${name}“ wirklich löschen?',
			'notebookUi.deleteWithAnnotations' => ({required Object name, required Object annotations}) => '„${name}“ enthält ${annotations}. Möchtest du sie ebenfalls löschen oder im Standard-Notizbuch behalten?',
			'notebookUi.keepInDefault' => 'Im Standard behalten',
			'notebookUi.deleteAnnotations' => 'Annotationen löschen',
			'highlightStyleUi.yourStyles' => 'Deine Markierungsstile',
			'highlightStyleUi.create' => 'Stil erstellen',
			'highlightStyleUi.edit' => 'Stil bearbeiten',
			'highlightStyleUi.duplicate' => 'Diesen Stil hast du bereits',
			'highlightStyleUi.delete' => 'Stil löschen',
			'highlightStyleUi.deleteNamedConfirmation' => ({required Object name}) => 'Möchtest du „${name}“ wirklich löschen?',
			'highlightStyleUi.deleteWithAnnotations' => ({required Object name, required Object annotations}) => '„${name}“ wird von ${annotations} verwendet. Möchtest du sie ebenfalls löschen oder behalten?',
			'highlightStyleUi.keepAnnotations' => 'Annotationen behalten',
			'highlightStyleUi.deleteAnnotations' => 'Annotationen löschen',
			'highlightStyleUi.updateAnnotations' => 'Annotationen aktualisieren',
			'highlightStyleUi.updateWithAnnotations' => ({required Object name, required Object annotations}) => '„${name}“ wird von ${annotations} verwendet. Möchtest du sie auf den neuen Stil aktualisieren oder unverändert lassen?',
			'highlightStyleUi.leaveAsIs' => 'Unverändert lassen',
			'highlightStyleUi.label' => 'Bezeichnung',
			'toolbarSettings.mainToolbar' => 'Hauptleiste',
			'toolbarSettings.verseSelection' => 'Versauswahl',
			'toolbarSettings.textSelection' => 'Textauswahl',
			'toolbarSettings.shownForMain' => 'Wird angezeigt, wenn nichts ausgewählt ist.',
			'toolbarSettings.shownForVerses' => 'Wird angezeigt, wenn ein Vers ausgewählt ist.',
			'toolbarSettings.shownForText' => 'Wird angezeigt, wenn du lange auf Text in Versen drückst.',
			'toolbarSettings.gestures' => 'Gesten',
			'toolbarSettings.longPress' => 'Langes Drücken',
			'toolbarSettings.mainLongPressDescription' => 'Kurzbefehl, wenn lange auf die Symbolleiste gedrückt wird.',
			'toolbarSettings.verseLongPressDescription' => 'Kurzbefehl, wenn lange auf eine Versauswahl gedrückt wird.',
			'toolbarSettings.textLongPressDescription' => 'Kurzbefehl, wenn lange auf eine Textauswahl gedrückt wird.',
			'toolbarSettings.hideToolbar' => 'Ausblenden',
			'toolbarSettings.hideToolbarDescription' => 'Blende die Symbolleiste beim Herunterscrollen aus, um ungestört in der Bibel zu lesen.',
			'toolbarSettings.pinToolbar' => 'Anheften',
			'toolbarSettings.pinToolbarDescription' => 'Hefte die Symbolleiste unten auf der Seite an.',
			'toolbarSettings.expandToAnnotation' => 'Auf Annotation erweitern',
			'toolbarSettings.expandTextDescription' => 'Langes Drücken auf ein annotiertes Wort wählt den ganzen markierten Bereich aus.',
			'toolbarSettings.expandVerseDescription' => 'Tippen auf einen Vers wählt die ganze annotierte Versauswahl aus.',
			'toolbarSettings.rangeSelection' => 'Bereichsauswahl',
			'toolbarSettings.rangeSelectionDescription' => 'Tippen auf einen zweiten Vers wählt alle Verse zwischen ihm und dem ersten aus.',
			'toolbarSettings.mainShortcut' => 'Kurzbefehl der Hauptleiste',
			'toolbarSettings.verseShortcut' => 'Kurzbefehl der Versauswahl',
			'toolbarSettings.textShortcut' => 'Kurzbefehl der Textauswahl',
			'themeSettings.title' => 'Design & Layout',
			'themeSettings.brightness' => 'Helligkeit',
			'themeSettings.font' => 'Schriftart',
			'themeSettings.fontSizeSpacing' => 'Schriftgröße & Abstand',
			'themeSettings.greekFontSizeSpacing' => 'Griechisch: Schriftgröße & Abstand',
			'themeSettings.hebrewFontSizeSpacing' => 'Hebräisch: Schriftgröße & Abstand',
			'themeSettings.system' => 'System',
			'themeSettings.systemTextSizeDescription' => 'Die bevorzugte Textgröße deines Geräts verwenden.',
			'themeSettings.defaultSizeDescription' => 'Die Standardwerte für Schriftgröße & Abstand verwenden.',
			'themeSettings.redLetters' => 'Rote Worte Jesu',
			'themeSettings.redLettersDescription' => 'Die Worte Jesu in Rot anzeigen.',
			'themeSettings.sectionHeadings' => 'Zwischenüberschriften',
			'themeSettings.verseNumbers' => 'Versnummern',
			'themeSettings.paragraphsDescription' => 'Verse in Absätzen darstellen.',
			'themeSettings.footnotesDescription' => 'Fußnotenzeichen im Text anzeigen.',
			'biblePlans.startABiblePlan' => 'Leseplan starten',
			'biblePlans.includedPlans' => 'Enthaltene Pläne',
			'biblePlans.includedPlansDescription' => 'Pläne, die in Lux enthalten sind.',
			'biblePlans.customPlansDescription' => 'Pläne, die du erstellt hast.',
			'biblePlans.createCustomPlan' => 'Eigenen Plan erstellen',
			'biblePlans.creationMethodQuestion' => 'Wie möchtest du deinen Plan erstellen?',
			'biblePlans.createWithAi' => 'Mit KI erstellen',
			'biblePlans.createWithAiDescription' => 'Erhalte einen Prompt für deine eigene KI und importiere dann den Plan, den sie erstellt.',
			'biblePlans.describeYourPlan' => 'Beschreibe deinen Plan',
			'biblePlans.planDescription' => 'Planbeschreibung',
			'biblePlans.describeYourPlanHint' => 'Beschreibe deinen Plan',
			'biblePlans.descriptionRequired' => 'Beschreibe den Plan, den du erstellen möchtest.',
			'biblePlans.examples' => 'Beispiele',
			'biblePlans.aiExamples' => 'Planbeispiele',
			'biblePlans.aiExampleList.0' => 'Lies den Römerbrief in 30 Tagen.',
			'biblePlans.aiExampleList.1' => 'Lies das Neue Testament in einem Monat.',
			'biblePlans.aiExampleList.2' => 'Lies Psalmen und Sprüche in 90 Tagen, mit einem Tag zum Nachdenken pro Woche.',
			'biblePlans.aiExampleList.3' => 'Lies die vier Evangelien in 60 Tagen und wechsle jeden Tag zwischen ihnen.',
			'biblePlans.aiExampleList.4' => 'Wechsle jeden Tag zwischen Lesungen aus dem Alten und dem Neuen Testament. Jeder Sonntag ist ein Tag zum Nachdenken. Lies die ganze Bibel in einem Jahr.',
			'biblePlans.aiImportTitle' => 'Mit KI erstellen & importieren',
			'biblePlans.aiImportInstructions' => 'Kopiere den Prompt in die KI, die du nutzt, und importiere dann den Plan, den sie erstellt.',
			'biblePlans.copyPrompt' => 'Prompt kopieren',
			'biblePlans.promptCopied' => 'Prompt in die Zwischenablage kopiert.',
			'biblePlans.importAction' => 'Importieren',
			'biblePlans.importDescription' => 'Einen Leseplan importieren.',
			'biblePlans.importPlan' => 'Leseplan importieren',
			'biblePlans.importPlanTitle' => 'Plan importieren',
			'biblePlans.importInstructions' => 'Importiere eine von Lux exportierte Leseplan-Datei oder füge kompatible Planinhalte ein.',
			'biblePlans.importOptionsHintPrefix' => 'Importiere eine ',
			'biblePlans.importOptionsHintSuffix' => '-Datei oder füge ihren Inhalt ein.',
			'biblePlans.aiImportOptionsHintPrefix' => 'Lux kann eine ',
			'biblePlans.aiImportOptionsHintSuffix' => '-Datei oder eingefügte Dateiinhalte importieren, je nachdem, was deine KI liefert.',
			'biblePlans.importSource' => 'Wie möchtest du den Plan importieren?',
			'biblePlans.importFromFile' => 'Aus Datei importieren',
			'biblePlans.importFromFileDescription' => 'Wähle eine heruntergeladene .lxbp-Datei.',
			'biblePlans.pasteToImport' => 'Zum Importieren einfügen',
			'biblePlans.pasteToImportDescription' => 'Füge den Inhalt einer .lxbp-Datei oder eines kompatiblen Plans ein.',
			'biblePlans.pastePlan' => 'Leseplan einfügen',
			'biblePlans.fileContents' => 'Dateiinhalt',
			'biblePlans.fileContentsHint' => 'Füge den Dateiinhalt hier ein',
			'biblePlans.biblePlanFile' => 'Lux-Leseplan',
			'biblePlans.importSucceeded' => ({required Object name}) => '„${name}“ ist bereit zum Importieren.',
			'biblePlans.share' => 'Teilen',
			'biblePlans.shareDescription' => 'Diese Leseplan-Datei mit einer anderen App oder Person teilen.',
			'biblePlans.download' => 'Herunterladen',
			'biblePlans.downloadDescription' => 'Diese Leseplan-Datei auf deinem Gerät speichern.',
			'biblePlans.importErrors.readFailed' => 'Lux konnte diese Datei nicht lesen. Versuche, sie erneut auszuwählen.',
			'biblePlans.importErrors.malformedJson' => 'Diese Datei ist nicht richtig formatiert.',
			'biblePlans.importErrors.invalidStructure' => 'Diese Datei ist kein gültiger Leseplan.',
			'biblePlans.importErrors.nameRequired' => 'Der importierte Plan braucht einen Namen.',
			'biblePlans.importErrors.invalidDayCount' => 'Der importierte Plan muss 1 bis 365 Tage enthalten.',
			'biblePlans.importErrors.readingRequired' => 'Der importierte Plan braucht mindestens einen Lesetag.',
			'biblePlans.importErrors.invalidPassage' => 'Der importierte Plan enthält eine ungültige Bibelstelle.',
			'biblePlans.importErrors.duplicatePassage' => 'Ein Tag im importierten Plan enthält denselben Abschnitt mehrmals.',
			'biblePlans.manual' => 'Manuell',
			'biblePlans.manualDescription' => 'Füge jeden Abschnitt selbst hinzu.',
			'biblePlans.chooseBooksAndDuration' => 'Bücher & Dauer wählen',
			'biblePlans.chooseBooksAndDurationDescription' => 'Lies Bücher über einen festgelegten Zeitraum.',
			'biblePlans.chooseBooks' => 'Bücher wählen',
			'biblePlans.filterBooks' => 'Bücher filtern',
			'biblePlans.chooseDuration' => 'Dauer wählen',
			_ => null,
		} ?? switch (path) {
			'biblePlans.durationInstructions' => 'Wie viele Tage soll dein Plan dauern?',
			'biblePlans.durationDayCount' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(count, one: '${count} Tag', other: '${count} Tage', ), 
			'biblePlans.generatedNames.twoBooks' => ({required Object first, required Object second}) => '${first} & ${second}',
			'biblePlans.generatedNames.bookCount' => ({required Object count}) => '${count} Bücher',
			'biblePlans.generatedNames.bible' => 'Bibel',
			'biblePlans.generatedNames.inOneDay' => ({required Object books}) => '${books} in 1 Tag',
			'biblePlans.generatedNames.inDays' => ({required Object books, required Object count}) => '${books} in ${count} Tagen',
			'biblePlans.generatedNames.inAYear' => ({required Object books}) => '${books} in einem Jahr',
			'biblePlans.nameAndColor' => 'Name & Farbe',
			'biblePlans.review' => 'Plan prüfen',
			'biblePlans.createAndStart' => 'Erstellen & starten',
			'biblePlans.myBiblePlan' => 'Mein Leseplan',
			'biblePlans.nameRequired' => 'Gib einen Namen für deinen Plan ein.',
			'biblePlans.nameAlreadyExists' => 'Ein Leseplan mit diesem Namen existiert bereits.',
			'biblePlans.discardPlanQuestion' => 'Änderungen verwerfen?',
			'biblePlans.discardPlanConfirmation' => 'Deine Änderungen gehen verloren.',
			'biblePlans.discard' => 'Verwerfen',
			'biblePlans.addDay' => 'Tag hinzufügen',
			'biblePlans.addPassage' => 'Abschnitt hinzufügen',
			'biblePlans.removeDay' => 'Tag entfernen',
			'biblePlans.removeDayQuestion' => 'Diesen Tag entfernen?',
			'biblePlans.removeDayConfirmation' => ({required Object day}) => 'Tag ${day} und seine Abschnitte werden entfernt.',
			'biblePlans.moveToAnotherDay' => 'Auf einen anderen Tag verschieben',
			'biblePlans.deletePlan' => 'Plan löschen',
			'biblePlans.deletePlanQuestion' => 'Diesen Plan löschen?',
			'biblePlans.deletePlanConfirmation' => ({required Object name}) => 'Möchtest du „${name}“ wirklich löschen?',
			'biblePlans.mixed' => 'Gemischt',
			'biblePlans.mixedScopeDescription' => 'Liest ausgewählte Bücher aus beiden Testamenten.',
			'biblePlans.startPlanQuestion' => 'Plan starten?',
			'biblePlans.reviewAndReflect' => 'Wiederholen & nachdenken',
			'biblePlans.startPlan' => 'Plan starten',
			'biblePlans.dailyReminders' => 'Tägliche Erinnerungen',
			'biblePlans.dailyRemindersDescription' => 'Lege fest, wann dich dieser Plan täglich ans Lesen erinnert.',
			'biblePlans.dailyAt' => ({required Object time}) => 'Täglich um ${time}',
			'biblePlans.reminderDiscoveryTitle' => 'Tägliche Erinnerung hinzufügen?',
			'biblePlans.reminderDiscoveryBody' => ({required Object name}) => 'Möchtest du, dass Lux dich jeden Tag daran erinnert, „${name}“ weiterzulesen?',
			'biblePlans.addReminder' => 'Erinnerung hinzufügen',
			'biblePlans.noReminder' => 'Nein',
			'biblePlans.deleteReminder' => 'Erinnerung löschen?',
			'biblePlans.deleteReminderConfirmation' => ({required Object name}) => 'Möchtest du die tägliche Erinnerung für „${name}“ wirklich löschen?',
			'biblePlans.reminderNotificationChannelName' => 'Erinnerungen an Lesepläne',
			'biblePlans.reminderNotificationChannelDescription' => 'Tägliche Erinnerungen an deine Lesepläne',
			'biblePlans.reminderNotificationTitle' => ({required Object name}) => '„${name}“ lesen',
			'biblePlans.reminderNotificationBody' => ({required Object reading}) => 'Die heutige Lesung ist ${reading}',
			'biblePlans.reminderPermissionDeniedTitle' => 'Benachrichtigungen sind aus',
			'biblePlans.reminderPermissionDeniedBody' => 'Erlaube Lux in den Einstellungen, Benachrichtigungen zu senden, um diese Erinnerung zu speichern.',
			'biblePlans.openNotificationSettings' => 'Einstellungen öffnen',
			'biblePlans.reminderSchedulingFailedTitle' => 'Erinnerung konnte nicht geplant werden',
			'biblePlans.reminderSchedulingFailedBody' => 'Lux konnte diese Erinnerung nicht planen. Bitte versuche es erneut.',
			'biblePlans.reminderSaved' => ({required Object name, required Object time}) => 'Erinnerung für „${name}“ täglich um ${time} gespeichert.',
			'biblePlans.stopPlan' => 'Plan beenden',
			'biblePlans.stopPlanDescription' => 'Diesen Plan und seinen Fortschritt in den Verlauf verschieben.',
			'biblePlans.readEntireChapter' => 'Ganzes Kapitel lesen',
			'biblePlans.pace' => 'Tempo',
			'biblePlans.choosePace' => 'Wähle dein Tempo',
			'biblePlans.relaxed' => 'Entspannt',
			'biblePlans.relaxedDescription' => 'Lies, wann immer du möchtest, ohne Zeitplan, mit dem du Schritt halten musst.',
			'biblePlans.paced' => 'Mit Zeitplan',
			'biblePlans.pacedDescription' => 'Lege ein Zielenddatum fest und sieh, ob du im Plan liegst.',
			'biblePlans.pacedToEnd' => ({required Object date}) => 'Ziel: Ende am ${date}',
			'biblePlans.targetEndDate' => 'Zielenddatum',
			'biblePlans.onTrack' => 'Im Plan',
			'biblePlans.daysBehind' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(count, one: '${count} Tag im Rückstand', other: '${count} Tage im Rückstand', ), 
			'biblePlans.daysAhead' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(count, one: '${count} Tag voraus', other: '${count} Tage voraus', ), 
			'biblePlans.catchUp' => 'Aufholen',
			'biblePlans.reviewDayAnnotations' => 'Annotationen des Tages ansehen',
			'biblePlans.history' => 'Verlauf',
			'biblePlans.historyDescription' => 'Früheren Fortschritt ansehen oder einen beendeten Plan fortsetzen.',
			'biblePlans.resume' => 'Fortsetzen',
			'biblePlans.resumeDescription' => 'Diesen Plan dort fortsetzen, wo du aufgehört hast.',
			'biblePlans.replace' => 'Ersetzen',
			'biblePlans.replacePlanQuestion' => 'Aktuellen Plan ersetzen?',
			'biblePlans.replacePlanConfirmation' => ({required Object name}) => 'Du folgst bereits „${name}“. Wenn du diesen Plan fortsetzt, wird dein aktueller Fortschritt in den Verlauf dieses Plans verschoben.',
			'biblePlans.viewAllAnnotations' => 'Alle Annotationen des Plans ansehen',
			'biblePlans.viewAllAnnotationsDescription' => 'Sieh dir jede Annotation an, die du beim Lesen dieses Plans erstellt hast.',
			'biblePlans.stoppedOn' => ({required Object date}) => 'Beendet am ${date}',
			'biblePlans.finishedOn' => ({required Object date}) => 'Abgeschlossen am ${date}',
			'biblePlans.deleteFromHistoryDescription' => 'Diesen Fortschritt aus dem Verlauf entfernen.',
			'biblePlans.deleteFromHistoryQuestion' => 'Aus dem Verlauf löschen?',
			'biblePlans.deleteFromHistoryConfirmation' => ({required Object name}) => 'Dieser Fortschritt bei „${name}“ wird gelöscht. Seine Annotationen bleiben unter Annotationen erhalten.',
			'biblePlans.deletePlanWithHistoryConfirmation' => ({required Object name}) => 'Möchtest du „${name}“ wirklich löschen? Der Verlauf des Plans wird ebenfalls gelöscht.',
			'biblePlans.readInContext' => 'Im Zusammenhang lesen',
			'biblePlans.startNew' => 'Neu starten',
			'biblePlans.day' => ({required Object day}) => 'Tag ${day}',
			'biblePlans.dayCount' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(count, one: '${count} Tag', other: '${count} Tage', ), 
			'biblePlans.stopConfirmation' => ({required Object name}) => '„${name}“ beenden? Du kannst den Plan später über den Verlauf dieses Plans unter „Leseplan starten“ fortsetzen.',
			'biblePlans.completed' => ({required Object name}) => '„${name}“ abgeschlossen.',
			'biblePlans.addPlan' => 'Leseplan hinzufügen',
			'searchUi.searchBible' => 'Bibel durchsuchen',
			'searchUi.startSearch' => 'Starte eine Suche',
			'searchUi.searchPrompt' => 'Gib ein Stichwort wie Licht, Wort oder Weisheit ein und drücke dann auf der Tastatur Enter.',
			'searchUi.usingTranslation' => ({required Object translation}) => 'Suche in ${translation}',
			'searchUi.unsupportedTranslation' => ({required Object translation}) => '${translation} unterstützt die Suche derzeit nicht. Stattdessen wird deine zuletzt verwendete Studienbibel genutzt.',
			'searchUi.strongSearchStudyBibleExplanation' => 'Die Suche nach Strong-Nummern benötigt die Strong-Auszeichnung auf Wortebene, die Studienbibeln enthalten. Stattdessen wird deine zuletzt verwendete Studienbibel genutzt.',
			'searchUi.wordOrPhraseHint' => 'Nach einem Wort oder Ausdruck suchen',
			'searchUi.wordHint' => 'Nach einem Wort suchen',
			'searchUi.strongNumberHint' => 'Nach einer Strong-Nummer suchen (z. B. H125)',
			'searchUi.wordMatching.title' => 'Wortabgleich',
			'searchUi.wordMatching.wholeWord.title' => 'Ganzes Wort',
			'searchUi.wordMatching.wholeWord.description' => 'Findet nur vollständige Wörter, die deiner Suche entsprechen.',
			'searchUi.wordMatching.wholeWord.example' => 'Beispiel: „Licht“ findet „Licht“',
			'searchUi.wordMatching.startOfWord.title' => 'Wortanfang',
			'searchUi.wordMatching.startOfWord.description' => 'Findet Wörter, die mit deiner Suche beginnen.',
			'searchUi.wordMatching.startOfWord.example' => 'Beispiel: „Licht“ findet auch „Lichter“',
			'searchUi.wordMatching.partOfWord.title' => 'Wortteil',
			'searchUi.wordMatching.partOfWord.description' => 'Findet Wörter, die deine Suche irgendwo enthalten.',
			'searchUi.wordMatching.partOfWord.example' => 'Beispiel: „Licht“ findet auch „Tageslicht“',
			'onboarding.skipQuestion' => 'Einführung überspringen?',
			'onboarding.skipConfirmation' => 'Möchtest du die Einführung wirklich überspringen? Du kannst sie unter Einstellungen > Hilfe erneut starten.',
			'onboarding.getStarted' => 'Erste Schritte',
			'onboarding.learnLux' => 'Lerne Lux kennen',
			'onboarding.checklistDescription' => 'Arbeite die Checkliste unten ab, um Lux kennenzulernen.',
			'onboarding.skipHint' => 'Keine Zeit? Tippe auf ✕, um zu überspringen.',
			'onboarding.joinDiscord' => 'Tritt unserer Discord-Community bei',
			'onboarding.discordInvitation' => 'Stell Fragen, gib Feedback und vernetze dich mit anderen, die Lux nutzen.',
			'analyticsNotice.title' => 'Ein Hinweis zu anonymen Analysen',
			'analyticsNotice.description' => 'Lux verwendet jetzt anonyme Analysen und Absturzberichte, um zu verstehen, welche Funktionen genutzt werden, und die Zuverlässigkeit zu verbessern.\n\nDiese Berichte enthalten niemals deine Notizen, Namen von Leseplänen oder Lesedetails, Suchbegriffe oder andere private Inhalte und sind nicht mit einem Konto verknüpft.\n\nWenn du Lux weiter nutzt, stimmst du der Übermittlung dieser Informationen zu.',
			'renamedBiblePlansNotice.title' => 'Lesepläne wurden aktualisiert',
			'renamedBiblePlansNotice.description' => 'Um Genauigkeit und Benennung der Lesepläne zu verbessern, wurden einige deiner Lesepläne umbenannt.',
			'tutorials.dontShowAgain' => 'Nicht mehr anzeigen',
			'audio.timer' => 'Audio-Timer',
			'audio.fiveMinutes' => '5 Minuten',
			'audio.tenMinutes' => '10 Minuten',
			'audio.fifteenMinutes' => '15 Minuten',
			'audio.thirtyMinutes' => '30 Minuten',
			'audio.oneHour' => '1 Stunde',
			'audio.loadError' => 'Das Audio konnte nicht geladen werden',
			'audio.connectionError' => 'Prüfe deine Internetverbindung oder versuche es später erneut.',
			'audio.initializationError' => 'Ein Fehler ist aufgetreten',
			'audio.initializationErrorDescription' => 'Beim Einrichten des Audios für dieses Gerät ist ein Fehler aufgetreten. Versuche, die App vollständig zu schließen und neu zu öffnen.',
			'audio.unavailable' => 'Für diese Bibel ist kein Audio verfügbar',
			'audio.chooseBible' => 'Wähle eine Bibel mit Audio, um dir dieses Kapitel anzuhören.',
			'audio.switchRequired' => 'Wechsle zu einer Bibel mit Audio, um dir diesen Abschnitt anzuhören.',
			'audio.rewindTenSeconds' => '10 Sekunden zurück',
			'audio.fastForwardTenSeconds' => '10 Sekunden vor',
			'audio.notificationChannelName' => 'Wiedergabe der Hörbibel',
			'audio.notificationChannelDescription' => 'Steuerung für die Wiedergabe der Hörbibel',
			'interlinearUi.interlinearBible' => 'Interlinearbibel',
			'interlinearUi.direction' => 'Interlinear-Richtung',
			'interlinearUi.reverse' => 'Umgekehrt',
			'interlinearUi.forward' => 'Vorwärts',
			'interlinearUi.reverseDescription' => 'Die Wörter erscheinen in englischer Lesereihenfolge.',
			'interlinearUi.forwardDescription' => 'Die Wörter erscheinen in der ursprünglichen hebräischen oder griechischen Reihenfolge.',
			'interlinearUi.studyBibleExplanation' => 'Studienbibeln sind Wort für Wort mit Strong-Nummern und Morphologie ausgezeichnet. Erst das macht die lexikalische Aufschlüsselung im Interlinear möglich. Stattdessen wird deine zuletzt verwendete Studienbibel genutzt.',
			'interlinearUi.usingTranslation' => ({required Object translation}) => 'Interlinear mit ${translation}',
			'chapterUnavailable.title' => ({required Object selectedTranslation, required Object testament}) => '${selectedTranslation} enthält kein ${testament}.',
			'chapterUnavailable.subtitle' => ({required Object testament, required Object fallbackTranslation}) => 'Stattdessen wird deine zuletzt verwendete Bibel für diesen Teil (${testament}) angezeigt: ${fallbackTranslation}.',
			'verseNumbering.referenceLabel' => ({required Object translation, required Object reference}) => '${translation} ${reference}',
			'verseNumbering.explanation' => ({required Object translation, required Object reference, required Object originalReference}) => '${translation} zählt Kapitel und Verse anders als die meisten englischen Übersetzungen.\n\nDer hier bei ${reference} angezeigte Text stammt aus ${originalReference} in ${translation} und wurde so zugeordnet, dass er zu den anderen Übersetzungen passt.',
			'compare.unavailable' => ({required Object translation}) => '${translation} enthält diese Auswahl nicht.',
			'commentaryUi.atAGlance' => ({required Object book}) => '${book} auf einen Blick',
			'commentaryUi.introTo' => ({required Object book}) => 'Einleitung zu ${book}',
			'commentaryUi.chapterOutline' => 'Kapitelübersicht',
			'commentaryUi.previousSection' => 'Vorheriger Abschnitt',
			'commentaryUi.nextSection' => 'Nächster Abschnitt',
			'searchLocations.currentBook' => 'Aktuelles Buch',
			'searchLocations.testaments' => 'Testamente',
			'searchLocations.books' => 'Bücher',
			'themeOptions.auto' => 'Automatisch',
			'themeOptions.light' => 'Hell',
			'themeOptions.dark' => 'Dunkel',
			'themeOptions.extraTiny' => 'Extrem klein',
			'themeOptions.tiny' => 'Sehr klein',
			'themeOptions.small' => 'Klein',
			'themeOptions.standard' => 'Standard',
			'themeOptions.large' => 'Groß',
			'themeOptions.huge' => 'Sehr groß',
			'themeOptions.extraHuge' => 'Extrem groß',
			'themeOptions.nativeAndSynthetic' => 'Eigene & ergänzte',
			'themeOptions.native' => 'Eigene',
			'themeOptions.none' => 'Keine',
			'themeOptions.allHeadingsDescription' => 'Überschriften in Übersetzungen anzeigen, die sie enthalten, und die Zwischenüberschriften der BSB in englische Übersetzungen ohne eigene Überschriften einfügen.',
			'themeOptions.nativeHeadingsDescription' => 'Überschriften in Übersetzungen anzeigen, die sie enthalten.',
			'themeOptions.noHeadingsDescription' => 'Keine Zwischenüberschriften anzeigen',
			'toolbarPresets.reader' => 'Leser',
			'toolbarPresets.noteTaker' => 'Notizenschreiber',
			'toolbarPresets.studier' => 'Bibelstudent',
			'toolbarPresets.readerDescription' => 'Abgestimmt auf ungestörtes Lesen und schnelle Navigation.',
			'toolbarPresets.noteTakerDescription' => 'Abgestimmt auf Markieren und Notizen.',
			'toolbarPresets.studierDescription' => 'Abgestimmt auf Querverweise, Kommentare und tiefes Studium.',
			'commentaryTypes.tyndaleDescription' => 'Vers-für-Vers-Studienanmerkungen zur ganzen Bibel, verfasst für die New Living Translation (NLT). Klar, fundiert und praxisnah.',
			'commentaryTypes.matthewHenryDescription' => 'Ein knapper, erbaulicher Kommentar zur ganzen Bibel aus der puritanischen Tradition. Warmherzig, praktisch und leicht zu lesen.',
			'commentaryTypes.jamiesonFaussetBrownDescription' => 'Ein kompakter Vers-für-Vers-Kommentar zur ganzen Bibel. Ausgewogen und zugänglich.',
			'commentaryTypes.calvinDescription' => 'Die klassische Auslegung des Reformators. Tiefgründig und lehrmäßig.',
			'strongDefinition.addedLabel' => 'ergänzt:',
			'strongDefinition.idiomLabel' => 'Idiom:',
			'strongDefinition.addedWord' => 'Ergänztes Wort',
			'strongDefinition.idiomaticRendering' => 'Idiomatische Wiedergabe',
			'strongDefinition.addedWordDescription' => 'Kennzeichnet ein Wort, das neben dem definierten hebräischen oder griechischen Wort ergänzt wird.',
			'strongDefinition.idiomaticRenderingDescription' => 'Kennzeichnet eine Wiedergabe, die eine typisch hebräische oder griechische Redewendung widerspiegelt.',
			'planTypes.throughTheBible' => 'Durch die Bibel',
			'planTypes.chronological' => 'Chronologisch in einem Jahr',
			'planTypes.oldAndNewTestament' => 'Altes und Neues Testament',
			'planTypes.historicallyBlended' => 'Historisch verflochten',
			'planTypes.everyDayInTheWord' => 'Jeden Tag im Wort',
			'planTypes.mcheyne' => 'M\'Cheyne',
			'planTypes.literaryStudy' => 'Literarisches Studium',
			'planTypes.differentTopics' => 'Verschiedene Themen',
			'planTypes.newTestamentPsalmsProverbs' => 'Neues Testament, Psalmen & Sprüche',
			'planTypes.fiveByFiveByFive' => '5x5x5 Neues Testament',
			'planTypes.gospelsAndEpistles' => 'Evangelien und Briefe',
			'planTypes.pentateuchAndHistory' => 'Pentateuch und Geschichte Israels',
			'planTypes.chroniclesAndProphets' => 'Chronik und Propheten',
			'planTypes.psalmsAndWisdom' => 'Psalmen und Weisheitsliteratur',
			'planTypes.mcheyneDescription' => 'Ein klassischer Plan mit vier kurzen Lesungen am Tag. In einem Jahr liest du das Alte Testament einmal und das Neue Testament und die Psalmen zweimal.',
			'planTypes.chronologicalDescription' => 'Lies die ganze Bibel in einem Jahr, geordnet nach der Reihenfolge, in der die Ereignisse tatsächlich geschahen.',
			'planTypes.throughTheBibleDescription' => 'Lies die ganze Bibel in einem Jahr von vorne bis hinten, von 1. Mose bis Offenbarung.',
			'planTypes.gospelsAndEpistlesDescription' => 'Verbringe das Jahr im Neuen Testament mit den Evangelien und den Briefen der Apostel.',
			'planTypes.everyDayInTheWordDescription' => 'Vier Lesungen am Tag aus dem Alten Testament, dem Neuen Testament, den Psalmen und den Sprüchen. Die ganze Bibel in einem Jahr, Psalmen & Sprüche zweimal.',
			'planTypes.literaryStudyDescription' => 'Erlebe die Bibel in einem Jahr nach literarischen Gattungen geordnet, von Erzählungen über Poesie bis zu Briefen.',
			'planTypes.chroniclesAndProphetsDescription' => 'Ein Jahr, das die Geschichte der Chronikbücher mit den Botschaften der Propheten verbindet.',
			'planTypes.pentateuchAndHistoryDescription' => 'Geh in einem Jahr durch die fünf Bücher Mose und die Geschichte Israels.',
			'planTypes.psalmsAndWisdomDescription' => 'Verbringe das Jahr in den Psalmen und Weisheitsbüchern wie Sprüche, Hiob und Prediger.',
			'planTypes.oldAndNewTestamentDescription' => 'Lies die ganze Bibel in einem Jahr und folge dabei dem Alten und Neuen Testament gemeinsam in kanonischer Reihenfolge.',
			'planTypes.historicallyBlendedDescription' => 'Lies die ganze Bibel in einem Jahr, mit Büchern und Abschnitten, die um zusammenhängende Ereignisse und Epochen angeordnet sind.',
			'planTypes.differentTopicsDescription' => 'Lies jeden Tag einen anderen Teil der Schrift und entdecke in einem Jahr jedes Buch der Bibel.',
			'planTypes.newTestamentPsalmsProverbsDescription' => 'Lies im Laufe eines Jahres das Neue Testament zusammen mit Psalmen und Sprüchen.',
			'planTypes.fiveByFiveByFiveDescription' => 'Lies an fünf Tagen pro Woche ein Kapitel aus dem Neuen Testament, gefolgt von zwei Tagen zum Wiederholen und Nachdenken.',
			'planTypes.oldScopeDescription' => 'Liest Bücher aus dem Alten Testament.',
			'planTypes.newScopeDescription' => 'Liest Bücher aus dem Neuen Testament.',
			'planTypes.wholeScopeDescription' => 'Liest jedes Buch des Alten und Neuen Testaments.',
			'planTypes.focused' => 'Fokussiert',
			'planTypes.comprehensive' => 'Vollständig',
			'planTypes.focusedDescription' => 'Deckt einen bestimmten Teil oder eine Sammlung innerhalb seines Umfangs ab.',
			'planTypes.comprehensiveDescription' => 'Deckt jedes Buch innerhalb seines Umfangs ab.',
			'onboardingSteps.viewCrossReferences' => 'Querverweise ansehen',
			'onboardingSteps.annotateVerse' => 'Einen Vers annotieren',
			'onboardingSteps.searchWord' => 'Nach einem Wort suchen',
			'onboardingSteps.switchBible' => 'Bibel wechseln',
			'onboardingSteps.navigateChapter' => 'Zu einem anderen Kapitel gehen',
			'onboardingSteps.goBack' => 'Zurückgehen',
			'onboardingSteps.swipeChapter' => 'Wischen, um das Kapitel zu wechseln',
			'onboardingSteps.addStudyPanel' => 'Ein Studienpanel hinzufügen',
			'onboardingSteps.customizeToolbar' => 'Symbolleisten anpassen',
			'onboardingSteps.startBiblePlan' => 'Einen Leseplan starten',
			'onboardingSteps.selectVerse' => 'Tippe auf einen Vers, um ihn auszuwählen',
			'onboardingSteps.selectWord' => 'Drücke lange auf ein Wort',
			'onboardingSteps.deselectPrefix' => 'Tippe auf ',
			'onboardingSteps.deselectSuffix' => ' neben deiner Auswahl, um sie aufzuheben',
			'onboardingSteps.revealToolbar' => 'Scrolle nach oben, um die Hauptleiste einzublenden',
			'onboardingSteps.addPanelPrefix' => 'Tippe auf ',
			'onboardingSteps.addPanelSuffix' => ' → Studieren → Studienpanel hinzufügen und füge ein beliebiges Studienpanel hinzu',
			'onboardingSteps.goToChapter' => 'Zu einem anderen Kapitel gehen',
			'onboardingSteps.openPrefix' => 'Öffne ',
			'onboardingSteps.crossReferencesSuffix' => ' → Studieren → Querverweise',
			'onboardingSteps.annotatePrefix' => 'Tippe auf ',
			'onboardingSteps.annotateSuffix' => ', um zu markieren oder eine Notiz hinzuzufügen',
			'onboardingSteps.searchPrefix' => 'Tippe auf ',
			'onboardingSteps.searchSuffix' => ', um das Wort überall nachzuschlagen',
			'onboardingSteps.switchBibleDescription' => ({required Object translation}) => 'Tippe auf die Hauptleiste → ${translation}, um die Bibel zu wechseln',
			'onboardingSteps.goToChapterDescription' => 'Tippe auf die Hauptleiste, um zu einem anderen Kapitel zu gehen',
			'onboardingSteps.goBackDescription' => 'Wische auf der Symbolleiste nach rechts, um zurückzugehen',
			'onboardingSteps.swipeChapterDescription' => 'Wische die Bibel nach links oder rechts, um das Kapitel zu wechseln',
			'onboardingSteps.viewPanelDescription' => 'Wische dieses Panel nach rechts, um dein Studienpanel zu sehen',
			'onboardingSteps.moreSeparator' => ' → Mehr → ',
			'onboardingSteps.customizeToolbarSuffix' => 'Symbolleisten und wähle eine Vorlage oder ändere deine Kurzbefehle',
			'onboardingSteps.startPlanSuffix' => ' → Lesepläne und starte einen beliebigen Leseplan',
			'dictionary.tyndale' => 'Tyndale Open Bible Dictionary',
			'articles.personHint' => 'Nach einer Person suchen',
			'articles.themeHint' => 'Nach einem Thema suchen',
			'articles.noMatchingPeople' => 'Keine passenden Personen',
			'articles.noMatchingThemes' => 'Keine passenden Themen',
			'articles.passagesForFurtherStudy' => 'Stellen zum Weiterstudieren',
			'articles.relatedDictionaryEntry' => 'Der vollständige Eintrag im Bibelwörterbuch, mit mehr Hintergrund und Details',
			'articles.relatedProfile' => 'Ein kürzeres Profil aus den Tyndale Study Notes, mit Stellen zum Weiterstudieren',
			'articles.relatedTheme' => 'Ein kürzerer Artikel aus den Tyndale Study Notes, mit Stellen zum Weiterstudieren',
			'maps.searchHint' => 'Nach einer Karte suchen',
			'maps.noMatchingMaps' => 'Keine passenden Karten',
			'navigation.recents' => 'Zuletzt',
			'navigation.navigate' => 'Navigieren',
			'navigation.book' => 'Buch',
			'navigation.chapter' => 'Kapitel',
			'navigation.verse' => 'Vers',
			'bibleSheet.allBibles' => 'Alle Bibeln',
			'bibleSheet.availableCount' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(count, one: '${count} Bibel verfügbar', other: '${count} Bibeln verfügbar', ), 
			'bibleSheet.wantAnotherTranslation' => 'Fehlt dir eine Übersetzung?',
			'bibleSheet.proposeOnDiscord' => 'Tritt unserem Discord bei, um eine vorzuschlagen',
			'passageSelection.findInBible' => 'In der Bibel finden',
			'passageSelection.selectEntireChapter' => 'Ganzes Kapitel auswählen',
			'passageSelection.selectVerses' => 'Verse auswählen',
			'passageSelection.addPassage' => ({required Object reference}) => '${reference} hinzufügen',
			'selectionUi.selected' => 'Ausgewählt: ',
			'selectionUi.sourceApiBible' => 'Quelle: [https://api.bible](https://api.bible)',
			'errors.deviceVerificationFailed' => 'Geräteprüfung fehlgeschlagen',
			'errors.deviceVerificationDescription' => 'Für den Zugriff auf diese Online-Bibel sind ein gültiges Gerät und eine rechtmäßige Installation von Lux nötig. Stelle sicher, dass du Lux aus einem offiziellen App Store installiert hast, und versuche es dann erneut.',
			'errors.generic' => 'Etwas ist schiefgelaufen',
			'errors.connection' => 'Prüfe deine Internetverbindung oder versuche es später erneut.',
			'morphology.attributes.type.name' => 'Wortart',
			'morphology.attributes.type.description' => 'Die grammatische Kategorie des Wortes.',
			'morphology.attributes.grammaticalCase.name' => 'Kasus',
			'morphology.attributes.grammaticalCase.description' => 'Die syntaktische Rolle, etwa Subjekt, Objekt oder Besitz.',
			'morphology.attributes.gender.name' => 'Genus',
			'morphology.attributes.gender.description' => 'Grammatisches Geschlecht: maskulin, feminin, neutrum (Griechisch) oder communis (Hebräisch).',
			'morphology.attributes.number.name' => 'Numerus',
			'morphology.attributes.number.description' => 'Ob sich das Wort auf eins (Singular), zwei (Dual) oder viele (Plural) bezieht.',
			'morphology.attributes.person.name' => 'Person',
			'morphology.attributes.person.description' => 'Auf wen sich das Wort bezieht: 1. (ich/wir), 2. (du/ihr) oder 3. (er/sie/es/sie).',
			'morphology.attributes.state.name' => 'Status',
			'morphology.attributes.state.description' => 'Der Status eines Substantivs: absolutus, constructus oder determinatus.',
			'morphology.attributes.tense.name' => 'Tempus',
			'morphology.attributes.tense.description' => 'Die Zeitform des Verbs, die Zeit und Aspekt verbindet.',
			'morphology.attributes.mood.name' => 'Modus',
			'morphology.attributes.mood.description' => 'Wie die Handlung ausgedrückt wird, etwa als Tatsache, Befehl oder Möglichkeit.',
			'morphology.attributes.voice.name' => 'Diathese',
			'morphology.attributes.voice.description' => 'Die Diathese: Aktiv, Medium oder Passiv.',
			'morphology.attributes.degree.name' => 'Steigerung',
			'morphology.attributes.degree.description' => 'Die Steigerungsstufe eines Adjektivs oder Adverbs: Positiv, Komparativ oder Superlativ.',
			'morphology.attributes.stem.name' => 'Stamm',
			'morphology.attributes.stem.description' => 'Der Verbalstamm (Binjan), etwa Qal, Nifal oder Piel.',
			'morphology.attributes.aspect.name' => 'Aspekt',
			'morphology.attributes.aspect.description' => 'Der Verbalaspekt, etwa Perfekt, Imperfekt oder Partizip.',
			'morphology.attributes.prefix.name' => 'Präfix',
			'morphology.attributes.prefix.description' => 'Ein hebräischer Präpositionsbuchstabe als Präfix.',
			'morphology.attributes.particle.name' => 'Partikel',
			'morphology.attributes.particle.description' => 'Ein kleines, unflektiertes Wort, oft eine Konjunktion oder ein Marker.',
			'morphology.attributes.code.name' => 'Code',
			'morphology.attributes.code.description' => 'Der unveränderte Morphologiecode, wie er im Quelltext steht.',
			'morphology.types.article.name' => 'Artikel',
			'morphology.types.article.description' => 'Ein bestimmter Artikel, „der“, „die“ oder „das“.',
			'morphology.types.article.examples' => 'der König|der Herr',
			'morphology.types.conjunction.name' => 'Konjunktion',
			'morphology.types.conjunction.description' => 'Ein Wort, das andere Wörter oder Sätze verbindet.',
			'morphology.types.conjunction.examples' => 'und|aber|denn',
			'morphology.types.preposition.name' => 'Präposition',
			'morphology.types.preposition.description' => 'Setzt ein Substantiv oder Pronomen in Beziehung zu anderen Wörtern.',
			'morphology.types.preposition.examples' => 'in|zu|mit',
			'morphology.types.adverb.name' => 'Adverb',
			'morphology.types.adverb.description' => 'Bestimmt ein Verb, Adjektiv oder anderes Adverb näher.',
			'morphology.types.adverb.examples' => 'schnell|jetzt|dort',
			'morphology.types.negativeAdverb.name' => 'Verneinendes Adverb',
			'morphology.types.negativeAdverb.description' => 'Ein Adverb, das eine Verneinung ausdrückt.',
			'morphology.types.negativeAdverb.examples' => 'nicht|niemals',
			'morphology.types.adjective.name' => 'Adjektiv',
			'morphology.types.adjective.description' => 'Ein Wort, das ein Substantiv beschreibt.',
			'morphology.types.adjective.examples' => 'groß|heilig|weise',
			'morphology.types.noun.name' => 'Substantiv',
			'morphology.types.noun.description' => 'Eine Person, ein Ort, eine Sache oder ein Begriff.',
			'morphology.types.noun.examples' => 'Stadt|Wasser|Liebe',
			'morphology.types.properNoun.name' => 'Eigenname',
			'morphology.types.properNoun.description' => 'Der Name einer bestimmten Person, eines Ortes oder einer Sache.',
			'morphology.types.properNoun.examples' => 'David|Jerusalem|Israel',
			'morphology.types.number.name' => 'Kardinalzahl',
			'morphology.types.number.description' => 'Eine Grundzahl.',
			'morphology.types.number.examples' => 'drei|zwölf|tausend',
			'morphology.types.ordinalNumber.name' => 'Ordinalzahl',
			'morphology.types.ordinalNumber.description' => 'Eine Ordnungszahl, etwa „erste“ oder „zweite“.',
			'morphology.types.ordinalNumber.examples' => 'erste|zehnte|siebzigste',
			'morphology.types.pronoun.name' => 'Pronomen',
			'morphology.types.pronoun.description' => 'Ein Wort, das für ein Substantiv steht.',
			'morphology.types.pronoun.examples' => 'er|sie|sie (Pl.)',
			'morphology.types.personalPronoun.name' => 'Personalpronomen',
			'morphology.types.personalPronoun.description' => 'Ein Pronomen, das sich auf eine bestimmte Person bezieht.',
			'morphology.types.personalPronoun.examples' => 'ich|du|wir',
			'morphology.types.demonstrativePronoun.name' => 'Demonstrativpronomen',
			'morphology.types.demonstrativePronoun.description' => 'Ein Pronomen, das auf etwas hinweist.',
			'morphology.types.demonstrativePronoun.examples' => 'dieser|diese|jene',
			'morphology.types.interrogativePronoun.name' => 'Interrogativpronomen',
			'morphology.types.interrogativePronoun.description' => 'Ein Pronomen, mit dem man eine Frage stellt.',
			'morphology.types.interrogativePronoun.examples' => 'wer?|was?|welcher?',
			'morphology.types.indefinitePronoun.name' => 'Indefinitpronomen',
			'morphology.types.indefinitePronoun.description' => 'Ein Pronomen, das sich auf nicht bestimmte Personen oder Dinge bezieht.',
			'morphology.types.indefinitePronoun.examples' => 'jemand|irgendwer|nichts',
			'morphology.types.reciprocalPronoun.name' => 'Reziprokpronomen',
			'morphology.types.reciprocalPronoun.description' => 'Ein Pronomen, das eine wechselseitige Handlung ausdrückt.',
			'morphology.types.reciprocalPronoun.examples' => 'einander|gegenseitig',
			'morphology.types.reflexivePronoun.name' => 'Reflexivpronomen',
			'morphology.types.reflexivePronoun.description' => 'Ein Pronomen, das sich auf das Subjekt zurückbezieht.',
			'morphology.types.reflexivePronoun.examples' => 'sich|sich selbst',
			'morphology.types.relativePronoun.name' => 'Relativpronomen',
			'morphology.types.relativePronoun.description' => 'Ein Pronomen, das einen Nebensatz einleitet.',
			'morphology.types.relativePronoun.examples' => 'der|welcher|das',
			'morphology.types.particle.name' => 'Partikel',
			'morphology.types.particle.description' => 'Ein kleines, unflektiertes Wort.',
			'morphology.types.particle.examples' => 'doch|nun',
			'morphology.types.negativeParticle.name' => 'Verneinungspartikel',
			'morphology.types.negativeParticle.description' => 'Eine Partikel, die eine Verneinung anzeigt.',
			'morphology.types.negativeParticle.examples' => 'nicht|kein',
			'morphology.types.interrogativeParticle.name' => 'Fragepartikel',
			'morphology.types.interrogativeParticle.description' => 'Eine Partikel, die eine Frage anzeigt.',
			'morphology.types.interrogativeParticle.examples' => '(hebräisches Präfix ה, ohne deutsche Entsprechung)',
			'morphology.types.demonstrativeParticle.name' => 'Hinweispartikel',
			'morphology.types.demonstrativeParticle.description' => 'Eine hinweisende Partikel, etwa „siehe“.',
			'morphology.types.demonstrativeParticle.examples' => 'siehe|sieh',
			'morphology.types.genericParticle.name' => 'Allgemeine Partikel',
			'morphology.types.genericParticle.description' => 'Eine vielseitig verwendete Partikel.',
			'morphology.types.genericParticle.examples' => 'doch|wahrlich',
			'morphology.types.relativeParticle.name' => 'Relativpartikel',
			'morphology.types.relativeParticle.description' => 'Eine Partikel, die einen Relativsatz einleitet.',
			'morphology.types.relativeParticle.examples' => 'dass|welcher',
			'morphology.types.verb.name' => 'Verb',
			'morphology.types.verb.description' => 'Ein Wort, das eine Handlung oder einen Zustand ausdrückt.',
			'morphology.types.verb.examples' => 'schreiben|sein|gehen',
			'morphology.types.pronominalSuffix.name' => 'Pronominalsuffix',
			'morphology.types.pronominalSuffix.description' => 'Ein Pronomen, das an das Ende eines Verbs oder Substantivs angehängt ist (Hebräisch).',
			'morphology.types.pronominalSuffix.examples' => 'seine Hand|ihr Land|ihre Stimme',
			'morphology.types.directObjectMarker.name' => 'Objektmarker',
			'morphology.types.directObjectMarker.description' => 'Das hebräische אֵת, das ein bestimmtes direktes Objekt kennzeichnet.',
			'morphology.types.directObjectMarker.examples' => 'אֵת (ohne deutsche Entsprechung)',
			'morphology.types.punctuation.name' => 'Satzzeichen',
			'morphology.types.punctuation.description' => 'Ein Satzzeichen.',
			'morphology.types.punctuation.examples' => '.|,|;',
			'morphology.types.interjection.name' => 'Interjektion',
			'morphology.types.interjection.description' => 'Ein kurzer Ausruf, der ein Gefühl ausdrückt.',
			'morphology.types.interjection.examples' => 'o!|ach!',
			'morphology.types.indeclinable.name' => 'Indeklinabel',
			'morphology.types.indeclinable.description' => 'Ein Wort, dessen Form sich durch Flexion nicht ändert.',
			'morphology.types.indeclinable.examples' => 'Hosianna|Halleluja',
			'morphology.types.hebraism.name' => 'Hebräisches Lehnwort',
			'morphology.types.hebraism.description' => 'Ein hebräisches oder aramäisches Lehnwort, das ins Griechische übernommen wurde.',
			'morphology.types.hebraism.examples' => 'Amen|Hosianna|Zebaoth',
			'morphology.types.unknown.name' => 'Unbekannt',
			'morphology.types.unknown.description' => 'Ein Morphologiecode, den der Parser nicht erkannt hat.',
			'morphology.types.unknown.examples' => '',
			'morphology.person.first.name' => '1. Person',
			'morphology.person.first.description' => 'Der Sprecher, „ich“ oder „wir“.',
			'morphology.person.first.examples' => 'ich bin|wir gehen|ich habe geredet',
			'morphology.person.second.name' => '2. Person',
			'morphology.person.second.description' => 'Der Angesprochene, „du“ oder „ihr“.',
			'morphology.person.second.examples' => 'du gehst|ihr hört|du hast gesehen',
			'morphology.person.third.name' => '3. Person',
			'morphology.person.third.description' => 'Diejenigen, über die gesprochen wird.',
			'morphology.person.third.examples' => 'er läuft|sie spricht|sie versammelten sich',
			'morphology.gender.masculine.name' => 'Maskulin',
			'morphology.gender.masculine.description' => 'Männliches grammatisches Geschlecht, verwendet für männliche Personen und per Konvention für viele Substantive.',
			'morphology.gender.masculine.examples' => 'Vater|Sohn|König',
			'morphology.gender.feminine.name' => 'Feminin',
			'morphology.gender.feminine.description' => 'Weibliches grammatisches Geschlecht, verwendet für weibliche Personen und per Konvention für viele Substantive.',
			'morphology.gender.feminine.examples' => 'Mutter|Tochter|Königin',
			'morphology.gender.neuter.name' => 'Neutrum',
			'morphology.gender.neuter.description' => 'Griechisches sächliches Geschlecht, weder männlich noch weiblich.',
			'morphology.gender.neuter.examples' => 'Kind (τέκνον)|Gabe (δῶρον)',
			'morphology.gender.common.name' => 'Communis',
			'morphology.gender.common.description' => 'Hebräisches gemeinsames Geschlecht, bei dem die Form sowohl männlich als auch weiblich sein kann.',
			'morphology.gender.common.examples' => 'Vieh|Stimme',
			'morphology.number.singular.name' => 'Singular',
			'morphology.number.singular.description' => 'Bezieht sich auf eins.',
			'morphology.number.singular.examples' => 'das Buch|ein Mann|ein Stein',
			'morphology.number.plural.name' => 'Plural',
			'morphology.number.plural.description' => 'Bezieht sich auf zwei oder mehr.',
			'morphology.number.plural.examples' => 'die Bücher|Männer|Steine',
			'morphology.number.dual.name' => 'Dual',
			'morphology.number.dual.description' => 'Bezieht sich auf ein natürliches Paar (nur Hebräisch).',
			'morphology.number.dual.examples' => 'Hände|Augen|zwei Tage',
			'morphology.kCase.nominative.name' => 'Nominativ',
			'morphology.kCase.nominative.description' => 'Kennzeichnet das Subjekt eines Satzes.',
			'morphology.kCase.nominative.examples' => 'Gott schuf|der König sieht',
			'morphology.kCase.genitive.name' => 'Genitiv',
			'morphology.kCase.genitive.description' => 'Zeigt Besitz oder Herkunft an, oft mit „von“ oder „des“ übersetzt.',
			'morphology.kCase.genitive.examples' => 'der Sohn Gottes|Reich der Himmel',
			'morphology.kCase.dative.name' => 'Dativ',
			'morphology.kCase.dative.description' => 'Kennzeichnet das indirekte Objekt, oft „zu“ oder „für“.',
			'morphology.kCase.dative.examples' => 'gab ihm|sprach zu ihnen',
			'morphology.kCase.accusative.name' => 'Akkusativ',
			'morphology.kCase.accusative.description' => 'Kennzeichnet das direkte Objekt.',
			'morphology.kCase.accusative.examples' => 'sah ihn|liebe deinen Nächsten',
			'morphology.kCase.vocative.name' => 'Vokativ',
			'morphology.kCase.vocative.description' => 'Wird bei direkter Anrede verwendet.',
			'morphology.kCase.vocative.examples' => 'Herr!|Vater!|Freund!',
			'morphology.state.absolute.name' => 'Absolutus',
			'morphology.state.absolute.description' => 'Die übliche, selbstständige Form eines Substantivs.',
			'morphology.state.absolute.examples' => 'ein König|ein Wort',
			'morphology.state.construct.name' => 'Constructus',
			'morphology.state.construct.description' => 'An ein folgendes Substantiv gebunden, drückt „X von Y“ aus.',
			'morphology.state.construct.examples' => 'König von Israel|Wort des HERRN',
			'morphology.state.determined.name' => 'Determinatus',
			'morphology.state.determined.description' => 'Als bestimmt gekennzeichnet, oft durch den Artikel.',
			'morphology.state.determined.examples' => 'der König|das Wort',
			'morphology.stem.qal.name' => 'Qal',
			'morphology.stem.qal.description' => 'Der einfache aktive Stamm, die Grundhandlung des Verbs.',
			'morphology.stem.qal.examples' => 'er schrieb|sie hörte',
			'morphology.stem.qalPassive.name' => 'Qal Passiv',
			'morphology.stem.qalPassive.description' => 'Ein seltenes Passiv des einfachen Stammes.',
			'morphology.stem.qalPassive.examples' => 'es wurde genommen',
			'morphology.stem.niphal.name' => 'Nifal',
			'morphology.stem.niphal.description' => 'Der einfache passive oder reflexive Stamm.',
			'morphology.stem.niphal.examples' => 'er wurde getötet|sie versammelten sich',
			'morphology.stem.piel.name' => 'Piel',
			'morphology.stem.piel.description' => 'Der intensive oder faktitive aktive Stamm.',
			'morphology.stem.piel.examples' => 'er lobte|er segnete|er zerschmetterte',
			'morphology.stem.pual.name' => 'Pual',
			'morphology.stem.pual.description' => 'Das Passiv des Piel.',
			'morphology.stem.pual.examples' => 'er wurde gelobt',
			'morphology.stem.hiphil.name' => 'Hifil',
			'morphology.stem.hiphil.description' => 'Der kausative aktive Stamm.',
			'morphology.stem.hiphil.examples' => 'er ließ schreiben|er führte heraus',
			'morphology.stem.hophal.name' => 'Hofal',
			'morphology.stem.hophal.description' => 'Das Passiv des Hifil.',
			'morphology.stem.hophal.examples' => 'er wurde zum Schreiben veranlasst',
			'morphology.stem.hithpael.name' => 'Hitpael',
			'morphology.stem.hithpael.description' => 'Das Reflexiv oder Reziprok des Piel.',
			'morphology.stem.hithpael.examples' => 'er heiligte sich|sie gingen umher',
			'morphology.stem.nithpael.name' => 'Nitpael',
			'morphology.stem.nithpael.description' => 'Ein seltener reflexiv-passiver Stamm.',
			'morphology.stem.nithpael.examples' => 'es wurde gesühnt',
			'morphology.aspect.perfect.name' => 'Perfekt',
			'morphology.aspect.perfect.description' => 'Abgeschlossene Handlung, meist mit Vergangenheit übersetzt.',
			'morphology.aspect.perfect.examples' => 'er schrieb|sie hat geredet',
			'morphology.aspect.imperfect.name' => 'Imperfekt',
			'morphology.aspect.imperfect.description' => 'Unabgeschlossene oder zukünftige Handlung, oft mit Futur oder als Gewohnheit übersetzt.',
			'morphology.aspect.imperfect.examples' => 'er wird schreiben|er schreibt',
			'morphology.aspect.imperative.name' => 'Imperativ',
			'morphology.aspect.imperative.description' => 'Ein direkter Befehl.',
			'morphology.aspect.imperative.examples' => 'Schreib!|Höre!',
			'morphology.aspect.infinitiveConstruct.name' => 'Infinitivus constructus',
			'morphology.aspect.infinitiveConstruct.description' => 'Ein Verbalsubstantiv in der Constructus-Form, oft mit Präpositionen verwendet.',
			'morphology.aspect.infinitiveConstruct.examples' => 'zu schreiben|beim Schreiben',
			'morphology.aspect.infinitiveAbsolute.name' => 'Infinitivus absolutus',
			'morphology.aspect.infinitiveAbsolute.description' => 'Ein selbstständiges Verbalsubstantiv, oft zur Betonung.',
			'morphology.aspect.infinitiveAbsolute.examples' => 'gewiss sterben|gründlich schreiben',
			'morphology.aspect.participle.name' => 'Partizip',
			'morphology.aspect.participle.description' => 'Ein Verbaladjektiv, das eine andauernde Handlung beschreibt.',
			'morphology.aspect.participle.examples' => 'schreibend|der Hörende',
			_ => null,
		} ?? switch (path) {
			'morphology.aspect.consecutiveImperfect.name' => 'Imperfectum consecutivum',
			'morphology.aspect.consecutiveImperfect.description' => 'Erzählform der Vergangenheit: Waw + Imperfekt.',
			'morphology.aspect.consecutiveImperfect.examples' => 'und er sprach|und sie gingen',
			'morphology.aspect.conjunctiveImperfect.name' => 'Imperfekt mit Waw',
			'morphology.aspect.conjunctiveImperfect.description' => 'Imperfekt mit verbindendem Waw, mit zukünftigem oder modalem Sinn.',
			'morphology.aspect.conjunctiveImperfect.examples' => 'und er wird schreiben',
			'morphology.aspect.conjunctivePerfect.name' => 'Perfekt mit Waw',
			'morphology.aspect.conjunctivePerfect.description' => 'Perfekt mit verbindendem Waw, oft zukünftig oder fortführend.',
			'morphology.aspect.conjunctivePerfect.examples' => 'und du sollst tun|und er wird richten',
			'morphology.aspect.passiveParticiple.name' => 'Passives Partizip',
			'morphology.aspect.passiveParticiple.description' => 'Die passive Form des Qal-Partizips.',
			'morphology.aspect.passiveParticiple.examples' => 'geschrieben|bewahrt',
			'morphology.hebrewMood.jussive.name' => 'Jussiv',
			'morphology.hebrewMood.jussive.description' => 'Ein Befehl oder Wunsch in der 3. Person.',
			'morphology.hebrewMood.jussive.examples' => 'Es werde Licht|Der HERR segne dich',
			'morphology.hebrewMood.cohortative.name' => 'Kohortativ',
			'morphology.hebrewMood.cohortative.description' => 'Eine Willensform der 1. Person, etwa „lasst uns“ oder „ich will“.',
			'morphology.hebrewMood.cohortative.examples' => 'Lasst uns gehen|Ich will loben',
			'morphology.hebrewMood.hSuffix.name' => 'h-Suffix',
			'morphology.hebrewMood.hSuffix.description' => 'Eine betonte Endung -ah am Imperfekt, oft ähnlich dem Kohortativ.',
			'morphology.hebrewMood.hSuffix.examples' => 'ich will gewiss kommen|lass mich nahen',
			'morphology.tense.present.name' => 'Präsens',
			'morphology.tense.present.description' => 'Andauernde oder allgemeine Handlung.',
			'morphology.tense.present.examples' => 'er liebt|sie gehen',
			'morphology.tense.imperfect.name' => 'Imperfekt',
			'morphology.tense.imperfect.description' => 'Andauernde oder wiederholte Handlung in der Vergangenheit.',
			'morphology.tense.imperfect.examples' => 'er lehrte|sie pflegten sich zu versammeln',
			'morphology.tense.future.name' => 'Futur',
			'morphology.tense.future.description' => 'Handlung, die geschehen wird.',
			'morphology.tense.future.examples' => 'er wird kommen|sie werden sehen',
			'morphology.tense.aorist.name' => 'Aorist',
			'morphology.tense.aorist.description' => 'Einfache vergangene Handlung als Ganzes betrachtet.',
			'morphology.tense.aorist.examples' => 'er sagte|sie gingen',
			'morphology.tense.perfect.name' => 'Perfekt',
			'morphology.tense.perfect.description' => 'Vergangene Handlung mit fortdauernder Wirkung in der Gegenwart.',
			'morphology.tense.perfect.examples' => 'ist geschrieben|ist gekommen',
			'morphology.tense.pluperfect.name' => 'Plusquamperfekt',
			'morphology.tense.pluperfect.description' => 'Vergangene Handlung vor einem anderen vergangenen Ereignis.',
			'morphology.tense.pluperfect.examples' => 'war geschrieben|war fortgegangen',
			'morphology.mood.indicative.name' => 'Indikativ',
			'morphology.mood.indicative.description' => 'Stellt eine Tatsache fest.',
			'morphology.mood.indicative.examples' => 'er ist|sie schrieben',
			'morphology.mood.imperative.name' => 'Imperativ',
			'morphology.mood.imperative.description' => 'Erteilt einen Befehl.',
			'morphology.mood.imperative.examples' => 'Geh!|Glaube!|Fürchte dich nicht!',
			'morphology.mood.subjunctive.name' => 'Konjunktiv',
			'morphology.mood.subjunctive.description' => 'Drückt Möglichkeit, Zweck oder Bedingung aus.',
			'morphology.mood.subjunctive.examples' => 'damit er schreibe|wenn er geht',
			'morphology.mood.optative.name' => 'Optativ',
			'morphology.mood.optative.description' => 'Drückt einen Wunsch oder eine entfernte Möglichkeit aus.',
			'morphology.mood.optative.examples' => 'so sei es|Gnade sei mit dir',
			'morphology.mood.infinitive.name' => 'Infinitiv',
			'morphology.mood.infinitive.description' => 'Ein Verbalsubstantiv, etwa „tun“.',
			'morphology.mood.infinitive.examples' => 'schreiben|glauben',
			'morphology.mood.participle.name' => 'Partizip',
			'morphology.mood.participle.description' => 'Ein Verbaladjektiv, etwa „tuend“ oder „getan habend“.',
			'morphology.mood.participle.examples' => 'der Schreibende|nachdem er geredet hatte',
			'morphology.voice.active.name' => 'Aktiv',
			'morphology.voice.active.description' => 'Das Subjekt führt die Handlung aus.',
			'morphology.voice.active.examples' => 'er schreibt|sie lehren',
			'morphology.voice.middle.name' => 'Medium',
			'morphology.voice.middle.description' => 'Das Subjekt handelt an sich selbst oder für sich selbst.',
			'morphology.voice.middle.examples' => 'er wäscht sich|sie verschafften sich',
			'morphology.voice.passive.name' => 'Passiv',
			'morphology.voice.passive.description' => 'Das Subjekt erfährt die Handlung.',
			'morphology.voice.passive.examples' => 'er wurde gesandt|sie wurden gelehrt',
			'morphology.voice.middleOrPassive.name' => 'Medium/Passiv',
			'morphology.voice.middleOrPassive.description' => 'Die Form kann Medium oder Passiv sein.',
			'morphology.voice.middleOrPassive.examples' => 'wurde auferweckt / erhob sich|wurden versammelt / versammelten sich',
			'morphology.degree.positive.name' => 'Positiv',
			'morphology.degree.positive.description' => 'Die Grundform, weder Komparativ noch Superlativ.',
			'morphology.degree.positive.examples' => 'groß|gut',
			'morphology.degree.comparative.name' => 'Komparativ',
			'morphology.degree.comparative.description' => 'Vergleicht zwei Dinge.',
			'morphology.degree.comparative.examples' => 'größer|besser als',
			'morphology.degree.superlative.name' => 'Superlativ',
			'morphology.degree.superlative.description' => 'Drückt den höchsten Grad aus.',
			'morphology.degree.superlative.examples' => 'am größten|am besten',
			'morphology.literals.rawCode' => 'Der unveränderte Morphologiecode, wie er in der Quelle stand.',
			'morphology.literals.waw' => 'Die hebräische Konjunktion Waw (וְ), „und“.',
			'morphology.literals.conjunction' => 'Ein Konjunktionsmarker.',
			'morphology.literals.bet' => 'Die hebräische Präfix-Präposition Bet (בְּ), „in“, „an“ oder „mit“.',
			'morphology.literals.kaf' => 'Die hebräische Präfix-Präposition Kaf (כְּ), „wie“ oder „gleich“.',
			'morphology.literals.lamed' => 'Die hebräische Präfix-Präposition Lamed (לְ), „zu“, „für“ oder „gehörend zu“.',
			'morphology.literals.mem' => 'Die hebräische Präfix-Präposition Mem (מִן), „von“ oder „aus“.',
			'morphology.literals.preposition' => 'Ein Präpositionsbuchstabe als Präfix.',
			'morphology.literals.wawExamples' => 'und|nun|aber',
			'morphology.literals.betExamples' => 'im Anfang|mit Kraft',
			'morphology.literals.kafExamples' => 'wie ein Löwe|wie ein Hirte',
			'morphology.literals.lamedExamples' => 'für David|für den König',
			'morphology.literals.memExamples' => 'aus Ägypten|aus dem Land',
			'settings.title' => 'Einstellungen',
			'settings.customize' => 'Anpassen',
			'settings.pushNotifications' => 'Push-Benachrichtigungen',
			'settings.biblePlanReminders' => 'Erinnerungen an Lesepläne',
			'settings.notificationsNotRequested' => 'Benachrichtigungen aktivieren',
			'settings.notificationsNotRequestedDescription' => 'Erlaube Lux, Benachrichtigungen zu senden, um deine Erinnerungen zu verwalten.',
			'settings.notificationsDisabled' => 'Benachrichtigungen sind deaktiviert',
			'settings.biblePlanRemindersDisabled' => 'Erinnerungen an Lesepläne sind ausgeschaltet.',
			'settings.verseOfTheDayRemindersDisabled' => 'Erinnerungen an den Vers des Tages sind ausgeschaltet.',
			'settings.notificationsDisabledDescription' => 'Aktiviere sie in den Geräteeinstellungen, um deine Erinnerungen zu verwalten.',
			'settings.language' => 'Sprache',
			'settings.system' => 'System',
			'settings.systemLanguageDescription' => 'Der Systemsprache folgen.',
			'settings.toolbarPresets' => 'Symbolleisten-Vorlagen',
			'settings.toolbarPreset' => 'Symbolleisten-Vorlage',
			'settings.presetWarning' => 'Wenn du eine Vorlage auswählst, werden die Kurzbefehle in all deinen Symbolleisten überschrieben.',
			'settings.yourContent' => 'Deine Inhalte',
			'settings.discussionAndAnnouncements' => 'Austausch und Ankündigungen',
			'settings.supportLux' => 'Lux unterstützen',
			'settings.rateLux' => 'Lux bewerten',
			'settings.leaveReview' => ({required Object store}) => 'Hinterlasse eine Bewertung im ${store}.',
			'settings.followLux' => 'Lux folgen',
			'settings.socialMediaAndVideo' => 'Social Media und Videos',
			'settings.shareLux' => 'Lux teilen',
			'settings.shareLuxDescription' => 'Lux mit jemandem teilen.',
			'settings.reportProblem' => 'Problem melden',
			'settings.reportProblemDescription' => 'Hilfe bei Fehlern und anderen Problemen erhalten.',
			'settings.recommended' => 'Empfohlen',
			'settings.emailSupport' => 'E-Mail-Support',
			'settings.restartGetStarted' => 'Erste Schritte neu starten',
			'settings.restartGetStartedDescription' => 'Die Checkliste „Erste Schritte“ erneut anzeigen.',
			'settings.resetTutorials' => 'Tipps zurücksetzen',
			'settings.resetTutorialsDescription' => 'Hilfreiche Hinweise in der ganzen App wieder anzeigen.',
			'settings.tutorialsReset' => 'Tipps wurden zurückgesetzt.',
			_ => null,
		};
	}
}
