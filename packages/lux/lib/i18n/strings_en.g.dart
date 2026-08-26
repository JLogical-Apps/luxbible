///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$languages$en languages = Translations$languages$en.internal(_root);
	late final Translations$highlightStyles$en highlightStyles = Translations$highlightStyles$en.internal(_root);
	late final Translations$colors$en colors = Translations$colors$en.internal(_root);
	late final Translations$testaments$en testaments = Translations$testaments$en.internal(_root);
	late final Translations$books$en books = Translations$books$en.internal(_root);
	late final Translations$common$en common = Translations$common$en.internal(_root);
	late final Translations$regionTypes$en regionTypes = Translations$regionTypes$en.internal(_root);
	late final Translations$mainActions$en mainActions = Translations$mainActions$en.internal(_root);
	late final Translations$verseOfTheDay$en verseOfTheDay = Translations$verseOfTheDay$en.internal(_root);
	late final Translations$studyActions$en studyActions = Translations$studyActions$en.internal(_root);
	late final Translations$selectionActions$en selectionActions = Translations$selectionActions$en.internal(_root);
	late final Translations$studyPanels$en studyPanels = Translations$studyPanels$en.internal(_root);
	late final Translations$bookmarks$en bookmarks = Translations$bookmarks$en.internal(_root);
	late final Translations$bookmarkPage$en bookmarkPage = Translations$bookmarkPage$en.internal(_root);
	late final Translations$commentaries$en commentaries = Translations$commentaries$en.internal(_root);
	late final Translations$toolbarShortcuts$en toolbarShortcuts = Translations$toolbarShortcuts$en.internal(_root);
	late final Translations$labels$en labels = Translations$labels$en.internal(_root);
	late final Translations$strongSheet$en strongSheet = Translations$strongSheet$en.internal(_root);
	late final Translations$bibleDetails$en bibleDetails = Translations$bibleDetails$en.internal(_root);
	late final Translations$emptyStates$en emptyStates = Translations$emptyStates$en.internal(_root);
	late final Translations$annotationUi$en annotationUi = Translations$annotationUi$en.internal(_root);
	late final Translations$notebookUi$en notebookUi = Translations$notebookUi$en.internal(_root);
	late final Translations$highlightStyleUi$en highlightStyleUi = Translations$highlightStyleUi$en.internal(_root);
	late final Translations$toolbarSettings$en toolbarSettings = Translations$toolbarSettings$en.internal(_root);
	late final Translations$themeSettings$en themeSettings = Translations$themeSettings$en.internal(_root);
	late final Translations$biblePlans$en biblePlans = Translations$biblePlans$en.internal(_root);
	late final Translations$searchUi$en searchUi = Translations$searchUi$en.internal(_root);
	late final Translations$onboarding$en onboarding = Translations$onboarding$en.internal(_root);
	late final Translations$tutorials$en tutorials = Translations$tutorials$en.internal(_root);
	late final Translations$audio$en audio = Translations$audio$en.internal(_root);
	late final Translations$interlinearUi$en interlinearUi = Translations$interlinearUi$en.internal(_root);
	late final Translations$chapterUnavailable$en chapterUnavailable = Translations$chapterUnavailable$en.internal(_root);
	late final Translations$verseNumbering$en verseNumbering = Translations$verseNumbering$en.internal(_root);
	late final Translations$compare$en compare = Translations$compare$en.internal(_root);
	late final Translations$commentaryUi$en commentaryUi = Translations$commentaryUi$en.internal(_root);
	late final Translations$searchLocations$en searchLocations = Translations$searchLocations$en.internal(_root);
	late final Translations$themeOptions$en themeOptions = Translations$themeOptions$en.internal(_root);
	late final Translations$toolbarPresets$en toolbarPresets = Translations$toolbarPresets$en.internal(_root);
	late final Translations$commentaryTypes$en commentaryTypes = Translations$commentaryTypes$en.internal(_root);
	late final Translations$strongDefinition$en strongDefinition = Translations$strongDefinition$en.internal(_root);
	late final Translations$planTypes$en planTypes = Translations$planTypes$en.internal(_root);
	late final Translations$onboardingSteps$en onboardingSteps = Translations$onboardingSteps$en.internal(_root);
	late final Translations$dictionary$en dictionary = Translations$dictionary$en.internal(_root);
	late final Translations$navigation$en navigation = Translations$navigation$en.internal(_root);
	late final Translations$bibleSheet$en bibleSheet = Translations$bibleSheet$en.internal(_root);
	late final Translations$selectionUi$en selectionUi = Translations$selectionUi$en.internal(_root);
	late final Translations$errors$en errors = Translations$errors$en.internal(_root);
	late final Translations$morphology$en morphology = Translations$morphology$en.internal(_root);
	late final Translations$settings$en settings = Translations$settings$en.internal(_root);
}

// Path: languages
class Translations$languages$en {
	Translations$languages$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'English'
	String get english => 'English';

	/// en: 'Dutch'
	String get dutch => 'Dutch';

	/// en: 'Greek'
	String get greek => 'Greek';

	/// en: 'Hebrew'
	String get hebrew => 'Hebrew';

	/// en: 'Russian'
	String get russian => 'Russian';

	/// en: 'French'
	String get french => 'French';

	/// en: 'Spanish'
	String get spanish => 'Spanish';
}

// Path: highlightStyles
class Translations$highlightStyles$en {
	Translations$highlightStyles$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Red'
	String get red => 'Red';

	/// en: 'Orange'
	String get orange => 'Orange';

	/// en: 'Yellow'
	String get yellow => 'Yellow';

	/// en: 'Green'
	String get green => 'Green';

	/// en: 'Blue'
	String get blue => 'Blue';

	/// en: 'Violet'
	String get violet => 'Violet';

	/// en: 'Underline'
	String get underline => 'Underline';

	/// en: 'Important'
	String get important => 'Important';

	/// en: 'Highlight'
	String get highlight => 'Highlight';

	/// en: 'Squiggle'
	String get squiggle => 'Squiggle';
}

// Path: colors
class Translations$colors$en {
	Translations$colors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Red'
	String get red => 'Red';

	/// en: 'Orange'
	String get orange => 'Orange';

	/// en: 'Yellow'
	String get yellow => 'Yellow';

	/// en: 'Green'
	String get green => 'Green';

	/// en: 'Blue'
	String get blue => 'Blue';

	/// en: 'Violet'
	String get violet => 'Violet';

	/// en: 'Silver'
	String get silver => 'Silver';
}

// Path: testaments
class Translations$testaments$en {
	Translations$testaments$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Old Testament'
	String get old => 'Old Testament';

	/// en: 'New Testament'
	String get newTestament => 'New Testament';

	/// en: 'Old Testament Only'
	String get oldOnly => 'Old Testament Only';

	/// en: 'New Testament Only'
	String get newOnly => 'New Testament Only';

	/// en: 'Whole Bible'
	String get wholeBible => 'Whole Bible';

	/// en: 'Only contains books in the Old Testament.'
	String get oldOnlyDescription => 'Only contains books in the Old Testament.';

	/// en: 'Only contains books in the New Testament.'
	String get newOnlyDescription => 'Only contains books in the New Testament.';

	/// en: 'Contains all the books in the Bible.'
	String get wholeBibleDescription => 'Contains all the books in the Bible.';
}

// Path: books
class Translations$books$en {
	Translations$books$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Genesis'
	String get genesis => 'Genesis';

	/// en: 'Exodus'
	String get exodus => 'Exodus';

	/// en: 'Leviticus'
	String get leviticus => 'Leviticus';

	/// en: 'Numbers'
	String get numbers => 'Numbers';

	/// en: 'Deuteronomy'
	String get deuteronomy => 'Deuteronomy';

	/// en: 'Joshua'
	String get joshua => 'Joshua';

	/// en: 'Judges'
	String get judges => 'Judges';

	/// en: 'Ruth'
	String get ruth => 'Ruth';

	/// en: '1 Samuel'
	String get samuel1 => '1 Samuel';

	/// en: '2 Samuel'
	String get samuel2 => '2 Samuel';

	/// en: '1 Kings'
	String get kings1 => '1 Kings';

	/// en: '2 Kings'
	String get kings2 => '2 Kings';

	/// en: '1 Chronicles'
	String get chronicles1 => '1 Chronicles';

	/// en: '2 Chronicles'
	String get chronicles2 => '2 Chronicles';

	/// en: 'Ezra'
	String get ezra => 'Ezra';

	/// en: 'Nehemiah'
	String get nehemiah => 'Nehemiah';

	/// en: 'Esther'
	String get esther => 'Esther';

	/// en: 'Job'
	String get job => 'Job';

	/// en: 'Psalm'
	String get psalm => 'Psalm';

	/// en: 'Psalms'
	String get psalms => 'Psalms';

	/// en: 'Proverbs'
	String get proverbs => 'Proverbs';

	/// en: 'Ecclesiastes'
	String get ecclesiastes => 'Ecclesiastes';

	/// en: 'Song of Solomon'
	String get songOfSolomon => 'Song of Solomon';

	/// en: 'Isaiah'
	String get isaiah => 'Isaiah';

	/// en: 'Jeremiah'
	String get jeremiah => 'Jeremiah';

	/// en: 'Lamentations'
	String get lamentations => 'Lamentations';

	/// en: 'Ezekiel'
	String get ezekiel => 'Ezekiel';

	/// en: 'Daniel'
	String get daniel => 'Daniel';

	/// en: 'Hosea'
	String get hosea => 'Hosea';

	/// en: 'Joel'
	String get joel => 'Joel';

	/// en: 'Amos'
	String get amos => 'Amos';

	/// en: 'Obadiah'
	String get obadiah => 'Obadiah';

	/// en: 'Jonah'
	String get jonah => 'Jonah';

	/// en: 'Micah'
	String get micah => 'Micah';

	/// en: 'Nahum'
	String get nahum => 'Nahum';

	/// en: 'Habakkuk'
	String get habakkuk => 'Habakkuk';

	/// en: 'Zephaniah'
	String get zephaniah => 'Zephaniah';

	/// en: 'Haggai'
	String get haggai => 'Haggai';

	/// en: 'Zechariah'
	String get zechariah => 'Zechariah';

	/// en: 'Malachi'
	String get malachi => 'Malachi';

	/// en: 'Matthew'
	String get matthew => 'Matthew';

	/// en: 'Mark'
	String get mark => 'Mark';

	/// en: 'Luke'
	String get luke => 'Luke';

	/// en: 'John'
	String get john => 'John';

	/// en: 'Acts'
	String get acts => 'Acts';

	/// en: 'Romans'
	String get romans => 'Romans';

	/// en: '1 Corinthians'
	String get corinthians1 => '1 Corinthians';

	/// en: '2 Corinthians'
	String get corinthians2 => '2 Corinthians';

	/// en: 'Galatians'
	String get galatians => 'Galatians';

	/// en: 'Ephesians'
	String get ephesians => 'Ephesians';

	/// en: 'Philippians'
	String get philippians => 'Philippians';

	/// en: 'Colossians'
	String get colossians => 'Colossians';

	/// en: '1 Thessalonians'
	String get thessalonians1 => '1 Thessalonians';

	/// en: '2 Thessalonians'
	String get thessalonians2 => '2 Thessalonians';

	/// en: '1 Timothy'
	String get timothy1 => '1 Timothy';

	/// en: '2 Timothy'
	String get timothy2 => '2 Timothy';

	/// en: 'Titus'
	String get titus => 'Titus';

	/// en: 'Philemon'
	String get philemon => 'Philemon';

	/// en: 'Hebrews'
	String get hebrews => 'Hebrews';

	/// en: 'James'
	String get james => 'James';

	/// en: '1 Peter'
	String get peter1 => '1 Peter';

	/// en: '2 Peter'
	String get peter2 => '2 Peter';

	/// en: '1 John'
	String get john1 => '1 John';

	/// en: '2 John'
	String get john2 => '2 John';

	/// en: '3 John'
	String get john3 => '3 John';

	/// en: 'Jude'
	String get jude => 'Jude';

	/// en: 'Revelation'
	String get revelation => 'Revelation';
}

// Path: common
class Translations$common$en {
	Translations$common$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add'
	String get add => 'Add';

	/// en: 'Add New'
	String get addNew => 'Add New';

	/// en: 'AM'
	String get am => 'AM';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Copy'
	String get copy => 'Copy';

	/// en: 'Continue'
	String get continueLabel => 'Continue';

	/// en: 'Create'
	String get create => 'Create';

	/// en: 'Custom'
	String get custom => 'Custom';

	/// en: 'Default'
	String get defaultLabel => 'Default';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Done'
	String get done => 'Done';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Finish'
	String get finish => 'Finish';

	/// en: 'Learn More'
	String get learnMore => 'Learn More';

	/// en: 'Nevermind'
	String get nevermind => 'Nevermind';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'No Matches'
	String get noMatches => 'No Matches';

	/// en: 'No notification'
	String get noNotification => 'No notification';

	/// en: 'Ok'
	String get ok => 'Ok';

	/// en: 'Off'
	String get off => 'Off';

	/// en: 'None'
	String get none => 'None';

	/// en: 'Clear'
	String get clear => 'Clear';

	/// en: 'Remove'
	String get remove => 'Remove';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'Select'
	String get select => 'Select';

	/// en: 'Show'
	String get show => 'Show';

	/// en: 'Hide'
	String get hide => 'Hide';

	/// en: 'PM'
	String get pm => 'PM';

	/// en: 'Sort'
	String get sort => 'Sort';

	/// en: 'Stop'
	String get stop => 'Stop';

	/// en: 'Try Again'
	String get tryAgain => 'Try Again';

	/// en: 'Switch to {translation}'
	String switchTo({required Object translation}) => 'Switch to ${translation}';

	/// en: 'This is not available in {translation}.'
	String notAvailableIn({required Object translation}) => 'This is not available in ${translation}.';
}

// Path: regionTypes
class Translations$regionTypes$en {
	Translations$regionTypes$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'this chapter'
	String get chapter => 'this chapter';

	/// en: 'these verses'
	String get verses => 'these verses';

	/// en: 'visible verses'
	String get visibleVerses => 'visible verses';

	/// en: 'this text'
	String get text => 'this text';
}

// Path: mainActions
class Translations$mainActions$en {
	Translations$mainActions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Pause Audio Bible'
	String get pauseAudio => 'Pause Audio Bible';

	/// en: 'Play Audio Bible'
	String get playAudio => 'Play Audio Bible';

	/// en: 'Bookmark'
	String get bookmark => 'Bookmark';

	/// en: 'Study'
	String get study => 'Study';

	/// en: 'Verse of the Day'
	String get verseOfTheDay => 'Verse of the Day';

	/// en: 'Add Study Panel'
	String get addStudyPanel => 'Add Study Panel';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'Resources'
	String get resources => 'Resources';

	/// en: 'Bible Plans'
	String get plans => 'Bible Plans';

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'More'
	String get more => 'More';

	/// en: 'Listen to the current chapter with an audio-enabled Bible.'
	String get audioDescription => 'Listen to the current chapter with an audio-enabled Bible.';

	/// en: 'Bookmark this chapter to easily access it from the search page.'
	String get bookmarkDescription => 'Bookmark this chapter to easily access it from the search page.';

	/// en: 'Manage this bookmark.'
	String get manageBookmarkDescription => 'Manage this bookmark.';

	/// en: 'View study tools for this chapter.'
	String get studyDescription => 'View study tools for this chapter.';

	/// en: 'View the verse of the day.'
	String get verseOfTheDayDescription => 'View the verse of the day.';

	/// en: 'Pin a panel beside the text that follows along and shows study tools for whatever you're reading.'
	String get studyPanelDescription => 'Pin a panel beside the text that follows along and shows study tools for whatever you\'re reading.';

	/// en: 'Search for words across the Bible.'
	String get searchDescription => 'Search for words across the Bible.';

	/// en: 'Look up words in the dictionary and lexicon.'
	String get resourcesDescription => 'Look up words in the dictionary and lexicon.';

	/// en: 'Read through the Bible with guided reading plans.'
	String get plansDescription => 'Read through the Bible with guided reading plans.';

	/// en: 'View the settings for Lux.'
	String get settingsDescription => 'View the settings for Lux.';

	/// en: 'View settings, your content, and community links.'
	String get moreDescription => 'View settings, your content, and community links.';
}

// Path: verseOfTheDay
class Translations$verseOfTheDay$en {
	Translations$verseOfTheDay$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add A Daily Reminder?'
	String get reminderDiscoveryTitle => 'Add A Daily Reminder?';

	/// en: 'Would you like Lux to notify you with the Verse of the Day each day?'
	String get reminderDiscoveryBody => 'Would you like Lux to notify you with the Verse of the Day each day?';

	/// en: 'Add Reminder'
	String get addReminder => 'Add Reminder';

	/// en: 'No'
	String get noReminder => 'No';

	/// en: 'Daily Reminder'
	String get dailyReminders => 'Daily Reminder';

	/// en: 'Delete Reminder?'
	String get deleteReminder => 'Delete Reminder?';

	/// en: 'Are you sure you want to delete your daily Verse of the Day reminder?'
	String get deleteReminderConfirmation => 'Are you sure you want to delete your daily Verse of the Day reminder?';

	/// en: 'Verse of the Day Reminders'
	String get reminderNotificationChannelName => 'Verse of the Day Reminders';

	/// en: 'Daily Verse of the Day reminders'
	String get reminderNotificationChannelDescription => 'Daily Verse of the Day reminders';

	/// en: 'Verse of the Day'
	String get reminderNotificationTitle => 'Verse of the Day';

	/// en: 'Notifications Are Off'
	String get reminderPermissionDeniedTitle => 'Notifications Are Off';

	/// en: 'To save this reminder, allow Lux to send notifications in Settings.'
	String get reminderPermissionDeniedBody => 'To save this reminder, allow Lux to send notifications in Settings.';

	/// en: 'Open Settings'
	String get openNotificationSettings => 'Open Settings';

	/// en: 'Couldn't Schedule Reminder'
	String get reminderSchedulingFailedTitle => 'Couldn\'t Schedule Reminder';

	/// en: 'Lux couldn't schedule this reminder. Please try again.'
	String get reminderSchedulingFailedBody => 'Lux couldn\'t schedule this reminder. Please try again.';

	/// en: 'Verse of the Day reminder saved for daily at {time}.'
	String reminderSaved({required Object time}) => 'Verse of the Day reminder saved for daily at ${time}.';
}

// Path: studyActions
class Translations$studyActions$en {
	Translations$studyActions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Quick Study'
	String get quickStudy => 'Quick Study';

	/// en: 'Compare'
	String get compare => 'Compare';

	/// en: 'Interlinear'
	String get interlinear => 'Interlinear';

	/// en: 'Commentary'
	String get commentary => 'Commentary';

	/// en: 'Cross References'
	String get crossReferences => 'Cross References';

	/// en: 'Compare {region} across a variety of translations.'
	String compareDescription({required Object region}) => 'Compare ${region} across a variety of translations.';

	/// en: 'View a lexical breakdown of {region} using Strong's.'
	String interlinearDescription({required Object region}) => 'View a lexical breakdown of ${region} using Strong\'s.';

	/// en: 'View commentaries of {region}.'
	String commentaryDescription({required Object region}) => 'View commentaries of ${region}.';

	/// en: 'View cross references of {region}.'
	String crossReferencesDescription({required Object region}) => 'View cross references of ${region}.';

	/// en: 'No Cross References Found'
	String get noCrossReferences => 'No Cross References Found';

	/// en: 'Cross references use {translation}'
	String crossReferencesUse({required Object translation}) => 'Cross references use ${translation}';

	/// en: 'Because your selected translation is only available online, cross references are shown using the latest Study Bible you used to save on performance and costs. Your selected translation is used everywhere else in the app.'
	String get onlineCrossReferencesExplanation => 'Because your selected translation is only available online, cross references are shown using the latest Study Bible you used to save on performance and costs. Your selected translation is used everywhere else in the app.';
}

// Path: selectionActions
class Translations$selectionActions$en {
	Translations$selectionActions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Annotate'
	String get annotate => 'Annotate';

	/// en: 'Study'
	String get study => 'Study';

	/// en: 'Copy'
	String get copy => 'Copy';

	/// en: 'Highlight'
	String get highlight => 'Highlight';

	/// en: 'Remove Annotations'
	String get removeAnnotations => 'Remove Annotations';

	/// en: 'Interlinear'
	String get interlinear => 'Interlinear';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'Annotate these verses.'
	String get annotateVersesDescription => 'Annotate these verses.';

	/// en: 'Study these verses.'
	String get studyVersesDescription => 'Study these verses.';

	/// en: 'Copy these verses to your clipboard.'
	String get copyVersesDescription => 'Copy these verses to your clipboard.';

	/// en: 'Annotate this text.'
	String get annotateTextDescription => 'Annotate this text.';

	/// en: 'View a lexical breakdown of this text.'
	String get interlinearTextDescription => 'View a lexical breakdown of this text.';

	/// en: 'Search the Bible for this text.'
	String get searchTextDescription => 'Search the Bible for this text.';

	/// en: 'Copy this text to your clipboard.'
	String get copyTextDescription => 'Copy this text to your clipboard.';

	/// en: 'Remove text selection annotations from {region}.'
	String removeTextAnnotationsDescription({required Object region}) => 'Remove text selection annotations from ${region}.';

	/// en: 'Highlight {region} with the last color you used.'
	String highlightTextDescription({required Object region}) => 'Highlight ${region} with the last color you used.';

	/// en: 'Remove verse selection annotations from {region}.'
	String removeVerseAnnotationsDescription({required Object region}) => 'Remove verse selection annotations from ${region}.';

	/// en: 'Highlight {region} with the last color you used.'
	String highlightVersesDescription({required Object region}) => 'Highlight ${region} with the last color you used.';

	/// en: 'Highlighted text in {reference}.'
	String highlightedText({required Object reference}) => 'Highlighted text in ${reference}.';

	/// en: 'Highlighted {reference}.'
	String highlightedVerses({required Object reference}) => 'Highlighted ${reference}.';

	/// en: '{reference} copied to clipboard.'
	String copiedVerses({required Object reference}) => '${reference} copied to clipboard.';

	/// en: 'Text selection copied to clipboard.'
	String get copiedText => 'Text selection copied to clipboard.';

	/// en: 'Interlinear by text selection is only available in Study Bibles, which are designed with word-for-word Strong's and morphology tagging. Switch your translation to a Study Bible to use this action.'
	String get interlinearUnavailable => 'Interlinear by text selection is only available in Study Bibles, which are designed with word-for-word Strong\'s and morphology tagging. Switch your translation to a Study Bible to use this action.';

	/// en: 'No interlinear words found in this selection.'
	String get noInterlinearWords => 'No interlinear words found in this selection.';

	/// en: 'Text in {reference}'
	String textInReference({required Object reference}) => 'Text in ${reference}';
}

// Path: studyPanels
class Translations$studyPanels$en {
	Translations$studyPanels$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Study Panel'
	String get title => 'Study Panel';

	/// en: 'Pin as Study Panel'
	String get pinAsStudyPanel => 'Pin as Study Panel';

	/// en: 'Compare with {translation}'
	String compareWith({required Object translation}) => 'Compare with ${translation}';

	/// en: '{direction} Interlinear'
	String directionInterlinear({required Object direction}) => '${direction} Interlinear';

	/// en: '{commentary} Commentary'
	String commentaryName({required Object commentary}) => '${commentary} Commentary';

	/// en: 'Notes'
	String get notes => 'Notes';

	/// en: 'No Notes Found'
	String get noNotes => 'No Notes Found';

	/// en: 'View your notes in visible verses.'
	String get notesDescription => 'View your notes in visible verses.';
}

// Path: bookmarks
class Translations$bookmarks$en {
	Translations$bookmarks$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Create Bookmark'
	String get create => 'Create Bookmark';

	/// en: 'Manage Bookmark'
	String get manage => 'Manage Bookmark';

	/// en: 'Stop Following'
	String get stopFollowing => 'Stop Following';

	/// en: 'Stop this bookmark from following you.'
	String get stopFollowingDescription => 'Stop this bookmark from following you.';

	/// en: 'Edit Bookmark'
	String get edit => 'Edit Bookmark';

	/// en: 'Delete Bookmark'
	String get delete => 'Delete Bookmark';

	/// en: 'Are you sure you want to delete this bookmark?'
	String get deleteConfirmation => 'Are you sure you want to delete this bookmark?';

	/// en: 'Are you sure you want to delete "{name}"?'
	String deleteNamedConfirmation({required Object name}) => 'Are you sure you want to delete "${name}"?';
}

// Path: bookmarkPage
class Translations$bookmarkPage$en {
	Translations$bookmarkPage$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your Bookmarks'
	String get title => 'Your Bookmarks';
}

// Path: commentaries
class Translations$commentaries$en {
	Translations$commentaries$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add & Remove Commentaries'
	String get addRemove => 'Add & Remove Commentaries';
}

// Path: toolbarShortcuts
class Translations$toolbarShortcuts$en {
	Translations$toolbarShortcuts$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Switch Bible'
	String get switchBible => 'Switch Bible';

	/// en: 'Dictionary'
	String get dictionary => 'Dictionary';

	/// en: 'Lexicon'
	String get lexicon => 'Lexicon';

	/// en: 'Theme & Layout'
	String get themeAndLayout => 'Theme & Layout';

	/// en: 'Switch the Bible translation.'
	String get switchBibleDescription => 'Switch the Bible translation.';

	/// en: 'Look up people, places, and topics in Easton's Bible Dictionary.'
	String get dictionaryDescription => 'Look up people, places, and topics in Easton\'s Bible Dictionary.';

	/// en: 'Study the original Hebrew and Greek words with Strong's Lexicon.'
	String get lexiconDescription => 'Study the original Hebrew and Greek words with Strong\'s Lexicon.';

	/// en: 'Customize the theme & layout of the Bible.'
	String get themeAndLayoutDescription => 'Customize the theme & layout of the Bible.';
}

// Path: labels
class Translations$labels$en {
	Translations$labels$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'About'
	String get about => 'About';

	/// en: 'Annotation'
	String get annotation => 'Annotation';

	/// en: 'Annotations'
	String get annotations => 'Annotations';

	/// en: 'Audio Bible'
	String get audioBible => 'Audio Bible';

	/// en: 'Bible'
	String get bible => 'Bible';

	/// en: 'Bibles'
	String get bibles => 'Bibles';

	/// en: 'Bible Plans'
	String get biblePlans => 'Bible Plans';

	/// en: 'Bookmarks'
	String get bookmarks => 'Bookmarks';

	/// en: 'Books'
	String get books => 'Books';

	/// en: 'Color'
	String get color => 'Color';

	/// en: 'Commentaries'
	String get commentaries => 'Commentaries';

	/// en: 'Commentary'
	String get commentary => 'Commentary';

	/// en: 'Community'
	String get community => 'Community';

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'Cross References'
	String get crossReferences => 'Cross References';

	/// en: 'Days'
	String get days => 'Days';

	/// en: 'Dictionary'
	String get dictionary => 'Dictionary';

	/// en: 'Discord'
	String get discord => 'Discord';

	/// en: 'Duration'
	String get duration => 'Duration';

	/// en: 'Following'
	String get following => 'Following';

	/// en: 'Footnotes'
	String get footnotes => 'Footnotes';

	/// en: 'Help'
	String get help => 'Help';

	/// en: 'Highlight Styles'
	String get highlightStyles => 'Highlight Styles';

	/// en: 'Instagram'
	String get instagram => 'Instagram';

	/// en: 'Interlinear'
	String get interlinear => 'Interlinear';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Layout'
	String get layout => 'Layout';

	/// en: 'Lexicon'
	String get lexicon => 'Lexicon';

	/// en: 'Licenses'
	String get licenses => 'Licenses';

	/// en: 'Locations'
	String get locations => 'Locations';

	/// en: 'Name'
	String get name => 'Name';

	/// en: 'Note'
	String get note => 'Note';

	/// en: 'Notebook'
	String get notebook => 'Notebook';

	/// en: 'Notebooks'
	String get notebooks => 'Notebooks';

	/// en: 'Notes'
	String get notes => 'Notes';

	/// en: 'Paragraphs'
	String get paragraphs => 'Paragraphs';

	/// en: 'Resources'
	String get resources => 'Resources';

	/// en: 'Scope'
	String get scope => 'Scope';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'Selection'
	String get selection => 'Selection';

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'Source'
	String get source => 'Source';

	/// en: 'Study'
	String get study => 'Study';

	/// en: 'Style'
	String get style => 'Style';

	/// en: 'Text'
	String get text => 'Text';

	/// en: 'Toolbar'
	String get toolbar => 'Toolbar';

	/// en: 'Toolbars'
	String get toolbars => 'Toolbars';

	/// en: 'Type'
	String get type => 'Type';

	/// en: 'Version'
	String get version => 'Version';

	/// en: 'Visibility'
	String get visibility => 'Visibility';
}

// Path: strongSheet
class Translations$strongSheet$en {
	Translations$strongSheet$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Interlinear Word'
	String get interlinearWord => 'Interlinear Word';

	/// en: 'Lexicon'
	String get lexicon => 'Lexicon';

	/// en: 'Legend'
	String get legend => 'Legend';

	/// en: 'Open In Search'
	String get openInSearch => 'Open In Search';

	/// en: 'Usage'
	String get usage => 'Usage';

	/// en: 'Inflected'
	String get inflected => 'Inflected';

	/// en: 'Transliteration'
	String get transliteration => 'Transliteration';

	/// en: 'Root'
	String get root => 'Root';

	/// en: 'Strong's {id}'
	String strongsId({required Object id}) => 'Strong\'s ${id}';

	/// en: 'Root Word'
	String get rootWord => 'Root Word';

	/// en: 'Pronunciation'
	String get pronunciation => 'Pronunciation';

	/// en: 'Strong's Definition'
	String get strongsDefinition => 'Strong\'s Definition';

	/// en: 'Biblical Usage'
	String get biblicalUsage => 'Biblical Usage';

	/// en: 'Definition'
	String get definition => 'Definition';

	/// en: 'Examples'
	String get examples => 'Examples';

	/// en: 'Examples: '
	String get examplesPrefix => 'Examples: ';

	/// en: 'Part of Speech'
	String get partOfSpeech => 'Part of Speech';

	/// en: 'Derivation'
	String get derivation => 'Derivation';

	/// en: 'Morphology'
	String get morphology => 'Morphology';

	/// en: 'Related Terms'
	String get relatedTerms => 'Related Terms';

	/// en: 'Morphology Info'
	String get morphologyInfo => 'Morphology Info';

	/// en: 'Strong's Definition Legend'
	String get definitionLegend => 'Strong\'s Definition Legend';

	/// en: 'Optional word'
	String get optionalWord => 'Optional word';

	/// en: 'Marks a word or syllable that may be supplied with the main word.'
	String get optionalWordDescription => 'Marks a word or syllable that may be supplied with the main word.';

	/// en: 'Added word in Hebrew or Greek'
	String get addedWord => 'Added word in Hebrew or Greek';

	/// en: 'Marks a word included in the English rendering even though it is not present in the Hebrew or Greek.'
	String get addedWordDescription => 'Marks a word included in the English rendering even though it is not present in the Hebrew or Greek.';

	/// en: 'Explanation'
	String get explanation => 'Explanation';

	/// en: 'Italic text at the end of a rendering explains a variation from the usual form.'
	String get renderingExplanation => 'Italic text at the end of a rendering explains a variation from the usual form.';

	/// en: 'Concordance'
	String get concordance => 'Concordance';
}

// Path: bibleDetails
class Translations$bibleDetails$en {
	Translations$bibleDetails$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Online Only'
	String get onlineOnly => 'Online Only';

	/// en: 'This Bible is streamed from {source}, so it requires an internet connection.'
	String onlineDescription({required Object source}) => 'This Bible is streamed from ${source}, so it requires an internet connection.';

	/// en: 'Study Bible'
	String get studyBible => 'Study Bible';

	/// en: 'Audio Bible'
	String get audioBible => 'Audio Bible';

	/// en: 'On Device'
	String get onDevice => 'On Device';

	/// en: 'This Bible is downloaded to your device, so you can search it and read offline.'
	String get onDeviceDescription => 'This Bible is downloaded to your device, so you can search it and read offline.';

	/// en: 'Includes interlinear and morphology data. Long-press any word while reading to see the original Greek or Hebrew.'
	String get studyBibleDescription => 'Includes interlinear and morphology data. Long-press any word while reading to see the original Greek or Hebrew.';

	/// en: 'Reading Bible'
	String get readingBible => 'Reading Bible';

	/// en: 'Doesn't include interlinear or morphology data.'
	String get readingBibleDescription => 'Doesn\'t include interlinear or morphology data.';

	/// en: 'Native Headings'
	String get nativeHeadings => 'Native Headings';

	/// en: 'Headings are included with this Bible.'
	String get nativeHeadingsDescription => 'Headings are included with this Bible.';

	/// en: 'Synthetic Headings'
	String get syntheticHeadings => 'Synthetic Headings';

	/// en: 'Headings are synthetically inserted into this Bible from the BSB.'
	String get syntheticHeadingsDescription => 'Headings are synthetically inserted into this Bible from the BSB.';

	/// en: 'No Headings'
	String get noHeadings => 'No Headings';

	/// en: 'No headings are included in this Bible.'
	String get noHeadingsDescription => 'No headings are included in this Bible.';

	/// en: 'Whether this Bible includes an Audio Bible'
	String get audioSupportDescription => 'Whether this Bible includes an Audio Bible';

	/// en: 'Red Letters'
	String get redLetters => 'Red Letters';

	/// en: 'Whether Red Letters are supported in this Bible.'
	String get redLettersDescription => 'Whether Red Letters are supported in this Bible.';

	/// en: 'Whether this Bible includes footnotes.'
	String get footnotesDescription => 'Whether this Bible includes footnotes.';

	/// en: 'Whether this Bible includes paragraphs.'
	String get paragraphsDescription => 'Whether this Bible includes paragraphs.';

	/// en: 'Add & Remove Bibles'
	String get addRemoveBibles => 'Add & Remove Bibles';

	/// en: 'Verse Numbering'
	String get verseNumbering => 'Verse Numbering';
}

// Path: emptyStates
class Translations$emptyStates$en {
	Translations$emptyStates$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No Commentaries Found'
	String get noCommentaries => 'No Commentaries Found';

	/// en: 'No matching words'
	String get noMatchingWords => 'No matching words';

	/// en: 'No matching terms'
	String get noMatchingTerms => 'No matching terms';

	/// en: 'No matching Bible plans.'
	String get noMatchingPlans => 'No matching Bible plans.';

	/// en: 'No matching annotations.'
	String get noMatchingAnnotations => 'No matching annotations.';

	/// en: 'No Search Results Found'
	String get noSearchResults => 'No Search Results Found';

	/// en: 'Try another search'
	String get tryAnotherSearch => 'Try another search';

	/// en: 'You haven't added any commentaries.'
	String get noCommentariesAdded => 'You haven\'t added any commentaries.';

	/// en: 'You haven't created any annotations.'
	String get noAnnotations => 'You haven\'t created any annotations.';

	/// en: 'You haven't created any bookmarks.'
	String get noBookmarks => 'You haven\'t created any bookmarks.';

	/// en: 'You haven't created any notebooks. Notebooks let you organize your annotations.'
	String get noNotebooks => 'You haven\'t created any notebooks. Notebooks let you organize your annotations.';

	/// en: 'You aren't following any reading plans yet. Find one to start reading through the Bible.'
	String get noPlans => 'You aren\'t following any reading plans yet. Find one to start reading through the Bible.';
}

// Path: annotationUi
class Translations$annotationUi$en {
	Translations$annotationUi$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your Annotations'
	String get yourAnnotations => 'Your Annotations';

	/// en: 'Annotate'
	String get annotate => 'Annotate';

	/// en: 'With Notes'
	String get withNotes => 'With Notes';

	/// en: 'Without Notes'
	String get withoutNotes => 'Without Notes';

	/// en: 'Most Recent'
	String get mostRecent => 'Most Recent';

	/// en: 'Location'
	String get location => 'Location';

	/// en: 'Delete Annotation'
	String get deleteAnnotation => 'Delete Annotation';

	/// en: 'Are you sure you want to delete this annotation?'
	String get deleteConfirmation => 'Are you sure you want to delete this annotation?';

	/// en: '(one) {{count} annotation} (other) {{count} annotations}'
	String annotationCount({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: '${count} annotation',
		other: '${count} annotations',
	);

	/// en: 'Annotated {time}'
	String annotatedTime({required Object time}) => 'Annotated ${time}';
}

// Path: notebookUi
class Translations$notebookUi$en {
	Translations$notebookUi$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your Notebooks'
	String get yourNotebooks => 'Your Notebooks';

	/// en: 'Hidden'
	String get hidden => 'Hidden';

	/// en: 'Hide the annotations in this notebook from appearing in the Bible.'
	String get hideDescription => 'Hide the annotations in this notebook from appearing in the Bible.';

	/// en: 'Show the annotations from this notebook in the Bible.'
	String get showDescription => 'Show the annotations from this notebook in the Bible.';

	/// en: 'The permanent notebook for unassigned annotations.'
	String get defaultDescription => 'The permanent notebook for unassigned annotations.';

	/// en: 'Create Notebook'
	String get create => 'Create Notebook';

	/// en: 'Edit Notebook'
	String get edit => 'Edit Notebook';

	/// en: 'Delete Notebook'
	String get delete => 'Delete Notebook';

	/// en: 'Are you sure you want to delete "{name}"?'
	String deleteNamedConfirmation({required Object name}) => 'Are you sure you want to delete "${name}"?';

	/// en: '"{name}" has {annotations}. Would you like to delete them too, or keep them in the Default notebook?'
	String deleteWithAnnotations({required Object name, required Object annotations}) => '"${name}" has ${annotations}. Would you like to delete them too, or keep them in the Default notebook?';

	/// en: 'Keep in Default'
	String get keepInDefault => 'Keep in Default';

	/// en: 'Delete Annotations'
	String get deleteAnnotations => 'Delete Annotations';
}

// Path: highlightStyleUi
class Translations$highlightStyleUi$en {
	Translations$highlightStyleUi$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your Highlight Styles'
	String get yourStyles => 'Your Highlight Styles';

	/// en: 'Create Style'
	String get create => 'Create Style';

	/// en: 'Edit Style'
	String get edit => 'Edit Style';

	/// en: 'You already have this style'
	String get duplicate => 'You already have this style';

	/// en: 'Delete Style'
	String get delete => 'Delete Style';

	/// en: 'Are you sure you want to delete "{name}"?'
	String deleteNamedConfirmation({required Object name}) => 'Are you sure you want to delete "${name}"?';

	/// en: '"{name}" has {annotations}. Would you like to delete them too, or keep them?'
	String deleteWithAnnotations({required Object name, required Object annotations}) => '"${name}" has ${annotations}. Would you like to delete them too, or keep them?';

	/// en: 'Keep Annotations'
	String get keepAnnotations => 'Keep Annotations';

	/// en: 'Delete Annotations'
	String get deleteAnnotations => 'Delete Annotations';

	/// en: 'Update Annotations'
	String get updateAnnotations => 'Update Annotations';

	/// en: '"{name}" has {annotations}. Would you like to update them to use the new style, or leave them as-is?'
	String updateWithAnnotations({required Object name, required Object annotations}) => '"${name}" has ${annotations}. Would you like to update them to use the new style, or leave them as-is?';

	/// en: 'Leave As-Is'
	String get leaveAsIs => 'Leave As-Is';

	/// en: 'Label'
	String get label => 'Label';
}

// Path: toolbarSettings
class Translations$toolbarSettings$en {
	Translations$toolbarSettings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Main Toolbar'
	String get mainToolbar => 'Main Toolbar';

	/// en: 'Verse Selection'
	String get verseSelection => 'Verse Selection';

	/// en: 'Text Selection'
	String get textSelection => 'Text Selection';

	/// en: 'Shown when nothing is selected.'
	String get shownForMain => 'Shown when nothing is selected.';

	/// en: 'Shown when a verse is selected.'
	String get shownForVerses => 'Shown when a verse is selected.';

	/// en: 'Shown when long-pressing text within verses.'
	String get shownForText => 'Shown when long-pressing text within verses.';

	/// en: 'Gestures'
	String get gestures => 'Gestures';

	/// en: 'Long Press'
	String get longPress => 'Long Press';

	/// en: 'Shortcut when the toolbar is long-pressed.'
	String get mainLongPressDescription => 'Shortcut when the toolbar is long-pressed.';

	/// en: 'Shortcut when a verse selection is long-pressed.'
	String get verseLongPressDescription => 'Shortcut when a verse selection is long-pressed.';

	/// en: 'Shortcut when a text selection is long-pressed.'
	String get textLongPressDescription => 'Shortcut when a text selection is long-pressed.';

	/// en: 'Hide'
	String get hideToolbar => 'Hide';

	/// en: 'Hide the toolbar while scrolling down for an immersive view of the Bible.'
	String get hideToolbarDescription => 'Hide the toolbar while scrolling down for an immersive view of the Bible.';

	/// en: 'Pin'
	String get pinToolbar => 'Pin';

	/// en: 'Pin the toolbar to the bottom of the page.'
	String get pinToolbarDescription => 'Pin the toolbar to the bottom of the page.';

	/// en: 'Expand to Annotation'
	String get expandToAnnotation => 'Expand to Annotation';

	/// en: 'Long-pressing an annotated word selects its full highlighted range.'
	String get expandTextDescription => 'Long-pressing an annotated word selects its full highlighted range.';

	/// en: 'Tapping a verse selects its full annotated verse selection.'
	String get expandVerseDescription => 'Tapping a verse selects its full annotated verse selection.';

	/// en: 'Range Selection'
	String get rangeSelection => 'Range Selection';

	/// en: 'Tapping a second verse selects all verses between it and the first.'
	String get rangeSelectionDescription => 'Tapping a second verse selects all verses between it and the first.';

	/// en: 'Main Toolbar Shortcut'
	String get mainShortcut => 'Main Toolbar Shortcut';

	/// en: 'Verse Selection Shortcut'
	String get verseShortcut => 'Verse Selection Shortcut';

	/// en: 'Text Selection Shortcut'
	String get textShortcut => 'Text Selection Shortcut';
}

// Path: themeSettings
class Translations$themeSettings$en {
	Translations$themeSettings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Theme & Layout'
	String get title => 'Theme & Layout';

	/// en: 'Brightness'
	String get brightness => 'Brightness';

	/// en: 'Font'
	String get font => 'Font';

	/// en: 'Font Size & Spacing'
	String get fontSizeSpacing => 'Font Size & Spacing';

	/// en: 'Greek Font Size & Spacing'
	String get greekFontSizeSpacing => 'Greek Font Size & Spacing';

	/// en: 'Hebrew Font Size & Spacing'
	String get hebrewFontSizeSpacing => 'Hebrew Font Size & Spacing';

	/// en: 'System'
	String get system => 'System';

	/// en: 'Use your device's preferred text size.'
	String get systemTextSizeDescription => 'Use your device\'s preferred text size.';

	/// en: 'Use the default Font Size & Spacing.'
	String get defaultSizeDescription => 'Use the default Font Size & Spacing.';

	/// en: 'Red Letters'
	String get redLetters => 'Red Letters';

	/// en: 'Show Jesus' words in red.'
	String get redLettersDescription => 'Show Jesus\' words in red.';

	/// en: 'Section Headings'
	String get sectionHeadings => 'Section Headings';

	/// en: 'Verse Numbers'
	String get verseNumbers => 'Verse Numbers';

	/// en: 'Format verses into paragraphs.'
	String get paragraphsDescription => 'Format verses into paragraphs.';

	/// en: 'Show footnote markers within the text.'
	String get footnotesDescription => 'Show footnote markers within the text.';
}

// Path: biblePlans
class Translations$biblePlans$en {
	Translations$biblePlans$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Find A Bible Plan'
	String get find => 'Find A Bible Plan';

	/// en: 'Start Plan?'
	String get startPlanQuestion => 'Start Plan?';

	/// en: 'Review & Reflect'
	String get reviewAndReflect => 'Review & Reflect';

	/// en: 'Start Plan'
	String get startPlan => 'Start Plan';

	/// en: 'Daily Reminders'
	String get dailyReminders => 'Daily Reminders';

	/// en: 'Set or edit when this plan reminds you to read each day.'
	String get dailyRemindersDescription => 'Set or edit when this plan reminds you to read each day.';

	/// en: 'Daily at {time}'
	String dailyAt({required Object time}) => 'Daily at ${time}';

	/// en: 'Add A Daily Reminder?'
	String get reminderDiscoveryTitle => 'Add A Daily Reminder?';

	/// en: 'Would you like Lux to remind you to continue "{name}" each day?'
	String reminderDiscoveryBody({required Object name}) => 'Would you like Lux to remind you to continue "${name}" each day?';

	/// en: 'Add Reminder'
	String get addReminder => 'Add Reminder';

	/// en: 'No'
	String get noReminder => 'No';

	/// en: 'Delete Reminder?'
	String get deleteReminder => 'Delete Reminder?';

	/// en: 'Are you sure you want to delete the daily reminder for "{name}"?'
	String deleteReminderConfirmation({required Object name}) => 'Are you sure you want to delete the daily reminder for "${name}"?';

	/// en: 'Bible Plan Reminders'
	String get reminderNotificationChannelName => 'Bible Plan Reminders';

	/// en: 'Daily reminders for your Bible plans'
	String get reminderNotificationChannelDescription => 'Daily reminders for your Bible plans';

	/// en: 'Read "{name}"'
	String reminderNotificationTitle({required Object name}) => 'Read "${name}"';

	/// en: 'Today's reading is {reading}'
	String reminderNotificationBody({required Object reading}) => 'Today\'s reading is ${reading}';

	/// en: 'Notifications Are Off'
	String get reminderPermissionDeniedTitle => 'Notifications Are Off';

	/// en: 'To save this reminder, allow Lux to send notifications in Settings.'
	String get reminderPermissionDeniedBody => 'To save this reminder, allow Lux to send notifications in Settings.';

	/// en: 'Open Settings'
	String get openNotificationSettings => 'Open Settings';

	/// en: 'Couldn't Schedule Reminder'
	String get reminderSchedulingFailedTitle => 'Couldn\'t Schedule Reminder';

	/// en: 'Lux couldn't schedule this reminder. Please try again.'
	String get reminderSchedulingFailedBody => 'Lux couldn\'t schedule this reminder. Please try again.';

	/// en: 'Reminder saved for "{name}" daily at {time}.'
	String reminderSaved({required Object name, required Object time}) => 'Reminder saved for "${name}" daily at ${time}.';

	/// en: 'Stop Plan'
	String get stopPlan => 'Stop Plan';

	/// en: 'Remove this plan and its progress.'
	String get stopPlanDescription => 'Remove this plan and its progress.';

	/// en: 'Read Entire Chapter'
	String get readEntireChapter => 'Read Entire Chapter';

	/// en: 'Read In Context'
	String get readInContext => 'Read In Context';

	/// en: 'Start New'
	String get startNew => 'Start New';

	/// en: 'Day {day}'
	String day({required Object day}) => 'Day ${day}';

	/// en: '(one) {{count} day} (other) {{count} days}'
	String dayCount({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: '${count} day',
		other: '${count} days',
	);

	/// en: 'Are you sure you want to stop "{name}"? Your progress will be lost.'
	String stopConfirmation({required Object name}) => 'Are you sure you want to stop "${name}"? Your progress will be lost.';

	/// en: '"{name}" completed.'
	String completed({required Object name}) => '"${name}" completed.';

	/// en: 'Add Bible plan'
	String get addPlan => 'Add Bible plan';
}

// Path: searchUi
class Translations$searchUi$en {
	Translations$searchUi$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Search Bible'
	String get searchBible => 'Search Bible';

	/// en: 'Start a search'
	String get startSearch => 'Start a search';

	/// en: 'Enter a keyword like light, word, or wisdom, then hit enter on the keyboard.'
	String get searchPrompt => 'Enter a keyword like light, word, or wisdom, then hit enter on the keyboard.';

	/// en: 'Using {translation} for search'
	String usingTranslation({required Object translation}) => 'Using ${translation} for search';

	/// en: '{translation} does not currently support search. Using your most-recent Study Bible instead.'
	String unsupportedTranslation({required Object translation}) => '${translation} does not currently support search. Using your most-recent Study Bible instead.';

	/// en: 'Strong's number searches require the word-level Strong's tagging included in Study Bibles. Using your most-recent Study Bible instead.'
	String get strongSearchStudyBibleExplanation => 'Strong\'s number searches require the word-level Strong\'s tagging included in Study Bibles. Using your most-recent Study Bible instead.';

	/// en: 'Search for a word or phrase'
	String get wordOrPhraseHint => 'Search for a word or phrase';

	/// en: 'Search for a word'
	String get wordHint => 'Search for a word';

	/// en: 'Search for a Strong's number (e.g. H125)'
	String get strongNumberHint => 'Search for a Strong\'s number (e.g. H125)';

	late final Translations$searchUi$wordMatching$en wordMatching = Translations$searchUi$wordMatching$en.internal(_root);
}

// Path: onboarding
class Translations$onboarding$en {
	Translations$onboarding$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Skip Onboarding?'
	String get skipQuestion => 'Skip Onboarding?';

	/// en: 'Are you sure you want to skip the onboarding? You can restart it from Settings > Help.'
	String get skipConfirmation => 'Are you sure you want to skip the onboarding? You can restart it from Settings > Help.';

	/// en: 'Get Started'
	String get getStarted => 'Get Started';

	/// en: 'Learn how to use Lux'
	String get learnLux => 'Learn how to use Lux';

	/// en: 'Complete the checklist below to learn how to use Lux.'
	String get checklistDescription => 'Complete the checklist below to learn how to use Lux.';

	/// en: 'In a hurry? Tap ✕ to skip.'
	String get skipHint => 'In a hurry? Tap ✕ to skip.';
}

// Path: tutorials
class Translations$tutorials$en {
	Translations$tutorials$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Don't Show Again'
	String get dontShowAgain => 'Don\'t Show Again';
}

// Path: audio
class Translations$audio$en {
	Translations$audio$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Audio Timer'
	String get timer => 'Audio Timer';

	/// en: '5 minutes'
	String get fiveMinutes => '5 minutes';

	/// en: '10 minutes'
	String get tenMinutes => '10 minutes';

	/// en: '15 minutes'
	String get fifteenMinutes => '15 minutes';

	/// en: '30 minutes'
	String get thirtyMinutes => '30 minutes';

	/// en: '1 hour'
	String get oneHour => '1 hour';

	/// en: 'The audio could not be loaded'
	String get loadError => 'The audio could not be loaded';

	/// en: 'Check your internet connection or try again later.'
	String get connectionError => 'Check your internet connection or try again later.';

	/// en: 'Audio is unavailable for this Bible'
	String get unavailable => 'Audio is unavailable for this Bible';

	/// en: 'Choose an audio-enabled Bible to listen to this chapter.'
	String get chooseBible => 'Choose an audio-enabled Bible to listen to this chapter.';

	/// en: 'Switch to an audio-enabled Bible to listen to this passage.'
	String get switchRequired => 'Switch to an audio-enabled Bible to listen to this passage.';

	/// en: 'Back 10 seconds'
	String get rewindTenSeconds => 'Back 10 seconds';

	/// en: 'Forward 10 seconds'
	String get fastForwardTenSeconds => 'Forward 10 seconds';

	/// en: 'Audio Bible playback'
	String get notificationChannelName => 'Audio Bible playback';

	/// en: 'Audio Bible playback controls'
	String get notificationChannelDescription => 'Audio Bible playback controls';
}

// Path: interlinearUi
class Translations$interlinearUi$en {
	Translations$interlinearUi$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Interlinear Bible'
	String get interlinearBible => 'Interlinear Bible';

	/// en: 'Interlinear Direction'
	String get direction => 'Interlinear Direction';

	/// en: 'Reverse'
	String get reverse => 'Reverse';

	/// en: 'Forward'
	String get forward => 'Forward';

	/// en: 'Words appear in the English reading order.'
	String get reverseDescription => 'Words appear in the English reading order.';

	/// en: 'Words appear in the original Hebrew or Greek order.'
	String get forwardDescription => 'Words appear in the original Hebrew or Greek order.';

	/// en: 'Study Bibles are designed with word-for-word Strong's and morphology tagging, which is what makes the Interlinear lexical breakdown possible. Using your most-recent Study Bible instead.'
	String get studyBibleExplanation => 'Study Bibles are designed with word-for-word Strong\'s and morphology tagging, which is what makes the Interlinear lexical breakdown possible. Using your most-recent Study Bible instead.';

	/// en: 'Using {translation} for interlinear'
	String usingTranslation({required Object translation}) => 'Using ${translation} for interlinear';
}

// Path: chapterUnavailable
class Translations$chapterUnavailable$en {
	Translations$chapterUnavailable$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '{selectedTranslation} doesn't include the {testament}.'
	String title({required Object selectedTranslation, required Object testament}) => '${selectedTranslation} doesn\'t include the ${testament}.';

	/// en: 'Showing your most-recent {testament} Bible, {fallbackTranslation}.'
	String subtitle({required Object testament, required Object fallbackTranslation}) => 'Showing your most-recent ${testament} Bible, ${fallbackTranslation}.';
}

// Path: verseNumbering
class Translations$verseNumbering$en {
	Translations$verseNumbering$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '{translation} {reference}'
	String referenceLabel({required Object translation, required Object reference}) => '${translation} ${reference}';

	/// en: 'The {translation} numbers its chapters and verses differently from most English translations. The text shown here at {reference} comes from {originalReference} in the {translation}, remapped so it lines up with the other translations.'
	String explanation({required Object translation, required Object reference, required Object originalReference}) => 'The ${translation} numbers its chapters and verses differently from most English translations.\n\nThe text shown here at ${reference} comes from ${originalReference} in the ${translation}, remapped so it lines up with the other translations.';
}

// Path: compare
class Translations$compare$en {
	Translations$compare$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '{translation} doesn't include this selection.'
	String unavailable({required Object translation}) => '${translation} doesn\'t include this selection.';
}

// Path: commentaryUi
class Translations$commentaryUi$en {
	Translations$commentaryUi$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Intro to {book}'
	String introTo({required Object book}) => 'Intro to ${book}';
}

// Path: searchLocations
class Translations$searchLocations$en {
	Translations$searchLocations$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Current Book'
	String get currentBook => 'Current Book';

	/// en: 'Testaments'
	String get testaments => 'Testaments';

	/// en: 'Books'
	String get books => 'Books';
}

// Path: themeOptions
class Translations$themeOptions$en {
	Translations$themeOptions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Auto'
	String get auto => 'Auto';

	/// en: 'Light'
	String get light => 'Light';

	/// en: 'Dark'
	String get dark => 'Dark';

	/// en: 'Extra Tiny'
	String get extraTiny => 'Extra Tiny';

	/// en: 'Tiny'
	String get tiny => 'Tiny';

	/// en: 'Small'
	String get small => 'Small';

	/// en: 'Standard'
	String get standard => 'Standard';

	/// en: 'Large'
	String get large => 'Large';

	/// en: 'Huge'
	String get huge => 'Huge';

	/// en: 'Extra Huge'
	String get extraHuge => 'Extra Huge';

	/// en: 'Native & Synthetic'
	String get nativeAndSynthetic => 'Native & Synthetic';

	/// en: 'Native'
	String get native => 'Native';

	/// en: 'None'
	String get none => 'None';

	/// en: 'Show headings in translations that support them, and synthetically insert BSB's section headings into English translations without them natively.'
	String get allHeadingsDescription => 'Show headings in translations that support them, and synthetically insert BSB\'s section headings into English translations without them natively.';

	/// en: 'Show headings in translations that support them.'
	String get nativeHeadingsDescription => 'Show headings in translations that support them.';

	/// en: 'Do not show section headings'
	String get noHeadingsDescription => 'Do not show section headings';
}

// Path: toolbarPresets
class Translations$toolbarPresets$en {
	Translations$toolbarPresets$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reader'
	String get reader => 'Reader';

	/// en: 'Note-taker'
	String get noteTaker => 'Note-taker';

	/// en: 'Studier'
	String get studier => 'Studier';

	/// en: 'Tuned for distraction-free reading and quick navigation.'
	String get readerDescription => 'Tuned for distraction-free reading and quick navigation.';

	/// en: 'Tuned for highlighting and taking notes.'
	String get noteTakerDescription => 'Tuned for highlighting and taking notes.';

	/// en: 'Tuned for cross-references, commentary, and deep study.'
	String get studierDescription => 'Tuned for cross-references, commentary, and deep study.';
}

// Path: commentaryTypes
class Translations$commentaryTypes$en {
	Translations$commentaryTypes$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'A concise, devotional commentary on the whole Bible from the Puritan tradition. Warm, practical, and easy to read.'
	String get matthewHenryDescription => 'A concise, devotional commentary on the whole Bible from the Puritan tradition. Warm, practical, and easy to read.';

	/// en: 'A compact, verse-by-verse commentary on the whole Bible. Balanced and accessible.'
	String get jamiesonFaussetBrownDescription => 'A compact, verse-by-verse commentary on the whole Bible. Balanced and accessible.';

	/// en: 'The Reformer's classic exposition. Deep and doctrinal.'
	String get calvinDescription => 'The Reformer\'s classic exposition. Deep and doctrinal.';
}

// Path: strongDefinition
class Translations$strongDefinition$en {
	Translations$strongDefinition$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'added:'
	String get addedLabel => 'added:';

	/// en: 'idiom:'
	String get idiomLabel => 'idiom:';

	/// en: 'Added word'
	String get addedWord => 'Added word';

	/// en: 'Idiomatic rendering'
	String get idiomaticRendering => 'Idiomatic rendering';

	/// en: 'Marks a word supplied alongside the Hebrew or Greek word being defined.'
	String get addedWordDescription => 'Marks a word supplied alongside the Hebrew or Greek word being defined.';

	/// en: 'Marks a rendering that reflects an expression particular to Hebrew or Greek.'
	String get idiomaticRenderingDescription => 'Marks a rendering that reflects an expression particular to Hebrew or Greek.';
}

// Path: planTypes
class Translations$planTypes$en {
	Translations$planTypes$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Through The Bible'
	String get throughTheBible => 'Through The Bible';

	/// en: 'One Year Chronological'
	String get chronological => 'One Year Chronological';

	/// en: 'Old and New Testament'
	String get oldAndNewTestament => 'Old and New Testament';

	/// en: 'Every Day In the Word'
	String get everyDayInTheWord => 'Every Day In the Word';

	/// en: 'M'Cheyne'
	String get mcheyne => 'M\'Cheyne';

	/// en: 'Literary Study'
	String get literaryStudy => 'Literary Study';

	/// en: 'Different Topics'
	String get differentTopics => 'Different Topics';

	/// en: 'New Testament, Psalms & Proverbs'
	String get newTestamentPsalmsProverbs => 'New Testament, Psalms & Proverbs';

	/// en: '5x5x5 New Testament'
	String get fiveByFiveByFive => '5x5x5 New Testament';

	/// en: 'Gospel and Epistles'
	String get gospelsAndEpistles => 'Gospel and Epistles';

	/// en: 'Pentateuch and History of Israel'
	String get pentateuchAndHistory => 'Pentateuch and History of Israel';

	/// en: 'Chronicles and Prophets'
	String get chroniclesAndProphets => 'Chronicles and Prophets';

	/// en: 'Psalms and Wisdom Literature'
	String get psalmsAndWisdom => 'Psalms and Wisdom Literature';

	/// en: 'A classic plan with four short readings a day. You read through the Old Testament once and the New Testament and Psalms twice in a year.'
	String get mcheyneDescription => 'A classic plan with four short readings a day. You read through the Old Testament once and the New Testament and Psalms twice in a year.';

	/// en: 'Read the whole Bible in a year, arranged in the order the events actually happened.'
	String get chronologicalDescription => 'Read the whole Bible in a year, arranged in the order the events actually happened.';

	/// en: 'Read straight through the whole Bible in a year, from Genesis to Revelation.'
	String get throughTheBibleDescription => 'Read straight through the whole Bible in a year, from Genesis to Revelation.';

	/// en: 'Spend the year in the New Testament, journeying through the Gospels and the letters of the apostles.'
	String get gospelsAndEpistlesDescription => 'Spend the year in the New Testament, journeying through the Gospels and the letters of the apostles.';

	/// en: 'Four readings a day from the Old Testament, New Testament, Psalms, and Proverbs, covering the whole Bible in a year, with Psalms & Proverbs twice.'
	String get everyDayInTheWordDescription => 'Four readings a day from the Old Testament, New Testament, Psalms, and Proverbs, covering the whole Bible in a year, with Psalms & Proverbs twice.';

	/// en: 'Experience the Bible over a year grouped by its literary styles, moving through story, poetry, and letters.'
	String get literaryStudyDescription => 'Experience the Bible over a year grouped by its literary styles, moving through story, poetry, and letters.';

	/// en: 'A year that pairs the history in Chronicles with the messages of the Prophets.'
	String get chroniclesAndProphetsDescription => 'A year that pairs the history in Chronicles with the messages of the Prophets.';

	/// en: 'Journey through the five books of Moses and the history of Israel over a year.'
	String get pentateuchAndHistoryDescription => 'Journey through the five books of Moses and the history of Israel over a year.';

	/// en: 'Spend the year in the Psalms and wisdom books like Proverbs, Job, and Ecclesiastes.'
	String get psalmsAndWisdomDescription => 'Spend the year in the Psalms and wisdom books like Proverbs, Job, and Ecclesiastes.';

	/// en: 'Read through both the Old and New Testaments together, with a passage from each every day.'
	String get oldAndNewTestamentDescription => 'Read through both the Old and New Testaments together, with a passage from each every day.';

	/// en: 'Rotate through a different section of Scripture each day, exploring every book of the Bible over a year.'
	String get differentTopicsDescription => 'Rotate through a different section of Scripture each day, exploring every book of the Bible over a year.';

	/// en: 'Read the New Testament alongside Psalms and Proverbs over the course of a year.'
	String get newTestamentPsalmsProverbsDescription => 'Read the New Testament alongside Psalms and Proverbs over the course of a year.';

	/// en: 'Read one New Testament chapter a day, five days a week, followed by two days to review and reflect.'
	String get fiveByFiveByFiveDescription => 'Read one New Testament chapter a day, five days a week, followed by two days to review and reflect.';

	/// en: 'Reads from books in the Old Testament.'
	String get oldScopeDescription => 'Reads from books in the Old Testament.';

	/// en: 'Reads from books in the New Testament.'
	String get newScopeDescription => 'Reads from books in the New Testament.';

	/// en: 'Reads from both the Old and New Testaments.'
	String get wholeScopeDescription => 'Reads from both the Old and New Testaments.';

	/// en: 'Focused'
	String get focused => 'Focused';

	/// en: 'Comprehensive'
	String get comprehensive => 'Comprehensive';

	/// en: 'Covers a specific section or collection within its scope.'
	String get focusedDescription => 'Covers a specific section or collection within its scope.';

	/// en: 'Covers every book within its scope.'
	String get comprehensiveDescription => 'Covers every book within its scope.';
}

// Path: onboardingSteps
class Translations$onboardingSteps$en {
	Translations$onboardingSteps$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'View cross references'
	String get viewCrossReferences => 'View cross references';

	/// en: 'Annotate a verse'
	String get annotateVerse => 'Annotate a verse';

	/// en: 'Search for a word'
	String get searchWord => 'Search for a word';

	/// en: 'Switch your Bible'
	String get switchBible => 'Switch your Bible';

	/// en: 'Go to another chapter'
	String get navigateChapter => 'Go to another chapter';

	/// en: 'Go back'
	String get goBack => 'Go back';

	/// en: 'Swipe to change chapter'
	String get swipeChapter => 'Swipe to change chapter';

	/// en: 'Add a study panel'
	String get addStudyPanel => 'Add a study panel';

	/// en: 'Customize your toolbars'
	String get customizeToolbar => 'Customize your toolbars';

	/// en: 'Start a Bible plan'
	String get startBiblePlan => 'Start a Bible plan';

	/// en: 'Tap a verse to select it'
	String get selectVerse => 'Tap a verse to select it';

	/// en: 'Long-press a word'
	String get selectWord => 'Long-press a word';

	/// en: 'Tap '
	String get deselectPrefix => 'Tap ';

	/// en: ' next to your selection to deselect'
	String get deselectSuffix => ' next to your selection to deselect';

	/// en: 'Scroll up to reveal the main toolbar'
	String get revealToolbar => 'Scroll up to reveal the main toolbar';

	/// en: 'Tap '
	String get addPanelPrefix => 'Tap ';

	/// en: ' → Study → Add Study Panel and add any study panel'
	String get addPanelSuffix => ' → Study → Add Study Panel and add any study panel';

	/// en: 'Go to another chapter'
	String get goToChapter => 'Go to another chapter';

	/// en: 'Open '
	String get openPrefix => 'Open ';

	/// en: ' → Study → Cross References'
	String get crossReferencesSuffix => ' → Study → Cross References';

	/// en: 'Tap '
	String get annotatePrefix => 'Tap ';

	/// en: ' to highlight or add a note'
	String get annotateSuffix => ' to highlight or add a note';

	/// en: 'Tap '
	String get searchPrefix => 'Tap ';

	/// en: ' to look the word up everywhere'
	String get searchSuffix => ' to look the word up everywhere';

	/// en: 'Tap the main toolbar → {translation} to switch Bibles'
	String switchBibleDescription({required Object translation}) => 'Tap the main toolbar → ${translation} to switch Bibles';

	/// en: 'Tap the main toolbar to go to another chapter'
	String get goToChapterDescription => 'Tap the main toolbar to go to another chapter';

	/// en: 'Swipe right on the toolbar to go back'
	String get goBackDescription => 'Swipe right on the toolbar to go back';

	/// en: 'Swipe the Bible left or right to change chapter'
	String get swipeChapterDescription => 'Swipe the Bible left or right to change chapter';

	/// en: 'Swipe this panel right to view your study panel'
	String get viewPanelDescription => 'Swipe this panel right to view your study panel';

	/// en: ' → More → '
	String get moreSeparator => ' → More → ';

	/// en: 'Toolbars and pick a toolbar preset or change any of your toolbar shortcuts'
	String get customizeToolbarSuffix => 'Toolbars and pick a toolbar preset or change any of your toolbar shortcuts';

	/// en: ' → Bible Plans and start any Bible plan'
	String get startPlanSuffix => ' → Bible Plans and start any Bible plan';
}

// Path: dictionary
class Translations$dictionary$en {
	Translations$dictionary$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Easton's Bible Dictionary'
	String get eastons => 'Easton\'s Bible Dictionary';
}

// Path: navigation
class Translations$navigation$en {
	Translations$navigation$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Recents'
	String get recents => 'Recents';

	/// en: 'Navigate'
	String get navigate => 'Navigate';

	/// en: 'Book'
	String get book => 'Book';

	/// en: 'Chapter'
	String get chapter => 'Chapter';

	/// en: 'Verse'
	String get verse => 'Verse';
}

// Path: bibleSheet
class Translations$bibleSheet$en {
	Translations$bibleSheet$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All Bibles'
	String get allBibles => 'All Bibles';

	/// en: '(one) {{count} Bible Available} (other) {{count} Bibles Available}'
	String availableCount({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count,
		one: '${count} Bible Available',
		other: '${count} Bibles Available',
	);
}

// Path: selectionUi
class Translations$selectionUi$en {
	Translations$selectionUi$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Selected: '
	String get selected => 'Selected: ';

	/// en: 'Sourced from [https://api.bible](https://api.bible)'
	String get sourceApiBible => 'Sourced from [https://api.bible](https://api.bible)';
}

// Path: errors
class Translations$errors$en {
	Translations$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Device verification failed'
	String get deviceVerificationFailed => 'Device verification failed';

	/// en: 'Access to this online Bible requires a valid device and legitimate installation of Lux. Make sure you installed Lux from an official app store, then try again.'
	String get deviceVerificationDescription => 'Access to this online Bible requires a valid device and legitimate installation of Lux. Make sure you installed Lux from an official app store, then try again.';

	/// en: 'Something went wrong'
	String get generic => 'Something went wrong';

	/// en: 'Check your internet connection or try again later.'
	String get connection => 'Check your internet connection or try again later.';
}

// Path: morphology
class Translations$morphology$en {
	Translations$morphology$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$morphology$attributes$en attributes = Translations$morphology$attributes$en.internal(_root);
	late final Translations$morphology$types$en types = Translations$morphology$types$en.internal(_root);
	late final Translations$morphology$person$en person = Translations$morphology$person$en.internal(_root);
	late final Translations$morphology$gender$en gender = Translations$morphology$gender$en.internal(_root);
	late final Translations$morphology$number$en number = Translations$morphology$number$en.internal(_root);
	late final Translations$morphology$kCase$en kCase = Translations$morphology$kCase$en.internal(_root);
	late final Translations$morphology$state$en state = Translations$morphology$state$en.internal(_root);
	late final Translations$morphology$stem$en stem = Translations$morphology$stem$en.internal(_root);
	late final Translations$morphology$aspect$en aspect = Translations$morphology$aspect$en.internal(_root);
	late final Translations$morphology$hebrewMood$en hebrewMood = Translations$morphology$hebrewMood$en.internal(_root);
	late final Translations$morphology$tense$en tense = Translations$morphology$tense$en.internal(_root);
	late final Translations$morphology$mood$en mood = Translations$morphology$mood$en.internal(_root);
	late final Translations$morphology$voice$en voice = Translations$morphology$voice$en.internal(_root);
	late final Translations$morphology$degree$en degree = Translations$morphology$degree$en.internal(_root);
	late final Translations$morphology$literals$en literals = Translations$morphology$literals$en.internal(_root);
}

// Path: settings
class Translations$settings$en {
	Translations$settings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	/// en: 'Customize'
	String get customize => 'Customize';

	/// en: 'Push Notifications'
	String get pushNotifications => 'Push Notifications';

	/// en: 'Bible Plan Reminders'
	String get biblePlanReminders => 'Bible Plan Reminders';

	/// en: 'Turn on notifications'
	String get notificationsNotRequested => 'Turn on notifications';

	/// en: 'Allow Lux to send notifications to manage your reminders.'
	String get notificationsNotRequestedDescription => 'Allow Lux to send notifications to manage your reminders.';

	/// en: 'Notifications are disabled'
	String get notificationsDisabled => 'Notifications are disabled';

	/// en: 'Bible Plan Reminders are turned off.'
	String get biblePlanRemindersDisabled => 'Bible Plan Reminders are turned off.';

	/// en: 'Verse of the Day reminders are turned off.'
	String get verseOfTheDayRemindersDisabled => 'Verse of the Day reminders are turned off.';

	/// en: 'Enable them in your device settings to manage your reminders.'
	String get notificationsDisabledDescription => 'Enable them in your device settings to manage your reminders.';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'System'
	String get system => 'System';

	/// en: 'Match your system's locale.'
	String get systemLanguageDescription => 'Match your system\'s locale.';

	/// en: 'Toolbar Presets'
	String get toolbarPresets => 'Toolbar Presets';

	/// en: 'Toolbar Preset'
	String get toolbarPreset => 'Toolbar Preset';

	/// en: 'Selecting a preset will override the shortcuts in all your toolbars.'
	String get presetWarning => 'Selecting a preset will override the shortcuts in all your toolbars.';

	/// en: 'Your Content'
	String get yourContent => 'Your Content';

	/// en: 'Discussion and announcements'
	String get discussionAndAnnouncements => 'Discussion and announcements';

	/// en: 'Tips and updates'
	String get tipsAndUpdates => 'Tips and updates';

	/// en: 'Support Lux'
	String get supportLux => 'Support Lux';

	/// en: 'Rate Lux'
	String get rateLux => 'Rate Lux';

	/// en: 'Leave a review on the App Store.'
	String get leaveReview => 'Leave a review on the App Store.';

	/// en: 'Lux is a passion project built on the conviction that Scripture should be freely available to all. The best way to support Lux is by leaving a review on the App Store. If there is anything keeping you from leaving a 5-star review, please join our Discord and share your feedback so we can address it quickly.'
	String get supportMessage => 'Lux is a passion project built on the conviction that Scripture should be freely available to all. The best way to support Lux is by leaving a review on the App Store.\n\nIf there is anything keeping you from leaving a 5-star review, please join our Discord and share your feedback so we can address it quickly.';

	/// en: 'Leave a Rating'
	String get leaveRating => 'Leave a Rating';

	/// en: 'Join Discord'
	String get joinDiscord => 'Join Discord';

	/// en: 'Restart Get Started'
	String get restartGetStarted => 'Restart Get Started';

	/// en: 'Show the Get Started checklist again.'
	String get restartGetStartedDescription => 'Show the Get Started checklist again.';

	/// en: 'Reset Tutorials'
	String get resetTutorials => 'Reset Tutorials';

	/// en: 'Show helpful hints throughout the app again.'
	String get resetTutorialsDescription => 'Show helpful hints throughout the app again.';

	/// en: 'Tutorials have been reset.'
	String get tutorialsReset => 'Tutorials have been reset.';
}

// Path: searchUi.wordMatching
class Translations$searchUi$wordMatching$en {
	Translations$searchUi$wordMatching$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Word Matching'
	String get title => 'Word Matching';

	late final Translations$searchUi$wordMatching$wholeWord$en wholeWord = Translations$searchUi$wordMatching$wholeWord$en.internal(_root);
	late final Translations$searchUi$wordMatching$startOfWord$en startOfWord = Translations$searchUi$wordMatching$startOfWord$en.internal(_root);
	late final Translations$searchUi$wordMatching$partOfWord$en partOfWord = Translations$searchUi$wordMatching$partOfWord$en.internal(_root);
}

// Path: morphology.attributes
class Translations$morphology$attributes$en {
	Translations$morphology$attributes$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$morphology$attributes$type$en type = Translations$morphology$attributes$type$en.internal(_root);
	late final Translations$morphology$attributes$grammaticalCase$en grammaticalCase = Translations$morphology$attributes$grammaticalCase$en.internal(_root);
	late final Translations$morphology$attributes$gender$en gender = Translations$morphology$attributes$gender$en.internal(_root);
	late final Translations$morphology$attributes$number$en number = Translations$morphology$attributes$number$en.internal(_root);
	late final Translations$morphology$attributes$person$en person = Translations$morphology$attributes$person$en.internal(_root);
	late final Translations$morphology$attributes$state$en state = Translations$morphology$attributes$state$en.internal(_root);
	late final Translations$morphology$attributes$tense$en tense = Translations$morphology$attributes$tense$en.internal(_root);
	late final Translations$morphology$attributes$mood$en mood = Translations$morphology$attributes$mood$en.internal(_root);
	late final Translations$morphology$attributes$voice$en voice = Translations$morphology$attributes$voice$en.internal(_root);
	late final Translations$morphology$attributes$degree$en degree = Translations$morphology$attributes$degree$en.internal(_root);
	late final Translations$morphology$attributes$stem$en stem = Translations$morphology$attributes$stem$en.internal(_root);
	late final Translations$morphology$attributes$aspect$en aspect = Translations$morphology$attributes$aspect$en.internal(_root);
	late final Translations$morphology$attributes$prefix$en prefix = Translations$morphology$attributes$prefix$en.internal(_root);
	late final Translations$morphology$attributes$particle$en particle = Translations$morphology$attributes$particle$en.internal(_root);
	late final Translations$morphology$attributes$code$en code = Translations$morphology$attributes$code$en.internal(_root);
}

// Path: morphology.types
class Translations$morphology$types$en {
	Translations$morphology$types$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$morphology$types$article$en article = Translations$morphology$types$article$en.internal(_root);
	late final Translations$morphology$types$conjunction$en conjunction = Translations$morphology$types$conjunction$en.internal(_root);
	late final Translations$morphology$types$preposition$en preposition = Translations$morphology$types$preposition$en.internal(_root);
	late final Translations$morphology$types$adverb$en adverb = Translations$morphology$types$adverb$en.internal(_root);
	late final Translations$morphology$types$negativeAdverb$en negativeAdverb = Translations$morphology$types$negativeAdverb$en.internal(_root);
	late final Translations$morphology$types$adjective$en adjective = Translations$morphology$types$adjective$en.internal(_root);
	late final Translations$morphology$types$noun$en noun = Translations$morphology$types$noun$en.internal(_root);
	late final Translations$morphology$types$properNoun$en properNoun = Translations$morphology$types$properNoun$en.internal(_root);
	late final Translations$morphology$types$number$en number = Translations$morphology$types$number$en.internal(_root);
	late final Translations$morphology$types$ordinalNumber$en ordinalNumber = Translations$morphology$types$ordinalNumber$en.internal(_root);
	late final Translations$morphology$types$pronoun$en pronoun = Translations$morphology$types$pronoun$en.internal(_root);
	late final Translations$morphology$types$personalPronoun$en personalPronoun = Translations$morphology$types$personalPronoun$en.internal(_root);
	late final Translations$morphology$types$demonstrativePronoun$en demonstrativePronoun = Translations$morphology$types$demonstrativePronoun$en.internal(_root);
	late final Translations$morphology$types$interrogativePronoun$en interrogativePronoun = Translations$morphology$types$interrogativePronoun$en.internal(_root);
	late final Translations$morphology$types$indefinitePronoun$en indefinitePronoun = Translations$morphology$types$indefinitePronoun$en.internal(_root);
	late final Translations$morphology$types$reciprocalPronoun$en reciprocalPronoun = Translations$morphology$types$reciprocalPronoun$en.internal(_root);
	late final Translations$morphology$types$reflexivePronoun$en reflexivePronoun = Translations$morphology$types$reflexivePronoun$en.internal(_root);
	late final Translations$morphology$types$relativePronoun$en relativePronoun = Translations$morphology$types$relativePronoun$en.internal(_root);
	late final Translations$morphology$types$particle$en particle = Translations$morphology$types$particle$en.internal(_root);
	late final Translations$morphology$types$negativeParticle$en negativeParticle = Translations$morphology$types$negativeParticle$en.internal(_root);
	late final Translations$morphology$types$interrogativeParticle$en interrogativeParticle = Translations$morphology$types$interrogativeParticle$en.internal(_root);
	late final Translations$morphology$types$demonstrativeParticle$en demonstrativeParticle = Translations$morphology$types$demonstrativeParticle$en.internal(_root);
	late final Translations$morphology$types$genericParticle$en genericParticle = Translations$morphology$types$genericParticle$en.internal(_root);
	late final Translations$morphology$types$relativeParticle$en relativeParticle = Translations$morphology$types$relativeParticle$en.internal(_root);
	late final Translations$morphology$types$verb$en verb = Translations$morphology$types$verb$en.internal(_root);
	late final Translations$morphology$types$pronominalSuffix$en pronominalSuffix = Translations$morphology$types$pronominalSuffix$en.internal(_root);
	late final Translations$morphology$types$directObjectMarker$en directObjectMarker = Translations$morphology$types$directObjectMarker$en.internal(_root);
	late final Translations$morphology$types$punctuation$en punctuation = Translations$morphology$types$punctuation$en.internal(_root);
	late final Translations$morphology$types$interjection$en interjection = Translations$morphology$types$interjection$en.internal(_root);
	late final Translations$morphology$types$indeclinable$en indeclinable = Translations$morphology$types$indeclinable$en.internal(_root);
	late final Translations$morphology$types$hebraism$en hebraism = Translations$morphology$types$hebraism$en.internal(_root);
	late final Translations$morphology$types$unknown$en unknown = Translations$morphology$types$unknown$en.internal(_root);
}

// Path: morphology.person
class Translations$morphology$person$en {
	Translations$morphology$person$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$morphology$person$first$en first = Translations$morphology$person$first$en.internal(_root);
	late final Translations$morphology$person$second$en second = Translations$morphology$person$second$en.internal(_root);
	late final Translations$morphology$person$third$en third = Translations$morphology$person$third$en.internal(_root);
}

// Path: morphology.gender
class Translations$morphology$gender$en {
	Translations$morphology$gender$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$morphology$gender$masculine$en masculine = Translations$morphology$gender$masculine$en.internal(_root);
	late final Translations$morphology$gender$feminine$en feminine = Translations$morphology$gender$feminine$en.internal(_root);
	late final Translations$morphology$gender$neuter$en neuter = Translations$morphology$gender$neuter$en.internal(_root);
	late final Translations$morphology$gender$common$en common = Translations$morphology$gender$common$en.internal(_root);
}

// Path: morphology.number
class Translations$morphology$number$en {
	Translations$morphology$number$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$morphology$number$singular$en singular = Translations$morphology$number$singular$en.internal(_root);
	late final Translations$morphology$number$plural$en plural = Translations$morphology$number$plural$en.internal(_root);
	late final Translations$morphology$number$dual$en dual = Translations$morphology$number$dual$en.internal(_root);
}

// Path: morphology.kCase
class Translations$morphology$kCase$en {
	Translations$morphology$kCase$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$morphology$kCase$nominative$en nominative = Translations$morphology$kCase$nominative$en.internal(_root);
	late final Translations$morphology$kCase$genitive$en genitive = Translations$morphology$kCase$genitive$en.internal(_root);
	late final Translations$morphology$kCase$dative$en dative = Translations$morphology$kCase$dative$en.internal(_root);
	late final Translations$morphology$kCase$accusative$en accusative = Translations$morphology$kCase$accusative$en.internal(_root);
	late final Translations$morphology$kCase$vocative$en vocative = Translations$morphology$kCase$vocative$en.internal(_root);
}

// Path: morphology.state
class Translations$morphology$state$en {
	Translations$morphology$state$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$morphology$state$absolute$en absolute = Translations$morphology$state$absolute$en.internal(_root);
	late final Translations$morphology$state$construct$en construct = Translations$morphology$state$construct$en.internal(_root);
	late final Translations$morphology$state$determined$en determined = Translations$morphology$state$determined$en.internal(_root);
}

// Path: morphology.stem
class Translations$morphology$stem$en {
	Translations$morphology$stem$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$morphology$stem$qal$en qal = Translations$morphology$stem$qal$en.internal(_root);
	late final Translations$morphology$stem$qalPassive$en qalPassive = Translations$morphology$stem$qalPassive$en.internal(_root);
	late final Translations$morphology$stem$niphal$en niphal = Translations$morphology$stem$niphal$en.internal(_root);
	late final Translations$morphology$stem$piel$en piel = Translations$morphology$stem$piel$en.internal(_root);
	late final Translations$morphology$stem$pual$en pual = Translations$morphology$stem$pual$en.internal(_root);
	late final Translations$morphology$stem$hiphil$en hiphil = Translations$morphology$stem$hiphil$en.internal(_root);
	late final Translations$morphology$stem$hophal$en hophal = Translations$morphology$stem$hophal$en.internal(_root);
	late final Translations$morphology$stem$hithpael$en hithpael = Translations$morphology$stem$hithpael$en.internal(_root);
	late final Translations$morphology$stem$nithpael$en nithpael = Translations$morphology$stem$nithpael$en.internal(_root);
}

// Path: morphology.aspect
class Translations$morphology$aspect$en {
	Translations$morphology$aspect$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$morphology$aspect$perfect$en perfect = Translations$morphology$aspect$perfect$en.internal(_root);
	late final Translations$morphology$aspect$imperfect$en imperfect = Translations$morphology$aspect$imperfect$en.internal(_root);
	late final Translations$morphology$aspect$imperative$en imperative = Translations$morphology$aspect$imperative$en.internal(_root);
	late final Translations$morphology$aspect$infinitiveConstruct$en infinitiveConstruct = Translations$morphology$aspect$infinitiveConstruct$en.internal(_root);
	late final Translations$morphology$aspect$infinitiveAbsolute$en infinitiveAbsolute = Translations$morphology$aspect$infinitiveAbsolute$en.internal(_root);
	late final Translations$morphology$aspect$participle$en participle = Translations$morphology$aspect$participle$en.internal(_root);
	late final Translations$morphology$aspect$consecutiveImperfect$en consecutiveImperfect = Translations$morphology$aspect$consecutiveImperfect$en.internal(_root);
	late final Translations$morphology$aspect$conjunctiveImperfect$en conjunctiveImperfect = Translations$morphology$aspect$conjunctiveImperfect$en.internal(_root);
	late final Translations$morphology$aspect$conjunctivePerfect$en conjunctivePerfect = Translations$morphology$aspect$conjunctivePerfect$en.internal(_root);
	late final Translations$morphology$aspect$passiveParticiple$en passiveParticiple = Translations$morphology$aspect$passiveParticiple$en.internal(_root);
}

// Path: morphology.hebrewMood
class Translations$morphology$hebrewMood$en {
	Translations$morphology$hebrewMood$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$morphology$hebrewMood$jussive$en jussive = Translations$morphology$hebrewMood$jussive$en.internal(_root);
	late final Translations$morphology$hebrewMood$cohortative$en cohortative = Translations$morphology$hebrewMood$cohortative$en.internal(_root);
	late final Translations$morphology$hebrewMood$hSuffix$en hSuffix = Translations$morphology$hebrewMood$hSuffix$en.internal(_root);
}

// Path: morphology.tense
class Translations$morphology$tense$en {
	Translations$morphology$tense$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$morphology$tense$present$en present = Translations$morphology$tense$present$en.internal(_root);
	late final Translations$morphology$tense$imperfect$en imperfect = Translations$morphology$tense$imperfect$en.internal(_root);
	late final Translations$morphology$tense$future$en future = Translations$morphology$tense$future$en.internal(_root);
	late final Translations$morphology$tense$aorist$en aorist = Translations$morphology$tense$aorist$en.internal(_root);
	late final Translations$morphology$tense$perfect$en perfect = Translations$morphology$tense$perfect$en.internal(_root);
	late final Translations$morphology$tense$pluperfect$en pluperfect = Translations$morphology$tense$pluperfect$en.internal(_root);
}

// Path: morphology.mood
class Translations$morphology$mood$en {
	Translations$morphology$mood$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$morphology$mood$indicative$en indicative = Translations$morphology$mood$indicative$en.internal(_root);
	late final Translations$morphology$mood$imperative$en imperative = Translations$morphology$mood$imperative$en.internal(_root);
	late final Translations$morphology$mood$subjunctive$en subjunctive = Translations$morphology$mood$subjunctive$en.internal(_root);
	late final Translations$morphology$mood$optative$en optative = Translations$morphology$mood$optative$en.internal(_root);
	late final Translations$morphology$mood$infinitive$en infinitive = Translations$morphology$mood$infinitive$en.internal(_root);
	late final Translations$morphology$mood$participle$en participle = Translations$morphology$mood$participle$en.internal(_root);
}

// Path: morphology.voice
class Translations$morphology$voice$en {
	Translations$morphology$voice$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$morphology$voice$active$en active = Translations$morphology$voice$active$en.internal(_root);
	late final Translations$morphology$voice$middle$en middle = Translations$morphology$voice$middle$en.internal(_root);
	late final Translations$morphology$voice$passive$en passive = Translations$morphology$voice$passive$en.internal(_root);
	late final Translations$morphology$voice$middleOrPassive$en middleOrPassive = Translations$morphology$voice$middleOrPassive$en.internal(_root);
}

// Path: morphology.degree
class Translations$morphology$degree$en {
	Translations$morphology$degree$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$morphology$degree$positive$en positive = Translations$morphology$degree$positive$en.internal(_root);
	late final Translations$morphology$degree$comparative$en comparative = Translations$morphology$degree$comparative$en.internal(_root);
	late final Translations$morphology$degree$superlative$en superlative = Translations$morphology$degree$superlative$en.internal(_root);
}

// Path: morphology.literals
class Translations$morphology$literals$en {
	Translations$morphology$literals$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'The raw morphology code as it appeared in the source.'
	String get rawCode => 'The raw morphology code as it appeared in the source.';

	/// en: 'The Hebrew waw (וְ) conjunction, meaning "and".'
	String get waw => 'The Hebrew waw (וְ) conjunction, meaning "and".';

	/// en: 'A conjunction marker.'
	String get conjunction => 'A conjunction marker.';

	/// en: 'The Hebrew bet (בְּ) prefix preposition, meaning "in", "at", or "with".'
	String get bet => 'The Hebrew bet (בְּ) prefix preposition, meaning "in", "at", or "with".';

	/// en: 'The Hebrew kaf (כְּ) prefix preposition, meaning "as" or "like".'
	String get kaf => 'The Hebrew kaf (כְּ) prefix preposition, meaning "as" or "like".';

	/// en: 'The Hebrew lamed (לְ) prefix preposition, meaning "to", "for", or "belonging to".'
	String get lamed => 'The Hebrew lamed (לְ) prefix preposition, meaning "to", "for", or "belonging to".';

	/// en: 'The Hebrew mem (מִן) prefix preposition, meaning "from" or "out of".'
	String get mem => 'The Hebrew mem (מִן) prefix preposition, meaning "from" or "out of".';

	/// en: 'A prefix preposition letter.'
	String get preposition => 'A prefix preposition letter.';

	/// en: 'and|now|but'
	String get wawExamples => 'and|now|but';

	/// en: 'in the beginning|with strength'
	String get betExamples => 'in the beginning|with strength';

	/// en: 'like a lion|as a shepherd'
	String get kafExamples => 'like a lion|as a shepherd';

	/// en: 'to David|for the king'
	String get lamedExamples => 'to David|for the king';

	/// en: 'from Egypt|out of the land'
	String get memExamples => 'from Egypt|out of the land';
}

// Path: searchUi.wordMatching.wholeWord
class Translations$searchUi$wordMatching$wholeWord$en {
	Translations$searchUi$wordMatching$wholeWord$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Whole Word'
	String get title => 'Whole Word';

	/// en: 'Find only complete words that match your search.'
	String get description => 'Find only complete words that match your search.';

	/// en: 'Example: “light” matches “light”'
	String get example => 'Example: “light” matches “light”';
}

// Path: searchUi.wordMatching.startOfWord
class Translations$searchUi$wordMatching$startOfWord$en {
	Translations$searchUi$wordMatching$startOfWord$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Start of Word'
	String get title => 'Start of Word';

	/// en: 'Find words that begin with your search.'
	String get description => 'Find words that begin with your search.';

	/// en: 'Example: “light” also matches “lightning”'
	String get example => 'Example: “light” also matches “lightning”';
}

// Path: searchUi.wordMatching.partOfWord
class Translations$searchUi$wordMatching$partOfWord$en {
	Translations$searchUi$wordMatching$partOfWord$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Part of Word'
	String get title => 'Part of Word';

	/// en: 'Find words containing your search anywhere.'
	String get description => 'Find words containing your search anywhere.';

	/// en: 'Example: “light” also matches “delight”'
	String get example => 'Example: “light” also matches “delight”';
}

// Path: morphology.attributes.type
class Translations$morphology$attributes$type$en {
	Translations$morphology$attributes$type$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Type'
	String get name => 'Type';

	/// en: 'The grammatical category of the word.'
	String get description => 'The grammatical category of the word.';
}

// Path: morphology.attributes.grammaticalCase
class Translations$morphology$attributes$grammaticalCase$en {
	Translations$morphology$attributes$grammaticalCase$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Case'
	String get name => 'Case';

	/// en: 'The syntactic role, such as subject, object, or possession.'
	String get description => 'The syntactic role, such as subject, object, or possession.';
}

// Path: morphology.attributes.gender
class Translations$morphology$attributes$gender$en {
	Translations$morphology$attributes$gender$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Gender'
	String get name => 'Gender';

	/// en: 'Grammatical gender: masculine, feminine, neuter (Greek), or common (Hebrew).'
	String get description => 'Grammatical gender: masculine, feminine, neuter (Greek), or common (Hebrew).';
}

// Path: morphology.attributes.number
class Translations$morphology$attributes$number$en {
	Translations$morphology$attributes$number$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Number'
	String get name => 'Number';

	/// en: 'Whether the word refers to one (singular), two (dual), or many (plural).'
	String get description => 'Whether the word refers to one (singular), two (dual), or many (plural).';
}

// Path: morphology.attributes.person
class Translations$morphology$attributes$person$en {
	Translations$morphology$attributes$person$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Person'
	String get name => 'Person';

	/// en: 'Who the word refers to: 1st (I/we), 2nd (you), or 3rd (he/she/it/they).'
	String get description => 'Who the word refers to: 1st (I/we), 2nd (you), or 3rd (he/she/it/they).';
}

// Path: morphology.attributes.state
class Translations$morphology$attributes$state$en {
	Translations$morphology$attributes$state$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'State'
	String get name => 'State';

	/// en: 'The state of a noun: absolute, construct, or determined.'
	String get description => 'The state of a noun: absolute, construct, or determined.';
}

// Path: morphology.attributes.tense
class Translations$morphology$attributes$tense$en {
	Translations$morphology$attributes$tense$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Tense'
	String get name => 'Tense';

	/// en: 'The verb tense, combining time and aspect.'
	String get description => 'The verb tense, combining time and aspect.';
}

// Path: morphology.attributes.mood
class Translations$morphology$attributes$mood$en {
	Translations$morphology$attributes$mood$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Mood'
	String get name => 'Mood';

	/// en: 'How the action is expressed, such as fact, command, or possibility.'
	String get description => 'How the action is expressed, such as fact, command, or possibility.';
}

// Path: morphology.attributes.voice
class Translations$morphology$attributes$voice$en {
	Translations$morphology$attributes$voice$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Voice'
	String get name => 'Voice';

	/// en: 'The voice: active, middle, or passive.'
	String get description => 'The voice: active, middle, or passive.';
}

// Path: morphology.attributes.degree
class Translations$morphology$attributes$degree$en {
	Translations$morphology$attributes$degree$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Degree'
	String get name => 'Degree';

	/// en: 'The degree of an adjective or adverb: positive, comparative, or superlative.'
	String get description => 'The degree of an adjective or adverb: positive, comparative, or superlative.';
}

// Path: morphology.attributes.stem
class Translations$morphology$attributes$stem$en {
	Translations$morphology$attributes$stem$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Stem'
	String get name => 'Stem';

	/// en: 'The verb stem (binyan), such as qal, niphal, or piel.'
	String get description => 'The verb stem (binyan), such as qal, niphal, or piel.';
}

// Path: morphology.attributes.aspect
class Translations$morphology$attributes$aspect$en {
	Translations$morphology$attributes$aspect$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Aspect'
	String get name => 'Aspect';

	/// en: 'The verb aspect, such as perfect, imperfect, or participle.'
	String get description => 'The verb aspect, such as perfect, imperfect, or participle.';
}

// Path: morphology.attributes.prefix
class Translations$morphology$attributes$prefix$en {
	Translations$morphology$attributes$prefix$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Prefix'
	String get name => 'Prefix';

	/// en: 'A Hebrew prefixed preposition letter.'
	String get description => 'A Hebrew prefixed preposition letter.';
}

// Path: morphology.attributes.particle
class Translations$morphology$attributes$particle$en {
	Translations$morphology$attributes$particle$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Particle'
	String get name => 'Particle';

	/// en: 'A small uninflected word, often a conjunction or marker.'
	String get description => 'A small uninflected word, often a conjunction or marker.';
}

// Path: morphology.attributes.code
class Translations$morphology$attributes$code$en {
	Translations$morphology$attributes$code$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Code'
	String get name => 'Code';

	/// en: 'The raw morphology code as it appears in the source text.'
	String get description => 'The raw morphology code as it appears in the source text.';
}

// Path: morphology.types.article
class Translations$morphology$types$article$en {
	Translations$morphology$types$article$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Article'
	String get name => 'Article';

	/// en: 'A definite article, "the".'
	String get description => 'A definite article, "the".';

	/// en: 'the king|the Lord'
	String get examples => 'the king|the Lord';
}

// Path: morphology.types.conjunction
class Translations$morphology$types$conjunction$en {
	Translations$morphology$types$conjunction$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Conjunction'
	String get name => 'Conjunction';

	/// en: 'A word that joins other words or clauses.'
	String get description => 'A word that joins other words or clauses.';

	/// en: 'and|but|for'
	String get examples => 'and|but|for';
}

// Path: morphology.types.preposition
class Translations$morphology$types$preposition$en {
	Translations$morphology$types$preposition$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Preposition'
	String get name => 'Preposition';

	/// en: 'Relates a noun or pronoun to other words.'
	String get description => 'Relates a noun or pronoun to other words.';

	/// en: 'in|to|with'
	String get examples => 'in|to|with';
}

// Path: morphology.types.adverb
class Translations$morphology$types$adverb$en {
	Translations$morphology$types$adverb$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Adverb'
	String get name => 'Adverb';

	/// en: 'Modifies a verb, adjective, or another adverb.'
	String get description => 'Modifies a verb, adjective, or another adverb.';

	/// en: 'quickly|now|there'
	String get examples => 'quickly|now|there';
}

// Path: morphology.types.negativeAdverb
class Translations$morphology$types$negativeAdverb$en {
	Translations$morphology$types$negativeAdverb$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Negative adverb'
	String get name => 'Negative adverb';

	/// en: 'An adverb expressing negation.'
	String get description => 'An adverb expressing negation.';

	/// en: 'not|never'
	String get examples => 'not|never';
}

// Path: morphology.types.adjective
class Translations$morphology$types$adjective$en {
	Translations$morphology$types$adjective$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Adjective'
	String get name => 'Adjective';

	/// en: 'A word that describes a noun.'
	String get description => 'A word that describes a noun.';

	/// en: 'great|holy|wise'
	String get examples => 'great|holy|wise';
}

// Path: morphology.types.noun
class Translations$morphology$types$noun$en {
	Translations$morphology$types$noun$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Noun'
	String get name => 'Noun';

	/// en: 'A person, place, thing, or idea.'
	String get description => 'A person, place, thing, or idea.';

	/// en: 'city|water|love'
	String get examples => 'city|water|love';
}

// Path: morphology.types.properNoun
class Translations$morphology$types$properNoun$en {
	Translations$morphology$types$properNoun$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Proper noun'
	String get name => 'Proper noun';

	/// en: 'A specific name of a person, place, or thing.'
	String get description => 'A specific name of a person, place, or thing.';

	/// en: 'David|Jerusalem|Israel'
	String get examples => 'David|Jerusalem|Israel';
}

// Path: morphology.types.number
class Translations$morphology$types$number$en {
	Translations$morphology$types$number$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Number'
	String get name => 'Number';

	/// en: 'A cardinal number.'
	String get description => 'A cardinal number.';

	/// en: 'three|twelve|thousand'
	String get examples => 'three|twelve|thousand';
}

// Path: morphology.types.ordinalNumber
class Translations$morphology$types$ordinalNumber$en {
	Translations$morphology$types$ordinalNumber$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Ordinal number'
	String get name => 'Ordinal number';

	/// en: 'An ordinal number, such as "first" or "second".'
	String get description => 'An ordinal number, such as "first" or "second".';

	/// en: 'first|tenth|seventieth'
	String get examples => 'first|tenth|seventieth';
}

// Path: morphology.types.pronoun
class Translations$morphology$types$pronoun$en {
	Translations$morphology$types$pronoun$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Pronoun'
	String get name => 'Pronoun';

	/// en: 'A word that stands in for a noun.'
	String get description => 'A word that stands in for a noun.';

	/// en: 'he|she|they'
	String get examples => 'he|she|they';
}

// Path: morphology.types.personalPronoun
class Translations$morphology$types$personalPronoun$en {
	Translations$morphology$types$personalPronoun$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Personal pronoun'
	String get name => 'Personal pronoun';

	/// en: 'A pronoun that refers to a specific person.'
	String get description => 'A pronoun that refers to a specific person.';

	/// en: 'I|you|we'
	String get examples => 'I|you|we';
}

// Path: morphology.types.demonstrativePronoun
class Translations$morphology$types$demonstrativePronoun$en {
	Translations$morphology$types$demonstrativePronoun$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Demonstrative pronoun'
	String get name => 'Demonstrative pronoun';

	/// en: 'A pronoun that points to something.'
	String get description => 'A pronoun that points to something.';

	/// en: 'this|these|those'
	String get examples => 'this|these|those';
}

// Path: morphology.types.interrogativePronoun
class Translations$morphology$types$interrogativePronoun$en {
	Translations$morphology$types$interrogativePronoun$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Interrogative pronoun'
	String get name => 'Interrogative pronoun';

	/// en: 'A pronoun used to ask a question.'
	String get description => 'A pronoun used to ask a question.';

	/// en: 'who?|what?|which?'
	String get examples => 'who?|what?|which?';
}

// Path: morphology.types.indefinitePronoun
class Translations$morphology$types$indefinitePronoun$en {
	Translations$morphology$types$indefinitePronoun$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Indefinite pronoun'
	String get name => 'Indefinite pronoun';

	/// en: 'A pronoun referring to non-specific entities.'
	String get description => 'A pronoun referring to non-specific entities.';

	/// en: 'someone|anyone|nothing'
	String get examples => 'someone|anyone|nothing';
}

// Path: morphology.types.reciprocalPronoun
class Translations$morphology$types$reciprocalPronoun$en {
	Translations$morphology$types$reciprocalPronoun$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reciprocal pronoun'
	String get name => 'Reciprocal pronoun';

	/// en: 'A pronoun expressing mutual action.'
	String get description => 'A pronoun expressing mutual action.';

	/// en: 'one another|each other'
	String get examples => 'one another|each other';
}

// Path: morphology.types.reflexivePronoun
class Translations$morphology$types$reflexivePronoun$en {
	Translations$morphology$types$reflexivePronoun$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Reflexive pronoun'
	String get name => 'Reflexive pronoun';

	/// en: 'A pronoun referring back to the subject.'
	String get description => 'A pronoun referring back to the subject.';

	/// en: 'himself|themselves'
	String get examples => 'himself|themselves';
}

// Path: morphology.types.relativePronoun
class Translations$morphology$types$relativePronoun$en {
	Translations$morphology$types$relativePronoun$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Relative pronoun'
	String get name => 'Relative pronoun';

	/// en: 'A pronoun introducing a subordinate clause.'
	String get description => 'A pronoun introducing a subordinate clause.';

	/// en: 'who|which|that'
	String get examples => 'who|which|that';
}

// Path: morphology.types.particle
class Translations$morphology$types$particle$en {
	Translations$morphology$types$particle$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Particle'
	String get name => 'Particle';

	/// en: 'A small uninflected word.'
	String get description => 'A small uninflected word.';

	/// en: 'indeed|now'
	String get examples => 'indeed|now';
}

// Path: morphology.types.negativeParticle
class Translations$morphology$types$negativeParticle$en {
	Translations$morphology$types$negativeParticle$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Negative particle'
	String get name => 'Negative particle';

	/// en: 'A particle that marks negation.'
	String get description => 'A particle that marks negation.';

	/// en: 'not|no'
	String get examples => 'not|no';
}

// Path: morphology.types.interrogativeParticle
class Translations$morphology$types$interrogativeParticle$en {
	Translations$morphology$types$interrogativeParticle$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Interrogative particle'
	String get name => 'Interrogative particle';

	/// en: 'A particle that marks a question.'
	String get description => 'A particle that marks a question.';

	/// en: '(Hebrew prefix ה, no English equivalent)'
	String get examples => '(Hebrew prefix ה, no English equivalent)';
}

// Path: morphology.types.demonstrativeParticle
class Translations$morphology$types$demonstrativeParticle$en {
	Translations$morphology$types$demonstrativeParticle$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Demonstrative particle'
	String get name => 'Demonstrative particle';

	/// en: 'A pointing particle, such as "behold".'
	String get description => 'A pointing particle, such as "behold".';

	/// en: 'behold|lo'
	String get examples => 'behold|lo';
}

// Path: morphology.types.genericParticle
class Translations$morphology$types$genericParticle$en {
	Translations$morphology$types$genericParticle$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Generic particle'
	String get name => 'Generic particle';

	/// en: 'A general-purpose particle.'
	String get description => 'A general-purpose particle.';

	/// en: 'indeed|truly'
	String get examples => 'indeed|truly';
}

// Path: morphology.types.relativeParticle
class Translations$morphology$types$relativeParticle$en {
	Translations$morphology$types$relativeParticle$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Relative particle'
	String get name => 'Relative particle';

	/// en: 'A particle that introduces a relative clause.'
	String get description => 'A particle that introduces a relative clause.';

	/// en: 'that|which'
	String get examples => 'that|which';
}

// Path: morphology.types.verb
class Translations$morphology$types$verb$en {
	Translations$morphology$types$verb$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Verb'
	String get name => 'Verb';

	/// en: 'A word expressing an action or state.'
	String get description => 'A word expressing an action or state.';

	/// en: 'write|be|go'
	String get examples => 'write|be|go';
}

// Path: morphology.types.pronominalSuffix
class Translations$morphology$types$pronominalSuffix$en {
	Translations$morphology$types$pronominalSuffix$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Pronominal suffix'
	String get name => 'Pronominal suffix';

	/// en: 'A pronoun fused to the end of a verb or noun (Hebrew).'
	String get description => 'A pronoun fused to the end of a verb or noun (Hebrew).';

	/// en: 'his hand|their land|her voice'
	String get examples => 'his hand|their land|her voice';
}

// Path: morphology.types.directObjectMarker
class Translations$morphology$types$directObjectMarker$en {
	Translations$morphology$types$directObjectMarker$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Direct object marker'
	String get name => 'Direct object marker';

	/// en: 'The Hebrew אֵת that marks a definite direct object.'
	String get description => 'The Hebrew אֵת that marks a definite direct object.';

	/// en: 'אֵת (no English equivalent)'
	String get examples => 'אֵת (no English equivalent)';
}

// Path: morphology.types.punctuation
class Translations$morphology$types$punctuation$en {
	Translations$morphology$types$punctuation$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Punctuation'
	String get name => 'Punctuation';

	/// en: 'A punctuation mark.'
	String get description => 'A punctuation mark.';

	/// en: '.|,|;'
	String get examples => '.|,|;';
}

// Path: morphology.types.interjection
class Translations$morphology$types$interjection$en {
	Translations$morphology$types$interjection$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Interjection'
	String get name => 'Interjection';

	/// en: 'A short exclamation expressing emotion.'
	String get description => 'A short exclamation expressing emotion.';

	/// en: 'oh!|alas!'
	String get examples => 'oh!|alas!';
}

// Path: morphology.types.indeclinable
class Translations$morphology$types$indeclinable$en {
	Translations$morphology$types$indeclinable$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Indeclinable'
	String get name => 'Indeclinable';

	/// en: 'A word that does not change form by inflection.'
	String get description => 'A word that does not change form by inflection.';

	/// en: 'Hosanna|Hallelujah'
	String get examples => 'Hosanna|Hallelujah';
}

// Path: morphology.types.hebraism
class Translations$morphology$types$hebraism$en {
	Translations$morphology$types$hebraism$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hebrew loanword'
	String get name => 'Hebrew loanword';

	/// en: 'A Hebrew or Aramaic loanword carried into Greek.'
	String get description => 'A Hebrew or Aramaic loanword carried into Greek.';

	/// en: 'Amen|Hosanna|Sabaoth'
	String get examples => 'Amen|Hosanna|Sabaoth';
}

// Path: morphology.types.unknown
class Translations$morphology$types$unknown$en {
	Translations$morphology$types$unknown$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Unknown'
	String get name => 'Unknown';

	/// en: 'A morphology code that the parser did not recognize.'
	String get description => 'A morphology code that the parser did not recognize.';

	/// en: ''
	String get examples => '';
}

// Path: morphology.person.first
class Translations$morphology$person$first$en {
	Translations$morphology$person$first$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '1st person'
	String get name => '1st person';

	/// en: 'The speaker, "I" or "we".'
	String get description => 'The speaker, "I" or "we".';

	/// en: 'I am|we walk|I have spoken'
	String get examples => 'I am|we walk|I have spoken';
}

// Path: morphology.person.second
class Translations$morphology$person$second$en {
	Translations$morphology$person$second$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '2nd person'
	String get name => '2nd person';

	/// en: 'The addressee, "you" (singular or plural).'
	String get description => 'The addressee, "you" (singular or plural).';

	/// en: 'you go|you (pl.) listen|you have seen'
	String get examples => 'you go|you (pl.) listen|you have seen';
}

// Path: morphology.person.third
class Translations$morphology$person$third$en {
	Translations$morphology$person$third$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '3rd person'
	String get name => '3rd person';

	/// en: 'The party being spoken about.'
	String get description => 'The party being spoken about.';

	/// en: 'he runs|she speaks|they gathered'
	String get examples => 'he runs|she speaks|they gathered';
}

// Path: morphology.gender.masculine
class Translations$morphology$gender$masculine$en {
	Translations$morphology$gender$masculine$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Masculine'
	String get name => 'Masculine';

	/// en: 'Masculine grammatical gender, used for male persons and many nouns by convention.'
	String get description => 'Masculine grammatical gender, used for male persons and many nouns by convention.';

	/// en: 'father|son|king'
	String get examples => 'father|son|king';
}

// Path: morphology.gender.feminine
class Translations$morphology$gender$feminine$en {
	Translations$morphology$gender$feminine$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Feminine'
	String get name => 'Feminine';

	/// en: 'Feminine grammatical gender, used for female persons and many nouns by convention.'
	String get description => 'Feminine grammatical gender, used for female persons and many nouns by convention.';

	/// en: 'mother|daughter|queen'
	String get examples => 'mother|daughter|queen';
}

// Path: morphology.gender.neuter
class Translations$morphology$gender$neuter$en {
	Translations$morphology$gender$neuter$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Neuter'
	String get name => 'Neuter';

	/// en: 'Greek neuter gender, neither masculine nor feminine.'
	String get description => 'Greek neuter gender, neither masculine nor feminine.';

	/// en: 'child (τέκνον)|gift (δῶρον)'
	String get examples => 'child (τέκνον)|gift (δῶρον)';
}

// Path: morphology.gender.common
class Translations$morphology$gender$common$en {
	Translations$morphology$gender$common$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Common'
	String get name => 'Common';

	/// en: 'Hebrew common gender, where the form serves both masculine and feminine.'
	String get description => 'Hebrew common gender, where the form serves both masculine and feminine.';

	/// en: 'cattle|voice'
	String get examples => 'cattle|voice';
}

// Path: morphology.number.singular
class Translations$morphology$number$singular$en {
	Translations$morphology$number$singular$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Singular'
	String get name => 'Singular';

	/// en: 'Refers to one.'
	String get description => 'Refers to one.';

	/// en: 'the book|a man|one stone'
	String get examples => 'the book|a man|one stone';
}

// Path: morphology.number.plural
class Translations$morphology$number$plural$en {
	Translations$morphology$number$plural$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Plural'
	String get name => 'Plural';

	/// en: 'Refers to two or more.'
	String get description => 'Refers to two or more.';

	/// en: 'the books|men|stones'
	String get examples => 'the books|men|stones';
}

// Path: morphology.number.dual
class Translations$morphology$number$dual$en {
	Translations$morphology$number$dual$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Dual'
	String get name => 'Dual';

	/// en: 'Refers to a natural pair (Hebrew only).'
	String get description => 'Refers to a natural pair (Hebrew only).';

	/// en: 'hands|eyes|two days'
	String get examples => 'hands|eyes|two days';
}

// Path: morphology.kCase.nominative
class Translations$morphology$kCase$nominative$en {
	Translations$morphology$kCase$nominative$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Nominative'
	String get name => 'Nominative';

	/// en: 'Marks the subject of a sentence.'
	String get description => 'Marks the subject of a sentence.';

	/// en: 'God created|the king sees'
	String get examples => 'God created|the king sees';
}

// Path: morphology.kCase.genitive
class Translations$morphology$kCase$genitive$en {
	Translations$morphology$kCase$genitive$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Genitive'
	String get name => 'Genitive';

	/// en: 'Indicates possession or origin, often translated "of".'
	String get description => 'Indicates possession or origin, often translated "of".';

	/// en: 'the Son of God|kingdom of heaven'
	String get examples => 'the Son of God|kingdom of heaven';
}

// Path: morphology.kCase.dative
class Translations$morphology$kCase$dative$en {
	Translations$morphology$kCase$dative$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Dative'
	String get name => 'Dative';

	/// en: 'Marks the indirect object, often "to" or "for".'
	String get description => 'Marks the indirect object, often "to" or "for".';

	/// en: 'gave to him|spoke to them'
	String get examples => 'gave to him|spoke to them';
}

// Path: morphology.kCase.accusative
class Translations$morphology$kCase$accusative$en {
	Translations$morphology$kCase$accusative$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Accusative'
	String get name => 'Accusative';

	/// en: 'Marks the direct object.'
	String get description => 'Marks the direct object.';

	/// en: 'saw him|love your neighbor'
	String get examples => 'saw him|love your neighbor';
}

// Path: morphology.kCase.vocative
class Translations$morphology$kCase$vocative$en {
	Translations$morphology$kCase$vocative$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Vocative'
	String get name => 'Vocative';

	/// en: 'Used in direct address.'
	String get description => 'Used in direct address.';

	/// en: 'Lord!|Father!|Friend!'
	String get examples => 'Lord!|Father!|Friend!';
}

// Path: morphology.state.absolute
class Translations$morphology$state$absolute$en {
	Translations$morphology$state$absolute$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Absolute'
	String get name => 'Absolute';

	/// en: 'The default, independent form of a noun.'
	String get description => 'The default, independent form of a noun.';

	/// en: 'a king|a word'
	String get examples => 'a king|a word';
}

// Path: morphology.state.construct
class Translations$morphology$state$construct$en {
	Translations$morphology$state$construct$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Construct'
	String get name => 'Construct';

	/// en: 'Bound to a following noun, expressing "X of Y".'
	String get description => 'Bound to a following noun, expressing "X of Y".';

	/// en: 'king of Israel|word of the LORD'
	String get examples => 'king of Israel|word of the LORD';
}

// Path: morphology.state.determined
class Translations$morphology$state$determined$en {
	Translations$morphology$state$determined$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Determined'
	String get name => 'Determined';

	/// en: 'Marked as definite, often by the article.'
	String get description => 'Marked as definite, often by the article.';

	/// en: 'the king|the word'
	String get examples => 'the king|the word';
}

// Path: morphology.stem.qal
class Translations$morphology$stem$qal$en {
	Translations$morphology$stem$qal$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Qal'
	String get name => 'Qal';

	/// en: 'The simple active stem, the basic action of the verb.'
	String get description => 'The simple active stem, the basic action of the verb.';

	/// en: 'he wrote|she heard'
	String get examples => 'he wrote|she heard';
}

// Path: morphology.stem.qalPassive
class Translations$morphology$stem$qalPassive$en {
	Translations$morphology$stem$qalPassive$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Qal passive'
	String get name => 'Qal passive';

	/// en: 'A rare passive of the simple stem.'
	String get description => 'A rare passive of the simple stem.';

	/// en: 'it was taken'
	String get examples => 'it was taken';
}

// Path: morphology.stem.niphal
class Translations$morphology$stem$niphal$en {
	Translations$morphology$stem$niphal$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Niphal'
	String get name => 'Niphal';

	/// en: 'The simple passive or reflexive stem.'
	String get description => 'The simple passive or reflexive stem.';

	/// en: 'he was killed|they gathered themselves'
	String get examples => 'he was killed|they gathered themselves';
}

// Path: morphology.stem.piel
class Translations$morphology$stem$piel$en {
	Translations$morphology$stem$piel$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Piel'
	String get name => 'Piel';

	/// en: 'The intensive or factitive active stem.'
	String get description => 'The intensive or factitive active stem.';

	/// en: 'he praised|he blessed|he shattered'
	String get examples => 'he praised|he blessed|he shattered';
}

// Path: morphology.stem.pual
class Translations$morphology$stem$pual$en {
	Translations$morphology$stem$pual$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Pual'
	String get name => 'Pual';

	/// en: 'The passive of the piel.'
	String get description => 'The passive of the piel.';

	/// en: 'he was praised'
	String get examples => 'he was praised';
}

// Path: morphology.stem.hiphil
class Translations$morphology$stem$hiphil$en {
	Translations$morphology$stem$hiphil$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hiphil'
	String get name => 'Hiphil';

	/// en: 'The causative active stem.'
	String get description => 'The causative active stem.';

	/// en: 'he caused to write|he led out'
	String get examples => 'he caused to write|he led out';
}

// Path: morphology.stem.hophal
class Translations$morphology$stem$hophal$en {
	Translations$morphology$stem$hophal$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hophal'
	String get name => 'Hophal';

	/// en: 'The passive of the hiphil.'
	String get description => 'The passive of the hiphil.';

	/// en: 'he was caused to write'
	String get examples => 'he was caused to write';
}

// Path: morphology.stem.hithpael
class Translations$morphology$stem$hithpael$en {
	Translations$morphology$stem$hithpael$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hithpael'
	String get name => 'Hithpael';

	/// en: 'The reflexive or reciprocal of the piel.'
	String get description => 'The reflexive or reciprocal of the piel.';

	/// en: 'he sanctified himself|they walked about'
	String get examples => 'he sanctified himself|they walked about';
}

// Path: morphology.stem.nithpael
class Translations$morphology$stem$nithpael$en {
	Translations$morphology$stem$nithpael$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Nithpael'
	String get name => 'Nithpael';

	/// en: 'A rare reflexive-passive stem.'
	String get description => 'A rare reflexive-passive stem.';

	/// en: 'it was atoned for'
	String get examples => 'it was atoned for';
}

// Path: morphology.aspect.perfect
class Translations$morphology$aspect$perfect$en {
	Translations$morphology$aspect$perfect$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Perfect'
	String get name => 'Perfect';

	/// en: 'Completed action, typically translated as past.'
	String get description => 'Completed action, typically translated as past.';

	/// en: 'he wrote|she has spoken'
	String get examples => 'he wrote|she has spoken';
}

// Path: morphology.aspect.imperfect
class Translations$morphology$aspect$imperfect$en {
	Translations$morphology$aspect$imperfect$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Imperfect'
	String get name => 'Imperfect';

	/// en: 'Incomplete or future action, often translated as future or habitual.'
	String get description => 'Incomplete or future action, often translated as future or habitual.';

	/// en: 'he will write|he writes'
	String get examples => 'he will write|he writes';
}

// Path: morphology.aspect.imperative
class Translations$morphology$aspect$imperative$en {
	Translations$morphology$aspect$imperative$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Imperative'
	String get name => 'Imperative';

	/// en: 'A direct command.'
	String get description => 'A direct command.';

	/// en: 'Write!|Listen!'
	String get examples => 'Write!|Listen!';
}

// Path: morphology.aspect.infinitiveConstruct
class Translations$morphology$aspect$infinitiveConstruct$en {
	Translations$morphology$aspect$infinitiveConstruct$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Infinitive construct'
	String get name => 'Infinitive construct';

	/// en: 'A verbal noun in construct form, often used with prepositions.'
	String get description => 'A verbal noun in construct form, often used with prepositions.';

	/// en: 'to write|when writing'
	String get examples => 'to write|when writing';
}

// Path: morphology.aspect.infinitiveAbsolute
class Translations$morphology$aspect$infinitiveAbsolute$en {
	Translations$morphology$aspect$infinitiveAbsolute$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Infinitive absolute'
	String get name => 'Infinitive absolute';

	/// en: 'An independent verbal noun, often emphatic.'
	String get description => 'An independent verbal noun, often emphatic.';

	/// en: 'surely die|write thoroughly'
	String get examples => 'surely die|write thoroughly';
}

// Path: morphology.aspect.participle
class Translations$morphology$aspect$participle$en {
	Translations$morphology$aspect$participle$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Participle'
	String get name => 'Participle';

	/// en: 'A verbal adjective describing ongoing action.'
	String get description => 'A verbal adjective describing ongoing action.';

	/// en: 'writing|the one who hears'
	String get examples => 'writing|the one who hears';
}

// Path: morphology.aspect.consecutiveImperfect
class Translations$morphology$aspect$consecutiveImperfect$en {
	Translations$morphology$aspect$consecutiveImperfect$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Consecutive imperfect'
	String get name => 'Consecutive imperfect';

	/// en: 'Past narrative form: waw + imperfect.'
	String get description => 'Past narrative form: waw + imperfect.';

	/// en: 'and he said|and they went'
	String get examples => 'and he said|and they went';
}

// Path: morphology.aspect.conjunctiveImperfect
class Translations$morphology$aspect$conjunctiveImperfect$en {
	Translations$morphology$aspect$conjunctiveImperfect$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Conjunctive imperfect'
	String get name => 'Conjunctive imperfect';

	/// en: 'Imperfect with conjunctive waw, with a future or modal sense.'
	String get description => 'Imperfect with conjunctive waw, with a future or modal sense.';

	/// en: 'and he will write'
	String get examples => 'and he will write';
}

// Path: morphology.aspect.conjunctivePerfect
class Translations$morphology$aspect$conjunctivePerfect$en {
	Translations$morphology$aspect$conjunctivePerfect$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Conjunctive perfect'
	String get name => 'Conjunctive perfect';

	/// en: 'Perfect with conjunctive waw, often future or sequential.'
	String get description => 'Perfect with conjunctive waw, often future or sequential.';

	/// en: 'and you shall do|and he will judge'
	String get examples => 'and you shall do|and he will judge';
}

// Path: morphology.aspect.passiveParticiple
class Translations$morphology$aspect$passiveParticiple$en {
	Translations$morphology$aspect$passiveParticiple$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Passive participle'
	String get name => 'Passive participle';

	/// en: 'The passive form of the qal participle.'
	String get description => 'The passive form of the qal participle.';

	/// en: 'written|kept'
	String get examples => 'written|kept';
}

// Path: morphology.hebrewMood.jussive
class Translations$morphology$hebrewMood$jussive$en {
	Translations$morphology$hebrewMood$jussive$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Jussive'
	String get name => 'Jussive';

	/// en: 'A 3rd-person command or wish.'
	String get description => 'A 3rd-person command or wish.';

	/// en: 'Let there be light|May the LORD bless you'
	String get examples => 'Let there be light|May the LORD bless you';
}

// Path: morphology.hebrewMood.cohortative
class Translations$morphology$hebrewMood$cohortative$en {
	Translations$morphology$hebrewMood$cohortative$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cohortative'
	String get name => 'Cohortative';

	/// en: 'A 1st-person volitional, such as "let us" or "I will".'
	String get description => 'A 1st-person volitional, such as "let us" or "I will".';

	/// en: 'Let us go|I will praise'
	String get examples => 'Let us go|I will praise';
}

// Path: morphology.hebrewMood.hSuffix
class Translations$morphology$hebrewMood$hSuffix$en {
	Translations$morphology$hebrewMood$hSuffix$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'h-suffix'
	String get name => 'h-suffix';

	/// en: 'An emphatic -ah ending on the imperfect, often cohortative-like.'
	String get description => 'An emphatic -ah ending on the imperfect, often cohortative-like.';

	/// en: 'I will surely come|let me draw near'
	String get examples => 'I will surely come|let me draw near';
}

// Path: morphology.tense.present
class Translations$morphology$tense$present$en {
	Translations$morphology$tense$present$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Present'
	String get name => 'Present';

	/// en: 'Ongoing or general action.'
	String get description => 'Ongoing or general action.';

	/// en: 'he loves|they walk'
	String get examples => 'he loves|they walk';
}

// Path: morphology.tense.imperfect
class Translations$morphology$tense$imperfect$en {
	Translations$morphology$tense$imperfect$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Imperfect'
	String get name => 'Imperfect';

	/// en: 'Continuous or repeated past action.'
	String get description => 'Continuous or repeated past action.';

	/// en: 'he was teaching|they used to gather'
	String get examples => 'he was teaching|they used to gather';
}

// Path: morphology.tense.future
class Translations$morphology$tense$future$en {
	Translations$morphology$tense$future$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Future'
	String get name => 'Future';

	/// en: 'Action that will happen.'
	String get description => 'Action that will happen.';

	/// en: 'he will come|they shall see'
	String get examples => 'he will come|they shall see';
}

// Path: morphology.tense.aorist
class Translations$morphology$tense$aorist$en {
	Translations$morphology$tense$aorist$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Aorist'
	String get name => 'Aorist';

	/// en: 'Simple past action viewed as a whole.'
	String get description => 'Simple past action viewed as a whole.';

	/// en: 'he said|they went'
	String get examples => 'he said|they went';
}

// Path: morphology.tense.perfect
class Translations$morphology$tense$perfect$en {
	Translations$morphology$tense$perfect$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Perfect'
	String get name => 'Perfect';

	/// en: 'Past action with a continuing present consequence.'
	String get description => 'Past action with a continuing present consequence.';

	/// en: 'has been written|has come'
	String get examples => 'has been written|has come';
}

// Path: morphology.tense.pluperfect
class Translations$morphology$tense$pluperfect$en {
	Translations$morphology$tense$pluperfect$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Pluperfect'
	String get name => 'Pluperfect';

	/// en: 'Past action prior to another past event.'
	String get description => 'Past action prior to another past event.';

	/// en: 'had been written|had departed'
	String get examples => 'had been written|had departed';
}

// Path: morphology.mood.indicative
class Translations$morphology$mood$indicative$en {
	Translations$morphology$mood$indicative$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Indicative'
	String get name => 'Indicative';

	/// en: 'States a fact.'
	String get description => 'States a fact.';

	/// en: 'he is|they wrote'
	String get examples => 'he is|they wrote';
}

// Path: morphology.mood.imperative
class Translations$morphology$mood$imperative$en {
	Translations$morphology$mood$imperative$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Imperative'
	String get name => 'Imperative';

	/// en: 'Issues a command.'
	String get description => 'Issues a command.';

	/// en: 'Go!|Believe!|Do not fear!'
	String get examples => 'Go!|Believe!|Do not fear!';
}

// Path: morphology.mood.subjunctive
class Translations$morphology$mood$subjunctive$en {
	Translations$morphology$mood$subjunctive$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Subjunctive'
	String get name => 'Subjunctive';

	/// en: 'Expresses possibility, purpose, or contingency.'
	String get description => 'Expresses possibility, purpose, or contingency.';

	/// en: 'that he might write|if he goes'
	String get examples => 'that he might write|if he goes';
}

// Path: morphology.mood.optative
class Translations$morphology$mood$optative$en {
	Translations$morphology$mood$optative$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Optative'
	String get name => 'Optative';

	/// en: 'Expresses a wish or remote possibility.'
	String get description => 'Expresses a wish or remote possibility.';

	/// en: 'may it be so|may you have grace'
	String get examples => 'may it be so|may you have grace';
}

// Path: morphology.mood.infinitive
class Translations$morphology$mood$infinitive$en {
	Translations$morphology$mood$infinitive$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Infinitive'
	String get name => 'Infinitive';

	/// en: 'A verbal noun, such as "to do".'
	String get description => 'A verbal noun, such as "to do".';

	/// en: 'to write|to believe'
	String get examples => 'to write|to believe';
}

// Path: morphology.mood.participle
class Translations$morphology$mood$participle$en {
	Translations$morphology$mood$participle$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Participle'
	String get name => 'Participle';

	/// en: 'A verbal adjective, such as "doing" or "having done".'
	String get description => 'A verbal adjective, such as "doing" or "having done".';

	/// en: 'the one writing|having spoken'
	String get examples => 'the one writing|having spoken';
}

// Path: morphology.voice.active
class Translations$morphology$voice$active$en {
	Translations$morphology$voice$active$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Active'
	String get name => 'Active';

	/// en: 'The subject performs the action.'
	String get description => 'The subject performs the action.';

	/// en: 'he writes|they teach'
	String get examples => 'he writes|they teach';
}

// Path: morphology.voice.middle
class Translations$morphology$voice$middle$en {
	Translations$morphology$voice$middle$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Middle'
	String get name => 'Middle';

	/// en: 'The subject acts on or for itself.'
	String get description => 'The subject acts on or for itself.';

	/// en: 'he washes himself|they obtained for themselves'
	String get examples => 'he washes himself|they obtained for themselves';
}

// Path: morphology.voice.passive
class Translations$morphology$voice$passive$en {
	Translations$morphology$voice$passive$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Passive'
	String get name => 'Passive';

	/// en: 'The subject receives the action.'
	String get description => 'The subject receives the action.';

	/// en: 'he was sent|they were taught'
	String get examples => 'he was sent|they were taught';
}

// Path: morphology.voice.middleOrPassive
class Translations$morphology$voice$middleOrPassive$en {
	Translations$morphology$voice$middleOrPassive$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Middle/Passive'
	String get name => 'Middle/Passive';

	/// en: 'The form is ambiguous between middle and passive.'
	String get description => 'The form is ambiguous between middle and passive.';

	/// en: 'was raised / raised himself|was assembled / assembled themselves'
	String get examples => 'was raised / raised himself|was assembled / assembled themselves';
}

// Path: morphology.degree.positive
class Translations$morphology$degree$positive$en {
	Translations$morphology$degree$positive$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Positive'
	String get name => 'Positive';

	/// en: 'The plain form, neither comparative nor superlative.'
	String get description => 'The plain form, neither comparative nor superlative.';

	/// en: 'great|good'
	String get examples => 'great|good';
}

// Path: morphology.degree.comparative
class Translations$morphology$degree$comparative$en {
	Translations$morphology$degree$comparative$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Comparative'
	String get name => 'Comparative';

	/// en: 'Compares two.'
	String get description => 'Compares two.';

	/// en: 'greater|better than'
	String get examples => 'greater|better than';
}

// Path: morphology.degree.superlative
class Translations$morphology$degree$superlative$en {
	Translations$morphology$degree$superlative$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Superlative'
	String get name => 'Superlative';

	/// en: 'Expresses the greatest degree.'
	String get description => 'Expresses the greatest degree.';

	/// en: 'greatest|best'
	String get examples => 'greatest|best';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'languages.english' => 'English',
			'languages.dutch' => 'Dutch',
			'languages.greek' => 'Greek',
			'languages.hebrew' => 'Hebrew',
			'languages.russian' => 'Russian',
			'languages.french' => 'French',
			'languages.spanish' => 'Spanish',
			'highlightStyles.red' => 'Red',
			'highlightStyles.orange' => 'Orange',
			'highlightStyles.yellow' => 'Yellow',
			'highlightStyles.green' => 'Green',
			'highlightStyles.blue' => 'Blue',
			'highlightStyles.violet' => 'Violet',
			'highlightStyles.underline' => 'Underline',
			'highlightStyles.important' => 'Important',
			'highlightStyles.highlight' => 'Highlight',
			'highlightStyles.squiggle' => 'Squiggle',
			'colors.red' => 'Red',
			'colors.orange' => 'Orange',
			'colors.yellow' => 'Yellow',
			'colors.green' => 'Green',
			'colors.blue' => 'Blue',
			'colors.violet' => 'Violet',
			'colors.silver' => 'Silver',
			'testaments.old' => 'Old Testament',
			'testaments.newTestament' => 'New Testament',
			'testaments.oldOnly' => 'Old Testament Only',
			'testaments.newOnly' => 'New Testament Only',
			'testaments.wholeBible' => 'Whole Bible',
			'testaments.oldOnlyDescription' => 'Only contains books in the Old Testament.',
			'testaments.newOnlyDescription' => 'Only contains books in the New Testament.',
			'testaments.wholeBibleDescription' => 'Contains all the books in the Bible.',
			'books.genesis' => 'Genesis',
			'books.exodus' => 'Exodus',
			'books.leviticus' => 'Leviticus',
			'books.numbers' => 'Numbers',
			'books.deuteronomy' => 'Deuteronomy',
			'books.joshua' => 'Joshua',
			'books.judges' => 'Judges',
			'books.ruth' => 'Ruth',
			'books.samuel1' => '1 Samuel',
			'books.samuel2' => '2 Samuel',
			'books.kings1' => '1 Kings',
			'books.kings2' => '2 Kings',
			'books.chronicles1' => '1 Chronicles',
			'books.chronicles2' => '2 Chronicles',
			'books.ezra' => 'Ezra',
			'books.nehemiah' => 'Nehemiah',
			'books.esther' => 'Esther',
			'books.job' => 'Job',
			'books.psalm' => 'Psalm',
			'books.psalms' => 'Psalms',
			'books.proverbs' => 'Proverbs',
			'books.ecclesiastes' => 'Ecclesiastes',
			'books.songOfSolomon' => 'Song of Solomon',
			'books.isaiah' => 'Isaiah',
			'books.jeremiah' => 'Jeremiah',
			'books.lamentations' => 'Lamentations',
			'books.ezekiel' => 'Ezekiel',
			'books.daniel' => 'Daniel',
			'books.hosea' => 'Hosea',
			'books.joel' => 'Joel',
			'books.amos' => 'Amos',
			'books.obadiah' => 'Obadiah',
			'books.jonah' => 'Jonah',
			'books.micah' => 'Micah',
			'books.nahum' => 'Nahum',
			'books.habakkuk' => 'Habakkuk',
			'books.zephaniah' => 'Zephaniah',
			'books.haggai' => 'Haggai',
			'books.zechariah' => 'Zechariah',
			'books.malachi' => 'Malachi',
			'books.matthew' => 'Matthew',
			'books.mark' => 'Mark',
			'books.luke' => 'Luke',
			'books.john' => 'John',
			'books.acts' => 'Acts',
			'books.romans' => 'Romans',
			'books.corinthians1' => '1 Corinthians',
			'books.corinthians2' => '2 Corinthians',
			'books.galatians' => 'Galatians',
			'books.ephesians' => 'Ephesians',
			'books.philippians' => 'Philippians',
			'books.colossians' => 'Colossians',
			'books.thessalonians1' => '1 Thessalonians',
			'books.thessalonians2' => '2 Thessalonians',
			'books.timothy1' => '1 Timothy',
			'books.timothy2' => '2 Timothy',
			'books.titus' => 'Titus',
			'books.philemon' => 'Philemon',
			'books.hebrews' => 'Hebrews',
			'books.james' => 'James',
			'books.peter1' => '1 Peter',
			'books.peter2' => '2 Peter',
			'books.john1' => '1 John',
			'books.john2' => '2 John',
			'books.john3' => '3 John',
			'books.jude' => 'Jude',
			'books.revelation' => 'Revelation',
			'common.add' => 'Add',
			'common.addNew' => 'Add New',
			'common.am' => 'AM',
			'common.cancel' => 'Cancel',
			'common.close' => 'Close',
			'common.copy' => 'Copy',
			'common.continueLabel' => 'Continue',
			'common.create' => 'Create',
			'common.custom' => 'Custom',
			'common.defaultLabel' => 'Default',
			'common.delete' => 'Delete',
			'common.done' => 'Done',
			'common.edit' => 'Edit',
			'common.finish' => 'Finish',
			'common.learnMore' => 'Learn More',
			'common.nevermind' => 'Nevermind',
			'common.next' => 'Next',
			'common.noMatches' => 'No Matches',
			'common.noNotification' => 'No notification',
			'common.ok' => 'Ok',
			'common.off' => 'Off',
			'common.none' => 'None',
			'common.clear' => 'Clear',
			'common.remove' => 'Remove',
			'common.save' => 'Save',
			'common.search' => 'Search',
			'common.select' => 'Select',
			'common.show' => 'Show',
			'common.hide' => 'Hide',
			'common.pm' => 'PM',
			'common.sort' => 'Sort',
			'common.stop' => 'Stop',
			'common.tryAgain' => 'Try Again',
			'common.switchTo' => ({required Object translation}) => 'Switch to ${translation}',
			'common.notAvailableIn' => ({required Object translation}) => 'This is not available in ${translation}.',
			'regionTypes.chapter' => 'this chapter',
			'regionTypes.verses' => 'these verses',
			'regionTypes.visibleVerses' => 'visible verses',
			'regionTypes.text' => 'this text',
			'mainActions.pauseAudio' => 'Pause Audio Bible',
			'mainActions.playAudio' => 'Play Audio Bible',
			'mainActions.bookmark' => 'Bookmark',
			'mainActions.study' => 'Study',
			'mainActions.verseOfTheDay' => 'Verse of the Day',
			'mainActions.addStudyPanel' => 'Add Study Panel',
			'mainActions.search' => 'Search',
			'mainActions.resources' => 'Resources',
			'mainActions.plans' => 'Bible Plans',
			'mainActions.settings' => 'Settings',
			'mainActions.more' => 'More',
			'mainActions.audioDescription' => 'Listen to the current chapter with an audio-enabled Bible.',
			'mainActions.bookmarkDescription' => 'Bookmark this chapter to easily access it from the search page.',
			'mainActions.manageBookmarkDescription' => 'Manage this bookmark.',
			'mainActions.studyDescription' => 'View study tools for this chapter.',
			'mainActions.verseOfTheDayDescription' => 'View the verse of the day.',
			'mainActions.studyPanelDescription' => 'Pin a panel beside the text that follows along and shows study tools for whatever you\'re reading.',
			'mainActions.searchDescription' => 'Search for words across the Bible.',
			'mainActions.resourcesDescription' => 'Look up words in the dictionary and lexicon.',
			'mainActions.plansDescription' => 'Read through the Bible with guided reading plans.',
			'mainActions.settingsDescription' => 'View the settings for Lux.',
			'mainActions.moreDescription' => 'View settings, your content, and community links.',
			'verseOfTheDay.reminderDiscoveryTitle' => 'Add A Daily Reminder?',
			'verseOfTheDay.reminderDiscoveryBody' => 'Would you like Lux to notify you with the Verse of the Day each day?',
			'verseOfTheDay.addReminder' => 'Add Reminder',
			'verseOfTheDay.noReminder' => 'No',
			'verseOfTheDay.dailyReminders' => 'Daily Reminder',
			'verseOfTheDay.deleteReminder' => 'Delete Reminder?',
			'verseOfTheDay.deleteReminderConfirmation' => 'Are you sure you want to delete your daily Verse of the Day reminder?',
			'verseOfTheDay.reminderNotificationChannelName' => 'Verse of the Day Reminders',
			'verseOfTheDay.reminderNotificationChannelDescription' => 'Daily Verse of the Day reminders',
			'verseOfTheDay.reminderNotificationTitle' => 'Verse of the Day',
			'verseOfTheDay.reminderPermissionDeniedTitle' => 'Notifications Are Off',
			'verseOfTheDay.reminderPermissionDeniedBody' => 'To save this reminder, allow Lux to send notifications in Settings.',
			'verseOfTheDay.openNotificationSettings' => 'Open Settings',
			'verseOfTheDay.reminderSchedulingFailedTitle' => 'Couldn\'t Schedule Reminder',
			'verseOfTheDay.reminderSchedulingFailedBody' => 'Lux couldn\'t schedule this reminder. Please try again.',
			'verseOfTheDay.reminderSaved' => ({required Object time}) => 'Verse of the Day reminder saved for daily at ${time}.',
			'studyActions.quickStudy' => 'Quick Study',
			'studyActions.compare' => 'Compare',
			'studyActions.interlinear' => 'Interlinear',
			'studyActions.commentary' => 'Commentary',
			'studyActions.crossReferences' => 'Cross References',
			'studyActions.compareDescription' => ({required Object region}) => 'Compare ${region} across a variety of translations.',
			'studyActions.interlinearDescription' => ({required Object region}) => 'View a lexical breakdown of ${region} using Strong\'s.',
			'studyActions.commentaryDescription' => ({required Object region}) => 'View commentaries of ${region}.',
			'studyActions.crossReferencesDescription' => ({required Object region}) => 'View cross references of ${region}.',
			'studyActions.noCrossReferences' => 'No Cross References Found',
			'studyActions.crossReferencesUse' => ({required Object translation}) => 'Cross references use ${translation}',
			'studyActions.onlineCrossReferencesExplanation' => 'Because your selected translation is only available online, cross references are shown using the latest Study Bible you used to save on performance and costs. Your selected translation is used everywhere else in the app.',
			'selectionActions.annotate' => 'Annotate',
			'selectionActions.study' => 'Study',
			'selectionActions.copy' => 'Copy',
			'selectionActions.highlight' => 'Highlight',
			'selectionActions.removeAnnotations' => 'Remove Annotations',
			'selectionActions.interlinear' => 'Interlinear',
			'selectionActions.search' => 'Search',
			'selectionActions.annotateVersesDescription' => 'Annotate these verses.',
			'selectionActions.studyVersesDescription' => 'Study these verses.',
			'selectionActions.copyVersesDescription' => 'Copy these verses to your clipboard.',
			'selectionActions.annotateTextDescription' => 'Annotate this text.',
			'selectionActions.interlinearTextDescription' => 'View a lexical breakdown of this text.',
			'selectionActions.searchTextDescription' => 'Search the Bible for this text.',
			'selectionActions.copyTextDescription' => 'Copy this text to your clipboard.',
			'selectionActions.removeTextAnnotationsDescription' => ({required Object region}) => 'Remove text selection annotations from ${region}.',
			'selectionActions.highlightTextDescription' => ({required Object region}) => 'Highlight ${region} with the last color you used.',
			'selectionActions.removeVerseAnnotationsDescription' => ({required Object region}) => 'Remove verse selection annotations from ${region}.',
			'selectionActions.highlightVersesDescription' => ({required Object region}) => 'Highlight ${region} with the last color you used.',
			'selectionActions.highlightedText' => ({required Object reference}) => 'Highlighted text in ${reference}.',
			'selectionActions.highlightedVerses' => ({required Object reference}) => 'Highlighted ${reference}.',
			'selectionActions.copiedVerses' => ({required Object reference}) => '${reference} copied to clipboard.',
			'selectionActions.copiedText' => 'Text selection copied to clipboard.',
			'selectionActions.interlinearUnavailable' => 'Interlinear by text selection is only available in Study Bibles, which are designed with word-for-word Strong\'s and morphology tagging. Switch your translation to a Study Bible to use this action.',
			'selectionActions.noInterlinearWords' => 'No interlinear words found in this selection.',
			'selectionActions.textInReference' => ({required Object reference}) => 'Text in ${reference}',
			'studyPanels.title' => 'Study Panel',
			'studyPanels.pinAsStudyPanel' => 'Pin as Study Panel',
			'studyPanels.compareWith' => ({required Object translation}) => 'Compare with ${translation}',
			'studyPanels.directionInterlinear' => ({required Object direction}) => '${direction} Interlinear',
			'studyPanels.commentaryName' => ({required Object commentary}) => '${commentary} Commentary',
			'studyPanels.notes' => 'Notes',
			'studyPanels.noNotes' => 'No Notes Found',
			'studyPanels.notesDescription' => 'View your notes in visible verses.',
			'bookmarks.create' => 'Create Bookmark',
			'bookmarks.manage' => 'Manage Bookmark',
			'bookmarks.stopFollowing' => 'Stop Following',
			'bookmarks.stopFollowingDescription' => 'Stop this bookmark from following you.',
			'bookmarks.edit' => 'Edit Bookmark',
			'bookmarks.delete' => 'Delete Bookmark',
			'bookmarks.deleteConfirmation' => 'Are you sure you want to delete this bookmark?',
			'bookmarks.deleteNamedConfirmation' => ({required Object name}) => 'Are you sure you want to delete "${name}"?',
			'bookmarkPage.title' => 'Your Bookmarks',
			'commentaries.addRemove' => 'Add & Remove Commentaries',
			'toolbarShortcuts.switchBible' => 'Switch Bible',
			'toolbarShortcuts.dictionary' => 'Dictionary',
			'toolbarShortcuts.lexicon' => 'Lexicon',
			'toolbarShortcuts.themeAndLayout' => 'Theme & Layout',
			'toolbarShortcuts.switchBibleDescription' => 'Switch the Bible translation.',
			'toolbarShortcuts.dictionaryDescription' => 'Look up people, places, and topics in Easton\'s Bible Dictionary.',
			'toolbarShortcuts.lexiconDescription' => 'Study the original Hebrew and Greek words with Strong\'s Lexicon.',
			'toolbarShortcuts.themeAndLayoutDescription' => 'Customize the theme & layout of the Bible.',
			'labels.about' => 'About',
			'labels.annotation' => 'Annotation',
			'labels.annotations' => 'Annotations',
			'labels.audioBible' => 'Audio Bible',
			'labels.bible' => 'Bible',
			'labels.bibles' => 'Bibles',
			'labels.biblePlans' => 'Bible Plans',
			'labels.bookmarks' => 'Bookmarks',
			'labels.books' => 'Books',
			'labels.color' => 'Color',
			'labels.commentaries' => 'Commentaries',
			'labels.commentary' => 'Commentary',
			'labels.community' => 'Community',
			'labels.completed' => 'Completed',
			'labels.crossReferences' => 'Cross References',
			'labels.days' => 'Days',
			'labels.dictionary' => 'Dictionary',
			'labels.discord' => 'Discord',
			'labels.duration' => 'Duration',
			'labels.following' => 'Following',
			'labels.footnotes' => 'Footnotes',
			'labels.help' => 'Help',
			'labels.highlightStyles' => 'Highlight Styles',
			'labels.instagram' => 'Instagram',
			'labels.interlinear' => 'Interlinear',
			'labels.language' => 'Language',
			'labels.layout' => 'Layout',
			'labels.lexicon' => 'Lexicon',
			'labels.licenses' => 'Licenses',
			'labels.locations' => 'Locations',
			'labels.name' => 'Name',
			'labels.note' => 'Note',
			'labels.notebook' => 'Notebook',
			'labels.notebooks' => 'Notebooks',
			'labels.notes' => 'Notes',
			'labels.paragraphs' => 'Paragraphs',
			'labels.resources' => 'Resources',
			'labels.scope' => 'Scope',
			'labels.search' => 'Search',
			'labels.selection' => 'Selection',
			'labels.settings' => 'Settings',
			'labels.source' => 'Source',
			'labels.study' => 'Study',
			'labels.style' => 'Style',
			'labels.text' => 'Text',
			'labels.toolbar' => 'Toolbar',
			'labels.toolbars' => 'Toolbars',
			'labels.type' => 'Type',
			'labels.version' => 'Version',
			'labels.visibility' => 'Visibility',
			'strongSheet.interlinearWord' => 'Interlinear Word',
			'strongSheet.lexicon' => 'Lexicon',
			'strongSheet.legend' => 'Legend',
			'strongSheet.openInSearch' => 'Open In Search',
			'strongSheet.usage' => 'Usage',
			'strongSheet.inflected' => 'Inflected',
			'strongSheet.transliteration' => 'Transliteration',
			'strongSheet.root' => 'Root',
			'strongSheet.strongsId' => ({required Object id}) => 'Strong\'s ${id}',
			'strongSheet.rootWord' => 'Root Word',
			'strongSheet.pronunciation' => 'Pronunciation',
			'strongSheet.strongsDefinition' => 'Strong\'s Definition',
			'strongSheet.biblicalUsage' => 'Biblical Usage',
			'strongSheet.definition' => 'Definition',
			'strongSheet.examples' => 'Examples',
			'strongSheet.examplesPrefix' => 'Examples: ',
			'strongSheet.partOfSpeech' => 'Part of Speech',
			'strongSheet.derivation' => 'Derivation',
			'strongSheet.morphology' => 'Morphology',
			'strongSheet.relatedTerms' => 'Related Terms',
			'strongSheet.morphologyInfo' => 'Morphology Info',
			'strongSheet.definitionLegend' => 'Strong\'s Definition Legend',
			'strongSheet.optionalWord' => 'Optional word',
			'strongSheet.optionalWordDescription' => 'Marks a word or syllable that may be supplied with the main word.',
			'strongSheet.addedWord' => 'Added word in Hebrew or Greek',
			'strongSheet.addedWordDescription' => 'Marks a word included in the English rendering even though it is not present in the Hebrew or Greek.',
			'strongSheet.explanation' => 'Explanation',
			'strongSheet.renderingExplanation' => 'Italic text at the end of a rendering explains a variation from the usual form.',
			'strongSheet.concordance' => 'Concordance',
			'bibleDetails.onlineOnly' => 'Online Only',
			'bibleDetails.onlineDescription' => ({required Object source}) => 'This Bible is streamed from ${source}, so it requires an internet connection.',
			'bibleDetails.studyBible' => 'Study Bible',
			'bibleDetails.audioBible' => 'Audio Bible',
			'bibleDetails.onDevice' => 'On Device',
			'bibleDetails.onDeviceDescription' => 'This Bible is downloaded to your device, so you can search it and read offline.',
			'bibleDetails.studyBibleDescription' => 'Includes interlinear and morphology data. Long-press any word while reading to see the original Greek or Hebrew.',
			'bibleDetails.readingBible' => 'Reading Bible',
			'bibleDetails.readingBibleDescription' => 'Doesn\'t include interlinear or morphology data.',
			'bibleDetails.nativeHeadings' => 'Native Headings',
			'bibleDetails.nativeHeadingsDescription' => 'Headings are included with this Bible.',
			'bibleDetails.syntheticHeadings' => 'Synthetic Headings',
			'bibleDetails.syntheticHeadingsDescription' => 'Headings are synthetically inserted into this Bible from the BSB.',
			'bibleDetails.noHeadings' => 'No Headings',
			'bibleDetails.noHeadingsDescription' => 'No headings are included in this Bible.',
			'bibleDetails.audioSupportDescription' => 'Whether this Bible includes an Audio Bible',
			'bibleDetails.redLetters' => 'Red Letters',
			'bibleDetails.redLettersDescription' => 'Whether Red Letters are supported in this Bible.',
			'bibleDetails.footnotesDescription' => 'Whether this Bible includes footnotes.',
			'bibleDetails.paragraphsDescription' => 'Whether this Bible includes paragraphs.',
			'bibleDetails.addRemoveBibles' => 'Add & Remove Bibles',
			'bibleDetails.verseNumbering' => 'Verse Numbering',
			'emptyStates.noCommentaries' => 'No Commentaries Found',
			'emptyStates.noMatchingWords' => 'No matching words',
			'emptyStates.noMatchingTerms' => 'No matching terms',
			'emptyStates.noMatchingPlans' => 'No matching Bible plans.',
			'emptyStates.noMatchingAnnotations' => 'No matching annotations.',
			'emptyStates.noSearchResults' => 'No Search Results Found',
			'emptyStates.tryAnotherSearch' => 'Try another search',
			'emptyStates.noCommentariesAdded' => 'You haven\'t added any commentaries.',
			'emptyStates.noAnnotations' => 'You haven\'t created any annotations.',
			'emptyStates.noBookmarks' => 'You haven\'t created any bookmarks.',
			'emptyStates.noNotebooks' => 'You haven\'t created any notebooks. Notebooks let you organize your annotations.',
			'emptyStates.noPlans' => 'You aren\'t following any reading plans yet. Find one to start reading through the Bible.',
			'annotationUi.yourAnnotations' => 'Your Annotations',
			'annotationUi.annotate' => 'Annotate',
			'annotationUi.withNotes' => 'With Notes',
			'annotationUi.withoutNotes' => 'Without Notes',
			'annotationUi.mostRecent' => 'Most Recent',
			'annotationUi.location' => 'Location',
			'annotationUi.deleteAnnotation' => 'Delete Annotation',
			'annotationUi.deleteConfirmation' => 'Are you sure you want to delete this annotation?',
			'annotationUi.annotationCount' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: '${count} annotation', other: '${count} annotations', ), 
			'annotationUi.annotatedTime' => ({required Object time}) => 'Annotated ${time}',
			'notebookUi.yourNotebooks' => 'Your Notebooks',
			'notebookUi.hidden' => 'Hidden',
			'notebookUi.hideDescription' => 'Hide the annotations in this notebook from appearing in the Bible.',
			'notebookUi.showDescription' => 'Show the annotations from this notebook in the Bible.',
			'notebookUi.defaultDescription' => 'The permanent notebook for unassigned annotations.',
			'notebookUi.create' => 'Create Notebook',
			'notebookUi.edit' => 'Edit Notebook',
			'notebookUi.delete' => 'Delete Notebook',
			'notebookUi.deleteNamedConfirmation' => ({required Object name}) => 'Are you sure you want to delete "${name}"?',
			'notebookUi.deleteWithAnnotations' => ({required Object name, required Object annotations}) => '"${name}" has ${annotations}. Would you like to delete them too, or keep them in the Default notebook?',
			'notebookUi.keepInDefault' => 'Keep in Default',
			'notebookUi.deleteAnnotations' => 'Delete Annotations',
			'highlightStyleUi.yourStyles' => 'Your Highlight Styles',
			'highlightStyleUi.create' => 'Create Style',
			'highlightStyleUi.edit' => 'Edit Style',
			'highlightStyleUi.duplicate' => 'You already have this style',
			'highlightStyleUi.delete' => 'Delete Style',
			'highlightStyleUi.deleteNamedConfirmation' => ({required Object name}) => 'Are you sure you want to delete "${name}"?',
			'highlightStyleUi.deleteWithAnnotations' => ({required Object name, required Object annotations}) => '"${name}" has ${annotations}. Would you like to delete them too, or keep them?',
			'highlightStyleUi.keepAnnotations' => 'Keep Annotations',
			'highlightStyleUi.deleteAnnotations' => 'Delete Annotations',
			'highlightStyleUi.updateAnnotations' => 'Update Annotations',
			'highlightStyleUi.updateWithAnnotations' => ({required Object name, required Object annotations}) => '"${name}" has ${annotations}. Would you like to update them to use the new style, or leave them as-is?',
			'highlightStyleUi.leaveAsIs' => 'Leave As-Is',
			'highlightStyleUi.label' => 'Label',
			'toolbarSettings.mainToolbar' => 'Main Toolbar',
			'toolbarSettings.verseSelection' => 'Verse Selection',
			'toolbarSettings.textSelection' => 'Text Selection',
			'toolbarSettings.shownForMain' => 'Shown when nothing is selected.',
			'toolbarSettings.shownForVerses' => 'Shown when a verse is selected.',
			'toolbarSettings.shownForText' => 'Shown when long-pressing text within verses.',
			'toolbarSettings.gestures' => 'Gestures',
			'toolbarSettings.longPress' => 'Long Press',
			'toolbarSettings.mainLongPressDescription' => 'Shortcut when the toolbar is long-pressed.',
			'toolbarSettings.verseLongPressDescription' => 'Shortcut when a verse selection is long-pressed.',
			'toolbarSettings.textLongPressDescription' => 'Shortcut when a text selection is long-pressed.',
			'toolbarSettings.hideToolbar' => 'Hide',
			'toolbarSettings.hideToolbarDescription' => 'Hide the toolbar while scrolling down for an immersive view of the Bible.',
			'toolbarSettings.pinToolbar' => 'Pin',
			'toolbarSettings.pinToolbarDescription' => 'Pin the toolbar to the bottom of the page.',
			'toolbarSettings.expandToAnnotation' => 'Expand to Annotation',
			'toolbarSettings.expandTextDescription' => 'Long-pressing an annotated word selects its full highlighted range.',
			'toolbarSettings.expandVerseDescription' => 'Tapping a verse selects its full annotated verse selection.',
			'toolbarSettings.rangeSelection' => 'Range Selection',
			'toolbarSettings.rangeSelectionDescription' => 'Tapping a second verse selects all verses between it and the first.',
			'toolbarSettings.mainShortcut' => 'Main Toolbar Shortcut',
			'toolbarSettings.verseShortcut' => 'Verse Selection Shortcut',
			'toolbarSettings.textShortcut' => 'Text Selection Shortcut',
			'themeSettings.title' => 'Theme & Layout',
			'themeSettings.brightness' => 'Brightness',
			'themeSettings.font' => 'Font',
			'themeSettings.fontSizeSpacing' => 'Font Size & Spacing',
			'themeSettings.greekFontSizeSpacing' => 'Greek Font Size & Spacing',
			'themeSettings.hebrewFontSizeSpacing' => 'Hebrew Font Size & Spacing',
			'themeSettings.system' => 'System',
			'themeSettings.systemTextSizeDescription' => 'Use your device\'s preferred text size.',
			'themeSettings.defaultSizeDescription' => 'Use the default Font Size & Spacing.',
			'themeSettings.redLetters' => 'Red Letters',
			'themeSettings.redLettersDescription' => 'Show Jesus\' words in red.',
			'themeSettings.sectionHeadings' => 'Section Headings',
			'themeSettings.verseNumbers' => 'Verse Numbers',
			'themeSettings.paragraphsDescription' => 'Format verses into paragraphs.',
			'themeSettings.footnotesDescription' => 'Show footnote markers within the text.',
			'biblePlans.find' => 'Find A Bible Plan',
			'biblePlans.startPlanQuestion' => 'Start Plan?',
			'biblePlans.reviewAndReflect' => 'Review & Reflect',
			'biblePlans.startPlan' => 'Start Plan',
			'biblePlans.dailyReminders' => 'Daily Reminders',
			'biblePlans.dailyRemindersDescription' => 'Set or edit when this plan reminds you to read each day.',
			'biblePlans.dailyAt' => ({required Object time}) => 'Daily at ${time}',
			'biblePlans.reminderDiscoveryTitle' => 'Add A Daily Reminder?',
			'biblePlans.reminderDiscoveryBody' => ({required Object name}) => 'Would you like Lux to remind you to continue "${name}" each day?',
			'biblePlans.addReminder' => 'Add Reminder',
			'biblePlans.noReminder' => 'No',
			'biblePlans.deleteReminder' => 'Delete Reminder?',
			'biblePlans.deleteReminderConfirmation' => ({required Object name}) => 'Are you sure you want to delete the daily reminder for "${name}"?',
			'biblePlans.reminderNotificationChannelName' => 'Bible Plan Reminders',
			'biblePlans.reminderNotificationChannelDescription' => 'Daily reminders for your Bible plans',
			'biblePlans.reminderNotificationTitle' => ({required Object name}) => 'Read "${name}"',
			'biblePlans.reminderNotificationBody' => ({required Object reading}) => 'Today\'s reading is ${reading}',
			'biblePlans.reminderPermissionDeniedTitle' => 'Notifications Are Off',
			'biblePlans.reminderPermissionDeniedBody' => 'To save this reminder, allow Lux to send notifications in Settings.',
			'biblePlans.openNotificationSettings' => 'Open Settings',
			'biblePlans.reminderSchedulingFailedTitle' => 'Couldn\'t Schedule Reminder',
			'biblePlans.reminderSchedulingFailedBody' => 'Lux couldn\'t schedule this reminder. Please try again.',
			'biblePlans.reminderSaved' => ({required Object name, required Object time}) => 'Reminder saved for "${name}" daily at ${time}.',
			'biblePlans.stopPlan' => 'Stop Plan',
			'biblePlans.stopPlanDescription' => 'Remove this plan and its progress.',
			'biblePlans.readEntireChapter' => 'Read Entire Chapter',
			'biblePlans.readInContext' => 'Read In Context',
			'biblePlans.startNew' => 'Start New',
			'biblePlans.day' => ({required Object day}) => 'Day ${day}',
			'biblePlans.dayCount' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: '${count} day', other: '${count} days', ), 
			'biblePlans.stopConfirmation' => ({required Object name}) => 'Are you sure you want to stop "${name}"? Your progress will be lost.',
			'biblePlans.completed' => ({required Object name}) => '"${name}" completed.',
			'biblePlans.addPlan' => 'Add Bible plan',
			'searchUi.searchBible' => 'Search Bible',
			'searchUi.startSearch' => 'Start a search',
			'searchUi.searchPrompt' => 'Enter a keyword like light, word, or wisdom, then hit enter on the keyboard.',
			'searchUi.usingTranslation' => ({required Object translation}) => 'Using ${translation} for search',
			'searchUi.unsupportedTranslation' => ({required Object translation}) => '${translation} does not currently support search. Using your most-recent Study Bible instead.',
			'searchUi.strongSearchStudyBibleExplanation' => 'Strong\'s number searches require the word-level Strong\'s tagging included in Study Bibles. Using your most-recent Study Bible instead.',
			'searchUi.wordOrPhraseHint' => 'Search for a word or phrase',
			'searchUi.wordHint' => 'Search for a word',
			'searchUi.strongNumberHint' => 'Search for a Strong\'s number (e.g. H125)',
			'searchUi.wordMatching.title' => 'Word Matching',
			'searchUi.wordMatching.wholeWord.title' => 'Whole Word',
			'searchUi.wordMatching.wholeWord.description' => 'Find only complete words that match your search.',
			'searchUi.wordMatching.wholeWord.example' => 'Example: “light” matches “light”',
			'searchUi.wordMatching.startOfWord.title' => 'Start of Word',
			'searchUi.wordMatching.startOfWord.description' => 'Find words that begin with your search.',
			'searchUi.wordMatching.startOfWord.example' => 'Example: “light” also matches “lightning”',
			'searchUi.wordMatching.partOfWord.title' => 'Part of Word',
			'searchUi.wordMatching.partOfWord.description' => 'Find words containing your search anywhere.',
			'searchUi.wordMatching.partOfWord.example' => 'Example: “light” also matches “delight”',
			'onboarding.skipQuestion' => 'Skip Onboarding?',
			'onboarding.skipConfirmation' => 'Are you sure you want to skip the onboarding? You can restart it from Settings > Help.',
			'onboarding.getStarted' => 'Get Started',
			'onboarding.learnLux' => 'Learn how to use Lux',
			'onboarding.checklistDescription' => 'Complete the checklist below to learn how to use Lux.',
			'onboarding.skipHint' => 'In a hurry? Tap ✕ to skip.',
			'tutorials.dontShowAgain' => 'Don\'t Show Again',
			'audio.timer' => 'Audio Timer',
			'audio.fiveMinutes' => '5 minutes',
			'audio.tenMinutes' => '10 minutes',
			'audio.fifteenMinutes' => '15 minutes',
			'audio.thirtyMinutes' => '30 minutes',
			'audio.oneHour' => '1 hour',
			'audio.loadError' => 'The audio could not be loaded',
			'audio.connectionError' => 'Check your internet connection or try again later.',
			'audio.unavailable' => 'Audio is unavailable for this Bible',
			'audio.chooseBible' => 'Choose an audio-enabled Bible to listen to this chapter.',
			'audio.switchRequired' => 'Switch to an audio-enabled Bible to listen to this passage.',
			'audio.rewindTenSeconds' => 'Back 10 seconds',
			'audio.fastForwardTenSeconds' => 'Forward 10 seconds',
			'audio.notificationChannelName' => 'Audio Bible playback',
			'audio.notificationChannelDescription' => 'Audio Bible playback controls',
			'interlinearUi.interlinearBible' => 'Interlinear Bible',
			'interlinearUi.direction' => 'Interlinear Direction',
			'interlinearUi.reverse' => 'Reverse',
			'interlinearUi.forward' => 'Forward',
			'interlinearUi.reverseDescription' => 'Words appear in the English reading order.',
			'interlinearUi.forwardDescription' => 'Words appear in the original Hebrew or Greek order.',
			'interlinearUi.studyBibleExplanation' => 'Study Bibles are designed with word-for-word Strong\'s and morphology tagging, which is what makes the Interlinear lexical breakdown possible. Using your most-recent Study Bible instead.',
			'interlinearUi.usingTranslation' => ({required Object translation}) => 'Using ${translation} for interlinear',
			'chapterUnavailable.title' => ({required Object selectedTranslation, required Object testament}) => '${selectedTranslation} doesn\'t include the ${testament}.',
			'chapterUnavailable.subtitle' => ({required Object testament, required Object fallbackTranslation}) => 'Showing your most-recent ${testament} Bible, ${fallbackTranslation}.',
			'verseNumbering.referenceLabel' => ({required Object translation, required Object reference}) => '${translation} ${reference}',
			'verseNumbering.explanation' => ({required Object translation, required Object reference, required Object originalReference}) => 'The ${translation} numbers its chapters and verses differently from most English translations.\n\nThe text shown here at ${reference} comes from ${originalReference} in the ${translation}, remapped so it lines up with the other translations.',
			'compare.unavailable' => ({required Object translation}) => '${translation} doesn\'t include this selection.',
			_ => null,
		} ?? switch (path) {
			'commentaryUi.introTo' => ({required Object book}) => 'Intro to ${book}',
			'searchLocations.currentBook' => 'Current Book',
			'searchLocations.testaments' => 'Testaments',
			'searchLocations.books' => 'Books',
			'themeOptions.auto' => 'Auto',
			'themeOptions.light' => 'Light',
			'themeOptions.dark' => 'Dark',
			'themeOptions.extraTiny' => 'Extra Tiny',
			'themeOptions.tiny' => 'Tiny',
			'themeOptions.small' => 'Small',
			'themeOptions.standard' => 'Standard',
			'themeOptions.large' => 'Large',
			'themeOptions.huge' => 'Huge',
			'themeOptions.extraHuge' => 'Extra Huge',
			'themeOptions.nativeAndSynthetic' => 'Native & Synthetic',
			'themeOptions.native' => 'Native',
			'themeOptions.none' => 'None',
			'themeOptions.allHeadingsDescription' => 'Show headings in translations that support them, and synthetically insert BSB\'s section headings into English translations without them natively.',
			'themeOptions.nativeHeadingsDescription' => 'Show headings in translations that support them.',
			'themeOptions.noHeadingsDescription' => 'Do not show section headings',
			'toolbarPresets.reader' => 'Reader',
			'toolbarPresets.noteTaker' => 'Note-taker',
			'toolbarPresets.studier' => 'Studier',
			'toolbarPresets.readerDescription' => 'Tuned for distraction-free reading and quick navigation.',
			'toolbarPresets.noteTakerDescription' => 'Tuned for highlighting and taking notes.',
			'toolbarPresets.studierDescription' => 'Tuned for cross-references, commentary, and deep study.',
			'commentaryTypes.matthewHenryDescription' => 'A concise, devotional commentary on the whole Bible from the Puritan tradition. Warm, practical, and easy to read.',
			'commentaryTypes.jamiesonFaussetBrownDescription' => 'A compact, verse-by-verse commentary on the whole Bible. Balanced and accessible.',
			'commentaryTypes.calvinDescription' => 'The Reformer\'s classic exposition. Deep and doctrinal.',
			'strongDefinition.addedLabel' => 'added:',
			'strongDefinition.idiomLabel' => 'idiom:',
			'strongDefinition.addedWord' => 'Added word',
			'strongDefinition.idiomaticRendering' => 'Idiomatic rendering',
			'strongDefinition.addedWordDescription' => 'Marks a word supplied alongside the Hebrew or Greek word being defined.',
			'strongDefinition.idiomaticRenderingDescription' => 'Marks a rendering that reflects an expression particular to Hebrew or Greek.',
			'planTypes.throughTheBible' => 'Through The Bible',
			'planTypes.chronological' => 'One Year Chronological',
			'planTypes.oldAndNewTestament' => 'Old and New Testament',
			'planTypes.everyDayInTheWord' => 'Every Day In the Word',
			'planTypes.mcheyne' => 'M\'Cheyne',
			'planTypes.literaryStudy' => 'Literary Study',
			'planTypes.differentTopics' => 'Different Topics',
			'planTypes.newTestamentPsalmsProverbs' => 'New Testament, Psalms & Proverbs',
			'planTypes.fiveByFiveByFive' => '5x5x5 New Testament',
			'planTypes.gospelsAndEpistles' => 'Gospel and Epistles',
			'planTypes.pentateuchAndHistory' => 'Pentateuch and History of Israel',
			'planTypes.chroniclesAndProphets' => 'Chronicles and Prophets',
			'planTypes.psalmsAndWisdom' => 'Psalms and Wisdom Literature',
			'planTypes.mcheyneDescription' => 'A classic plan with four short readings a day. You read through the Old Testament once and the New Testament and Psalms twice in a year.',
			'planTypes.chronologicalDescription' => 'Read the whole Bible in a year, arranged in the order the events actually happened.',
			'planTypes.throughTheBibleDescription' => 'Read straight through the whole Bible in a year, from Genesis to Revelation.',
			'planTypes.gospelsAndEpistlesDescription' => 'Spend the year in the New Testament, journeying through the Gospels and the letters of the apostles.',
			'planTypes.everyDayInTheWordDescription' => 'Four readings a day from the Old Testament, New Testament, Psalms, and Proverbs, covering the whole Bible in a year, with Psalms & Proverbs twice.',
			'planTypes.literaryStudyDescription' => 'Experience the Bible over a year grouped by its literary styles, moving through story, poetry, and letters.',
			'planTypes.chroniclesAndProphetsDescription' => 'A year that pairs the history in Chronicles with the messages of the Prophets.',
			'planTypes.pentateuchAndHistoryDescription' => 'Journey through the five books of Moses and the history of Israel over a year.',
			'planTypes.psalmsAndWisdomDescription' => 'Spend the year in the Psalms and wisdom books like Proverbs, Job, and Ecclesiastes.',
			'planTypes.oldAndNewTestamentDescription' => 'Read through both the Old and New Testaments together, with a passage from each every day.',
			'planTypes.differentTopicsDescription' => 'Rotate through a different section of Scripture each day, exploring every book of the Bible over a year.',
			'planTypes.newTestamentPsalmsProverbsDescription' => 'Read the New Testament alongside Psalms and Proverbs over the course of a year.',
			'planTypes.fiveByFiveByFiveDescription' => 'Read one New Testament chapter a day, five days a week, followed by two days to review and reflect.',
			'planTypes.oldScopeDescription' => 'Reads from books in the Old Testament.',
			'planTypes.newScopeDescription' => 'Reads from books in the New Testament.',
			'planTypes.wholeScopeDescription' => 'Reads from both the Old and New Testaments.',
			'planTypes.focused' => 'Focused',
			'planTypes.comprehensive' => 'Comprehensive',
			'planTypes.focusedDescription' => 'Covers a specific section or collection within its scope.',
			'planTypes.comprehensiveDescription' => 'Covers every book within its scope.',
			'onboardingSteps.viewCrossReferences' => 'View cross references',
			'onboardingSteps.annotateVerse' => 'Annotate a verse',
			'onboardingSteps.searchWord' => 'Search for a word',
			'onboardingSteps.switchBible' => 'Switch your Bible',
			'onboardingSteps.navigateChapter' => 'Go to another chapter',
			'onboardingSteps.goBack' => 'Go back',
			'onboardingSteps.swipeChapter' => 'Swipe to change chapter',
			'onboardingSteps.addStudyPanel' => 'Add a study panel',
			'onboardingSteps.customizeToolbar' => 'Customize your toolbars',
			'onboardingSteps.startBiblePlan' => 'Start a Bible plan',
			'onboardingSteps.selectVerse' => 'Tap a verse to select it',
			'onboardingSteps.selectWord' => 'Long-press a word',
			'onboardingSteps.deselectPrefix' => 'Tap ',
			'onboardingSteps.deselectSuffix' => ' next to your selection to deselect',
			'onboardingSteps.revealToolbar' => 'Scroll up to reveal the main toolbar',
			'onboardingSteps.addPanelPrefix' => 'Tap ',
			'onboardingSteps.addPanelSuffix' => ' → Study → Add Study Panel and add any study panel',
			'onboardingSteps.goToChapter' => 'Go to another chapter',
			'onboardingSteps.openPrefix' => 'Open ',
			'onboardingSteps.crossReferencesSuffix' => ' → Study → Cross References',
			'onboardingSteps.annotatePrefix' => 'Tap ',
			'onboardingSteps.annotateSuffix' => ' to highlight or add a note',
			'onboardingSteps.searchPrefix' => 'Tap ',
			'onboardingSteps.searchSuffix' => ' to look the word up everywhere',
			'onboardingSteps.switchBibleDescription' => ({required Object translation}) => 'Tap the main toolbar → ${translation} to switch Bibles',
			'onboardingSteps.goToChapterDescription' => 'Tap the main toolbar to go to another chapter',
			'onboardingSteps.goBackDescription' => 'Swipe right on the toolbar to go back',
			'onboardingSteps.swipeChapterDescription' => 'Swipe the Bible left or right to change chapter',
			'onboardingSteps.viewPanelDescription' => 'Swipe this panel right to view your study panel',
			'onboardingSteps.moreSeparator' => ' → More → ',
			'onboardingSteps.customizeToolbarSuffix' => 'Toolbars and pick a toolbar preset or change any of your toolbar shortcuts',
			'onboardingSteps.startPlanSuffix' => ' → Bible Plans and start any Bible plan',
			'dictionary.eastons' => 'Easton\'s Bible Dictionary',
			'navigation.recents' => 'Recents',
			'navigation.navigate' => 'Navigate',
			'navigation.book' => 'Book',
			'navigation.chapter' => 'Chapter',
			'navigation.verse' => 'Verse',
			'bibleSheet.allBibles' => 'All Bibles',
			'bibleSheet.availableCount' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(count, one: '${count} Bible Available', other: '${count} Bibles Available', ), 
			'selectionUi.selected' => 'Selected: ',
			'selectionUi.sourceApiBible' => 'Sourced from [https://api.bible](https://api.bible)',
			'errors.deviceVerificationFailed' => 'Device verification failed',
			'errors.deviceVerificationDescription' => 'Access to this online Bible requires a valid device and legitimate installation of Lux. Make sure you installed Lux from an official app store, then try again.',
			'errors.generic' => 'Something went wrong',
			'errors.connection' => 'Check your internet connection or try again later.',
			'morphology.attributes.type.name' => 'Type',
			'morphology.attributes.type.description' => 'The grammatical category of the word.',
			'morphology.attributes.grammaticalCase.name' => 'Case',
			'morphology.attributes.grammaticalCase.description' => 'The syntactic role, such as subject, object, or possession.',
			'morphology.attributes.gender.name' => 'Gender',
			'morphology.attributes.gender.description' => 'Grammatical gender: masculine, feminine, neuter (Greek), or common (Hebrew).',
			'morphology.attributes.number.name' => 'Number',
			'morphology.attributes.number.description' => 'Whether the word refers to one (singular), two (dual), or many (plural).',
			'morphology.attributes.person.name' => 'Person',
			'morphology.attributes.person.description' => 'Who the word refers to: 1st (I/we), 2nd (you), or 3rd (he/she/it/they).',
			'morphology.attributes.state.name' => 'State',
			'morphology.attributes.state.description' => 'The state of a noun: absolute, construct, or determined.',
			'morphology.attributes.tense.name' => 'Tense',
			'morphology.attributes.tense.description' => 'The verb tense, combining time and aspect.',
			'morphology.attributes.mood.name' => 'Mood',
			'morphology.attributes.mood.description' => 'How the action is expressed, such as fact, command, or possibility.',
			'morphology.attributes.voice.name' => 'Voice',
			'morphology.attributes.voice.description' => 'The voice: active, middle, or passive.',
			'morphology.attributes.degree.name' => 'Degree',
			'morphology.attributes.degree.description' => 'The degree of an adjective or adverb: positive, comparative, or superlative.',
			'morphology.attributes.stem.name' => 'Stem',
			'morphology.attributes.stem.description' => 'The verb stem (binyan), such as qal, niphal, or piel.',
			'morphology.attributes.aspect.name' => 'Aspect',
			'morphology.attributes.aspect.description' => 'The verb aspect, such as perfect, imperfect, or participle.',
			'morphology.attributes.prefix.name' => 'Prefix',
			'morphology.attributes.prefix.description' => 'A Hebrew prefixed preposition letter.',
			'morphology.attributes.particle.name' => 'Particle',
			'morphology.attributes.particle.description' => 'A small uninflected word, often a conjunction or marker.',
			'morphology.attributes.code.name' => 'Code',
			'morphology.attributes.code.description' => 'The raw morphology code as it appears in the source text.',
			'morphology.types.article.name' => 'Article',
			'morphology.types.article.description' => 'A definite article, "the".',
			'morphology.types.article.examples' => 'the king|the Lord',
			'morphology.types.conjunction.name' => 'Conjunction',
			'morphology.types.conjunction.description' => 'A word that joins other words or clauses.',
			'morphology.types.conjunction.examples' => 'and|but|for',
			'morphology.types.preposition.name' => 'Preposition',
			'morphology.types.preposition.description' => 'Relates a noun or pronoun to other words.',
			'morphology.types.preposition.examples' => 'in|to|with',
			'morphology.types.adverb.name' => 'Adverb',
			'morphology.types.adverb.description' => 'Modifies a verb, adjective, or another adverb.',
			'morphology.types.adverb.examples' => 'quickly|now|there',
			'morphology.types.negativeAdverb.name' => 'Negative adverb',
			'morphology.types.negativeAdverb.description' => 'An adverb expressing negation.',
			'morphology.types.negativeAdverb.examples' => 'not|never',
			'morphology.types.adjective.name' => 'Adjective',
			'morphology.types.adjective.description' => 'A word that describes a noun.',
			'morphology.types.adjective.examples' => 'great|holy|wise',
			'morphology.types.noun.name' => 'Noun',
			'morphology.types.noun.description' => 'A person, place, thing, or idea.',
			'morphology.types.noun.examples' => 'city|water|love',
			'morphology.types.properNoun.name' => 'Proper noun',
			'morphology.types.properNoun.description' => 'A specific name of a person, place, or thing.',
			'morphology.types.properNoun.examples' => 'David|Jerusalem|Israel',
			'morphology.types.number.name' => 'Number',
			'morphology.types.number.description' => 'A cardinal number.',
			'morphology.types.number.examples' => 'three|twelve|thousand',
			'morphology.types.ordinalNumber.name' => 'Ordinal number',
			'morphology.types.ordinalNumber.description' => 'An ordinal number, such as "first" or "second".',
			'morphology.types.ordinalNumber.examples' => 'first|tenth|seventieth',
			'morphology.types.pronoun.name' => 'Pronoun',
			'morphology.types.pronoun.description' => 'A word that stands in for a noun.',
			'morphology.types.pronoun.examples' => 'he|she|they',
			'morphology.types.personalPronoun.name' => 'Personal pronoun',
			'morphology.types.personalPronoun.description' => 'A pronoun that refers to a specific person.',
			'morphology.types.personalPronoun.examples' => 'I|you|we',
			'morphology.types.demonstrativePronoun.name' => 'Demonstrative pronoun',
			'morphology.types.demonstrativePronoun.description' => 'A pronoun that points to something.',
			'morphology.types.demonstrativePronoun.examples' => 'this|these|those',
			'morphology.types.interrogativePronoun.name' => 'Interrogative pronoun',
			'morphology.types.interrogativePronoun.description' => 'A pronoun used to ask a question.',
			'morphology.types.interrogativePronoun.examples' => 'who?|what?|which?',
			'morphology.types.indefinitePronoun.name' => 'Indefinite pronoun',
			'morphology.types.indefinitePronoun.description' => 'A pronoun referring to non-specific entities.',
			'morphology.types.indefinitePronoun.examples' => 'someone|anyone|nothing',
			'morphology.types.reciprocalPronoun.name' => 'Reciprocal pronoun',
			'morphology.types.reciprocalPronoun.description' => 'A pronoun expressing mutual action.',
			'morphology.types.reciprocalPronoun.examples' => 'one another|each other',
			'morphology.types.reflexivePronoun.name' => 'Reflexive pronoun',
			'morphology.types.reflexivePronoun.description' => 'A pronoun referring back to the subject.',
			'morphology.types.reflexivePronoun.examples' => 'himself|themselves',
			'morphology.types.relativePronoun.name' => 'Relative pronoun',
			'morphology.types.relativePronoun.description' => 'A pronoun introducing a subordinate clause.',
			'morphology.types.relativePronoun.examples' => 'who|which|that',
			'morphology.types.particle.name' => 'Particle',
			'morphology.types.particle.description' => 'A small uninflected word.',
			'morphology.types.particle.examples' => 'indeed|now',
			'morphology.types.negativeParticle.name' => 'Negative particle',
			'morphology.types.negativeParticle.description' => 'A particle that marks negation.',
			'morphology.types.negativeParticle.examples' => 'not|no',
			'morphology.types.interrogativeParticle.name' => 'Interrogative particle',
			'morphology.types.interrogativeParticle.description' => 'A particle that marks a question.',
			'morphology.types.interrogativeParticle.examples' => '(Hebrew prefix ה, no English equivalent)',
			'morphology.types.demonstrativeParticle.name' => 'Demonstrative particle',
			'morphology.types.demonstrativeParticle.description' => 'A pointing particle, such as "behold".',
			'morphology.types.demonstrativeParticle.examples' => 'behold|lo',
			'morphology.types.genericParticle.name' => 'Generic particle',
			'morphology.types.genericParticle.description' => 'A general-purpose particle.',
			'morphology.types.genericParticle.examples' => 'indeed|truly',
			'morphology.types.relativeParticle.name' => 'Relative particle',
			'morphology.types.relativeParticle.description' => 'A particle that introduces a relative clause.',
			'morphology.types.relativeParticle.examples' => 'that|which',
			'morphology.types.verb.name' => 'Verb',
			'morphology.types.verb.description' => 'A word expressing an action or state.',
			'morphology.types.verb.examples' => 'write|be|go',
			'morphology.types.pronominalSuffix.name' => 'Pronominal suffix',
			'morphology.types.pronominalSuffix.description' => 'A pronoun fused to the end of a verb or noun (Hebrew).',
			'morphology.types.pronominalSuffix.examples' => 'his hand|their land|her voice',
			'morphology.types.directObjectMarker.name' => 'Direct object marker',
			'morphology.types.directObjectMarker.description' => 'The Hebrew אֵת that marks a definite direct object.',
			'morphology.types.directObjectMarker.examples' => 'אֵת (no English equivalent)',
			'morphology.types.punctuation.name' => 'Punctuation',
			'morphology.types.punctuation.description' => 'A punctuation mark.',
			'morphology.types.punctuation.examples' => '.|,|;',
			'morphology.types.interjection.name' => 'Interjection',
			'morphology.types.interjection.description' => 'A short exclamation expressing emotion.',
			'morphology.types.interjection.examples' => 'oh!|alas!',
			'morphology.types.indeclinable.name' => 'Indeclinable',
			'morphology.types.indeclinable.description' => 'A word that does not change form by inflection.',
			'morphology.types.indeclinable.examples' => 'Hosanna|Hallelujah',
			'morphology.types.hebraism.name' => 'Hebrew loanword',
			'morphology.types.hebraism.description' => 'A Hebrew or Aramaic loanword carried into Greek.',
			'morphology.types.hebraism.examples' => 'Amen|Hosanna|Sabaoth',
			'morphology.types.unknown.name' => 'Unknown',
			'morphology.types.unknown.description' => 'A morphology code that the parser did not recognize.',
			'morphology.types.unknown.examples' => '',
			'morphology.person.first.name' => '1st person',
			'morphology.person.first.description' => 'The speaker, "I" or "we".',
			'morphology.person.first.examples' => 'I am|we walk|I have spoken',
			'morphology.person.second.name' => '2nd person',
			'morphology.person.second.description' => 'The addressee, "you" (singular or plural).',
			'morphology.person.second.examples' => 'you go|you (pl.) listen|you have seen',
			'morphology.person.third.name' => '3rd person',
			'morphology.person.third.description' => 'The party being spoken about.',
			'morphology.person.third.examples' => 'he runs|she speaks|they gathered',
			'morphology.gender.masculine.name' => 'Masculine',
			'morphology.gender.masculine.description' => 'Masculine grammatical gender, used for male persons and many nouns by convention.',
			'morphology.gender.masculine.examples' => 'father|son|king',
			'morphology.gender.feminine.name' => 'Feminine',
			'morphology.gender.feminine.description' => 'Feminine grammatical gender, used for female persons and many nouns by convention.',
			'morphology.gender.feminine.examples' => 'mother|daughter|queen',
			'morphology.gender.neuter.name' => 'Neuter',
			'morphology.gender.neuter.description' => 'Greek neuter gender, neither masculine nor feminine.',
			'morphology.gender.neuter.examples' => 'child (τέκνον)|gift (δῶρον)',
			'morphology.gender.common.name' => 'Common',
			'morphology.gender.common.description' => 'Hebrew common gender, where the form serves both masculine and feminine.',
			'morphology.gender.common.examples' => 'cattle|voice',
			'morphology.number.singular.name' => 'Singular',
			'morphology.number.singular.description' => 'Refers to one.',
			'morphology.number.singular.examples' => 'the book|a man|one stone',
			'morphology.number.plural.name' => 'Plural',
			'morphology.number.plural.description' => 'Refers to two or more.',
			'morphology.number.plural.examples' => 'the books|men|stones',
			'morphology.number.dual.name' => 'Dual',
			'morphology.number.dual.description' => 'Refers to a natural pair (Hebrew only).',
			'morphology.number.dual.examples' => 'hands|eyes|two days',
			'morphology.kCase.nominative.name' => 'Nominative',
			'morphology.kCase.nominative.description' => 'Marks the subject of a sentence.',
			'morphology.kCase.nominative.examples' => 'God created|the king sees',
			'morphology.kCase.genitive.name' => 'Genitive',
			'morphology.kCase.genitive.description' => 'Indicates possession or origin, often translated "of".',
			'morphology.kCase.genitive.examples' => 'the Son of God|kingdom of heaven',
			'morphology.kCase.dative.name' => 'Dative',
			'morphology.kCase.dative.description' => 'Marks the indirect object, often "to" or "for".',
			'morphology.kCase.dative.examples' => 'gave to him|spoke to them',
			'morphology.kCase.accusative.name' => 'Accusative',
			'morphology.kCase.accusative.description' => 'Marks the direct object.',
			'morphology.kCase.accusative.examples' => 'saw him|love your neighbor',
			'morphology.kCase.vocative.name' => 'Vocative',
			'morphology.kCase.vocative.description' => 'Used in direct address.',
			'morphology.kCase.vocative.examples' => 'Lord!|Father!|Friend!',
			'morphology.state.absolute.name' => 'Absolute',
			'morphology.state.absolute.description' => 'The default, independent form of a noun.',
			'morphology.state.absolute.examples' => 'a king|a word',
			'morphology.state.construct.name' => 'Construct',
			'morphology.state.construct.description' => 'Bound to a following noun, expressing "X of Y".',
			'morphology.state.construct.examples' => 'king of Israel|word of the LORD',
			'morphology.state.determined.name' => 'Determined',
			'morphology.state.determined.description' => 'Marked as definite, often by the article.',
			'morphology.state.determined.examples' => 'the king|the word',
			'morphology.stem.qal.name' => 'Qal',
			'morphology.stem.qal.description' => 'The simple active stem, the basic action of the verb.',
			'morphology.stem.qal.examples' => 'he wrote|she heard',
			'morphology.stem.qalPassive.name' => 'Qal passive',
			'morphology.stem.qalPassive.description' => 'A rare passive of the simple stem.',
			'morphology.stem.qalPassive.examples' => 'it was taken',
			'morphology.stem.niphal.name' => 'Niphal',
			'morphology.stem.niphal.description' => 'The simple passive or reflexive stem.',
			'morphology.stem.niphal.examples' => 'he was killed|they gathered themselves',
			'morphology.stem.piel.name' => 'Piel',
			'morphology.stem.piel.description' => 'The intensive or factitive active stem.',
			'morphology.stem.piel.examples' => 'he praised|he blessed|he shattered',
			'morphology.stem.pual.name' => 'Pual',
			'morphology.stem.pual.description' => 'The passive of the piel.',
			'morphology.stem.pual.examples' => 'he was praised',
			'morphology.stem.hiphil.name' => 'Hiphil',
			'morphology.stem.hiphil.description' => 'The causative active stem.',
			'morphology.stem.hiphil.examples' => 'he caused to write|he led out',
			'morphology.stem.hophal.name' => 'Hophal',
			'morphology.stem.hophal.description' => 'The passive of the hiphil.',
			'morphology.stem.hophal.examples' => 'he was caused to write',
			'morphology.stem.hithpael.name' => 'Hithpael',
			'morphology.stem.hithpael.description' => 'The reflexive or reciprocal of the piel.',
			'morphology.stem.hithpael.examples' => 'he sanctified himself|they walked about',
			'morphology.stem.nithpael.name' => 'Nithpael',
			'morphology.stem.nithpael.description' => 'A rare reflexive-passive stem.',
			'morphology.stem.nithpael.examples' => 'it was atoned for',
			'morphology.aspect.perfect.name' => 'Perfect',
			'morphology.aspect.perfect.description' => 'Completed action, typically translated as past.',
			'morphology.aspect.perfect.examples' => 'he wrote|she has spoken',
			'morphology.aspect.imperfect.name' => 'Imperfect',
			'morphology.aspect.imperfect.description' => 'Incomplete or future action, often translated as future or habitual.',
			'morphology.aspect.imperfect.examples' => 'he will write|he writes',
			'morphology.aspect.imperative.name' => 'Imperative',
			'morphology.aspect.imperative.description' => 'A direct command.',
			'morphology.aspect.imperative.examples' => 'Write!|Listen!',
			'morphology.aspect.infinitiveConstruct.name' => 'Infinitive construct',
			'morphology.aspect.infinitiveConstruct.description' => 'A verbal noun in construct form, often used with prepositions.',
			'morphology.aspect.infinitiveConstruct.examples' => 'to write|when writing',
			'morphology.aspect.infinitiveAbsolute.name' => 'Infinitive absolute',
			'morphology.aspect.infinitiveAbsolute.description' => 'An independent verbal noun, often emphatic.',
			'morphology.aspect.infinitiveAbsolute.examples' => 'surely die|write thoroughly',
			'morphology.aspect.participle.name' => 'Participle',
			'morphology.aspect.participle.description' => 'A verbal adjective describing ongoing action.',
			'morphology.aspect.participle.examples' => 'writing|the one who hears',
			'morphology.aspect.consecutiveImperfect.name' => 'Consecutive imperfect',
			'morphology.aspect.consecutiveImperfect.description' => 'Past narrative form: waw + imperfect.',
			'morphology.aspect.consecutiveImperfect.examples' => 'and he said|and they went',
			'morphology.aspect.conjunctiveImperfect.name' => 'Conjunctive imperfect',
			'morphology.aspect.conjunctiveImperfect.description' => 'Imperfect with conjunctive waw, with a future or modal sense.',
			'morphology.aspect.conjunctiveImperfect.examples' => 'and he will write',
			'morphology.aspect.conjunctivePerfect.name' => 'Conjunctive perfect',
			'morphology.aspect.conjunctivePerfect.description' => 'Perfect with conjunctive waw, often future or sequential.',
			'morphology.aspect.conjunctivePerfect.examples' => 'and you shall do|and he will judge',
			'morphology.aspect.passiveParticiple.name' => 'Passive participle',
			'morphology.aspect.passiveParticiple.description' => 'The passive form of the qal participle.',
			'morphology.aspect.passiveParticiple.examples' => 'written|kept',
			'morphology.hebrewMood.jussive.name' => 'Jussive',
			'morphology.hebrewMood.jussive.description' => 'A 3rd-person command or wish.',
			'morphology.hebrewMood.jussive.examples' => 'Let there be light|May the LORD bless you',
			'morphology.hebrewMood.cohortative.name' => 'Cohortative',
			'morphology.hebrewMood.cohortative.description' => 'A 1st-person volitional, such as "let us" or "I will".',
			'morphology.hebrewMood.cohortative.examples' => 'Let us go|I will praise',
			'morphology.hebrewMood.hSuffix.name' => 'h-suffix',
			'morphology.hebrewMood.hSuffix.description' => 'An emphatic -ah ending on the imperfect, often cohortative-like.',
			'morphology.hebrewMood.hSuffix.examples' => 'I will surely come|let me draw near',
			'morphology.tense.present.name' => 'Present',
			'morphology.tense.present.description' => 'Ongoing or general action.',
			'morphology.tense.present.examples' => 'he loves|they walk',
			'morphology.tense.imperfect.name' => 'Imperfect',
			'morphology.tense.imperfect.description' => 'Continuous or repeated past action.',
			'morphology.tense.imperfect.examples' => 'he was teaching|they used to gather',
			'morphology.tense.future.name' => 'Future',
			'morphology.tense.future.description' => 'Action that will happen.',
			'morphology.tense.future.examples' => 'he will come|they shall see',
			'morphology.tense.aorist.name' => 'Aorist',
			'morphology.tense.aorist.description' => 'Simple past action viewed as a whole.',
			'morphology.tense.aorist.examples' => 'he said|they went',
			'morphology.tense.perfect.name' => 'Perfect',
			'morphology.tense.perfect.description' => 'Past action with a continuing present consequence.',
			'morphology.tense.perfect.examples' => 'has been written|has come',
			'morphology.tense.pluperfect.name' => 'Pluperfect',
			'morphology.tense.pluperfect.description' => 'Past action prior to another past event.',
			'morphology.tense.pluperfect.examples' => 'had been written|had departed',
			'morphology.mood.indicative.name' => 'Indicative',
			'morphology.mood.indicative.description' => 'States a fact.',
			'morphology.mood.indicative.examples' => 'he is|they wrote',
			'morphology.mood.imperative.name' => 'Imperative',
			'morphology.mood.imperative.description' => 'Issues a command.',
			'morphology.mood.imperative.examples' => 'Go!|Believe!|Do not fear!',
			'morphology.mood.subjunctive.name' => 'Subjunctive',
			'morphology.mood.subjunctive.description' => 'Expresses possibility, purpose, or contingency.',
			'morphology.mood.subjunctive.examples' => 'that he might write|if he goes',
			'morphology.mood.optative.name' => 'Optative',
			'morphology.mood.optative.description' => 'Expresses a wish or remote possibility.',
			'morphology.mood.optative.examples' => 'may it be so|may you have grace',
			'morphology.mood.infinitive.name' => 'Infinitive',
			'morphology.mood.infinitive.description' => 'A verbal noun, such as "to do".',
			'morphology.mood.infinitive.examples' => 'to write|to believe',
			'morphology.mood.participle.name' => 'Participle',
			'morphology.mood.participle.description' => 'A verbal adjective, such as "doing" or "having done".',
			'morphology.mood.participle.examples' => 'the one writing|having spoken',
			'morphology.voice.active.name' => 'Active',
			'morphology.voice.active.description' => 'The subject performs the action.',
			'morphology.voice.active.examples' => 'he writes|they teach',
			'morphology.voice.middle.name' => 'Middle',
			'morphology.voice.middle.description' => 'The subject acts on or for itself.',
			'morphology.voice.middle.examples' => 'he washes himself|they obtained for themselves',
			'morphology.voice.passive.name' => 'Passive',
			'morphology.voice.passive.description' => 'The subject receives the action.',
			'morphology.voice.passive.examples' => 'he was sent|they were taught',
			'morphology.voice.middleOrPassive.name' => 'Middle/Passive',
			'morphology.voice.middleOrPassive.description' => 'The form is ambiguous between middle and passive.',
			'morphology.voice.middleOrPassive.examples' => 'was raised / raised himself|was assembled / assembled themselves',
			'morphology.degree.positive.name' => 'Positive',
			'morphology.degree.positive.description' => 'The plain form, neither comparative nor superlative.',
			'morphology.degree.positive.examples' => 'great|good',
			'morphology.degree.comparative.name' => 'Comparative',
			'morphology.degree.comparative.description' => 'Compares two.',
			'morphology.degree.comparative.examples' => 'greater|better than',
			'morphology.degree.superlative.name' => 'Superlative',
			'morphology.degree.superlative.description' => 'Expresses the greatest degree.',
			'morphology.degree.superlative.examples' => 'greatest|best',
			'morphology.literals.rawCode' => 'The raw morphology code as it appeared in the source.',
			'morphology.literals.waw' => 'The Hebrew waw (וְ) conjunction, meaning "and".',
			'morphology.literals.conjunction' => 'A conjunction marker.',
			'morphology.literals.bet' => 'The Hebrew bet (בְּ) prefix preposition, meaning "in", "at", or "with".',
			'morphology.literals.kaf' => 'The Hebrew kaf (כְּ) prefix preposition, meaning "as" or "like".',
			'morphology.literals.lamed' => 'The Hebrew lamed (לְ) prefix preposition, meaning "to", "for", or "belonging to".',
			'morphology.literals.mem' => 'The Hebrew mem (מִן) prefix preposition, meaning "from" or "out of".',
			'morphology.literals.preposition' => 'A prefix preposition letter.',
			'morphology.literals.wawExamples' => 'and|now|but',
			'morphology.literals.betExamples' => 'in the beginning|with strength',
			'morphology.literals.kafExamples' => 'like a lion|as a shepherd',
			'morphology.literals.lamedExamples' => 'to David|for the king',
			'morphology.literals.memExamples' => 'from Egypt|out of the land',
			'settings.title' => 'Settings',
			'settings.customize' => 'Customize',
			'settings.pushNotifications' => 'Push Notifications',
			'settings.biblePlanReminders' => 'Bible Plan Reminders',
			'settings.notificationsNotRequested' => 'Turn on notifications',
			'settings.notificationsNotRequestedDescription' => 'Allow Lux to send notifications to manage your reminders.',
			'settings.notificationsDisabled' => 'Notifications are disabled',
			'settings.biblePlanRemindersDisabled' => 'Bible Plan Reminders are turned off.',
			'settings.verseOfTheDayRemindersDisabled' => 'Verse of the Day reminders are turned off.',
			'settings.notificationsDisabledDescription' => 'Enable them in your device settings to manage your reminders.',
			'settings.language' => 'Language',
			'settings.system' => 'System',
			'settings.systemLanguageDescription' => 'Match your system\'s locale.',
			'settings.toolbarPresets' => 'Toolbar Presets',
			'settings.toolbarPreset' => 'Toolbar Preset',
			'settings.presetWarning' => 'Selecting a preset will override the shortcuts in all your toolbars.',
			'settings.yourContent' => 'Your Content',
			'settings.discussionAndAnnouncements' => 'Discussion and announcements',
			'settings.tipsAndUpdates' => 'Tips and updates',
			'settings.supportLux' => 'Support Lux',
			'settings.rateLux' => 'Rate Lux',
			'settings.leaveReview' => 'Leave a review on the App Store.',
			'settings.supportMessage' => 'Lux is a passion project built on the conviction that Scripture should be freely available to all. The best way to support Lux is by leaving a review on the App Store.\n\nIf there is anything keeping you from leaving a 5-star review, please join our Discord and share your feedback so we can address it quickly.',
			'settings.leaveRating' => 'Leave a Rating',
			'settings.joinDiscord' => 'Join Discord',
			'settings.restartGetStarted' => 'Restart Get Started',
			'settings.restartGetStartedDescription' => 'Show the Get Started checklist again.',
			'settings.resetTutorials' => 'Reset Tutorials',
			'settings.resetTutorialsDescription' => 'Show helpful hints throughout the app again.',
			'settings.tutorialsReset' => 'Tutorials have been reset.',
			_ => null,
		};
	}
}
