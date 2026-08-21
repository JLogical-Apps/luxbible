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
class TranslationsRu extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsRu({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ru>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsRu _root = this; // ignore: unused_field

	@override 
	TranslationsRu $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsRu(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$languages$ru languages = _Translations$languages$ru._(_root);
	@override late final _Translations$highlightStyles$ru highlightStyles = _Translations$highlightStyles$ru._(_root);
	@override late final _Translations$colors$ru colors = _Translations$colors$ru._(_root);
	@override late final _Translations$testaments$ru testaments = _Translations$testaments$ru._(_root);
	@override late final _Translations$books$ru books = _Translations$books$ru._(_root);
	@override late final _Translations$common$ru common = _Translations$common$ru._(_root);
	@override late final _Translations$regionTypes$ru regionTypes = _Translations$regionTypes$ru._(_root);
	@override late final _Translations$mainActions$ru mainActions = _Translations$mainActions$ru._(_root);
	@override late final _Translations$verseOfTheDay$ru verseOfTheDay = _Translations$verseOfTheDay$ru._(_root);
	@override late final _Translations$studyActions$ru studyActions = _Translations$studyActions$ru._(_root);
	@override late final _Translations$selectionActions$ru selectionActions = _Translations$selectionActions$ru._(_root);
	@override late final _Translations$studyPanels$ru studyPanels = _Translations$studyPanels$ru._(_root);
	@override late final _Translations$bookmarks$ru bookmarks = _Translations$bookmarks$ru._(_root);
	@override late final _Translations$bookmarkPage$ru bookmarkPage = _Translations$bookmarkPage$ru._(_root);
	@override late final _Translations$commentaries$ru commentaries = _Translations$commentaries$ru._(_root);
	@override late final _Translations$toolbarShortcuts$ru toolbarShortcuts = _Translations$toolbarShortcuts$ru._(_root);
	@override late final _Translations$labels$ru labels = _Translations$labels$ru._(_root);
	@override late final _Translations$strongSheet$ru strongSheet = _Translations$strongSheet$ru._(_root);
	@override late final _Translations$bibleDetails$ru bibleDetails = _Translations$bibleDetails$ru._(_root);
	@override late final _Translations$emptyStates$ru emptyStates = _Translations$emptyStates$ru._(_root);
	@override late final _Translations$annotationUi$ru annotationUi = _Translations$annotationUi$ru._(_root);
	@override late final _Translations$notebookUi$ru notebookUi = _Translations$notebookUi$ru._(_root);
	@override late final _Translations$highlightStyleUi$ru highlightStyleUi = _Translations$highlightStyleUi$ru._(_root);
	@override late final _Translations$toolbarSettings$ru toolbarSettings = _Translations$toolbarSettings$ru._(_root);
	@override late final _Translations$themeSettings$ru themeSettings = _Translations$themeSettings$ru._(_root);
	@override late final _Translations$biblePlans$ru biblePlans = _Translations$biblePlans$ru._(_root);
	@override late final _Translations$searchUi$ru searchUi = _Translations$searchUi$ru._(_root);
	@override late final _Translations$onboarding$ru onboarding = _Translations$onboarding$ru._(_root);
	@override late final _Translations$tutorials$ru tutorials = _Translations$tutorials$ru._(_root);
	@override late final _Translations$audio$ru audio = _Translations$audio$ru._(_root);
	@override late final _Translations$interlinearUi$ru interlinearUi = _Translations$interlinearUi$ru._(_root);
	@override late final _Translations$chapterUnavailable$ru chapterUnavailable = _Translations$chapterUnavailable$ru._(_root);
	@override late final _Translations$verseNumbering$ru verseNumbering = _Translations$verseNumbering$ru._(_root);
	@override late final _Translations$compare$ru compare = _Translations$compare$ru._(_root);
	@override late final _Translations$commentaryUi$ru commentaryUi = _Translations$commentaryUi$ru._(_root);
	@override late final _Translations$searchLocations$ru searchLocations = _Translations$searchLocations$ru._(_root);
	@override late final _Translations$themeOptions$ru themeOptions = _Translations$themeOptions$ru._(_root);
	@override late final _Translations$toolbarPresets$ru toolbarPresets = _Translations$toolbarPresets$ru._(_root);
	@override late final _Translations$commentaryTypes$ru commentaryTypes = _Translations$commentaryTypes$ru._(_root);
	@override late final _Translations$strongDefinition$ru strongDefinition = _Translations$strongDefinition$ru._(_root);
	@override late final _Translations$planTypes$ru planTypes = _Translations$planTypes$ru._(_root);
	@override late final _Translations$onboardingSteps$ru onboardingSteps = _Translations$onboardingSteps$ru._(_root);
	@override late final _Translations$dictionary$ru dictionary = _Translations$dictionary$ru._(_root);
	@override late final _Translations$navigation$ru navigation = _Translations$navigation$ru._(_root);
	@override late final _Translations$selectionUi$ru selectionUi = _Translations$selectionUi$ru._(_root);
	@override late final _Translations$errors$ru errors = _Translations$errors$ru._(_root);
	@override late final _Translations$morphology$ru morphology = _Translations$morphology$ru._(_root);
	@override late final _Translations$settings$ru settings = _Translations$settings$ru._(_root);
}

// Path: languages
class _Translations$languages$ru extends Translations$languages$en {
	_Translations$languages$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get english => 'Английский';
	@override String get dutch => 'Нидерландский';
	@override String get greek => 'Греческий';
	@override String get hebrew => 'Иврит';
	@override String get russian => 'Русский';
}

// Path: highlightStyles
class _Translations$highlightStyles$ru extends Translations$highlightStyles$en {
	_Translations$highlightStyles$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get red => 'Красный';
	@override String get orange => 'Оранжевый';
	@override String get yellow => 'Желтый';
	@override String get green => 'Зеленый';
	@override String get blue => 'Синий';
	@override String get violet => 'Фиолетовый';
	@override String get underline => 'Подчёркивание';
	@override String get important => 'Важное';
	@override String get highlight => 'Выделение';
	@override String get squiggle => 'Волнистая линия';
}

// Path: colors
class _Translations$colors$ru extends Translations$colors$en {
	_Translations$colors$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get red => 'Красный';
	@override String get orange => 'Оранжевый';
	@override String get yellow => 'Желтый';
	@override String get green => 'Зеленый';
	@override String get blue => 'Синий';
	@override String get violet => 'Фиолетовый';
	@override String get silver => 'Серебряный';
}

// Path: testaments
class _Translations$testaments$ru extends Translations$testaments$en {
	_Translations$testaments$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get old => 'Ветхий Завет';
	@override String get newTestament => 'Новый Завет';
	@override String get oldOnly => 'Только Ветхий Завет';
	@override String get newOnly => 'Только Новый Завет';
	@override String get wholeBible => 'Вся Библия';
	@override String get oldOnlyDescription => 'Содержит только книги Ветхого Завета.';
	@override String get newOnlyDescription => 'Содержит только книги Нового Завета.';
	@override String get wholeBibleDescription => 'Содержит все книги Библии.';
}

// Path: books
class _Translations$books$ru extends Translations$books$en {
	_Translations$books$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get genesis => 'Бытие';
	@override String get exodus => 'Исход';
	@override String get leviticus => 'Левит';
	@override String get numbers => 'Числа';
	@override String get deuteronomy => 'Второзаконие';
	@override String get joshua => 'Иисус Навин';
	@override String get judges => 'Судьи';
	@override String get ruth => 'Руфь';
	@override String get samuel1 => '1 Царств';
	@override String get samuel2 => '2 Царств';
	@override String get kings1 => '3 Царств';
	@override String get kings2 => '4 Царств';
	@override String get chronicles1 => '1 Паралипоменон';
	@override String get chronicles2 => '2 Паралипоменон';
	@override String get ezra => 'Ездра';
	@override String get nehemiah => 'Неемия';
	@override String get esther => 'Есфирь';
	@override String get job => 'Иов';
	@override String get psalm => 'Псалом';
	@override String get psalms => 'Псалмы';
	@override String get proverbs => 'Притчи';
	@override String get ecclesiastes => 'Екклесиаст';
	@override String get songOfSolomon => 'Песнь песней';
	@override String get isaiah => 'Исаия';
	@override String get jeremiah => 'Иеремия';
	@override String get lamentations => 'Плач Иеремии';
	@override String get ezekiel => 'Иезекииль';
	@override String get daniel => 'Даниил';
	@override String get hosea => 'Осия';
	@override String get joel => 'Иоиль';
	@override String get amos => 'Амос';
	@override String get obadiah => 'Авдий';
	@override String get jonah => 'Иона';
	@override String get micah => 'Михей';
	@override String get nahum => 'Наум';
	@override String get habakkuk => 'Аввакум';
	@override String get zephaniah => 'Софония';
	@override String get haggai => 'Аггей';
	@override String get zechariah => 'Захария';
	@override String get malachi => 'Малахия';
	@override String get matthew => 'Матфей';
	@override String get mark => 'Марк';
	@override String get luke => 'Лука';
	@override String get john => 'Иоанн';
	@override String get acts => 'Деяния';
	@override String get romans => 'Римлянам';
	@override String get corinthians1 => '1 Коринфянам';
	@override String get corinthians2 => '2 Коринфянам';
	@override String get galatians => 'Галатам';
	@override String get ephesians => 'Ефесянам';
	@override String get philippians => 'Филиппийцам';
	@override String get colossians => 'Колоссянам';
	@override String get thessalonians1 => '1 Фессалоникийцам';
	@override String get thessalonians2 => '2 Фессалоникийцам';
	@override String get timothy1 => '1 Тимофею';
	@override String get timothy2 => '2 Тимофею';
	@override String get titus => 'Тит';
	@override String get philemon => 'Филимон';
	@override String get hebrews => 'Евреям';
	@override String get james => 'Иаков';
	@override String get peter1 => '1 Петра';
	@override String get peter2 => '2 Петра';
	@override String get john1 => '1 Иоанна';
	@override String get john2 => '2 Иоанна';
	@override String get john3 => '3 Иоанна';
	@override String get jude => 'Иуда';
	@override String get revelation => 'Откровение';
}

// Path: common
class _Translations$common$ru extends Translations$common$en {
	_Translations$common$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get add => 'Добавить';
	@override String get addNew => 'Добавить';
	@override String get am => 'ДП';
	@override String get cancel => 'Отмена';
	@override String get close => 'Закрыть';
	@override String get copy => 'Копировать';
	@override String get continueLabel => 'Продолжить';
	@override String get create => 'Создать';
	@override String get custom => 'Пользовательский';
	@override String get defaultLabel => 'По умолчанию';
	@override String get delete => 'Удалить';
	@override String get done => 'Готово';
	@override String get edit => 'Редактировать';
	@override String get finish => 'Завершить';
	@override String get learnMore => 'Узнать больше';
	@override String get nevermind => 'Неважно';
	@override String get next => 'Далее';
	@override String get noMatches => 'Нет совпадений';
	@override String get noNotification => 'Нет уведомления';
	@override String get ok => 'Хорошо';
	@override String get off => 'Выкл.';
	@override String get none => 'Нет';
	@override String get clear => 'Очистить';
	@override String get remove => 'Удалить';
	@override String get save => 'Сохранить';
	@override String get search => 'Поиск';
	@override String get select => 'Выбрать';
	@override String get show => 'Показать';
	@override String get hide => 'Скрыть';
	@override String get pm => 'ПП';
	@override String get sort => 'Сортировать';
	@override String get stop => 'Остановить';
	@override String get tryAgain => 'Попробуйте еще раз';
	@override String switchTo({required Object translation}) => 'Переключиться на ${translation}';
	@override String notAvailableIn({required Object translation}) => 'Это недоступно в ${translation}.';
}

// Path: regionTypes
class _Translations$regionTypes$ru extends Translations$regionTypes$en {
	_Translations$regionTypes$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get chapter => 'эта глава';
	@override String get verses => 'эти стихи';
	@override String get visibleVerses => 'видимые стихи';
	@override String get text => 'этот текст';
}

// Path: mainActions
class _Translations$mainActions$ru extends Translations$mainActions$en {
	_Translations$mainActions$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get pauseAudio => 'Пауза Аудио Библия';
	@override String get playAudio => 'Воспроизвести аудио Библию';
	@override String get bookmark => 'Закладка';
	@override String get study => 'Изучение';
	@override String get verseOfTheDay => 'Стих дня';
	@override String get addStudyPanel => 'Добавить панель исследования';
	@override String get search => 'Поиск';
	@override String get resources => 'Ресурсы';
	@override String get plans => 'Библейские планы';
	@override String get settings => 'Настройки';
	@override String get more => 'Ещё';
	@override String get audioDescription => 'Слушайте текущую главу с помощью Библии с поддержкой аудио.';
	@override String get bookmarkDescription => 'Добавьте эту главу в закладки, чтобы легко получить к ней доступ со страницы поиска.';
	@override String get manageBookmarkDescription => 'Управляйте этой закладкой.';
	@override String get studyDescription => 'Просмотрите инструменты обучения для этой главы.';
	@override String get verseOfTheDayDescription => 'Посмотрите сегодняшний стих.';
	@override String get verseOfTheDayLoading => 'Загрузка сегодняшнего стиха…';
	@override String get verseOfTheDayUnavailable => 'Не удалось загрузить сегодняшний стих.';
	@override String get studyPanelDescription => 'Прикрепите панель рядом с текстом, который следует по тексту и на котором показаны инструменты изучения того, что вы читаете.';
	@override String get searchDescription => 'Ищите слова в Библии.';
	@override String get resourcesDescription => 'Найдите слова в словаре и лексиконе.';
	@override String get plansDescription => 'Читайте Библию с помощью управляемых планов чтения.';
	@override String get settingsDescription => 'Откройте настройки Lux.';
	@override String get moreDescription => 'Просматривайте настройки, ваш контент и ссылки на сообщество.';
}

// Path: verseOfTheDay
class _Translations$verseOfTheDay$ru extends Translations$verseOfTheDay$en {
	_Translations$verseOfTheDay$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get reminderDiscoveryTitle => 'Добавить ежедневное напоминание?';
	@override String get reminderDiscoveryBody => 'Хотите, чтобы Lux ежедневно напоминал вам о стихе дня?';
	@override String get addReminder => 'Добавить напоминание';
	@override String get noReminder => 'Нет';
	@override String get dailyReminders => 'Ежедневное напоминание';
	@override String get deleteReminder => 'Удалить напоминание?';
	@override String get deleteReminderConfirmation => 'Удалить ежедневное напоминание о стихе дня?';
	@override String get reminderNotificationChannelName => 'Напоминания о стихе дня';
	@override String get reminderNotificationChannelDescription => 'Ежедневные напоминания о стихе дня';
	@override String get reminderNotificationTitle => 'Стих дня';
	@override String get reminderPermissionDeniedTitle => 'Уведомления отключены';
	@override String get reminderPermissionDeniedBody => 'Чтобы сохранить это напоминание, разрешите Lux отправлять уведомления в настройках.';
	@override String get openNotificationSettings => 'Открыть настройки';
	@override String get reminderSchedulingFailedTitle => 'Не удалось установить напоминание';
	@override String get reminderSchedulingFailedBody => 'Lux не удалось установить это напоминание. Повторите попытку.';
	@override String reminderSaved({required Object time}) => 'Ежедневное напоминание о стихе дня сохранено на ${time}.';
}

// Path: studyActions
class _Translations$studyActions$ru extends Translations$studyActions$en {
	_Translations$studyActions$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get quickStudy => 'Быстрое изучение';
	@override String get compare => 'Сравнивать';
	@override String get interlinear => 'Подстрочный';
	@override String get commentary => 'Комментарий';
	@override String get crossReferences => 'Перекрестные ссылки';
	@override String compareDescription({required Object region}) => 'Сравните ${region} в различных переводах.';
	@override String interlinearDescription({required Object region}) => 'Просмотрите лексическую разбивку ${region} с помощью Strong\'s.';
	@override String commentaryDescription({required Object region}) => 'Посмотреть комментарии ${region}.';
	@override String crossReferencesDescription({required Object region}) => 'Просмотрите перекрестные ссылки ${region}.';
	@override String get noCrossReferences => 'Перекрестных ссылок не найдено';
	@override String crossReferencesUse({required Object translation}) => 'В перекрестных ссылках используется ${translation}.';
	@override String get onlineCrossReferencesExplanation => 'Поскольку выбранный вами перевод доступен только в Интернете, перекрестные ссылки показаны с использованием последней версии Учебной Библии, которую вы использовали, чтобы сэкономить на производительности и затратах. Выбранный вами перевод используется повсюду в приложении.';
}

// Path: selectionActions
class _Translations$selectionActions$ru extends Translations$selectionActions$en {
	_Translations$selectionActions$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get annotate => 'Аннотировать';
	@override String get study => 'Изучать';
	@override String get copy => 'Копировать';
	@override String get highlight => 'Выделить';
	@override String get removeAnnotations => 'Удалить аннотации';
	@override String get interlinear => 'Подстрочник';
	@override String get search => 'Поиск';
	@override String get annotateVersesDescription => 'Прокомментируйте эти стихи.';
	@override String get studyVersesDescription => 'Изучите эти стихи.';
	@override String get copyVersesDescription => 'Скопируйте эти стихи в буфер обмена.';
	@override String get annotateTextDescription => 'Прокомментируйте этот текст.';
	@override String get interlinearTextDescription => 'Посмотрите лексическую разбивку этого текста.';
	@override String get searchTextDescription => 'Найдите в Библии этот текст.';
	@override String get copyTextDescription => 'Скопируйте этот текст в буфер обмена.';
	@override String removeTextAnnotationsDescription({required Object region}) => 'Удалите аннотации выделения текста из ${region}.';
	@override String highlightTextDescription({required Object region}) => 'Выделите ${region} последним использованным цветом.';
	@override String removeVerseAnnotationsDescription({required Object region}) => 'Удалите аннотации выбора стихов из ${region}.';
	@override String highlightVersesDescription({required Object region}) => 'Выделите ${region} последним использованным цветом.';
	@override String highlightedText({required Object reference}) => 'Выделенный текст в ${reference}.';
	@override String highlightedVerses({required Object reference}) => 'Выделен ${reference}.';
	@override String copiedVerses({required Object reference}) => '${reference} скопировано в буфер обмена.';
	@override String get copiedText => 'Выделенный текст скопирован в буфер обмена.';
	@override String get interlinearUnavailable => 'Подстрочный выбор текста доступен только в Учебных Библиях, которые разработаны с использованием дословных тегов Стронга и морфологических тегов. Чтобы использовать это действие, переключите свой перевод на Учебную Библию.';
	@override String get noInterlinearWords => 'В этой выборке не найдено подстрочных слов.';
	@override String textInReference({required Object reference}) => 'Текст в ${reference}';
}

// Path: studyPanels
class _Translations$studyPanels$ru extends Translations$studyPanels$en {
	_Translations$studyPanels$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Панель изучения';
	@override String get pinAsStudyPanel => 'Закрепить как панель изучения';
	@override String compareWith({required Object translation}) => 'Сравнение с ${translation}';
	@override String directionInterlinear({required Object direction}) => '${direction} подстрочник';
	@override String commentaryName({required Object commentary}) => 'Комментарий ${commentary}';
	@override String get notes => 'Примечания';
	@override String get noNotes => 'Заметки не найдены';
	@override String get notesDescription => 'Просматривайте свои заметки в видимых стихах.';
}

// Path: bookmarks
class _Translations$bookmarks$ru extends Translations$bookmarks$en {
	_Translations$bookmarks$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get create => 'Создать закладку';
	@override String get manage => 'Управление закладками';
	@override String get stopFollowing => 'Открепить';
	@override String get stopFollowingDescription => 'Не перемещать эту закладку вслед за текущей главой.';
	@override String get edit => 'Изменить закладку';
	@override String get delete => 'Удалить закладку';
	@override String get deleteConfirmation => 'Вы уверены, что хотите удалить эту закладку?';
	@override String deleteNamedConfirmation({required Object name}) => 'Вы уверены, что хотите удалить «${name}»?';
}

// Path: bookmarkPage
class _Translations$bookmarkPage$ru extends Translations$bookmarkPage$en {
	_Translations$bookmarkPage$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ваши закладки';
}

// Path: commentaries
class _Translations$commentaries$ru extends Translations$commentaries$en {
	_Translations$commentaries$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get addRemove => 'Добавить и удалить комментарии';
}

// Path: toolbarShortcuts
class _Translations$toolbarShortcuts$ru extends Translations$toolbarShortcuts$en {
	_Translations$toolbarShortcuts$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get switchBible => 'Переключить Библию';
	@override String get dictionary => 'Словарь';
	@override String get lexicon => 'Лексикон';
	@override String get themeAndLayout => 'Тема и макет';
	@override String get switchBibleDescription => 'Переключите перевод Библии.';
	@override String get dictionaryDescription => 'Ищите людей, места и темы в Библейском словаре Истона.';
	@override String get lexiconDescription => 'Изучите оригинальные еврейские и греческие слова с помощью «Лексикона Стронга».';
	@override String get themeAndLayoutDescription => 'Настройте тему и макет Библии.';
}

// Path: labels
class _Translations$labels$ru extends Translations$labels$en {
	_Translations$labels$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get about => 'О приложении';
	@override String get annotation => 'Аннотация';
	@override String get annotations => 'Аннотации';
	@override String get audioBible => 'Аудио Библия';
	@override String get bible => 'Библия';
	@override String get bibles => 'Библии';
	@override String get biblePlans => 'Библейские планы';
	@override String get bookmarks => 'Закладки';
	@override String get books => 'Книги';
	@override String get color => 'Цвет';
	@override String get commentaries => 'Комментарии';
	@override String get commentary => 'Комментарий';
	@override String get community => 'Сообщество';
	@override String get completed => 'Завершено';
	@override String get crossReferences => 'Перекрестные ссылки';
	@override String get days => 'Дни';
	@override String get dictionary => 'Словарь';
	@override String get discord => 'Discord';
	@override String get duration => 'Продолжительность';
	@override String get following => 'Активные';
	@override String get footnotes => 'Сноски';
	@override String get help => 'Помощь';
	@override String get highlightStyles => 'Стили выделения';
	@override String get instagram => 'Инстаграм';
	@override String get interlinear => 'Подстрочный';
	@override String get language => 'Язык';
	@override String get layout => 'Макет';
	@override String get lexicon => 'Лексикон';
	@override String get licenses => 'Лицензии';
	@override String get locations => 'Локации';
	@override String get name => 'Имя';
	@override String get note => 'Примечание';
	@override String get notebook => 'Блокнот';
	@override String get notebooks => 'Блокноты';
	@override String get notes => 'Примечания';
	@override String get paragraphs => 'Абзацы';
	@override String get resources => 'Ресурсы';
	@override String get scope => 'Объем';
	@override String get search => 'Поиск';
	@override String get selection => 'Выбор';
	@override String get settings => 'Настройки';
	@override String get source => 'Источник';
	@override String get study => 'Изучение';
	@override String get style => 'Стиль';
	@override String get text => 'Текст';
	@override String get toolbar => 'Панель инструментов';
	@override String get toolbars => 'Панели инструментов';
	@override String get type => 'Тип';
	@override String get version => 'Версия';
	@override String get visibility => 'Видимость';
}

// Path: strongSheet
class _Translations$strongSheet$ru extends Translations$strongSheet$en {
	_Translations$strongSheet$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get interlinearWord => 'Подстрочное слово';
	@override String get lexicon => 'Лексикон';
	@override String get legend => 'Легенда';
	@override String get openInSearch => 'Открыть в поиске';
	@override String get usage => 'Использование';
	@override String get inflected => 'измененный';
	@override String get transliteration => 'Транслитерация';
	@override String get root => 'Корень';
	@override String strongsId({required Object id}) => 'Стронга ${id}';
	@override String get rootWord => 'Корневое слово';
	@override String get pronunciation => 'Произношение';
	@override String get strongsDefinition => 'Определение Стронга';
	@override String get biblicalUsage => 'Библейское использование';
	@override String get definition => 'Определение';
	@override String get examples => 'Примеры';
	@override String get examplesPrefix => 'Примеры:';
	@override String get partOfSpeech => 'Часть речи';
	@override String get derivation => 'Вывод';
	@override String get morphology => 'Морфология';
	@override String get relatedTerms => 'Связанные термины';
	@override String get morphologyInfo => 'Информация о морфологии';
	@override String get definitionLegend => 'Легенда определения Стронга';
	@override String get optionalWord => 'Необязательное слово';
	@override String get optionalWordDescription => 'Отмечает слово или слог, который может быть дополнен основным словом.';
	@override String get addedWord => 'Добавлено слово на иврите или греческом языке.';
	@override String get addedWordDescription => 'Отмечает слово, включенное в английский перевод, даже если оно отсутствует в иврите или греческом языке.';
	@override String get explanation => 'Объяснение';
	@override String get renderingExplanation => 'Курсив в конце изображения объясняет отличие от обычной формы.';
	@override String get concordance => 'Согласие';
}

// Path: bibleDetails
class _Translations$bibleDetails$ru extends Translations$bibleDetails$en {
	_Translations$bibleDetails$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get onlineOnly => 'Только онлайн';
	@override String onlineDescription({required Object source}) => 'Эта Библия транслируется с ${source}, поэтому для нее требуется подключение к Интернету.';
	@override String get studyBible => 'Учебная Библия';
	@override String get audioBible => 'Аудио Библия';
	@override String get onDevice => 'На устройстве';
	@override String get onDeviceDescription => 'Эта Библия загружена на ваше устройство, поэтому вы можете искать ее и читать в автономном режиме.';
	@override String get studyBibleDescription => 'Включает подстрочные и морфологические данные. Нажмите и удерживайте любое слово во время чтения, чтобы увидеть оригинал на греческом или иврите.';
	@override String get readingBible => 'Библия для чтения';
	@override String get readingBibleDescription => 'Не включает подстрочные или морфологические данные.';
	@override String get nativeHeadings => 'Исходные заголовки';
	@override String get nativeHeadingsDescription => 'В эту Библию включены заголовки.';
	@override String get syntheticHeadings => 'Синтетические заголовки';
	@override String get syntheticHeadingsDescription => 'Заголовки синтетически вставлены в эту Библию из BSB.';
	@override String get noHeadings => 'Нет заголовков';
	@override String get noHeadingsDescription => 'В этой Библии нет заголовков.';
	@override String get audioSupportDescription => 'Поддерживает ли эта Библия аудиовоспроизведение.';
	@override String get redLetters => 'Красные буквы';
	@override String get redLettersDescription => 'Поддерживаются ли красные буквы в этой Библии.';
	@override String get footnotesDescription => 'Есть ли в этой Библии сноски.';
	@override String get paragraphsDescription => 'Включает ли эта Библия абзацы.';
	@override String get addRemoveBibles => 'Добавить и удалить Библии';
	@override String get verseNumbering => 'Нумерация стихов';
}

// Path: emptyStates
class _Translations$emptyStates$ru extends Translations$emptyStates$en {
	_Translations$emptyStates$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get noCommentaries => 'Комментарии не найдены';
	@override String get noMatchingWords => 'Нет подходящих слов';
	@override String get noMatchingTerms => 'Нет соответствующих условий';
	@override String get noMatchingPlans => 'Нет подходящих библейских планов.';
	@override String get noMatchingAnnotations => 'Нет соответствующих аннотаций.';
	@override String get noSearchResults => 'Результаты поиска не найдены';
	@override String get tryAnotherSearch => 'Попробуйте другой поиск';
	@override String get noCommentariesAdded => 'Вы не добавили ни одного комментария.';
	@override String get noAnnotations => 'Вы не создали ни одной аннотации.';
	@override String get noBookmarks => 'Вы не создали ни одной закладки.';
	@override String get noNotebooks => 'Вы не создали ни одного блокнота. Блокноты позволяют систематизировать ваши аннотации.';
	@override String get noPlans => 'Вы пока не выполняете ни одного плана чтения. Найдите один, чтобы начать читать Библию.';
}

// Path: annotationUi
class _Translations$annotationUi$ru extends Translations$annotationUi$en {
	_Translations$annotationUi$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get yourAnnotations => 'Ваши аннотации';
	@override String get annotate => 'Аннотировать';
	@override String get withNotes => 'С примечаниями';
	@override String get withoutNotes => 'Без примечаний';
	@override String get mostRecent => 'Самый последний';
	@override String get location => 'Расположение';
	@override String get deleteAnnotation => 'Удалить аннотацию';
	@override String get deleteConfirmation => 'Вы уверены, что хотите удалить эту аннотацию?';
	@override String annotationCount({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(count,
		one: '${count} аннотация',
		few: '${count} аннотации',
		many: '${count} аннотаций',
		other: '${count} аннотации',
	);
	@override String annotatedTime({required Object time}) => 'С аннотацией ${time}';
}

// Path: notebookUi
class _Translations$notebookUi$ru extends Translations$notebookUi$en {
	_Translations$notebookUi$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get yourNotebooks => 'Ваши блокноты';
	@override String get hidden => 'Скрытый';
	@override String get hideDescription => 'Скройте аннотации в этом блокноте, чтобы они не появлялись в Библии.';
	@override String get showDescription => 'Покажите аннотации из этой тетради в Библии.';
	@override String get defaultDescription => 'Постоянный блокнот для неназначенных аннотаций.';
	@override String get create => 'Создать блокнот';
	@override String get edit => 'Редактировать блокнот';
	@override String get delete => 'Удалить блокнот';
	@override String deleteNamedConfirmation({required Object name}) => 'Вы уверены, что хотите удалить «${name}»?';
	@override String deleteWithAnnotations({required Object name, required Object annotations}) => '«${name}» имеет ${annotations}. Хотите ли вы также удалить их или оставить в блокноте по умолчанию?';
	@override String get keepInDefault => 'Оставить по умолчанию';
	@override String get deleteAnnotations => 'Удалить аннотации';
}

// Path: highlightStyleUi
class _Translations$highlightStyleUi$ru extends Translations$highlightStyleUi$en {
	_Translations$highlightStyleUi$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get yourStyles => 'Ваши стили выделения';
	@override String get create => 'Создать стиль';
	@override String get edit => 'Редактировать стиль';
	@override String get duplicate => 'У вас уже есть этот стиль';
	@override String get delete => 'Удалить стиль';
	@override String deleteNamedConfirmation({required Object name}) => 'Вы уверены, что хотите удалить «${name}»?';
	@override String deleteWithAnnotations({required Object name, required Object annotations}) => '«${name}» имеет ${annotations}. Вы хотите их тоже удалить или оставить?';
	@override String get keepAnnotations => 'Сохранять аннотации';
	@override String get deleteAnnotations => 'Удалить аннотации';
	@override String get updateAnnotations => 'Обновить аннотации';
	@override String updateWithAnnotations({required Object name, required Object annotations}) => '«${name}» имеет ${annotations}. Хотите обновить их, чтобы использовать новый стиль, или оставить как есть?';
	@override String get leaveAsIs => 'Оставить как есть';
	@override String get label => 'Название';
}

// Path: toolbarSettings
class _Translations$toolbarSettings$ru extends Translations$toolbarSettings$en {
	_Translations$toolbarSettings$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get mainToolbar => 'Главная панель инструментов';
	@override String get verseSelection => 'Выбор стиха';
	@override String get textSelection => 'Выбор текста';
	@override String get shownForMain => 'Отображается, когда ничего не выбрано.';
	@override String get shownForVerses => 'Отображается, когда выбран стих.';
	@override String get shownForText => 'Отображается при длительном нажатии текста внутри стихов.';
	@override String get gestures => 'Жесты';
	@override String get longPress => 'Длительное нажатие';
	@override String get mainLongPressDescription => 'Ярлык при длительном нажатии на панель инструментов.';
	@override String get verseLongPressDescription => 'Ярлык при длительном нажатии выбора стиха.';
	@override String get textLongPressDescription => 'Ярлык при длительном нажатии на выделенный текст.';
	@override String get hideToolbar => 'Скрывать';
	@override String get hideToolbarDescription => 'Скройте панель инструментов при прокрутке вниз, чтобы получить захватывающий вид Библии.';
	@override String get pinToolbar => 'Закрепить';
	@override String get pinToolbarDescription => 'Закрепите панель инструментов внизу страницы.';
	@override String get expandToAnnotation => 'Развернуть до аннотации';
	@override String get expandTextDescription => 'Длительное нажатие на аннотированное слово выделяет весь выделенный диапазон.';
	@override String get expandVerseDescription => 'Нажатие на стих выбирает полный аннотированный стих.';
	@override String get rangeSelection => 'Выбор диапазона';
	@override String get rangeSelectionDescription => 'Нажатие на второй стих выбирает все стихи между ним и первым.';
	@override String get mainShortcut => 'Ярлык на главной панели инструментов';
	@override String get verseShortcut => 'Ярлык выбора стиха';
	@override String get textShortcut => 'Ярлык выбора текста';
}

// Path: themeSettings
class _Translations$themeSettings$ru extends Translations$themeSettings$en {
	_Translations$themeSettings$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Тема и макет';
	@override String get brightness => 'Яркость';
	@override String get font => 'Шрифт';
	@override String get fontSizeSpacing => 'Размер шрифта и интервал';
	@override String get greekFontSizeSpacing => 'Размер и интервал греческого шрифта';
	@override String get hebrewFontSizeSpacing => 'Размер и интервал ивритского шрифта';
	@override String get system => 'Система';
	@override String get systemTextSizeDescription => 'Используйте предпочтительный размер текста вашего устройства.';
	@override String get defaultSizeDescription => 'Используйте размер и интервал шрифта по умолчанию.';
	@override String get redLetters => 'Красные буквы';
	@override String get redLettersDescription => 'Покажите слова Иисуса красным цветом.';
	@override String get sectionHeadings => 'Заголовки разделов';
	@override String get verseNumbers => 'Номера стихов';
	@override String get paragraphsDescription => 'Разбейте стихи на абзацы.';
	@override String get footnotesDescription => 'Показывать маркеры сносок внутри текста.';
}

// Path: biblePlans
class _Translations$biblePlans$ru extends Translations$biblePlans$en {
	_Translations$biblePlans$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get find => 'Найдите библейский план';
	@override String get startPlanQuestion => 'Начать план?';
	@override String get reviewAndReflect => 'Обзор и размышление';
	@override String get startPlan => 'Начать план';
	@override String get dailyReminders => 'Ежедневные напоминания';
	@override String get dailyRemindersDescription => 'Установите или измените время ежедневного напоминания об этом плане.';
	@override String dailyAt({required Object time}) => 'Ежедневно в ${time}';
	@override String get reminderDiscoveryTitle => 'Добавить ежедневное напоминание?';
	@override String reminderDiscoveryBody({required Object name}) => 'Хотите, чтобы Lux ежедневно напоминал вам продолжить план «${name}»?';
	@override String get addReminder => 'Добавить напоминание';
	@override String get noReminder => 'Нет';
	@override String get deleteReminder => 'Удалить напоминание?';
	@override String deleteReminderConfirmation({required Object name}) => 'Вы уверены, что хотите удалить ежедневное напоминание для плана «${name}»?';
	@override String get reminderNotificationChannelName => 'Напоминания о библейских планах';
	@override String get reminderNotificationChannelDescription => 'Ежедневные напоминания о ваших библейских планах';
	@override String reminderNotificationTitle({required Object name}) => 'Прочитайте «${name}»';
	@override String reminderNotificationBody({required Object reading}) => 'Сегодняшнее чтение: ${reading}';
	@override String get reminderPermissionDeniedTitle => 'Уведомления отключены';
	@override String get reminderPermissionDeniedBody => 'Чтобы сохранить это напоминание, разрешите Lux отправлять уведомления в настройках.';
	@override String get openNotificationSettings => 'Открыть настройки';
	@override String get reminderSchedulingFailedTitle => 'Не удалось установить напоминание';
	@override String get reminderSchedulingFailedBody => 'Lux не удалось установить это напоминание. Повторите попытку.';
	@override String reminderSaved({required Object name, required Object time}) => 'Напоминание для плана «${name}» сохранено на ${time} каждый день.';
	@override String get stopPlan => 'Остановить план';
	@override String get stopPlanDescription => 'Удалите этот план и его ход.';
	@override String get readEntireChapter => 'Читать всю главу';
	@override String get readInContext => 'Читать в контексте';
	@override String get startNew => 'Начать заново';
	@override String day({required Object day}) => 'День ${day}';
	@override String dayCount({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(count,
		one: '${count} день',
		few: '${count} дня',
		many: '${count} дней',
		other: '${count} дня',
	);
	@override String stopConfirmation({required Object name}) => 'Вы уверены, что хотите остановить "${name}"? Ваш прогресс будет потерян.';
	@override String completed({required Object name}) => '«${name}» завершено.';
	@override String get addPlan => 'Добавить библейский план';
}

// Path: searchUi
class _Translations$searchUi$ru extends Translations$searchUi$en {
	_Translations$searchUi$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get searchBible => 'Поиск в Библии';
	@override String get startSearch => 'Начать поиск';
	@override String get searchPrompt => 'Введите ключевое слово, например свет, слово или мудрость, затем нажмите Enter на клавиатуре.';
	@override String usingTranslation({required Object translation}) => 'Использование ${translation} для поиска';
	@override String unsupportedTranslation({required Object translation}) => '${translation} в настоящее время не поддерживает поиск. Вместо этого используйте самую последнюю Учебную Библию.';
	@override String get wordOrPhraseHint => 'Поиск слова или фразы';
	@override String get wordHint => 'Поиск слова';
	@override String get strongNumberHint => 'Найдите номер Стронга (например, H125)';
}

// Path: onboarding
class _Translations$onboarding$ru extends Translations$onboarding$en {
	_Translations$onboarding$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get skipQuestion => 'Пропустить адаптацию?';
	@override String get skipConfirmation => 'Вы уверены, что хотите пропустить знакомство с приложением? Его можно запустить снова в разделе «Настройки» > «Справка».';
	@override String get getStarted => 'Начать';
	@override String get learnLux => 'Узнайте, как использовать Lux';
	@override String get checklistDescription => 'Заполните контрольный список ниже, чтобы узнать, как использовать Lux.';
	@override String get skipHint => 'Торопитесь? Нажмите ✕, чтобы пропустить.';
}

// Path: tutorials
class _Translations$tutorials$ru extends Translations$tutorials$en {
	_Translations$tutorials$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get dontShowAgain => 'Больше не показывать';
}

// Path: audio
class _Translations$audio$ru extends Translations$audio$en {
	_Translations$audio$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get timer => 'Аудио Таймер';
	@override String get fiveMinutes => '5 минут';
	@override String get tenMinutes => '10 минут';
	@override String get fifteenMinutes => '15 минут';
	@override String get thirtyMinutes => '30 минут';
	@override String get oneHour => '1 час';
	@override String get loadError => 'Не удалось загрузить аудио';
	@override String get connectionError => 'Проверьте подключение к Интернету или повторите попытку позже.';
	@override String get unavailable => 'Звук для этой Библии недоступен.';
	@override String get chooseBible => 'Чтобы прослушать эту главу, выберите Библию с аудиозаписью.';
	@override String get switchRequired => 'Чтобы прослушать этот отрывок, переключитесь на Библию с аудиозаписью.';
	@override String get rewindTenSeconds => 'На 10 секунд назад';
	@override String get fastForwardTenSeconds => 'На 10 секунд вперед';
	@override String get notificationChannelName => 'Аудио воспроизведение Библии';
	@override String get notificationChannelDescription => 'Элементы управления воспроизведением аудио Библии';
}

// Path: interlinearUi
class _Translations$interlinearUi$ru extends Translations$interlinearUi$en {
	_Translations$interlinearUi$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get interlinearBible => 'Подстрочная Библия';
	@override String get direction => 'Направление подстрочника';
	@override String get reverse => 'Обратное';
	@override String get forward => 'Вперед';
	@override String get reverseDescription => 'Слова появляются в английском порядке чтения.';
	@override String get forwardDescription => 'Слова появляются в исходном еврейском или греческом порядке.';
	@override String get studyBibleExplanation => 'Учебные Библии составлены с использованием дословных тегов Стронга и морфологических тегов, что делает возможной подстрочную лексическую разбивку. Вместо этого используйте самую последнюю Учебную Библию.';
	@override String usingTranslation({required Object translation}) => 'Использование ${translation} для подстрочного текста';
}

// Path: chapterUnavailable
class _Translations$chapterUnavailable$ru extends Translations$chapterUnavailable$en {
	_Translations$chapterUnavailable$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String title({required Object selectedTranslation, required Object testament}) => '${selectedTranslation} не включает ${testament}.';
	@override String subtitle({required Object testament, required Object fallbackTranslation}) => 'Показываем вашу последнюю ${testament} Библию, ${fallbackTranslation}.';
}

// Path: verseNumbering
class _Translations$verseNumbering$ru extends Translations$verseNumbering$en {
	_Translations$verseNumbering$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String referenceLabel({required Object translation, required Object reference}) => '${translation} ${reference}';
	@override String explanation({required Object translation, required Object reference, required Object originalReference}) => '${translation} нумерует главы и стихи иначе, чем в большинстве английских переводов.\n\nТекст, показанный здесь в ${reference}, взят из ${originalReference} в ${translation} и переназначен, чтобы соответствовать другим переводам.';
}

// Path: compare
class _Translations$compare$ru extends Translations$compare$en {
	_Translations$compare$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String unavailable({required Object translation}) => '${translation} не включает этот выбор.';
}

// Path: commentaryUi
class _Translations$commentaryUi$ru extends Translations$commentaryUi$en {
	_Translations$commentaryUi$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String introTo({required Object book}) => 'Знакомство с ${book}';
}

// Path: searchLocations
class _Translations$searchLocations$ru extends Translations$searchLocations$en {
	_Translations$searchLocations$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get currentBook => 'Текущая книга';
	@override String get testaments => 'Заветы';
	@override String get books => 'Книги';
}

// Path: themeOptions
class _Translations$themeOptions$ru extends Translations$themeOptions$en {
	_Translations$themeOptions$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get auto => 'Авто';
	@override String get light => 'Светлая';
	@override String get dark => 'Тёмная';
	@override String get extraTiny => 'Очень мелкий';
	@override String get tiny => 'Мелкий';
	@override String get small => 'Маленький';
	@override String get standard => 'Стандартный';
	@override String get large => 'Большой';
	@override String get huge => 'Огромный';
	@override String get extraHuge => 'Очень крупный';
	@override String get nativeAndSynthetic => 'Исходные и добавленные';
	@override String get native => 'Исходные';
	@override String get none => 'Нет';
	@override String get allHeadingsDescription => 'Покажите заголовки в переводах, которые их поддерживают, и синтетически вставляйте заголовки разделов BSB в английские переводы без них изначально.';
	@override String get nativeHeadingsDescription => 'Показывать заголовки в переводах, которые их поддерживают.';
	@override String get noHeadingsDescription => 'Не показывать заголовки разделов';
}

// Path: toolbarPresets
class _Translations$toolbarPresets$ru extends Translations$toolbarPresets$en {
	_Translations$toolbarPresets$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get reader => 'Читатель';
	@override String get noteTaker => 'Блокнот';
	@override String get studier => 'Студент';
	@override String get readerDescription => 'Настроен для чтения без отвлекающих факторов и быстрой навигации.';
	@override String get noteTakerDescription => 'Настроен для выделения и создания заметок.';
	@override String get studierDescription => 'Настроен на перекрестные ссылки, комментарии и глубокое изучение.';
}

// Path: commentaryTypes
class _Translations$commentaryTypes$ru extends Translations$commentaryTypes$en {
	_Translations$commentaryTypes$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get matthewHenryDescription => 'Краткий, религиозный комментарий ко всей Библии пуританской традиции. Теплый, практичный и легко читаемый.';
	@override String get jamiesonFaussetBrownDescription => 'Компактный, поэтапный комментарий ко всей Библии. Сбалансированный и доступный.';
	@override String get calvinDescription => 'Классическое изложение реформатора. Глубокий и доктринальный.';
}

// Path: strongDefinition
class _Translations$strongDefinition$ru extends Translations$strongDefinition$en {
	_Translations$strongDefinition$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get addedLabel => 'добавлен:';
	@override String get idiomLabel => 'идиома:';
	@override String get addedWord => 'Добавлено слово';
	@override String get idiomaticRendering => 'Идиоматический рендеринг';
	@override String get addedWordDescription => 'Отмечает слово, указанное рядом с определяемым еврейским или греческим словом.';
	@override String get idiomaticRenderingDescription => 'Отмечает перевод, который отражает выражение, характерное для иврита или греческого языка.';
}

// Path: planTypes
class _Translations$planTypes$ru extends Translations$planTypes$en {
	_Translations$planTypes$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get throughTheBible => 'Через Библию';
	@override String get chronological => 'Один год в хронологическом порядке';
	@override String get oldAndNewTestament => 'Ветхий и Новый Завет';
	@override String get everyDayInTheWord => 'Каждый день в слове';
	@override String get mcheyne => 'М\'Чейн';
	@override String get literaryStudy => 'Литературное исследование';
	@override String get differentTopics => 'Разные темы';
	@override String get newTestamentPsalmsProverbs => 'Новый Завет, Псалмы и Притчи';
	@override String get fiveByFiveByFive => '5x5x5 Новый Завет';
	@override String get gospelsAndEpistles => 'Евангелие и послания';
	@override String get pentateuchAndHistory => 'Пятикнижие и история Израиля';
	@override String get chroniclesAndProphets => 'Летописи и Пророки';
	@override String get psalmsAndWisdom => 'Псалмы и литература мудрости';
	@override String get mcheyneDescription => 'Классический план с четырьмя короткими чтениями в день. Вы читаете Ветхий Завет один раз, а Новый Завет и Псалмы — два раза в год.';
	@override String get chronologicalDescription => 'Прочитайте всю Библию за год, расположив ее в том порядке, в котором события действительно произошли.';
	@override String get throughTheBibleDescription => 'Прочтите всю Библию за год, от Бытия до Откровения.';
	@override String get gospelsAndEpistlesDescription => 'Проведите год в Новом Завете, путешествуя по Евангелиям и посланиям апостолов.';
	@override String get everyDayInTheWordDescription => 'Четыре чтения в день Ветхого Завета, Нового Завета, Псалмов и Притчей, охватывающих всю Библию за год, плюс Псалмы и Притчи дважды.';
	@override String get literaryStudyDescription => 'Изучите Библию в течение года, сгруппированную по литературным стилям, проходя через рассказы, поэзию и письма.';
	@override String get chroniclesAndProphetsDescription => 'Год, в котором история Хроник сочетается с посланиями Пророков.';
	@override String get pentateuchAndHistoryDescription => 'Путешествие по пяти книгам Моисея и истории Израиля за год.';
	@override String get psalmsAndWisdomDescription => 'Проведите год за чтением псалмов и книг мудрости, таких как Притчи, Иов и Экклезиаст.';
	@override String get oldAndNewTestamentDescription => 'Читайте вместе Ветхий и Новый Заветы, каждый день по отрывку из каждого.';
	@override String get differentTopicsDescription => 'Каждый день просматривайте разные разделы Священного Писания, исследуя каждую книгу Библии в течение года.';
	@override String get newTestamentPsalmsProverbsDescription => 'Читайте Новый Завет вместе с Псалмами и Притчами в течение года.';
	@override String get fiveByFiveByFiveDescription => 'Читайте по одной главе Нового Завета в день, пять дней в неделю, а затем два дня для повторения и размышления.';
	@override String get oldScopeDescription => 'Читает книги Ветхого Завета.';
	@override String get newScopeDescription => 'Читает книги Нового Завета.';
	@override String get wholeScopeDescription => 'Читает как Ветхий, так и Новый Завет.';
	@override String get focused => 'Сосредоточенный';
	@override String get comprehensive => 'Всесторонний';
	@override String get focusedDescription => 'Охватывает определенный раздел или коллекцию в пределах своей области действия.';
	@override String get comprehensiveDescription => 'Охватывает каждую книгу в пределах своей компетенции.';
}

// Path: onboardingSteps
class _Translations$onboardingSteps$ru extends Translations$onboardingSteps$en {
	_Translations$onboardingSteps$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get viewCrossReferences => 'Просмотр перекрестных ссылок';
	@override String get annotateVerse => 'Комментировать стих';
	@override String get searchWord => 'Поиск слова';
	@override String get switchBible => 'Переключите свою Библию';
	@override String get navigateChapter => 'Перейти в другую главу';
	@override String get goBack => 'Возвращаться';
	@override String get swipeChapter => 'Проведите пальцем по экрану, чтобы изменить главу';
	@override String get addStudyPanel => 'Добавить панель исследований';
	@override String get customizeToolbar => 'Настройте свои панели инструментов';
	@override String get startBiblePlan => 'Начать библейский план';
	@override String get selectVerse => 'Коснитесь стиха, чтобы выбрать его.';
	@override String get selectWord => 'Длительное нажатие слова';
	@override String get deselectPrefix => 'Нажмите';
	@override String get deselectSuffix => 'рядом с вашим выбором, чтобы отменить выбор';
	@override String get revealToolbar => 'Прокрутите вверх, чтобы открыть главную панель инструментов.';
	@override String get addPanelPrefix => 'Нажмите';
	@override String get addPanelSuffix => ' → Исследование → Добавить панель исследований и добавьте любую панель исследований.';
	@override String get goToChapter => 'Перейти в другую главу';
	@override String get openPrefix => 'Открыть';
	@override String get crossReferencesSuffix => '→ Исследование → Перекрестные ссылки';
	@override String get annotatePrefix => 'Нажмите';
	@override String get annotateSuffix => 'выделить или добавить заметку';
	@override String get searchPrefix => 'Нажмите';
	@override String get searchSuffix => 'искать это слово повсюду';
	@override String switchBibleDescription({required Object translation}) => 'Коснитесь главной панели инструментов → ${translation}, чтобы переключить Библию.';
	@override String get goToChapterDescription => 'Коснитесь главной панели инструментов, чтобы перейти к другой главе.';
	@override String get goBackDescription => 'Проведите пальцем вправо по панели инструментов, чтобы вернуться назад.';
	@override String get swipeChapterDescription => 'Проведите по Библии влево или вправо, чтобы изменить главу.';
	@override String get viewPanelDescription => 'Проведите пальцем по этой панели вправо, чтобы просмотреть панель исследования.';
	@override String get moreSeparator => ' → Ещё → ';
	@override String get customizeToolbarSuffix => 'Панели инструментов: выберите предустановку или измените ярлыки панели инструментов.';
	@override String get startPlanSuffix => '→ Библейские планы и начните любой библейский план';
}

// Path: dictionary
class _Translations$dictionary$ru extends Translations$dictionary$en {
	_Translations$dictionary$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get eastons => 'Библейский словарь Истона';
}

// Path: navigation
class _Translations$navigation$ru extends Translations$navigation$en {
	_Translations$navigation$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get recents => 'Недавние';
	@override String get navigate => 'Навигация';
	@override String get book => 'Книга';
	@override String get chapter => 'Глава';
	@override String get verse => 'Стих';
}

// Path: selectionUi
class _Translations$selectionUi$ru extends Translations$selectionUi$en {
	_Translations$selectionUi$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get selected => 'Выбрано:';
	@override String get sourceApiBible => 'Источник: [https://api.bible](https://api.bible).';
}

// Path: errors
class _Translations$errors$ru extends Translations$errors$en {
	_Translations$errors$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get deviceVerificationFailed => 'Проверка устройства не удалась';
	@override String get deviceVerificationDescription => 'Для доступа к этой онлайн-Библии требуется действующее устройство и законная установка Lux. Убедитесь, что вы установили Lux из официального магазина приложений, а затем повторите попытку.';
	@override String get generic => 'Что-то пошло не так';
	@override String get connection => 'Проверьте подключение к Интернету или повторите попытку позже.';
}

// Path: morphology
class _Translations$morphology$ru extends Translations$morphology$en {
	_Translations$morphology$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$attributes$ru attributes = _Translations$morphology$attributes$ru._(_root);
	@override late final _Translations$morphology$types$ru types = _Translations$morphology$types$ru._(_root);
	@override late final _Translations$morphology$person$ru person = _Translations$morphology$person$ru._(_root);
	@override late final _Translations$morphology$gender$ru gender = _Translations$morphology$gender$ru._(_root);
	@override late final _Translations$morphology$number$ru number = _Translations$morphology$number$ru._(_root);
	@override late final _Translations$morphology$kCase$ru kCase = _Translations$morphology$kCase$ru._(_root);
	@override late final _Translations$morphology$state$ru state = _Translations$morphology$state$ru._(_root);
	@override late final _Translations$morphology$stem$ru stem = _Translations$morphology$stem$ru._(_root);
	@override late final _Translations$morphology$aspect$ru aspect = _Translations$morphology$aspect$ru._(_root);
	@override late final _Translations$morphology$hebrewMood$ru hebrewMood = _Translations$morphology$hebrewMood$ru._(_root);
	@override late final _Translations$morphology$tense$ru tense = _Translations$morphology$tense$ru._(_root);
	@override late final _Translations$morphology$mood$ru mood = _Translations$morphology$mood$ru._(_root);
	@override late final _Translations$morphology$voice$ru voice = _Translations$morphology$voice$ru._(_root);
	@override late final _Translations$morphology$degree$ru degree = _Translations$morphology$degree$ru._(_root);
	@override late final _Translations$morphology$literals$ru literals = _Translations$morphology$literals$ru._(_root);
}

// Path: settings
class _Translations$settings$ru extends Translations$settings$en {
	_Translations$settings$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Настройки';
	@override String get customize => 'Настроить';
	@override String get pushNotifications => 'Push-уведомления';
	@override String get biblePlanReminders => 'Напоминания о библейских планах';
	@override String get notificationsNotRequested => 'Включите уведомления.';
	@override String get notificationsNotRequestedDescription => 'Разрешите Lux отправлять уведомления, чтобы управлять напоминаниями.';
	@override String get notificationsDisabled => 'Уведомления для Lux отключены.';
	@override String get biblePlanRemindersDisabled => 'Напоминания о библейских планах отключены.';
	@override String get verseOfTheDayRemindersDisabled => 'Напоминания о стихе дня отключены.';
	@override String get notificationsDisabledDescription => 'Включите их в настройках устройства, чтобы управлять напоминаниями.';
	@override String get language => 'Язык';
	@override String get system => 'Система';
	@override String get systemLanguageDescription => 'Использовать язык системы.';
	@override String get toolbarPresets => 'Наборы панелей инструментов';
	@override String get toolbarPreset => 'Набор панели инструментов';
	@override String get presetWarning => 'Выбор набора заменит ярлыки на всех панелях инструментов.';
	@override String get yourContent => 'Ваш контент';
	@override String get discussionAndAnnouncements => 'Обсуждение и анонсы';
	@override String get tipsAndUpdates => 'Советы и обновления';
	@override String get supportLux => 'Поддержать Lux';
	@override String get rateLux => 'Оценить Lux';
	@override String get leaveReview => 'Оставить отзыв в App Store.';
	@override String get supportMessage => 'Lux создан с убеждением, что Священное Писание должно быть доступно каждому. Лучший способ поддержать Lux — оставить отзыв в App Store.\n\nЕсли что-то мешает вам поставить 5 звёзд, присоединитесь к нашему Discord и расскажите об этом, чтобы мы могли быстро решить проблему.';
	@override String get leaveRating => 'Оставить оценку';
	@override String get joinDiscord => 'Присоединиться к Discord';
	@override String get restartGetStarted => 'Начать знакомство заново';
	@override String get restartGetStartedDescription => 'Снова показать контрольный список знакомства с приложением.';
	@override String get resetTutorials => 'Сбросить подсказки';
	@override String get resetTutorialsDescription => 'Снова показывать полезные подсказки в приложении.';
	@override String get tutorialsReset => 'Подсказки сброшены.';
}

// Path: morphology.attributes
class _Translations$morphology$attributes$ru extends Translations$morphology$attributes$en {
	_Translations$morphology$attributes$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$attributes$type$ru type = _Translations$morphology$attributes$type$ru._(_root);
	@override late final _Translations$morphology$attributes$grammaticalCase$ru grammaticalCase = _Translations$morphology$attributes$grammaticalCase$ru._(_root);
	@override late final _Translations$morphology$attributes$gender$ru gender = _Translations$morphology$attributes$gender$ru._(_root);
	@override late final _Translations$morphology$attributes$number$ru number = _Translations$morphology$attributes$number$ru._(_root);
	@override late final _Translations$morphology$attributes$person$ru person = _Translations$morphology$attributes$person$ru._(_root);
	@override late final _Translations$morphology$attributes$state$ru state = _Translations$morphology$attributes$state$ru._(_root);
	@override late final _Translations$morphology$attributes$tense$ru tense = _Translations$morphology$attributes$tense$ru._(_root);
	@override late final _Translations$morphology$attributes$mood$ru mood = _Translations$morphology$attributes$mood$ru._(_root);
	@override late final _Translations$morphology$attributes$voice$ru voice = _Translations$morphology$attributes$voice$ru._(_root);
	@override late final _Translations$morphology$attributes$degree$ru degree = _Translations$morphology$attributes$degree$ru._(_root);
	@override late final _Translations$morphology$attributes$stem$ru stem = _Translations$morphology$attributes$stem$ru._(_root);
	@override late final _Translations$morphology$attributes$aspect$ru aspect = _Translations$morphology$attributes$aspect$ru._(_root);
	@override late final _Translations$morphology$attributes$prefix$ru prefix = _Translations$morphology$attributes$prefix$ru._(_root);
	@override late final _Translations$morphology$attributes$particle$ru particle = _Translations$morphology$attributes$particle$ru._(_root);
	@override late final _Translations$morphology$attributes$code$ru code = _Translations$morphology$attributes$code$ru._(_root);
}

// Path: morphology.types
class _Translations$morphology$types$ru extends Translations$morphology$types$en {
	_Translations$morphology$types$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$types$article$ru article = _Translations$morphology$types$article$ru._(_root);
	@override late final _Translations$morphology$types$conjunction$ru conjunction = _Translations$morphology$types$conjunction$ru._(_root);
	@override late final _Translations$morphology$types$preposition$ru preposition = _Translations$morphology$types$preposition$ru._(_root);
	@override late final _Translations$morphology$types$adverb$ru adverb = _Translations$morphology$types$adverb$ru._(_root);
	@override late final _Translations$morphology$types$negativeAdverb$ru negativeAdverb = _Translations$morphology$types$negativeAdverb$ru._(_root);
	@override late final _Translations$morphology$types$adjective$ru adjective = _Translations$morphology$types$adjective$ru._(_root);
	@override late final _Translations$morphology$types$noun$ru noun = _Translations$morphology$types$noun$ru._(_root);
	@override late final _Translations$morphology$types$properNoun$ru properNoun = _Translations$morphology$types$properNoun$ru._(_root);
	@override late final _Translations$morphology$types$number$ru number = _Translations$morphology$types$number$ru._(_root);
	@override late final _Translations$morphology$types$ordinalNumber$ru ordinalNumber = _Translations$morphology$types$ordinalNumber$ru._(_root);
	@override late final _Translations$morphology$types$pronoun$ru pronoun = _Translations$morphology$types$pronoun$ru._(_root);
	@override late final _Translations$morphology$types$personalPronoun$ru personalPronoun = _Translations$morphology$types$personalPronoun$ru._(_root);
	@override late final _Translations$morphology$types$demonstrativePronoun$ru demonstrativePronoun = _Translations$morphology$types$demonstrativePronoun$ru._(_root);
	@override late final _Translations$morphology$types$interrogativePronoun$ru interrogativePronoun = _Translations$morphology$types$interrogativePronoun$ru._(_root);
	@override late final _Translations$morphology$types$indefinitePronoun$ru indefinitePronoun = _Translations$morphology$types$indefinitePronoun$ru._(_root);
	@override late final _Translations$morphology$types$reciprocalPronoun$ru reciprocalPronoun = _Translations$morphology$types$reciprocalPronoun$ru._(_root);
	@override late final _Translations$morphology$types$reflexivePronoun$ru reflexivePronoun = _Translations$morphology$types$reflexivePronoun$ru._(_root);
	@override late final _Translations$morphology$types$relativePronoun$ru relativePronoun = _Translations$morphology$types$relativePronoun$ru._(_root);
	@override late final _Translations$morphology$types$particle$ru particle = _Translations$morphology$types$particle$ru._(_root);
	@override late final _Translations$morphology$types$negativeParticle$ru negativeParticle = _Translations$morphology$types$negativeParticle$ru._(_root);
	@override late final _Translations$morphology$types$interrogativeParticle$ru interrogativeParticle = _Translations$morphology$types$interrogativeParticle$ru._(_root);
	@override late final _Translations$morphology$types$demonstrativeParticle$ru demonstrativeParticle = _Translations$morphology$types$demonstrativeParticle$ru._(_root);
	@override late final _Translations$morphology$types$genericParticle$ru genericParticle = _Translations$morphology$types$genericParticle$ru._(_root);
	@override late final _Translations$morphology$types$relativeParticle$ru relativeParticle = _Translations$morphology$types$relativeParticle$ru._(_root);
	@override late final _Translations$morphology$types$verb$ru verb = _Translations$morphology$types$verb$ru._(_root);
	@override late final _Translations$morphology$types$pronominalSuffix$ru pronominalSuffix = _Translations$morphology$types$pronominalSuffix$ru._(_root);
	@override late final _Translations$morphology$types$directObjectMarker$ru directObjectMarker = _Translations$morphology$types$directObjectMarker$ru._(_root);
	@override late final _Translations$morphology$types$punctuation$ru punctuation = _Translations$morphology$types$punctuation$ru._(_root);
	@override late final _Translations$morphology$types$interjection$ru interjection = _Translations$morphology$types$interjection$ru._(_root);
	@override late final _Translations$morphology$types$indeclinable$ru indeclinable = _Translations$morphology$types$indeclinable$ru._(_root);
	@override late final _Translations$morphology$types$hebraism$ru hebraism = _Translations$morphology$types$hebraism$ru._(_root);
	@override late final _Translations$morphology$types$unknown$ru unknown = _Translations$morphology$types$unknown$ru._(_root);
}

// Path: morphology.person
class _Translations$morphology$person$ru extends Translations$morphology$person$en {
	_Translations$morphology$person$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$person$first$ru first = _Translations$morphology$person$first$ru._(_root);
	@override late final _Translations$morphology$person$second$ru second = _Translations$morphology$person$second$ru._(_root);
	@override late final _Translations$morphology$person$third$ru third = _Translations$morphology$person$third$ru._(_root);
}

// Path: morphology.gender
class _Translations$morphology$gender$ru extends Translations$morphology$gender$en {
	_Translations$morphology$gender$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$gender$masculine$ru masculine = _Translations$morphology$gender$masculine$ru._(_root);
	@override late final _Translations$morphology$gender$feminine$ru feminine = _Translations$morphology$gender$feminine$ru._(_root);
	@override late final _Translations$morphology$gender$neuter$ru neuter = _Translations$morphology$gender$neuter$ru._(_root);
	@override late final _Translations$morphology$gender$common$ru common = _Translations$morphology$gender$common$ru._(_root);
}

// Path: morphology.number
class _Translations$morphology$number$ru extends Translations$morphology$number$en {
	_Translations$morphology$number$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$number$singular$ru singular = _Translations$morphology$number$singular$ru._(_root);
	@override late final _Translations$morphology$number$plural$ru plural = _Translations$morphology$number$plural$ru._(_root);
	@override late final _Translations$morphology$number$dual$ru dual = _Translations$morphology$number$dual$ru._(_root);
}

// Path: morphology.kCase
class _Translations$morphology$kCase$ru extends Translations$morphology$kCase$en {
	_Translations$morphology$kCase$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$kCase$nominative$ru nominative = _Translations$morphology$kCase$nominative$ru._(_root);
	@override late final _Translations$morphology$kCase$genitive$ru genitive = _Translations$morphology$kCase$genitive$ru._(_root);
	@override late final _Translations$morphology$kCase$dative$ru dative = _Translations$morphology$kCase$dative$ru._(_root);
	@override late final _Translations$morphology$kCase$accusative$ru accusative = _Translations$morphology$kCase$accusative$ru._(_root);
	@override late final _Translations$morphology$kCase$vocative$ru vocative = _Translations$morphology$kCase$vocative$ru._(_root);
}

// Path: morphology.state
class _Translations$morphology$state$ru extends Translations$morphology$state$en {
	_Translations$morphology$state$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$state$absolute$ru absolute = _Translations$morphology$state$absolute$ru._(_root);
	@override late final _Translations$morphology$state$construct$ru construct = _Translations$morphology$state$construct$ru._(_root);
	@override late final _Translations$morphology$state$determined$ru determined = _Translations$morphology$state$determined$ru._(_root);
}

// Path: morphology.stem
class _Translations$morphology$stem$ru extends Translations$morphology$stem$en {
	_Translations$morphology$stem$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$stem$qal$ru qal = _Translations$morphology$stem$qal$ru._(_root);
	@override late final _Translations$morphology$stem$qalPassive$ru qalPassive = _Translations$morphology$stem$qalPassive$ru._(_root);
	@override late final _Translations$morphology$stem$niphal$ru niphal = _Translations$morphology$stem$niphal$ru._(_root);
	@override late final _Translations$morphology$stem$piel$ru piel = _Translations$morphology$stem$piel$ru._(_root);
	@override late final _Translations$morphology$stem$pual$ru pual = _Translations$morphology$stem$pual$ru._(_root);
	@override late final _Translations$morphology$stem$hiphil$ru hiphil = _Translations$morphology$stem$hiphil$ru._(_root);
	@override late final _Translations$morphology$stem$hophal$ru hophal = _Translations$morphology$stem$hophal$ru._(_root);
	@override late final _Translations$morphology$stem$hithpael$ru hithpael = _Translations$morphology$stem$hithpael$ru._(_root);
	@override late final _Translations$morphology$stem$nithpael$ru nithpael = _Translations$morphology$stem$nithpael$ru._(_root);
}

// Path: morphology.aspect
class _Translations$morphology$aspect$ru extends Translations$morphology$aspect$en {
	_Translations$morphology$aspect$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$aspect$perfect$ru perfect = _Translations$morphology$aspect$perfect$ru._(_root);
	@override late final _Translations$morphology$aspect$imperfect$ru imperfect = _Translations$morphology$aspect$imperfect$ru._(_root);
	@override late final _Translations$morphology$aspect$imperative$ru imperative = _Translations$morphology$aspect$imperative$ru._(_root);
	@override late final _Translations$morphology$aspect$infinitiveConstruct$ru infinitiveConstruct = _Translations$morphology$aspect$infinitiveConstruct$ru._(_root);
	@override late final _Translations$morphology$aspect$infinitiveAbsolute$ru infinitiveAbsolute = _Translations$morphology$aspect$infinitiveAbsolute$ru._(_root);
	@override late final _Translations$morphology$aspect$participle$ru participle = _Translations$morphology$aspect$participle$ru._(_root);
	@override late final _Translations$morphology$aspect$consecutiveImperfect$ru consecutiveImperfect = _Translations$morphology$aspect$consecutiveImperfect$ru._(_root);
	@override late final _Translations$morphology$aspect$conjunctiveImperfect$ru conjunctiveImperfect = _Translations$morphology$aspect$conjunctiveImperfect$ru._(_root);
	@override late final _Translations$morphology$aspect$conjunctivePerfect$ru conjunctivePerfect = _Translations$morphology$aspect$conjunctivePerfect$ru._(_root);
	@override late final _Translations$morphology$aspect$passiveParticiple$ru passiveParticiple = _Translations$morphology$aspect$passiveParticiple$ru._(_root);
}

// Path: morphology.hebrewMood
class _Translations$morphology$hebrewMood$ru extends Translations$morphology$hebrewMood$en {
	_Translations$morphology$hebrewMood$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$hebrewMood$jussive$ru jussive = _Translations$morphology$hebrewMood$jussive$ru._(_root);
	@override late final _Translations$morphology$hebrewMood$cohortative$ru cohortative = _Translations$morphology$hebrewMood$cohortative$ru._(_root);
	@override late final _Translations$morphology$hebrewMood$hSuffix$ru hSuffix = _Translations$morphology$hebrewMood$hSuffix$ru._(_root);
}

// Path: morphology.tense
class _Translations$morphology$tense$ru extends Translations$morphology$tense$en {
	_Translations$morphology$tense$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$tense$present$ru present = _Translations$morphology$tense$present$ru._(_root);
	@override late final _Translations$morphology$tense$imperfect$ru imperfect = _Translations$morphology$tense$imperfect$ru._(_root);
	@override late final _Translations$morphology$tense$future$ru future = _Translations$morphology$tense$future$ru._(_root);
	@override late final _Translations$morphology$tense$aorist$ru aorist = _Translations$morphology$tense$aorist$ru._(_root);
	@override late final _Translations$morphology$tense$perfect$ru perfect = _Translations$morphology$tense$perfect$ru._(_root);
	@override late final _Translations$morphology$tense$pluperfect$ru pluperfect = _Translations$morphology$tense$pluperfect$ru._(_root);
}

// Path: morphology.mood
class _Translations$morphology$mood$ru extends Translations$morphology$mood$en {
	_Translations$morphology$mood$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$mood$indicative$ru indicative = _Translations$morphology$mood$indicative$ru._(_root);
	@override late final _Translations$morphology$mood$imperative$ru imperative = _Translations$morphology$mood$imperative$ru._(_root);
	@override late final _Translations$morphology$mood$subjunctive$ru subjunctive = _Translations$morphology$mood$subjunctive$ru._(_root);
	@override late final _Translations$morphology$mood$optative$ru optative = _Translations$morphology$mood$optative$ru._(_root);
	@override late final _Translations$morphology$mood$infinitive$ru infinitive = _Translations$morphology$mood$infinitive$ru._(_root);
	@override late final _Translations$morphology$mood$participle$ru participle = _Translations$morphology$mood$participle$ru._(_root);
}

// Path: morphology.voice
class _Translations$morphology$voice$ru extends Translations$morphology$voice$en {
	_Translations$morphology$voice$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$voice$active$ru active = _Translations$morphology$voice$active$ru._(_root);
	@override late final _Translations$morphology$voice$middle$ru middle = _Translations$morphology$voice$middle$ru._(_root);
	@override late final _Translations$morphology$voice$passive$ru passive = _Translations$morphology$voice$passive$ru._(_root);
	@override late final _Translations$morphology$voice$middleOrPassive$ru middleOrPassive = _Translations$morphology$voice$middleOrPassive$ru._(_root);
}

// Path: morphology.degree
class _Translations$morphology$degree$ru extends Translations$morphology$degree$en {
	_Translations$morphology$degree$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$morphology$degree$positive$ru positive = _Translations$morphology$degree$positive$ru._(_root);
	@override late final _Translations$morphology$degree$comparative$ru comparative = _Translations$morphology$degree$comparative$ru._(_root);
	@override late final _Translations$morphology$degree$superlative$ru superlative = _Translations$morphology$degree$superlative$ru._(_root);
}

// Path: morphology.literals
class _Translations$morphology$literals$ru extends Translations$morphology$literals$en {
	_Translations$morphology$literals$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get rawCode => 'Необработанный код морфологии в том виде, в котором он указан в исходном коде.';
	@override String get waw => 'Еврейский союз вау (וְ) означает «и».';
	@override String get conjunction => 'Маркер соединения.';
	@override String get bet => 'Префикс-префикс на иврите (בְּ), означающий «в», «в» или «с».';
	@override String get kaf => 'Еврейский префикс-предлог каф (כְּ), означающий «как» или «подобно».';
	@override String get lamed => 'Еврейский префикс-предлог ламед (לְ), означающий «кому», «для» или «принадлежащий».';
	@override String get mem => 'Еврейский префикс-предлог мем (מִן), означающий «из» или «из».';
	@override String get preposition => 'Префиксная буква-предлог.';
	@override String get wawExamples => 'и|сейчас|но';
	@override String get betExamples => 'вначале|с силой';
	@override String get kafExamples => 'как лев|как пастух';
	@override String get lamedExamples => 'Давиду|за царя';
	@override String get memExamples => 'из Египта|из земли';
}

// Path: morphology.attributes.type
class _Translations$morphology$attributes$type$ru extends Translations$morphology$attributes$type$en {
	_Translations$morphology$attributes$type$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Тип';
	@override String get description => 'Грамматическая категория слова.';
}

// Path: morphology.attributes.grammaticalCase
class _Translations$morphology$attributes$grammaticalCase$ru extends Translations$morphology$attributes$grammaticalCase$en {
	_Translations$morphology$attributes$grammaticalCase$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Падеж';
	@override String get description => 'Синтаксическая роль, такая как субъект, объект или владение.';
}

// Path: morphology.attributes.gender
class _Translations$morphology$attributes$gender$ru extends Translations$morphology$attributes$gender$en {
	_Translations$morphology$attributes$gender$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Род';
	@override String get description => 'Грамматический род: мужской, женский, средний (греческий) или общий (иврит).';
}

// Path: morphology.attributes.number
class _Translations$morphology$attributes$number$ru extends Translations$morphology$attributes$number$en {
	_Translations$morphology$attributes$number$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Число';
	@override String get description => 'Относится ли слово к одному (единственное число), двум (двойственное) или многим (множественное число).';
}

// Path: morphology.attributes.person
class _Translations$morphology$attributes$person$ru extends Translations$morphology$attributes$person$en {
	_Translations$morphology$attributes$person$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Лицо';
	@override String get description => 'К кому относится это слово: 1-й (я/мы), 2-й (вы) или 3-й (он/она/оно/они).';
}

// Path: morphology.attributes.state
class _Translations$morphology$attributes$state$ru extends Translations$morphology$attributes$state$en {
	_Translations$morphology$attributes$state$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Состояние';
	@override String get description => 'Состояние существительного: абсолютное, конструктное или определенное.';
}

// Path: morphology.attributes.tense
class _Translations$morphology$attributes$tense$ru extends Translations$morphology$attributes$tense$en {
	_Translations$morphology$attributes$tense$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Время';
	@override String get description => 'Глагол – время, сочетающее в себе время и вид.';
}

// Path: morphology.attributes.mood
class _Translations$morphology$attributes$mood$ru extends Translations$morphology$attributes$mood$en {
	_Translations$morphology$attributes$mood$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Наклонение';
	@override String get description => 'Как выражается действие, например факт, команда или возможность.';
}

// Path: morphology.attributes.voice
class _Translations$morphology$attributes$voice$ru extends Translations$morphology$attributes$voice$en {
	_Translations$morphology$attributes$voice$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Залог';
	@override String get description => 'Голос: активный, средний или пассивный.';
}

// Path: morphology.attributes.degree
class _Translations$morphology$attributes$degree$ru extends Translations$morphology$attributes$degree$en {
	_Translations$morphology$attributes$degree$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Степень';
	@override String get description => 'Степень прилагательного или наречия: положительная, сравнительная или превосходная степень.';
}

// Path: morphology.attributes.stem
class _Translations$morphology$attributes$stem$ru extends Translations$morphology$attributes$stem$en {
	_Translations$morphology$attributes$stem$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Корень';
	@override String get description => 'Основа глагола (биньян), например qal, niphal или piel.';
}

// Path: morphology.attributes.aspect
class _Translations$morphology$attributes$aspect$ru extends Translations$morphology$attributes$aspect$en {
	_Translations$morphology$attributes$aspect$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Аспект';
	@override String get description => 'Вид глагола, например совершенный, несовершенный или причастие.';
}

// Path: morphology.attributes.prefix
class _Translations$morphology$attributes$prefix$ru extends Translations$morphology$attributes$prefix$en {
	_Translations$morphology$attributes$prefix$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Префикс';
	@override String get description => 'Еврейская буква-предлог с префиксом.';
}

// Path: morphology.attributes.particle
class _Translations$morphology$attributes$particle$ru extends Translations$morphology$attributes$particle$en {
	_Translations$morphology$attributes$particle$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Частица';
	@override String get description => 'Небольшое неизменяемое слово, часто союз или маркер.';
}

// Path: morphology.attributes.code
class _Translations$morphology$attributes$code$ru extends Translations$morphology$attributes$code$en {
	_Translations$morphology$attributes$code$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Код';
	@override String get description => 'Необработанный код морфологии в том виде, в каком он представлен в исходном тексте.';
}

// Path: morphology.types.article
class _Translations$morphology$types$article$ru extends Translations$morphology$types$article$en {
	_Translations$morphology$types$article$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Артикль';
	@override String get description => 'Определенный артикль «the».';
	@override String get examples => 'король | Господь';
}

// Path: morphology.types.conjunction
class _Translations$morphology$types$conjunction$ru extends Translations$morphology$types$conjunction$en {
	_Translations$morphology$types$conjunction$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Союз';
	@override String get description => 'Слово, которое объединяет другие слова или предложения.';
	@override String get examples => 'и|но|для';
}

// Path: morphology.types.preposition
class _Translations$morphology$types$preposition$ru extends Translations$morphology$types$preposition$en {
	_Translations$morphology$types$preposition$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Предлог';
	@override String get description => 'Связывает существительное или местоимение с другими словами.';
	@override String get examples => 'в|в|с';
}

// Path: morphology.types.adverb
class _Translations$morphology$types$adverb$ru extends Translations$morphology$types$adverb$en {
	_Translations$morphology$types$adverb$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Наречие';
	@override String get description => 'Изменяет глагол, прилагательное или другое наречие.';
	@override String get examples => 'быстро|сейчас|там';
}

// Path: morphology.types.negativeAdverb
class _Translations$morphology$types$negativeAdverb$ru extends Translations$morphology$types$negativeAdverb$en {
	_Translations$morphology$types$negativeAdverb$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Отрицательное наречие';
	@override String get description => 'Наречие, выражающее отрицание.';
	@override String get examples => 'нет|никогда';
}

// Path: morphology.types.adjective
class _Translations$morphology$types$adjective$ru extends Translations$morphology$types$adjective$en {
	_Translations$morphology$types$adjective$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Прилагательное';
	@override String get description => 'Слово, описывающее существительное.';
	@override String get examples => 'великий|святой|мудрый';
}

// Path: morphology.types.noun
class _Translations$morphology$types$noun$ru extends Translations$morphology$types$noun$en {
	_Translations$morphology$types$noun$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Существительное';
	@override String get description => 'Человек, место, вещь или идея.';
	@override String get examples => 'город|вода|любовь';
}

// Path: morphology.types.properNoun
class _Translations$morphology$types$properNoun$ru extends Translations$morphology$types$properNoun$en {
	_Translations$morphology$types$properNoun$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Имя собственное';
	@override String get description => 'Конкретное имя человека, места или предмета.';
	@override String get examples => 'Давид|Иерусалим|Израиль';
}

// Path: morphology.types.number
class _Translations$morphology$types$number$ru extends Translations$morphology$types$number$en {
	_Translations$morphology$types$number$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Число';
	@override String get description => 'Кардинальное число.';
	@override String get examples => 'три|двенадцать|тысячи';
}

// Path: morphology.types.ordinalNumber
class _Translations$morphology$types$ordinalNumber$ru extends Translations$morphology$types$ordinalNumber$en {
	_Translations$morphology$types$ordinalNumber$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Порядковый номер';
	@override String get description => 'Порядковый номер, например «первый» или «второй».';
	@override String get examples => 'первый|десятый|семидесятый';
}

// Path: morphology.types.pronoun
class _Translations$morphology$types$pronoun$ru extends Translations$morphology$types$pronoun$en {
	_Translations$morphology$types$pronoun$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Местоимение';
	@override String get description => 'Слово, заменяющее существительное.';
	@override String get examples => 'он|она|они';
}

// Path: morphology.types.personalPronoun
class _Translations$morphology$types$personalPronoun$ru extends Translations$morphology$types$personalPronoun$en {
	_Translations$morphology$types$personalPronoun$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Личное местоимение';
	@override String get description => 'Местоимение, обозначающее конкретного человека.';
	@override String get examples => 'я|ты|мы';
}

// Path: morphology.types.demonstrativePronoun
class _Translations$morphology$types$demonstrativePronoun$ru extends Translations$morphology$types$demonstrativePronoun$en {
	_Translations$morphology$types$demonstrativePronoun$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Указательное местоимение';
	@override String get description => 'Местоимение, указывающее на что-либо.';
	@override String get examples => 'это|эти|те';
}

// Path: morphology.types.interrogativePronoun
class _Translations$morphology$types$interrogativePronoun$ru extends Translations$morphology$types$interrogativePronoun$en {
	_Translations$morphology$types$interrogativePronoun$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Вопросительное местоимение';
	@override String get description => 'Местоимение, используемое для задания вопроса.';
	@override String get examples => 'кто?|что?|что?';
}

// Path: morphology.types.indefinitePronoun
class _Translations$morphology$types$indefinitePronoun$ru extends Translations$morphology$types$indefinitePronoun$en {
	_Translations$morphology$types$indefinitePronoun$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Неопределённое местоимение';
	@override String get description => 'Местоимение, обозначающее неспецифические сущности.';
	@override String get examples => 'кто-то|кто-то|ничего';
}

// Path: morphology.types.reciprocalPronoun
class _Translations$morphology$types$reciprocalPronoun$ru extends Translations$morphology$types$reciprocalPronoun$en {
	_Translations$morphology$types$reciprocalPronoun$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Взаимное местоимение';
	@override String get description => 'Местоимение, выражающее взаимное действие.';
	@override String get examples => 'друг друга | друг друга';
}

// Path: morphology.types.reflexivePronoun
class _Translations$morphology$types$reflexivePronoun$ru extends Translations$morphology$types$reflexivePronoun$en {
	_Translations$morphology$types$reflexivePronoun$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Возвратное местоимение';
	@override String get description => 'Местоимение, возвращающее к предмету.';
	@override String get examples => 'сам|сами';
}

// Path: morphology.types.relativePronoun
class _Translations$morphology$types$relativePronoun$ru extends Translations$morphology$types$relativePronoun$en {
	_Translations$morphology$types$relativePronoun$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Относительное местоимение';
	@override String get description => 'Местоимение, вводящее придаточное предложение.';
	@override String get examples => 'кто|который|что';
}

// Path: morphology.types.particle
class _Translations$morphology$types$particle$ru extends Translations$morphology$types$particle$en {
	_Translations$morphology$types$particle$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Частица';
	@override String get description => 'Небольшое неизменяемое слово.';
	@override String get examples => 'действительно|сейчас';
}

// Path: morphology.types.negativeParticle
class _Translations$morphology$types$negativeParticle$ru extends Translations$morphology$types$negativeParticle$en {
	_Translations$morphology$types$negativeParticle$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Отрицательная частица';
	@override String get description => 'Частица, обозначающая отрицание.';
	@override String get examples => 'нет|нет';
}

// Path: morphology.types.interrogativeParticle
class _Translations$morphology$types$interrogativeParticle$ru extends Translations$morphology$types$interrogativeParticle$en {
	_Translations$morphology$types$interrogativeParticle$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Вопросительная частица';
	@override String get description => 'Частица, обозначающая вопрос.';
	@override String get examples => '(префикс на иврите ה, английского эквивалента нет)';
}

// Path: morphology.types.demonstrativeParticle
class _Translations$morphology$types$demonstrativeParticle$ru extends Translations$morphology$types$demonstrativeParticle$en {
	_Translations$morphology$types$demonstrativeParticle$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Демонстративная частица';
	@override String get description => 'Указательная частица, например «вот».';
	@override String get examples => 'вот | вот';
}

// Path: morphology.types.genericParticle
class _Translations$morphology$types$genericParticle$ru extends Translations$morphology$types$genericParticle$en {
	_Translations$morphology$types$genericParticle$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Родовая частица';
	@override String get description => 'Частица общего назначения.';
	@override String get examples => 'действительно | действительно';
}

// Path: morphology.types.relativeParticle
class _Translations$morphology$types$relativeParticle$ru extends Translations$morphology$types$relativeParticle$en {
	_Translations$morphology$types$relativeParticle$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Относительная частица';
	@override String get description => 'Частица, вводящая придаточное предложение.';
	@override String get examples => 'то, что | что';
}

// Path: morphology.types.verb
class _Translations$morphology$types$verb$ru extends Translations$morphology$types$verb$en {
	_Translations$morphology$types$verb$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Глагол';
	@override String get description => 'Слово, выражающее действие или состояние.';
	@override String get examples => 'писать|быть|идти';
}

// Path: morphology.types.pronominalSuffix
class _Translations$morphology$types$pronominalSuffix$ru extends Translations$morphology$types$pronominalSuffix$en {
	_Translations$morphology$types$pronominalSuffix$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Местоименный суффикс';
	@override String get description => 'Местоимение, слитое с окончанием глагола или существительного (иврит).';
	@override String get examples => 'его рука|их земля|ее голос';
}

// Path: morphology.types.directObjectMarker
class _Translations$morphology$types$directObjectMarker$ru extends Translations$morphology$types$directObjectMarker$en {
	_Translations$morphology$types$directObjectMarker$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Прямой маркер объекта';
	@override String get description => 'Еврейское אֵת, обозначающее определенный прямой объект.';
	@override String get examples => 'אֵת (нет английского эквивалента)';
}

// Path: morphology.types.punctuation
class _Translations$morphology$types$punctuation$ru extends Translations$morphology$types$punctuation$en {
	_Translations$morphology$types$punctuation$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Пунктуация';
	@override String get description => 'Знак препинания.';
	@override String get examples => '.|,|;';
}

// Path: morphology.types.interjection
class _Translations$morphology$types$interjection$ru extends Translations$morphology$types$interjection$en {
	_Translations$morphology$types$interjection$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Междометие';
	@override String get description => 'Короткое восклицание, выражающее эмоции.';
	@override String get examples => 'о!|увы!';
}

// Path: morphology.types.indeclinable
class _Translations$morphology$types$indeclinable$ru extends Translations$morphology$types$indeclinable$en {
	_Translations$morphology$types$indeclinable$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Несклоняемый';
	@override String get description => 'Слово, не меняющее форму при изменении.';
	@override String get examples => 'Осанна|Аллилуйя';
}

// Path: morphology.types.hebraism
class _Translations$morphology$types$hebraism$ru extends Translations$morphology$types$hebraism$en {
	_Translations$morphology$types$hebraism$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'заимствованное слово на иврите';
	@override String get description => 'Заимствованное слово из иврита или арамейского языка, перенесенное в греческий язык.';
	@override String get examples => 'Аминь|Осанна|Саваоф';
}

// Path: morphology.types.unknown
class _Translations$morphology$types$unknown$ru extends Translations$morphology$types$unknown$en {
	_Translations$morphology$types$unknown$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Неизвестный';
	@override String get description => 'Морфологический код, который не распознан синтаксическим анализатором.';
	@override String get examples => '';
}

// Path: morphology.person.first
class _Translations$morphology$person$first$ru extends Translations$morphology$person$first$en {
	_Translations$morphology$person$first$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => '1-й человек';
	@override String get description => 'Говорящий: «Я» или «мы».';
	@override String get examples => 'Я|мы идем|я говорил';
}

// Path: morphology.person.second
class _Translations$morphology$person$second$ru extends Translations$morphology$person$second$en {
	_Translations$morphology$person$second$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => '2-й человек';
	@override String get description => 'Адресат, «вы» (единственное или множественное число).';
	@override String get examples => 'ты идешь|вы (мн.) слушаете|вы видели';
}

// Path: morphology.person.third
class _Translations$morphology$person$third$ru extends Translations$morphology$person$third$en {
	_Translations$morphology$person$third$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => '3-е лицо';
	@override String get description => 'Вечеринка, о которой идет речь.';
	@override String get examples => 'он бежит|она говорит|они собрались';
}

// Path: morphology.gender.masculine
class _Translations$morphology$gender$masculine$ru extends Translations$morphology$gender$masculine$en {
	_Translations$morphology$gender$masculine$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Мужской род';
	@override String get description => 'Мужской грамматический род, по традиции используется для лиц мужского пола и многих существительных.';
	@override String get examples => 'отец|сын|король';
}

// Path: morphology.gender.feminine
class _Translations$morphology$gender$feminine$ru extends Translations$morphology$gender$feminine$en {
	_Translations$morphology$gender$feminine$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Женственный';
	@override String get description => 'Женский грамматический род, по традиции используется для обозначения лиц женского пола и многих существительных.';
	@override String get examples => 'мать|дочь|королева';
}

// Path: morphology.gender.neuter
class _Translations$morphology$gender$neuter$ru extends Translations$morphology$gender$neuter$en {
	_Translations$morphology$gender$neuter$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Средний';
	@override String get description => 'Греческий средний род, ни мужской, ни женский.';
	@override String get examples => 'ребенок (τέκνον)|подарок (δῶρον)';
}

// Path: morphology.gender.common
class _Translations$morphology$gender$common$ru extends Translations$morphology$gender$common$en {
	_Translations$morphology$gender$common$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Общий';
	@override String get description => 'Общий род в иврите, где форма служит как мужскому, так и женскому роду.';
	@override String get examples => 'крупный рогатый скот|голос';
}

// Path: morphology.number.singular
class _Translations$morphology$number$singular$ru extends Translations$morphology$number$singular$en {
	_Translations$morphology$number$singular$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Единственное число';
	@override String get description => 'Относится к одному.';
	@override String get examples => 'книга|мужчина|один камень';
}

// Path: morphology.number.plural
class _Translations$morphology$number$plural$ru extends Translations$morphology$number$plural$en {
	_Translations$morphology$number$plural$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Множественное число';
	@override String get description => 'Относится к двум и более.';
	@override String get examples => 'книги|мужчины|камни';
}

// Path: morphology.number.dual
class _Translations$morphology$number$dual$ru extends Translations$morphology$number$dual$en {
	_Translations$morphology$number$dual$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Двойной';
	@override String get description => 'Относится к натуральной паре (только на иврите).';
	@override String get examples => 'руки|глаза|два дня';
}

// Path: morphology.kCase.nominative
class _Translations$morphology$kCase$nominative$ru extends Translations$morphology$kCase$nominative$en {
	_Translations$morphology$kCase$nominative$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Именительный падеж';
	@override String get description => 'Обозначает подлежащее предложения.';
	@override String get examples => 'Бог создал|царь видит';
}

// Path: morphology.kCase.genitive
class _Translations$morphology$kCase$genitive$ru extends Translations$morphology$kCase$genitive$en {
	_Translations$morphology$kCase$genitive$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Родительный падеж';
	@override String get description => 'Указывает на владение или происхождение, часто переводится как «из».';
	@override String get examples => 'Сын Божий|Царство Небесное';
}

// Path: morphology.kCase.dative
class _Translations$morphology$kCase$dative$ru extends Translations$morphology$kCase$dative$en {
	_Translations$morphology$kCase$dative$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Дательный падеж';
	@override String get description => 'Обозначает косвенный объект, часто «кому» или «за».';
	@override String get examples => 'дал ему | поговорил с ними';
}

// Path: morphology.kCase.accusative
class _Translations$morphology$kCase$accusative$ru extends Translations$morphology$kCase$accusative$en {
	_Translations$morphology$kCase$accusative$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Винительный падеж';
	@override String get description => 'Отмечает прямой объект.';
	@override String get examples => 'видел его|люби своего соседа';
}

// Path: morphology.kCase.vocative
class _Translations$morphology$kCase$vocative$ru extends Translations$morphology$kCase$vocative$en {
	_Translations$morphology$kCase$vocative$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Звательный падеж';
	@override String get description => 'Используется по прямому адресу.';
	@override String get examples => 'Господи!|Отец!|Друг!';
}

// Path: morphology.state.absolute
class _Translations$morphology$state$absolute$ru extends Translations$morphology$state$absolute$en {
	_Translations$morphology$state$absolute$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Абсолютный';
	@override String get description => 'Независимая форма существительного по умолчанию.';
	@override String get examples => 'король | слово';
}

// Path: morphology.state.construct
class _Translations$morphology$state$construct$ru extends Translations$morphology$state$construct$en {
	_Translations$morphology$state$construct$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Построить';
	@override String get description => 'Связан со следующим существительным, выражающим «X из Y».';
	@override String get examples => 'царь Израиля | слово Господне';
}

// Path: morphology.state.determined
class _Translations$morphology$state$determined$ru extends Translations$morphology$state$determined$en {
	_Translations$morphology$state$determined$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Определенный';
	@override String get description => 'Помечено как определенное, часто по артиклю.';
	@override String get examples => 'король|слово';
}

// Path: morphology.stem.qal
class _Translations$morphology$stem$qal$ru extends Translations$morphology$stem$qal$en {
	_Translations$morphology$stem$qal$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Кал';
	@override String get description => 'Простая активная основа, основное действие глагола.';
	@override String get examples => 'он написал|она услышала';
}

// Path: morphology.stem.qalPassive
class _Translations$morphology$stem$qalPassive$ru extends Translations$morphology$stem$qalPassive$en {
	_Translations$morphology$stem$qalPassive$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Кал пассивный';
	@override String get description => 'Редкий пассив простой основы.';
	@override String get examples => 'это было принято';
}

// Path: morphology.stem.niphal
class _Translations$morphology$stem$niphal$ru extends Translations$morphology$stem$niphal$en {
	_Translations$morphology$stem$niphal$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Нифаль';
	@override String get description => 'Простая пассивная или рефлексивная основа.';
	@override String get examples => 'его убили|они собрались сами';
}

// Path: morphology.stem.piel
class _Translations$morphology$stem$piel$ru extends Translations$morphology$stem$piel$en {
	_Translations$morphology$stem$piel$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Пиль';
	@override String get description => 'Интенсивная или фактивная активная основа.';
	@override String get examples => 'он похвалил|он благословил|он разбил';
}

// Path: morphology.stem.pual
class _Translations$morphology$stem$pual$ru extends Translations$morphology$stem$pual$en {
	_Translations$morphology$stem$pual$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Пуал';
	@override String get description => 'Пассив пиеля.';
	@override String get examples => 'его хвалили';
}

// Path: morphology.stem.hiphil
class _Translations$morphology$stem$hiphil$ru extends Translations$morphology$stem$hiphil$en {
	_Translations$morphology$stem$hiphil$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Хифил';
	@override String get description => 'Причинно-активная основа.';
	@override String get examples => 'он заставил написать|он вывел';
}

// Path: morphology.stem.hophal
class _Translations$morphology$stem$hophal$ru extends Translations$morphology$stem$hophal$en {
	_Translations$morphology$stem$hophal$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Хофал';
	@override String get description => 'Пассив Хифила.';
	@override String get examples => 'его заставили написать';
}

// Path: morphology.stem.hithpael
class _Translations$morphology$stem$hithpael$ru extends Translations$morphology$stem$hithpael$en {
	_Translations$morphology$stem$hithpael$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Хитпаэль';
	@override String get description => 'Рефлекторный или реципрокный пилель.';
	@override String get examples => 'он освятил себя | они гуляли';
}

// Path: morphology.stem.nithpael
class _Translations$morphology$stem$nithpael$ru extends Translations$morphology$stem$nithpael$en {
	_Translations$morphology$stem$nithpael$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Нитпаэль';
	@override String get description => 'Редкий рефлексивно-пассивный стебель.';
	@override String get examples => 'это было искуплено';
}

// Path: morphology.aspect.perfect
class _Translations$morphology$aspect$perfect$ru extends Translations$morphology$aspect$perfect$en {
	_Translations$morphology$aspect$perfect$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Совершенный вид';
	@override String get description => 'Завершенное действие обычно переводится как прошлое.';
	@override String get examples => 'он написал|она говорила';
}

// Path: morphology.aspect.imperfect
class _Translations$morphology$aspect$imperfect$ru extends Translations$morphology$aspect$imperfect$en {
	_Translations$morphology$aspect$imperfect$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Несовершенный';
	@override String get description => 'Незавершенное или будущее действие, часто переводится как будущее или привычное.';
	@override String get examples => 'он напишет | он напишет';
}

// Path: morphology.aspect.imperative
class _Translations$morphology$aspect$imperative$ru extends Translations$morphology$aspect$imperative$en {
	_Translations$morphology$aspect$imperative$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Императив';
	@override String get description => 'Прямой приказ.';
	@override String get examples => 'Пишите!|Слушайте!';
}

// Path: morphology.aspect.infinitiveConstruct
class _Translations$morphology$aspect$infinitiveConstruct$ru extends Translations$morphology$aspect$infinitiveConstruct$en {
	_Translations$morphology$aspect$infinitiveConstruct$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Инфинитивная конструкция';
	@override String get description => 'Отглагольное существительное в форме конструкции, часто употребляемое с предлогами.';
	@override String get examples => 'писать | когда пишешь';
}

// Path: morphology.aspect.infinitiveAbsolute
class _Translations$morphology$aspect$infinitiveAbsolute$ru extends Translations$morphology$aspect$infinitiveAbsolute$en {
	_Translations$morphology$aspect$infinitiveAbsolute$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Инфинитив абсолютный';
	@override String get description => 'Самостоятельное отглагольное существительное, часто эмфатическое.';
	@override String get examples => 'обязательно умру|напиши тщательно';
}

// Path: morphology.aspect.participle
class _Translations$morphology$aspect$participle$ru extends Translations$morphology$aspect$participle$en {
	_Translations$morphology$aspect$participle$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Причастие';
	@override String get description => 'Глагольное прилагательное, описывающее продолжающееся действие.';
	@override String get examples => 'пишу|тот, кто слышит';
}

// Path: morphology.aspect.consecutiveImperfect
class _Translations$morphology$aspect$consecutiveImperfect$ru extends Translations$morphology$aspect$consecutiveImperfect$en {
	_Translations$morphology$aspect$consecutiveImperfect$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Последовательный несовершенный';
	@override String get description => 'Форма прошедшего повествования: waw + несовершенный.';
	@override String get examples => 'и он сказал|и они пошли';
}

// Path: morphology.aspect.conjunctiveImperfect
class _Translations$morphology$aspect$conjunctiveImperfect$ru extends Translations$morphology$aspect$conjunctiveImperfect$en {
	_Translations$morphology$aspect$conjunctiveImperfect$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Союзный имперфект';
	@override String get description => 'Несовершенный вид с союзным союзом waw, с будущим или модальным значением.';
	@override String get examples => 'и он напишет';
}

// Path: morphology.aspect.conjunctivePerfect
class _Translations$morphology$aspect$conjunctivePerfect$ru extends Translations$morphology$aspect$conjunctivePerfect$en {
	_Translations$morphology$aspect$conjunctivePerfect$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Союзный совершенный';
	@override String get description => 'Идеально сочетается с союзным союзом waw, часто будущим или последовательным.';
	@override String get examples => 'и ты сделаешь, и он будет судить';
}

// Path: morphology.aspect.passiveParticiple
class _Translations$morphology$aspect$passiveParticiple$ru extends Translations$morphology$aspect$passiveParticiple$en {
	_Translations$morphology$aspect$passiveParticiple$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Пассивное причастие';
	@override String get description => 'Пассивная форма причастия qal.';
	@override String get examples => 'написано|сохранено';
}

// Path: morphology.hebrewMood.jussive
class _Translations$morphology$hebrewMood$jussive$ru extends Translations$morphology$hebrewMood$jussive$en {
	_Translations$morphology$hebrewMood$jussive$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Юссив';
	@override String get description => 'Команда или желание от третьего лица.';
	@override String get examples => 'Да будет свет|Да благословит тебя Господь';
}

// Path: morphology.hebrewMood.cohortative
class _Translations$morphology$hebrewMood$cohortative$ru extends Translations$morphology$hebrewMood$cohortative$en {
	_Translations$morphology$hebrewMood$cohortative$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'когортативный';
	@override String get description => 'Волевой глагол от 1-го лица, например «давайте» или «я буду».';
	@override String get examples => 'Пойдём|Я похвалю';
}

// Path: morphology.hebrewMood.hSuffix
class _Translations$morphology$hebrewMood$hSuffix$ru extends Translations$morphology$hebrewMood$hSuffix$en {
	_Translations$morphology$hebrewMood$hSuffix$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'h-суффикс';
	@override String get description => 'Упорное -ah, оканчивающееся на несовершенном, часто похожем на когортативное.';
	@override String get examples => 'Я обязательно приду|позволь мне приблизиться';
}

// Path: morphology.tense.present
class _Translations$morphology$tense$present$ru extends Translations$morphology$tense$present$en {
	_Translations$morphology$tense$present$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Настоящее';
	@override String get description => 'Текущее или общее действие.';
	@override String get examples => 'он любит|они гуляют';
}

// Path: morphology.tense.imperfect
class _Translations$morphology$tense$imperfect$ru extends Translations$morphology$tense$imperfect$en {
	_Translations$morphology$tense$imperfect$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Несовершенный';
	@override String get description => 'Непрерывное или повторяющееся действие в прошлом.';
	@override String get examples => 'он преподавал|они собирались';
}

// Path: morphology.tense.future
class _Translations$morphology$tense$future$ru extends Translations$morphology$tense$future$en {
	_Translations$morphology$tense$future$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Будущее';
	@override String get description => 'Действие, которое произойдет.';
	@override String get examples => 'он придет|они увидят';
}

// Path: morphology.tense.aorist
class _Translations$morphology$tense$aorist$ru extends Translations$morphology$tense$aorist$en {
	_Translations$morphology$tense$aorist$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Аорист';
	@override String get description => 'Простое прошедшее действие, рассматриваемое в целом.';
	@override String get examples => 'он сказал|они пошли';
}

// Path: morphology.tense.perfect
class _Translations$morphology$tense$perfect$ru extends Translations$morphology$tense$perfect$en {
	_Translations$morphology$tense$perfect$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Перфект';
	@override String get description => 'Прошлое действие с продолжающимися последствиями в настоящем.';
	@override String get examples => 'было написано | пришло';
}

// Path: morphology.tense.pluperfect
class _Translations$morphology$tense$pluperfect$ru extends Translations$morphology$tense$pluperfect$en {
	_Translations$morphology$tense$pluperfect$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Плюперфект';
	@override String get description => 'Прошлое действие, предшествовавшее другому прошлому событию.';
	@override String get examples => 'было написано|ушло';
}

// Path: morphology.mood.indicative
class _Translations$morphology$mood$indicative$ru extends Translations$morphology$mood$indicative$en {
	_Translations$morphology$mood$indicative$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Изъявительное';
	@override String get description => 'Констатирует факт.';
	@override String get examples => 'он | они написали';
}

// Path: morphology.mood.imperative
class _Translations$morphology$mood$imperative$ru extends Translations$morphology$mood$imperative$en {
	_Translations$morphology$mood$imperative$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Императив';
	@override String get description => 'Выдает команду.';
	@override String get examples => 'Идите!|Верьте!|Не бойтесь!';
}

// Path: morphology.mood.subjunctive
class _Translations$morphology$mood$subjunctive$ru extends Translations$morphology$mood$subjunctive$en {
	_Translations$morphology$mood$subjunctive$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Сослагательное наклонение';
	@override String get description => 'Выражает возможность, цель или непредвиденное обстоятельство.';
	@override String get examples => 'что он мог бы написать|если пойдёт';
}

// Path: morphology.mood.optative
class _Translations$morphology$mood$optative$ru extends Translations$morphology$mood$optative$en {
	_Translations$morphology$mood$optative$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Оптатив';
	@override String get description => 'Выражает желание или отдаленную возможность.';
	@override String get examples => 'да будет так | да будет тебе милость';
}

// Path: morphology.mood.infinitive
class _Translations$morphology$mood$infinitive$ru extends Translations$morphology$mood$infinitive$en {
	_Translations$morphology$mood$infinitive$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'инфинитив';
	@override String get description => 'Отглагольное существительное, например «делать».';
	@override String get examples => 'писать|верить';
}

// Path: morphology.mood.participle
class _Translations$morphology$mood$participle$ru extends Translations$morphology$mood$participle$en {
	_Translations$morphology$mood$participle$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Причастие';
	@override String get description => 'Отглагольное прилагательное, например «делать» или «сделать».';
	@override String get examples => 'тот, кто пишет|говорит';
}

// Path: morphology.voice.active
class _Translations$morphology$voice$active$ru extends Translations$morphology$voice$active$en {
	_Translations$morphology$voice$active$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Активный';
	@override String get description => 'Субъект выполняет действие.';
	@override String get examples => 'он пишет|они учат';
}

// Path: morphology.voice.middle
class _Translations$morphology$voice$middle$ru extends Translations$morphology$voice$middle$en {
	_Translations$morphology$voice$middle$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Средний';
	@override String get description => 'Субъект действует сам по себе или для себя.';
	@override String get examples => 'он моется|они достали себе';
}

// Path: morphology.voice.passive
class _Translations$morphology$voice$passive$ru extends Translations$morphology$voice$passive$en {
	_Translations$morphology$voice$passive$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Пассивный';
	@override String get description => 'Субъект получает действие.';
	@override String get examples => 'его послали|их научили';
}

// Path: morphology.voice.middleOrPassive
class _Translations$morphology$voice$middleOrPassive$ru extends Translations$morphology$voice$middleOrPassive$en {
	_Translations$morphology$voice$middleOrPassive$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Средний/Пассивный';
	@override String get description => 'Форма неоднозначна между средней и пассивной.';
	@override String get examples => 'был поднят / поднял сам | был собран / собрался сам';
}

// Path: morphology.degree.positive
class _Translations$morphology$degree$positive$ru extends Translations$morphology$degree$positive$en {
	_Translations$morphology$degree$positive$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Позитивный';
	@override String get description => 'Простая форма, ни сравнительная, ни превосходная степень.';
	@override String get examples => 'отлично|хорошо';
}

// Path: morphology.degree.comparative
class _Translations$morphology$degree$comparative$ru extends Translations$morphology$degree$comparative$en {
	_Translations$morphology$degree$comparative$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'Сравнительный';
	@override String get description => 'Сравнивает двоих.';
	@override String get examples => 'больше | лучше, чем';
}

// Path: morphology.degree.superlative
class _Translations$morphology$degree$superlative$ru extends Translations$morphology$degree$superlative$en {
	_Translations$morphology$degree$superlative$ru._(TranslationsRu root) : this._root = root, super.internal(root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get name => 'превосходная степень';
	@override String get description => 'Выражает наибольшую степень.';
	@override String get examples => 'величайший|лучший';
}

/// The flat map containing all translations for locale <ru>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsRu {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'languages.english' => 'Английский',
			'languages.dutch' => 'Нидерландский',
			'languages.greek' => 'Греческий',
			'languages.hebrew' => 'Иврит',
			'languages.russian' => 'Русский',
			'highlightStyles.red' => 'Красный',
			'highlightStyles.orange' => 'Оранжевый',
			'highlightStyles.yellow' => 'Желтый',
			'highlightStyles.green' => 'Зеленый',
			'highlightStyles.blue' => 'Синий',
			'highlightStyles.violet' => 'Фиолетовый',
			'highlightStyles.underline' => 'Подчёркивание',
			'highlightStyles.important' => 'Важное',
			'highlightStyles.highlight' => 'Выделение',
			'highlightStyles.squiggle' => 'Волнистая линия',
			'colors.red' => 'Красный',
			'colors.orange' => 'Оранжевый',
			'colors.yellow' => 'Желтый',
			'colors.green' => 'Зеленый',
			'colors.blue' => 'Синий',
			'colors.violet' => 'Фиолетовый',
			'colors.silver' => 'Серебряный',
			'testaments.old' => 'Ветхий Завет',
			'testaments.newTestament' => 'Новый Завет',
			'testaments.oldOnly' => 'Только Ветхий Завет',
			'testaments.newOnly' => 'Только Новый Завет',
			'testaments.wholeBible' => 'Вся Библия',
			'testaments.oldOnlyDescription' => 'Содержит только книги Ветхого Завета.',
			'testaments.newOnlyDescription' => 'Содержит только книги Нового Завета.',
			'testaments.wholeBibleDescription' => 'Содержит все книги Библии.',
			'books.genesis' => 'Бытие',
			'books.exodus' => 'Исход',
			'books.leviticus' => 'Левит',
			'books.numbers' => 'Числа',
			'books.deuteronomy' => 'Второзаконие',
			'books.joshua' => 'Иисус Навин',
			'books.judges' => 'Судьи',
			'books.ruth' => 'Руфь',
			'books.samuel1' => '1 Царств',
			'books.samuel2' => '2 Царств',
			'books.kings1' => '3 Царств',
			'books.kings2' => '4 Царств',
			'books.chronicles1' => '1 Паралипоменон',
			'books.chronicles2' => '2 Паралипоменон',
			'books.ezra' => 'Ездра',
			'books.nehemiah' => 'Неемия',
			'books.esther' => 'Есфирь',
			'books.job' => 'Иов',
			'books.psalm' => 'Псалом',
			'books.psalms' => 'Псалмы',
			'books.proverbs' => 'Притчи',
			'books.ecclesiastes' => 'Екклесиаст',
			'books.songOfSolomon' => 'Песнь песней',
			'books.isaiah' => 'Исаия',
			'books.jeremiah' => 'Иеремия',
			'books.lamentations' => 'Плач Иеремии',
			'books.ezekiel' => 'Иезекииль',
			'books.daniel' => 'Даниил',
			'books.hosea' => 'Осия',
			'books.joel' => 'Иоиль',
			'books.amos' => 'Амос',
			'books.obadiah' => 'Авдий',
			'books.jonah' => 'Иона',
			'books.micah' => 'Михей',
			'books.nahum' => 'Наум',
			'books.habakkuk' => 'Аввакум',
			'books.zephaniah' => 'Софония',
			'books.haggai' => 'Аггей',
			'books.zechariah' => 'Захария',
			'books.malachi' => 'Малахия',
			'books.matthew' => 'Матфей',
			'books.mark' => 'Марк',
			'books.luke' => 'Лука',
			'books.john' => 'Иоанн',
			'books.acts' => 'Деяния',
			'books.romans' => 'Римлянам',
			'books.corinthians1' => '1 Коринфянам',
			'books.corinthians2' => '2 Коринфянам',
			'books.galatians' => 'Галатам',
			'books.ephesians' => 'Ефесянам',
			'books.philippians' => 'Филиппийцам',
			'books.colossians' => 'Колоссянам',
			'books.thessalonians1' => '1 Фессалоникийцам',
			'books.thessalonians2' => '2 Фессалоникийцам',
			'books.timothy1' => '1 Тимофею',
			'books.timothy2' => '2 Тимофею',
			'books.titus' => 'Тит',
			'books.philemon' => 'Филимон',
			'books.hebrews' => 'Евреям',
			'books.james' => 'Иаков',
			'books.peter1' => '1 Петра',
			'books.peter2' => '2 Петра',
			'books.john1' => '1 Иоанна',
			'books.john2' => '2 Иоанна',
			'books.john3' => '3 Иоанна',
			'books.jude' => 'Иуда',
			'books.revelation' => 'Откровение',
			'common.add' => 'Добавить',
			'common.addNew' => 'Добавить',
			'common.am' => 'ДП',
			'common.cancel' => 'Отмена',
			'common.close' => 'Закрыть',
			'common.copy' => 'Копировать',
			'common.continueLabel' => 'Продолжить',
			'common.create' => 'Создать',
			'common.custom' => 'Пользовательский',
			'common.defaultLabel' => 'По умолчанию',
			'common.delete' => 'Удалить',
			'common.done' => 'Готово',
			'common.edit' => 'Редактировать',
			'common.finish' => 'Завершить',
			'common.learnMore' => 'Узнать больше',
			'common.nevermind' => 'Неважно',
			'common.next' => 'Далее',
			'common.noMatches' => 'Нет совпадений',
			'common.noNotification' => 'Нет уведомления',
			'common.ok' => 'Хорошо',
			'common.off' => 'Выкл.',
			'common.none' => 'Нет',
			'common.clear' => 'Очистить',
			'common.remove' => 'Удалить',
			'common.save' => 'Сохранить',
			'common.search' => 'Поиск',
			'common.select' => 'Выбрать',
			'common.show' => 'Показать',
			'common.hide' => 'Скрыть',
			'common.pm' => 'ПП',
			'common.sort' => 'Сортировать',
			'common.stop' => 'Остановить',
			'common.tryAgain' => 'Попробуйте еще раз',
			'common.switchTo' => ({required Object translation}) => 'Переключиться на ${translation}',
			'common.notAvailableIn' => ({required Object translation}) => 'Это недоступно в ${translation}.',
			'regionTypes.chapter' => 'эта глава',
			'regionTypes.verses' => 'эти стихи',
			'regionTypes.visibleVerses' => 'видимые стихи',
			'regionTypes.text' => 'этот текст',
			'mainActions.pauseAudio' => 'Пауза Аудио Библия',
			'mainActions.playAudio' => 'Воспроизвести аудио Библию',
			'mainActions.bookmark' => 'Закладка',
			'mainActions.study' => 'Изучение',
			'mainActions.verseOfTheDay' => 'Стих дня',
			'mainActions.addStudyPanel' => 'Добавить панель исследования',
			'mainActions.search' => 'Поиск',
			'mainActions.resources' => 'Ресурсы',
			'mainActions.plans' => 'Библейские планы',
			'mainActions.settings' => 'Настройки',
			'mainActions.more' => 'Ещё',
			'mainActions.audioDescription' => 'Слушайте текущую главу с помощью Библии с поддержкой аудио.',
			'mainActions.bookmarkDescription' => 'Добавьте эту главу в закладки, чтобы легко получить к ней доступ со страницы поиска.',
			'mainActions.manageBookmarkDescription' => 'Управляйте этой закладкой.',
			'mainActions.studyDescription' => 'Просмотрите инструменты обучения для этой главы.',
			'mainActions.verseOfTheDayDescription' => 'Посмотрите сегодняшний стих.',
			'mainActions.verseOfTheDayLoading' => 'Загрузка сегодняшнего стиха…',
			'mainActions.verseOfTheDayUnavailable' => 'Не удалось загрузить сегодняшний стих.',
			'mainActions.studyPanelDescription' => 'Прикрепите панель рядом с текстом, который следует по тексту и на котором показаны инструменты изучения того, что вы читаете.',
			'mainActions.searchDescription' => 'Ищите слова в Библии.',
			'mainActions.resourcesDescription' => 'Найдите слова в словаре и лексиконе.',
			'mainActions.plansDescription' => 'Читайте Библию с помощью управляемых планов чтения.',
			'mainActions.settingsDescription' => 'Откройте настройки Lux.',
			'mainActions.moreDescription' => 'Просматривайте настройки, ваш контент и ссылки на сообщество.',
			'verseOfTheDay.reminderDiscoveryTitle' => 'Добавить ежедневное напоминание?',
			'verseOfTheDay.reminderDiscoveryBody' => 'Хотите, чтобы Lux ежедневно напоминал вам о стихе дня?',
			'verseOfTheDay.addReminder' => 'Добавить напоминание',
			'verseOfTheDay.noReminder' => 'Нет',
			'verseOfTheDay.dailyReminders' => 'Ежедневное напоминание',
			'verseOfTheDay.deleteReminder' => 'Удалить напоминание?',
			'verseOfTheDay.deleteReminderConfirmation' => 'Удалить ежедневное напоминание о стихе дня?',
			'verseOfTheDay.reminderNotificationChannelName' => 'Напоминания о стихе дня',
			'verseOfTheDay.reminderNotificationChannelDescription' => 'Ежедневные напоминания о стихе дня',
			'verseOfTheDay.reminderNotificationTitle' => 'Стих дня',
			'verseOfTheDay.reminderPermissionDeniedTitle' => 'Уведомления отключены',
			'verseOfTheDay.reminderPermissionDeniedBody' => 'Чтобы сохранить это напоминание, разрешите Lux отправлять уведомления в настройках.',
			'verseOfTheDay.openNotificationSettings' => 'Открыть настройки',
			'verseOfTheDay.reminderSchedulingFailedTitle' => 'Не удалось установить напоминание',
			'verseOfTheDay.reminderSchedulingFailedBody' => 'Lux не удалось установить это напоминание. Повторите попытку.',
			'verseOfTheDay.reminderSaved' => ({required Object time}) => 'Ежедневное напоминание о стихе дня сохранено на ${time}.',
			'studyActions.quickStudy' => 'Быстрое изучение',
			'studyActions.compare' => 'Сравнивать',
			'studyActions.interlinear' => 'Подстрочный',
			'studyActions.commentary' => 'Комментарий',
			'studyActions.crossReferences' => 'Перекрестные ссылки',
			'studyActions.compareDescription' => ({required Object region}) => 'Сравните ${region} в различных переводах.',
			'studyActions.interlinearDescription' => ({required Object region}) => 'Просмотрите лексическую разбивку ${region} с помощью Strong\'s.',
			'studyActions.commentaryDescription' => ({required Object region}) => 'Посмотреть комментарии ${region}.',
			'studyActions.crossReferencesDescription' => ({required Object region}) => 'Просмотрите перекрестные ссылки ${region}.',
			'studyActions.noCrossReferences' => 'Перекрестных ссылок не найдено',
			'studyActions.crossReferencesUse' => ({required Object translation}) => 'В перекрестных ссылках используется ${translation}.',
			'studyActions.onlineCrossReferencesExplanation' => 'Поскольку выбранный вами перевод доступен только в Интернете, перекрестные ссылки показаны с использованием последней версии Учебной Библии, которую вы использовали, чтобы сэкономить на производительности и затратах. Выбранный вами перевод используется повсюду в приложении.',
			'selectionActions.annotate' => 'Аннотировать',
			'selectionActions.study' => 'Изучать',
			'selectionActions.copy' => 'Копировать',
			'selectionActions.highlight' => 'Выделить',
			'selectionActions.removeAnnotations' => 'Удалить аннотации',
			'selectionActions.interlinear' => 'Подстрочник',
			'selectionActions.search' => 'Поиск',
			'selectionActions.annotateVersesDescription' => 'Прокомментируйте эти стихи.',
			'selectionActions.studyVersesDescription' => 'Изучите эти стихи.',
			'selectionActions.copyVersesDescription' => 'Скопируйте эти стихи в буфер обмена.',
			'selectionActions.annotateTextDescription' => 'Прокомментируйте этот текст.',
			'selectionActions.interlinearTextDescription' => 'Посмотрите лексическую разбивку этого текста.',
			'selectionActions.searchTextDescription' => 'Найдите в Библии этот текст.',
			'selectionActions.copyTextDescription' => 'Скопируйте этот текст в буфер обмена.',
			'selectionActions.removeTextAnnotationsDescription' => ({required Object region}) => 'Удалите аннотации выделения текста из ${region}.',
			'selectionActions.highlightTextDescription' => ({required Object region}) => 'Выделите ${region} последним использованным цветом.',
			'selectionActions.removeVerseAnnotationsDescription' => ({required Object region}) => 'Удалите аннотации выбора стихов из ${region}.',
			'selectionActions.highlightVersesDescription' => ({required Object region}) => 'Выделите ${region} последним использованным цветом.',
			'selectionActions.highlightedText' => ({required Object reference}) => 'Выделенный текст в ${reference}.',
			'selectionActions.highlightedVerses' => ({required Object reference}) => 'Выделен ${reference}.',
			'selectionActions.copiedVerses' => ({required Object reference}) => '${reference} скопировано в буфер обмена.',
			'selectionActions.copiedText' => 'Выделенный текст скопирован в буфер обмена.',
			'selectionActions.interlinearUnavailable' => 'Подстрочный выбор текста доступен только в Учебных Библиях, которые разработаны с использованием дословных тегов Стронга и морфологических тегов. Чтобы использовать это действие, переключите свой перевод на Учебную Библию.',
			'selectionActions.noInterlinearWords' => 'В этой выборке не найдено подстрочных слов.',
			'selectionActions.textInReference' => ({required Object reference}) => 'Текст в ${reference}',
			'studyPanels.title' => 'Панель изучения',
			'studyPanels.pinAsStudyPanel' => 'Закрепить как панель изучения',
			'studyPanels.compareWith' => ({required Object translation}) => 'Сравнение с ${translation}',
			'studyPanels.directionInterlinear' => ({required Object direction}) => '${direction} подстрочник',
			'studyPanels.commentaryName' => ({required Object commentary}) => 'Комментарий ${commentary}',
			'studyPanels.notes' => 'Примечания',
			'studyPanels.noNotes' => 'Заметки не найдены',
			'studyPanels.notesDescription' => 'Просматривайте свои заметки в видимых стихах.',
			'bookmarks.create' => 'Создать закладку',
			'bookmarks.manage' => 'Управление закладками',
			'bookmarks.stopFollowing' => 'Открепить',
			'bookmarks.stopFollowingDescription' => 'Не перемещать эту закладку вслед за текущей главой.',
			'bookmarks.edit' => 'Изменить закладку',
			'bookmarks.delete' => 'Удалить закладку',
			'bookmarks.deleteConfirmation' => 'Вы уверены, что хотите удалить эту закладку?',
			'bookmarks.deleteNamedConfirmation' => ({required Object name}) => 'Вы уверены, что хотите удалить «${name}»?',
			'bookmarkPage.title' => 'Ваши закладки',
			'commentaries.addRemove' => 'Добавить и удалить комментарии',
			'toolbarShortcuts.switchBible' => 'Переключить Библию',
			'toolbarShortcuts.dictionary' => 'Словарь',
			'toolbarShortcuts.lexicon' => 'Лексикон',
			'toolbarShortcuts.themeAndLayout' => 'Тема и макет',
			'toolbarShortcuts.switchBibleDescription' => 'Переключите перевод Библии.',
			'toolbarShortcuts.dictionaryDescription' => 'Ищите людей, места и темы в Библейском словаре Истона.',
			'toolbarShortcuts.lexiconDescription' => 'Изучите оригинальные еврейские и греческие слова с помощью «Лексикона Стронга».',
			'toolbarShortcuts.themeAndLayoutDescription' => 'Настройте тему и макет Библии.',
			'labels.about' => 'О приложении',
			'labels.annotation' => 'Аннотация',
			'labels.annotations' => 'Аннотации',
			'labels.audioBible' => 'Аудио Библия',
			'labels.bible' => 'Библия',
			'labels.bibles' => 'Библии',
			'labels.biblePlans' => 'Библейские планы',
			'labels.bookmarks' => 'Закладки',
			'labels.books' => 'Книги',
			'labels.color' => 'Цвет',
			'labels.commentaries' => 'Комментарии',
			'labels.commentary' => 'Комментарий',
			'labels.community' => 'Сообщество',
			'labels.completed' => 'Завершено',
			'labels.crossReferences' => 'Перекрестные ссылки',
			'labels.days' => 'Дни',
			'labels.dictionary' => 'Словарь',
			'labels.discord' => 'Discord',
			'labels.duration' => 'Продолжительность',
			'labels.following' => 'Активные',
			'labels.footnotes' => 'Сноски',
			'labels.help' => 'Помощь',
			'labels.highlightStyles' => 'Стили выделения',
			'labels.instagram' => 'Инстаграм',
			'labels.interlinear' => 'Подстрочный',
			'labels.language' => 'Язык',
			'labels.layout' => 'Макет',
			'labels.lexicon' => 'Лексикон',
			'labels.licenses' => 'Лицензии',
			'labels.locations' => 'Локации',
			'labels.name' => 'Имя',
			'labels.note' => 'Примечание',
			'labels.notebook' => 'Блокнот',
			'labels.notebooks' => 'Блокноты',
			'labels.notes' => 'Примечания',
			'labels.paragraphs' => 'Абзацы',
			'labels.resources' => 'Ресурсы',
			'labels.scope' => 'Объем',
			'labels.search' => 'Поиск',
			'labels.selection' => 'Выбор',
			'labels.settings' => 'Настройки',
			'labels.source' => 'Источник',
			'labels.study' => 'Изучение',
			'labels.style' => 'Стиль',
			'labels.text' => 'Текст',
			'labels.toolbar' => 'Панель инструментов',
			'labels.toolbars' => 'Панели инструментов',
			'labels.type' => 'Тип',
			'labels.version' => 'Версия',
			'labels.visibility' => 'Видимость',
			'strongSheet.interlinearWord' => 'Подстрочное слово',
			'strongSheet.lexicon' => 'Лексикон',
			'strongSheet.legend' => 'Легенда',
			'strongSheet.openInSearch' => 'Открыть в поиске',
			'strongSheet.usage' => 'Использование',
			'strongSheet.inflected' => 'измененный',
			'strongSheet.transliteration' => 'Транслитерация',
			'strongSheet.root' => 'Корень',
			'strongSheet.strongsId' => ({required Object id}) => 'Стронга ${id}',
			'strongSheet.rootWord' => 'Корневое слово',
			'strongSheet.pronunciation' => 'Произношение',
			'strongSheet.strongsDefinition' => 'Определение Стронга',
			'strongSheet.biblicalUsage' => 'Библейское использование',
			'strongSheet.definition' => 'Определение',
			'strongSheet.examples' => 'Примеры',
			'strongSheet.examplesPrefix' => 'Примеры:',
			'strongSheet.partOfSpeech' => 'Часть речи',
			'strongSheet.derivation' => 'Вывод',
			'strongSheet.morphology' => 'Морфология',
			'strongSheet.relatedTerms' => 'Связанные термины',
			'strongSheet.morphologyInfo' => 'Информация о морфологии',
			'strongSheet.definitionLegend' => 'Легенда определения Стронга',
			'strongSheet.optionalWord' => 'Необязательное слово',
			'strongSheet.optionalWordDescription' => 'Отмечает слово или слог, который может быть дополнен основным словом.',
			'strongSheet.addedWord' => 'Добавлено слово на иврите или греческом языке.',
			'strongSheet.addedWordDescription' => 'Отмечает слово, включенное в английский перевод, даже если оно отсутствует в иврите или греческом языке.',
			'strongSheet.explanation' => 'Объяснение',
			'strongSheet.renderingExplanation' => 'Курсив в конце изображения объясняет отличие от обычной формы.',
			'strongSheet.concordance' => 'Согласие',
			'bibleDetails.onlineOnly' => 'Только онлайн',
			'bibleDetails.onlineDescription' => ({required Object source}) => 'Эта Библия транслируется с ${source}, поэтому для нее требуется подключение к Интернету.',
			'bibleDetails.studyBible' => 'Учебная Библия',
			'bibleDetails.audioBible' => 'Аудио Библия',
			'bibleDetails.onDevice' => 'На устройстве',
			'bibleDetails.onDeviceDescription' => 'Эта Библия загружена на ваше устройство, поэтому вы можете искать ее и читать в автономном режиме.',
			'bibleDetails.studyBibleDescription' => 'Включает подстрочные и морфологические данные. Нажмите и удерживайте любое слово во время чтения, чтобы увидеть оригинал на греческом или иврите.',
			'bibleDetails.readingBible' => 'Библия для чтения',
			'bibleDetails.readingBibleDescription' => 'Не включает подстрочные или морфологические данные.',
			'bibleDetails.nativeHeadings' => 'Исходные заголовки',
			'bibleDetails.nativeHeadingsDescription' => 'В эту Библию включены заголовки.',
			'bibleDetails.syntheticHeadings' => 'Синтетические заголовки',
			'bibleDetails.syntheticHeadingsDescription' => 'Заголовки синтетически вставлены в эту Библию из BSB.',
			'bibleDetails.noHeadings' => 'Нет заголовков',
			'bibleDetails.noHeadingsDescription' => 'В этой Библии нет заголовков.',
			'bibleDetails.audioSupportDescription' => 'Поддерживает ли эта Библия аудиовоспроизведение.',
			'bibleDetails.redLetters' => 'Красные буквы',
			'bibleDetails.redLettersDescription' => 'Поддерживаются ли красные буквы в этой Библии.',
			'bibleDetails.footnotesDescription' => 'Есть ли в этой Библии сноски.',
			'bibleDetails.paragraphsDescription' => 'Включает ли эта Библия абзацы.',
			'bibleDetails.addRemoveBibles' => 'Добавить и удалить Библии',
			'bibleDetails.verseNumbering' => 'Нумерация стихов',
			'emptyStates.noCommentaries' => 'Комментарии не найдены',
			'emptyStates.noMatchingWords' => 'Нет подходящих слов',
			'emptyStates.noMatchingTerms' => 'Нет соответствующих условий',
			'emptyStates.noMatchingPlans' => 'Нет подходящих библейских планов.',
			'emptyStates.noMatchingAnnotations' => 'Нет соответствующих аннотаций.',
			'emptyStates.noSearchResults' => 'Результаты поиска не найдены',
			'emptyStates.tryAnotherSearch' => 'Попробуйте другой поиск',
			'emptyStates.noCommentariesAdded' => 'Вы не добавили ни одного комментария.',
			'emptyStates.noAnnotations' => 'Вы не создали ни одной аннотации.',
			'emptyStates.noBookmarks' => 'Вы не создали ни одной закладки.',
			'emptyStates.noNotebooks' => 'Вы не создали ни одного блокнота. Блокноты позволяют систематизировать ваши аннотации.',
			'emptyStates.noPlans' => 'Вы пока не выполняете ни одного плана чтения. Найдите один, чтобы начать читать Библию.',
			'annotationUi.yourAnnotations' => 'Ваши аннотации',
			'annotationUi.annotate' => 'Аннотировать',
			'annotationUi.withNotes' => 'С примечаниями',
			'annotationUi.withoutNotes' => 'Без примечаний',
			'annotationUi.mostRecent' => 'Самый последний',
			'annotationUi.location' => 'Расположение',
			'annotationUi.deleteAnnotation' => 'Удалить аннотацию',
			'annotationUi.deleteConfirmation' => 'Вы уверены, что хотите удалить эту аннотацию?',
			'annotationUi.annotationCount' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(count, one: '${count} аннотация', few: '${count} аннотации', many: '${count} аннотаций', other: '${count} аннотации', ), 
			'annotationUi.annotatedTime' => ({required Object time}) => 'С аннотацией ${time}',
			'notebookUi.yourNotebooks' => 'Ваши блокноты',
			'notebookUi.hidden' => 'Скрытый',
			'notebookUi.hideDescription' => 'Скройте аннотации в этом блокноте, чтобы они не появлялись в Библии.',
			'notebookUi.showDescription' => 'Покажите аннотации из этой тетради в Библии.',
			'notebookUi.defaultDescription' => 'Постоянный блокнот для неназначенных аннотаций.',
			'notebookUi.create' => 'Создать блокнот',
			'notebookUi.edit' => 'Редактировать блокнот',
			'notebookUi.delete' => 'Удалить блокнот',
			'notebookUi.deleteNamedConfirmation' => ({required Object name}) => 'Вы уверены, что хотите удалить «${name}»?',
			'notebookUi.deleteWithAnnotations' => ({required Object name, required Object annotations}) => '«${name}» имеет ${annotations}. Хотите ли вы также удалить их или оставить в блокноте по умолчанию?',
			'notebookUi.keepInDefault' => 'Оставить по умолчанию',
			'notebookUi.deleteAnnotations' => 'Удалить аннотации',
			'highlightStyleUi.yourStyles' => 'Ваши стили выделения',
			'highlightStyleUi.create' => 'Создать стиль',
			'highlightStyleUi.edit' => 'Редактировать стиль',
			'highlightStyleUi.duplicate' => 'У вас уже есть этот стиль',
			'highlightStyleUi.delete' => 'Удалить стиль',
			'highlightStyleUi.deleteNamedConfirmation' => ({required Object name}) => 'Вы уверены, что хотите удалить «${name}»?',
			'highlightStyleUi.deleteWithAnnotations' => ({required Object name, required Object annotations}) => '«${name}» имеет ${annotations}. Вы хотите их тоже удалить или оставить?',
			'highlightStyleUi.keepAnnotations' => 'Сохранять аннотации',
			'highlightStyleUi.deleteAnnotations' => 'Удалить аннотации',
			'highlightStyleUi.updateAnnotations' => 'Обновить аннотации',
			'highlightStyleUi.updateWithAnnotations' => ({required Object name, required Object annotations}) => '«${name}» имеет ${annotations}. Хотите обновить их, чтобы использовать новый стиль, или оставить как есть?',
			'highlightStyleUi.leaveAsIs' => 'Оставить как есть',
			'highlightStyleUi.label' => 'Название',
			'toolbarSettings.mainToolbar' => 'Главная панель инструментов',
			'toolbarSettings.verseSelection' => 'Выбор стиха',
			'toolbarSettings.textSelection' => 'Выбор текста',
			'toolbarSettings.shownForMain' => 'Отображается, когда ничего не выбрано.',
			'toolbarSettings.shownForVerses' => 'Отображается, когда выбран стих.',
			'toolbarSettings.shownForText' => 'Отображается при длительном нажатии текста внутри стихов.',
			'toolbarSettings.gestures' => 'Жесты',
			'toolbarSettings.longPress' => 'Длительное нажатие',
			'toolbarSettings.mainLongPressDescription' => 'Ярлык при длительном нажатии на панель инструментов.',
			'toolbarSettings.verseLongPressDescription' => 'Ярлык при длительном нажатии выбора стиха.',
			'toolbarSettings.textLongPressDescription' => 'Ярлык при длительном нажатии на выделенный текст.',
			'toolbarSettings.hideToolbar' => 'Скрывать',
			'toolbarSettings.hideToolbarDescription' => 'Скройте панель инструментов при прокрутке вниз, чтобы получить захватывающий вид Библии.',
			'toolbarSettings.pinToolbar' => 'Закрепить',
			'toolbarSettings.pinToolbarDescription' => 'Закрепите панель инструментов внизу страницы.',
			'toolbarSettings.expandToAnnotation' => 'Развернуть до аннотации',
			'toolbarSettings.expandTextDescription' => 'Длительное нажатие на аннотированное слово выделяет весь выделенный диапазон.',
			'toolbarSettings.expandVerseDescription' => 'Нажатие на стих выбирает полный аннотированный стих.',
			'toolbarSettings.rangeSelection' => 'Выбор диапазона',
			'toolbarSettings.rangeSelectionDescription' => 'Нажатие на второй стих выбирает все стихи между ним и первым.',
			'toolbarSettings.mainShortcut' => 'Ярлык на главной панели инструментов',
			'toolbarSettings.verseShortcut' => 'Ярлык выбора стиха',
			'toolbarSettings.textShortcut' => 'Ярлык выбора текста',
			'themeSettings.title' => 'Тема и макет',
			'themeSettings.brightness' => 'Яркость',
			'themeSettings.font' => 'Шрифт',
			'themeSettings.fontSizeSpacing' => 'Размер шрифта и интервал',
			'themeSettings.greekFontSizeSpacing' => 'Размер и интервал греческого шрифта',
			'themeSettings.hebrewFontSizeSpacing' => 'Размер и интервал ивритского шрифта',
			'themeSettings.system' => 'Система',
			'themeSettings.systemTextSizeDescription' => 'Используйте предпочтительный размер текста вашего устройства.',
			'themeSettings.defaultSizeDescription' => 'Используйте размер и интервал шрифта по умолчанию.',
			'themeSettings.redLetters' => 'Красные буквы',
			'themeSettings.redLettersDescription' => 'Покажите слова Иисуса красным цветом.',
			'themeSettings.sectionHeadings' => 'Заголовки разделов',
			'themeSettings.verseNumbers' => 'Номера стихов',
			'themeSettings.paragraphsDescription' => 'Разбейте стихи на абзацы.',
			'themeSettings.footnotesDescription' => 'Показывать маркеры сносок внутри текста.',
			'biblePlans.find' => 'Найдите библейский план',
			'biblePlans.startPlanQuestion' => 'Начать план?',
			'biblePlans.reviewAndReflect' => 'Обзор и размышление',
			'biblePlans.startPlan' => 'Начать план',
			'biblePlans.dailyReminders' => 'Ежедневные напоминания',
			'biblePlans.dailyRemindersDescription' => 'Установите или измените время ежедневного напоминания об этом плане.',
			'biblePlans.dailyAt' => ({required Object time}) => 'Ежедневно в ${time}',
			'biblePlans.reminderDiscoveryTitle' => 'Добавить ежедневное напоминание?',
			'biblePlans.reminderDiscoveryBody' => ({required Object name}) => 'Хотите, чтобы Lux ежедневно напоминал вам продолжить план «${name}»?',
			'biblePlans.addReminder' => 'Добавить напоминание',
			'biblePlans.noReminder' => 'Нет',
			'biblePlans.deleteReminder' => 'Удалить напоминание?',
			'biblePlans.deleteReminderConfirmation' => ({required Object name}) => 'Вы уверены, что хотите удалить ежедневное напоминание для плана «${name}»?',
			'biblePlans.reminderNotificationChannelName' => 'Напоминания о библейских планах',
			'biblePlans.reminderNotificationChannelDescription' => 'Ежедневные напоминания о ваших библейских планах',
			'biblePlans.reminderNotificationTitle' => ({required Object name}) => 'Прочитайте «${name}»',
			'biblePlans.reminderNotificationBody' => ({required Object reading}) => 'Сегодняшнее чтение: ${reading}',
			'biblePlans.reminderPermissionDeniedTitle' => 'Уведомления отключены',
			'biblePlans.reminderPermissionDeniedBody' => 'Чтобы сохранить это напоминание, разрешите Lux отправлять уведомления в настройках.',
			'biblePlans.openNotificationSettings' => 'Открыть настройки',
			'biblePlans.reminderSchedulingFailedTitle' => 'Не удалось установить напоминание',
			'biblePlans.reminderSchedulingFailedBody' => 'Lux не удалось установить это напоминание. Повторите попытку.',
			'biblePlans.reminderSaved' => ({required Object name, required Object time}) => 'Напоминание для плана «${name}» сохранено на ${time} каждый день.',
			'biblePlans.stopPlan' => 'Остановить план',
			'biblePlans.stopPlanDescription' => 'Удалите этот план и его ход.',
			'biblePlans.readEntireChapter' => 'Читать всю главу',
			'biblePlans.readInContext' => 'Читать в контексте',
			'biblePlans.startNew' => 'Начать заново',
			'biblePlans.day' => ({required Object day}) => 'День ${day}',
			'biblePlans.dayCount' => ({required num count}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('ru'))(count, one: '${count} день', few: '${count} дня', many: '${count} дней', other: '${count} дня', ), 
			'biblePlans.stopConfirmation' => ({required Object name}) => 'Вы уверены, что хотите остановить "${name}"? Ваш прогресс будет потерян.',
			'biblePlans.completed' => ({required Object name}) => '«${name}» завершено.',
			'biblePlans.addPlan' => 'Добавить библейский план',
			'searchUi.searchBible' => 'Поиск в Библии',
			'searchUi.startSearch' => 'Начать поиск',
			'searchUi.searchPrompt' => 'Введите ключевое слово, например свет, слово или мудрость, затем нажмите Enter на клавиатуре.',
			'searchUi.usingTranslation' => ({required Object translation}) => 'Использование ${translation} для поиска',
			'searchUi.unsupportedTranslation' => ({required Object translation}) => '${translation} в настоящее время не поддерживает поиск. Вместо этого используйте самую последнюю Учебную Библию.',
			'searchUi.wordOrPhraseHint' => 'Поиск слова или фразы',
			'searchUi.wordHint' => 'Поиск слова',
			'searchUi.strongNumberHint' => 'Найдите номер Стронга (например, H125)',
			'onboarding.skipQuestion' => 'Пропустить адаптацию?',
			'onboarding.skipConfirmation' => 'Вы уверены, что хотите пропустить знакомство с приложением? Его можно запустить снова в разделе «Настройки» > «Справка».',
			'onboarding.getStarted' => 'Начать',
			'onboarding.learnLux' => 'Узнайте, как использовать Lux',
			'onboarding.checklistDescription' => 'Заполните контрольный список ниже, чтобы узнать, как использовать Lux.',
			'onboarding.skipHint' => 'Торопитесь? Нажмите ✕, чтобы пропустить.',
			'tutorials.dontShowAgain' => 'Больше не показывать',
			'audio.timer' => 'Аудио Таймер',
			'audio.fiveMinutes' => '5 минут',
			'audio.tenMinutes' => '10 минут',
			'audio.fifteenMinutes' => '15 минут',
			'audio.thirtyMinutes' => '30 минут',
			'audio.oneHour' => '1 час',
			'audio.loadError' => 'Не удалось загрузить аудио',
			'audio.connectionError' => 'Проверьте подключение к Интернету или повторите попытку позже.',
			'audio.unavailable' => 'Звук для этой Библии недоступен.',
			'audio.chooseBible' => 'Чтобы прослушать эту главу, выберите Библию с аудиозаписью.',
			'audio.switchRequired' => 'Чтобы прослушать этот отрывок, переключитесь на Библию с аудиозаписью.',
			'audio.rewindTenSeconds' => 'На 10 секунд назад',
			'audio.fastForwardTenSeconds' => 'На 10 секунд вперед',
			'audio.notificationChannelName' => 'Аудио воспроизведение Библии',
			'audio.notificationChannelDescription' => 'Элементы управления воспроизведением аудио Библии',
			'interlinearUi.interlinearBible' => 'Подстрочная Библия',
			'interlinearUi.direction' => 'Направление подстрочника',
			'interlinearUi.reverse' => 'Обратное',
			'interlinearUi.forward' => 'Вперед',
			'interlinearUi.reverseDescription' => 'Слова появляются в английском порядке чтения.',
			'interlinearUi.forwardDescription' => 'Слова появляются в исходном еврейском или греческом порядке.',
			'interlinearUi.studyBibleExplanation' => 'Учебные Библии составлены с использованием дословных тегов Стронга и морфологических тегов, что делает возможной подстрочную лексическую разбивку. Вместо этого используйте самую последнюю Учебную Библию.',
			'interlinearUi.usingTranslation' => ({required Object translation}) => 'Использование ${translation} для подстрочного текста',
			'chapterUnavailable.title' => ({required Object selectedTranslation, required Object testament}) => '${selectedTranslation} не включает ${testament}.',
			'chapterUnavailable.subtitle' => ({required Object testament, required Object fallbackTranslation}) => 'Показываем вашу последнюю ${testament} Библию, ${fallbackTranslation}.',
			'verseNumbering.referenceLabel' => ({required Object translation, required Object reference}) => '${translation} ${reference}',
			'verseNumbering.explanation' => ({required Object translation, required Object reference, required Object originalReference}) => '${translation} нумерует главы и стихи иначе, чем в большинстве английских переводов.\n\nТекст, показанный здесь в ${reference}, взят из ${originalReference} в ${translation} и переназначен, чтобы соответствовать другим переводам.',
			'compare.unavailable' => ({required Object translation}) => '${translation} не включает этот выбор.',
			'commentaryUi.introTo' => ({required Object book}) => 'Знакомство с ${book}',
			'searchLocations.currentBook' => 'Текущая книга',
			'searchLocations.testaments' => 'Заветы',
			'searchLocations.books' => 'Книги',
			'themeOptions.auto' => 'Авто',
			'themeOptions.light' => 'Светлая',
			'themeOptions.dark' => 'Тёмная',
			'themeOptions.extraTiny' => 'Очень мелкий',
			'themeOptions.tiny' => 'Мелкий',
			'themeOptions.small' => 'Маленький',
			'themeOptions.standard' => 'Стандартный',
			_ => null,
		} ?? switch (path) {
			'themeOptions.large' => 'Большой',
			'themeOptions.huge' => 'Огромный',
			'themeOptions.extraHuge' => 'Очень крупный',
			'themeOptions.nativeAndSynthetic' => 'Исходные и добавленные',
			'themeOptions.native' => 'Исходные',
			'themeOptions.none' => 'Нет',
			'themeOptions.allHeadingsDescription' => 'Покажите заголовки в переводах, которые их поддерживают, и синтетически вставляйте заголовки разделов BSB в английские переводы без них изначально.',
			'themeOptions.nativeHeadingsDescription' => 'Показывать заголовки в переводах, которые их поддерживают.',
			'themeOptions.noHeadingsDescription' => 'Не показывать заголовки разделов',
			'toolbarPresets.reader' => 'Читатель',
			'toolbarPresets.noteTaker' => 'Блокнот',
			'toolbarPresets.studier' => 'Студент',
			'toolbarPresets.readerDescription' => 'Настроен для чтения без отвлекающих факторов и быстрой навигации.',
			'toolbarPresets.noteTakerDescription' => 'Настроен для выделения и создания заметок.',
			'toolbarPresets.studierDescription' => 'Настроен на перекрестные ссылки, комментарии и глубокое изучение.',
			'commentaryTypes.matthewHenryDescription' => 'Краткий, религиозный комментарий ко всей Библии пуританской традиции. Теплый, практичный и легко читаемый.',
			'commentaryTypes.jamiesonFaussetBrownDescription' => 'Компактный, поэтапный комментарий ко всей Библии. Сбалансированный и доступный.',
			'commentaryTypes.calvinDescription' => 'Классическое изложение реформатора. Глубокий и доктринальный.',
			'strongDefinition.addedLabel' => 'добавлен:',
			'strongDefinition.idiomLabel' => 'идиома:',
			'strongDefinition.addedWord' => 'Добавлено слово',
			'strongDefinition.idiomaticRendering' => 'Идиоматический рендеринг',
			'strongDefinition.addedWordDescription' => 'Отмечает слово, указанное рядом с определяемым еврейским или греческим словом.',
			'strongDefinition.idiomaticRenderingDescription' => 'Отмечает перевод, который отражает выражение, характерное для иврита или греческого языка.',
			'planTypes.throughTheBible' => 'Через Библию',
			'planTypes.chronological' => 'Один год в хронологическом порядке',
			'planTypes.oldAndNewTestament' => 'Ветхий и Новый Завет',
			'planTypes.everyDayInTheWord' => 'Каждый день в слове',
			'planTypes.mcheyne' => 'М\'Чейн',
			'planTypes.literaryStudy' => 'Литературное исследование',
			'planTypes.differentTopics' => 'Разные темы',
			'planTypes.newTestamentPsalmsProverbs' => 'Новый Завет, Псалмы и Притчи',
			'planTypes.fiveByFiveByFive' => '5x5x5 Новый Завет',
			'planTypes.gospelsAndEpistles' => 'Евангелие и послания',
			'planTypes.pentateuchAndHistory' => 'Пятикнижие и история Израиля',
			'planTypes.chroniclesAndProphets' => 'Летописи и Пророки',
			'planTypes.psalmsAndWisdom' => 'Псалмы и литература мудрости',
			'planTypes.mcheyneDescription' => 'Классический план с четырьмя короткими чтениями в день. Вы читаете Ветхий Завет один раз, а Новый Завет и Псалмы — два раза в год.',
			'planTypes.chronologicalDescription' => 'Прочитайте всю Библию за год, расположив ее в том порядке, в котором события действительно произошли.',
			'planTypes.throughTheBibleDescription' => 'Прочтите всю Библию за год, от Бытия до Откровения.',
			'planTypes.gospelsAndEpistlesDescription' => 'Проведите год в Новом Завете, путешествуя по Евангелиям и посланиям апостолов.',
			'planTypes.everyDayInTheWordDescription' => 'Четыре чтения в день Ветхого Завета, Нового Завета, Псалмов и Притчей, охватывающих всю Библию за год, плюс Псалмы и Притчи дважды.',
			'planTypes.literaryStudyDescription' => 'Изучите Библию в течение года, сгруппированную по литературным стилям, проходя через рассказы, поэзию и письма.',
			'planTypes.chroniclesAndProphetsDescription' => 'Год, в котором история Хроник сочетается с посланиями Пророков.',
			'planTypes.pentateuchAndHistoryDescription' => 'Путешествие по пяти книгам Моисея и истории Израиля за год.',
			'planTypes.psalmsAndWisdomDescription' => 'Проведите год за чтением псалмов и книг мудрости, таких как Притчи, Иов и Экклезиаст.',
			'planTypes.oldAndNewTestamentDescription' => 'Читайте вместе Ветхий и Новый Заветы, каждый день по отрывку из каждого.',
			'planTypes.differentTopicsDescription' => 'Каждый день просматривайте разные разделы Священного Писания, исследуя каждую книгу Библии в течение года.',
			'planTypes.newTestamentPsalmsProverbsDescription' => 'Читайте Новый Завет вместе с Псалмами и Притчами в течение года.',
			'planTypes.fiveByFiveByFiveDescription' => 'Читайте по одной главе Нового Завета в день, пять дней в неделю, а затем два дня для повторения и размышления.',
			'planTypes.oldScopeDescription' => 'Читает книги Ветхого Завета.',
			'planTypes.newScopeDescription' => 'Читает книги Нового Завета.',
			'planTypes.wholeScopeDescription' => 'Читает как Ветхий, так и Новый Завет.',
			'planTypes.focused' => 'Сосредоточенный',
			'planTypes.comprehensive' => 'Всесторонний',
			'planTypes.focusedDescription' => 'Охватывает определенный раздел или коллекцию в пределах своей области действия.',
			'planTypes.comprehensiveDescription' => 'Охватывает каждую книгу в пределах своей компетенции.',
			'onboardingSteps.viewCrossReferences' => 'Просмотр перекрестных ссылок',
			'onboardingSteps.annotateVerse' => 'Комментировать стих',
			'onboardingSteps.searchWord' => 'Поиск слова',
			'onboardingSteps.switchBible' => 'Переключите свою Библию',
			'onboardingSteps.navigateChapter' => 'Перейти в другую главу',
			'onboardingSteps.goBack' => 'Возвращаться',
			'onboardingSteps.swipeChapter' => 'Проведите пальцем по экрану, чтобы изменить главу',
			'onboardingSteps.addStudyPanel' => 'Добавить панель исследований',
			'onboardingSteps.customizeToolbar' => 'Настройте свои панели инструментов',
			'onboardingSteps.startBiblePlan' => 'Начать библейский план',
			'onboardingSteps.selectVerse' => 'Коснитесь стиха, чтобы выбрать его.',
			'onboardingSteps.selectWord' => 'Длительное нажатие слова',
			'onboardingSteps.deselectPrefix' => 'Нажмите',
			'onboardingSteps.deselectSuffix' => 'рядом с вашим выбором, чтобы отменить выбор',
			'onboardingSteps.revealToolbar' => 'Прокрутите вверх, чтобы открыть главную панель инструментов.',
			'onboardingSteps.addPanelPrefix' => 'Нажмите',
			'onboardingSteps.addPanelSuffix' => ' → Исследование → Добавить панель исследований и добавьте любую панель исследований.',
			'onboardingSteps.goToChapter' => 'Перейти в другую главу',
			'onboardingSteps.openPrefix' => 'Открыть',
			'onboardingSteps.crossReferencesSuffix' => '→ Исследование → Перекрестные ссылки',
			'onboardingSteps.annotatePrefix' => 'Нажмите',
			'onboardingSteps.annotateSuffix' => 'выделить или добавить заметку',
			'onboardingSteps.searchPrefix' => 'Нажмите',
			'onboardingSteps.searchSuffix' => 'искать это слово повсюду',
			'onboardingSteps.switchBibleDescription' => ({required Object translation}) => 'Коснитесь главной панели инструментов → ${translation}, чтобы переключить Библию.',
			'onboardingSteps.goToChapterDescription' => 'Коснитесь главной панели инструментов, чтобы перейти к другой главе.',
			'onboardingSteps.goBackDescription' => 'Проведите пальцем вправо по панели инструментов, чтобы вернуться назад.',
			'onboardingSteps.swipeChapterDescription' => 'Проведите по Библии влево или вправо, чтобы изменить главу.',
			'onboardingSteps.viewPanelDescription' => 'Проведите пальцем по этой панели вправо, чтобы просмотреть панель исследования.',
			'onboardingSteps.moreSeparator' => ' → Ещё → ',
			'onboardingSteps.customizeToolbarSuffix' => 'Панели инструментов: выберите предустановку или измените ярлыки панели инструментов.',
			'onboardingSteps.startPlanSuffix' => '→ Библейские планы и начните любой библейский план',
			'dictionary.eastons' => 'Библейский словарь Истона',
			'navigation.recents' => 'Недавние',
			'navigation.navigate' => 'Навигация',
			'navigation.book' => 'Книга',
			'navigation.chapter' => 'Глава',
			'navigation.verse' => 'Стих',
			'selectionUi.selected' => 'Выбрано:',
			'selectionUi.sourceApiBible' => 'Источник: [https://api.bible](https://api.bible).',
			'errors.deviceVerificationFailed' => 'Проверка устройства не удалась',
			'errors.deviceVerificationDescription' => 'Для доступа к этой онлайн-Библии требуется действующее устройство и законная установка Lux. Убедитесь, что вы установили Lux из официального магазина приложений, а затем повторите попытку.',
			'errors.generic' => 'Что-то пошло не так',
			'errors.connection' => 'Проверьте подключение к Интернету или повторите попытку позже.',
			'morphology.attributes.type.name' => 'Тип',
			'morphology.attributes.type.description' => 'Грамматическая категория слова.',
			'morphology.attributes.grammaticalCase.name' => 'Падеж',
			'morphology.attributes.grammaticalCase.description' => 'Синтаксическая роль, такая как субъект, объект или владение.',
			'morphology.attributes.gender.name' => 'Род',
			'morphology.attributes.gender.description' => 'Грамматический род: мужской, женский, средний (греческий) или общий (иврит).',
			'morphology.attributes.number.name' => 'Число',
			'morphology.attributes.number.description' => 'Относится ли слово к одному (единственное число), двум (двойственное) или многим (множественное число).',
			'morphology.attributes.person.name' => 'Лицо',
			'morphology.attributes.person.description' => 'К кому относится это слово: 1-й (я/мы), 2-й (вы) или 3-й (он/она/оно/они).',
			'morphology.attributes.state.name' => 'Состояние',
			'morphology.attributes.state.description' => 'Состояние существительного: абсолютное, конструктное или определенное.',
			'morphology.attributes.tense.name' => 'Время',
			'morphology.attributes.tense.description' => 'Глагол – время, сочетающее в себе время и вид.',
			'morphology.attributes.mood.name' => 'Наклонение',
			'morphology.attributes.mood.description' => 'Как выражается действие, например факт, команда или возможность.',
			'morphology.attributes.voice.name' => 'Залог',
			'morphology.attributes.voice.description' => 'Голос: активный, средний или пассивный.',
			'morphology.attributes.degree.name' => 'Степень',
			'morphology.attributes.degree.description' => 'Степень прилагательного или наречия: положительная, сравнительная или превосходная степень.',
			'morphology.attributes.stem.name' => 'Корень',
			'morphology.attributes.stem.description' => 'Основа глагола (биньян), например qal, niphal или piel.',
			'morphology.attributes.aspect.name' => 'Аспект',
			'morphology.attributes.aspect.description' => 'Вид глагола, например совершенный, несовершенный или причастие.',
			'morphology.attributes.prefix.name' => 'Префикс',
			'morphology.attributes.prefix.description' => 'Еврейская буква-предлог с префиксом.',
			'morphology.attributes.particle.name' => 'Частица',
			'morphology.attributes.particle.description' => 'Небольшое неизменяемое слово, часто союз или маркер.',
			'morphology.attributes.code.name' => 'Код',
			'morphology.attributes.code.description' => 'Необработанный код морфологии в том виде, в каком он представлен в исходном тексте.',
			'morphology.types.article.name' => 'Артикль',
			'morphology.types.article.description' => 'Определенный артикль «the».',
			'morphology.types.article.examples' => 'король | Господь',
			'morphology.types.conjunction.name' => 'Союз',
			'morphology.types.conjunction.description' => 'Слово, которое объединяет другие слова или предложения.',
			'morphology.types.conjunction.examples' => 'и|но|для',
			'morphology.types.preposition.name' => 'Предлог',
			'morphology.types.preposition.description' => 'Связывает существительное или местоимение с другими словами.',
			'morphology.types.preposition.examples' => 'в|в|с',
			'morphology.types.adverb.name' => 'Наречие',
			'morphology.types.adverb.description' => 'Изменяет глагол, прилагательное или другое наречие.',
			'morphology.types.adverb.examples' => 'быстро|сейчас|там',
			'morphology.types.negativeAdverb.name' => 'Отрицательное наречие',
			'morphology.types.negativeAdverb.description' => 'Наречие, выражающее отрицание.',
			'morphology.types.negativeAdverb.examples' => 'нет|никогда',
			'morphology.types.adjective.name' => 'Прилагательное',
			'morphology.types.adjective.description' => 'Слово, описывающее существительное.',
			'morphology.types.adjective.examples' => 'великий|святой|мудрый',
			'morphology.types.noun.name' => 'Существительное',
			'morphology.types.noun.description' => 'Человек, место, вещь или идея.',
			'morphology.types.noun.examples' => 'город|вода|любовь',
			'morphology.types.properNoun.name' => 'Имя собственное',
			'morphology.types.properNoun.description' => 'Конкретное имя человека, места или предмета.',
			'morphology.types.properNoun.examples' => 'Давид|Иерусалим|Израиль',
			'morphology.types.number.name' => 'Число',
			'morphology.types.number.description' => 'Кардинальное число.',
			'morphology.types.number.examples' => 'три|двенадцать|тысячи',
			'morphology.types.ordinalNumber.name' => 'Порядковый номер',
			'morphology.types.ordinalNumber.description' => 'Порядковый номер, например «первый» или «второй».',
			'morphology.types.ordinalNumber.examples' => 'первый|десятый|семидесятый',
			'morphology.types.pronoun.name' => 'Местоимение',
			'morphology.types.pronoun.description' => 'Слово, заменяющее существительное.',
			'morphology.types.pronoun.examples' => 'он|она|они',
			'morphology.types.personalPronoun.name' => 'Личное местоимение',
			'morphology.types.personalPronoun.description' => 'Местоимение, обозначающее конкретного человека.',
			'morphology.types.personalPronoun.examples' => 'я|ты|мы',
			'morphology.types.demonstrativePronoun.name' => 'Указательное местоимение',
			'morphology.types.demonstrativePronoun.description' => 'Местоимение, указывающее на что-либо.',
			'morphology.types.demonstrativePronoun.examples' => 'это|эти|те',
			'morphology.types.interrogativePronoun.name' => 'Вопросительное местоимение',
			'morphology.types.interrogativePronoun.description' => 'Местоимение, используемое для задания вопроса.',
			'morphology.types.interrogativePronoun.examples' => 'кто?|что?|что?',
			'morphology.types.indefinitePronoun.name' => 'Неопределённое местоимение',
			'morphology.types.indefinitePronoun.description' => 'Местоимение, обозначающее неспецифические сущности.',
			'morphology.types.indefinitePronoun.examples' => 'кто-то|кто-то|ничего',
			'morphology.types.reciprocalPronoun.name' => 'Взаимное местоимение',
			'morphology.types.reciprocalPronoun.description' => 'Местоимение, выражающее взаимное действие.',
			'morphology.types.reciprocalPronoun.examples' => 'друг друга | друг друга',
			'morphology.types.reflexivePronoun.name' => 'Возвратное местоимение',
			'morphology.types.reflexivePronoun.description' => 'Местоимение, возвращающее к предмету.',
			'morphology.types.reflexivePronoun.examples' => 'сам|сами',
			'morphology.types.relativePronoun.name' => 'Относительное местоимение',
			'morphology.types.relativePronoun.description' => 'Местоимение, вводящее придаточное предложение.',
			'morphology.types.relativePronoun.examples' => 'кто|который|что',
			'morphology.types.particle.name' => 'Частица',
			'morphology.types.particle.description' => 'Небольшое неизменяемое слово.',
			'morphology.types.particle.examples' => 'действительно|сейчас',
			'morphology.types.negativeParticle.name' => 'Отрицательная частица',
			'morphology.types.negativeParticle.description' => 'Частица, обозначающая отрицание.',
			'morphology.types.negativeParticle.examples' => 'нет|нет',
			'morphology.types.interrogativeParticle.name' => 'Вопросительная частица',
			'morphology.types.interrogativeParticle.description' => 'Частица, обозначающая вопрос.',
			'morphology.types.interrogativeParticle.examples' => '(префикс на иврите ה, английского эквивалента нет)',
			'morphology.types.demonstrativeParticle.name' => 'Демонстративная частица',
			'morphology.types.demonstrativeParticle.description' => 'Указательная частица, например «вот».',
			'morphology.types.demonstrativeParticle.examples' => 'вот | вот',
			'morphology.types.genericParticle.name' => 'Родовая частица',
			'morphology.types.genericParticle.description' => 'Частица общего назначения.',
			'morphology.types.genericParticle.examples' => 'действительно | действительно',
			'morphology.types.relativeParticle.name' => 'Относительная частица',
			'morphology.types.relativeParticle.description' => 'Частица, вводящая придаточное предложение.',
			'morphology.types.relativeParticle.examples' => 'то, что | что',
			'morphology.types.verb.name' => 'Глагол',
			'morphology.types.verb.description' => 'Слово, выражающее действие или состояние.',
			'morphology.types.verb.examples' => 'писать|быть|идти',
			'morphology.types.pronominalSuffix.name' => 'Местоименный суффикс',
			'morphology.types.pronominalSuffix.description' => 'Местоимение, слитое с окончанием глагола или существительного (иврит).',
			'morphology.types.pronominalSuffix.examples' => 'его рука|их земля|ее голос',
			'morphology.types.directObjectMarker.name' => 'Прямой маркер объекта',
			'morphology.types.directObjectMarker.description' => 'Еврейское אֵת, обозначающее определенный прямой объект.',
			'morphology.types.directObjectMarker.examples' => 'אֵת (нет английского эквивалента)',
			'morphology.types.punctuation.name' => 'Пунктуация',
			'morphology.types.punctuation.description' => 'Знак препинания.',
			'morphology.types.punctuation.examples' => '.|,|;',
			'morphology.types.interjection.name' => 'Междометие',
			'morphology.types.interjection.description' => 'Короткое восклицание, выражающее эмоции.',
			'morphology.types.interjection.examples' => 'о!|увы!',
			'morphology.types.indeclinable.name' => 'Несклоняемый',
			'morphology.types.indeclinable.description' => 'Слово, не меняющее форму при изменении.',
			'morphology.types.indeclinable.examples' => 'Осанна|Аллилуйя',
			'morphology.types.hebraism.name' => 'заимствованное слово на иврите',
			'morphology.types.hebraism.description' => 'Заимствованное слово из иврита или арамейского языка, перенесенное в греческий язык.',
			'morphology.types.hebraism.examples' => 'Аминь|Осанна|Саваоф',
			'morphology.types.unknown.name' => 'Неизвестный',
			'morphology.types.unknown.description' => 'Морфологический код, который не распознан синтаксическим анализатором.',
			'morphology.types.unknown.examples' => '',
			'morphology.person.first.name' => '1-й человек',
			'morphology.person.first.description' => 'Говорящий: «Я» или «мы».',
			'morphology.person.first.examples' => 'Я|мы идем|я говорил',
			'morphology.person.second.name' => '2-й человек',
			'morphology.person.second.description' => 'Адресат, «вы» (единственное или множественное число).',
			'morphology.person.second.examples' => 'ты идешь|вы (мн.) слушаете|вы видели',
			'morphology.person.third.name' => '3-е лицо',
			'morphology.person.third.description' => 'Вечеринка, о которой идет речь.',
			'morphology.person.third.examples' => 'он бежит|она говорит|они собрались',
			'morphology.gender.masculine.name' => 'Мужской род',
			'morphology.gender.masculine.description' => 'Мужской грамматический род, по традиции используется для лиц мужского пола и многих существительных.',
			'morphology.gender.masculine.examples' => 'отец|сын|король',
			'morphology.gender.feminine.name' => 'Женственный',
			'morphology.gender.feminine.description' => 'Женский грамматический род, по традиции используется для обозначения лиц женского пола и многих существительных.',
			'morphology.gender.feminine.examples' => 'мать|дочь|королева',
			'morphology.gender.neuter.name' => 'Средний',
			'morphology.gender.neuter.description' => 'Греческий средний род, ни мужской, ни женский.',
			'morphology.gender.neuter.examples' => 'ребенок (τέκνον)|подарок (δῶρον)',
			'morphology.gender.common.name' => 'Общий',
			'morphology.gender.common.description' => 'Общий род в иврите, где форма служит как мужскому, так и женскому роду.',
			'morphology.gender.common.examples' => 'крупный рогатый скот|голос',
			'morphology.number.singular.name' => 'Единственное число',
			'morphology.number.singular.description' => 'Относится к одному.',
			'morphology.number.singular.examples' => 'книга|мужчина|один камень',
			'morphology.number.plural.name' => 'Множественное число',
			'morphology.number.plural.description' => 'Относится к двум и более.',
			'morphology.number.plural.examples' => 'книги|мужчины|камни',
			'morphology.number.dual.name' => 'Двойной',
			'morphology.number.dual.description' => 'Относится к натуральной паре (только на иврите).',
			'morphology.number.dual.examples' => 'руки|глаза|два дня',
			'morphology.kCase.nominative.name' => 'Именительный падеж',
			'morphology.kCase.nominative.description' => 'Обозначает подлежащее предложения.',
			'morphology.kCase.nominative.examples' => 'Бог создал|царь видит',
			'morphology.kCase.genitive.name' => 'Родительный падеж',
			'morphology.kCase.genitive.description' => 'Указывает на владение или происхождение, часто переводится как «из».',
			'morphology.kCase.genitive.examples' => 'Сын Божий|Царство Небесное',
			'morphology.kCase.dative.name' => 'Дательный падеж',
			'morphology.kCase.dative.description' => 'Обозначает косвенный объект, часто «кому» или «за».',
			'morphology.kCase.dative.examples' => 'дал ему | поговорил с ними',
			'morphology.kCase.accusative.name' => 'Винительный падеж',
			'morphology.kCase.accusative.description' => 'Отмечает прямой объект.',
			'morphology.kCase.accusative.examples' => 'видел его|люби своего соседа',
			'morphology.kCase.vocative.name' => 'Звательный падеж',
			'morphology.kCase.vocative.description' => 'Используется по прямому адресу.',
			'morphology.kCase.vocative.examples' => 'Господи!|Отец!|Друг!',
			'morphology.state.absolute.name' => 'Абсолютный',
			'morphology.state.absolute.description' => 'Независимая форма существительного по умолчанию.',
			'morphology.state.absolute.examples' => 'король | слово',
			'morphology.state.construct.name' => 'Построить',
			'morphology.state.construct.description' => 'Связан со следующим существительным, выражающим «X из Y».',
			'morphology.state.construct.examples' => 'царь Израиля | слово Господне',
			'morphology.state.determined.name' => 'Определенный',
			'morphology.state.determined.description' => 'Помечено как определенное, часто по артиклю.',
			'morphology.state.determined.examples' => 'король|слово',
			'morphology.stem.qal.name' => 'Кал',
			'morphology.stem.qal.description' => 'Простая активная основа, основное действие глагола.',
			'morphology.stem.qal.examples' => 'он написал|она услышала',
			'morphology.stem.qalPassive.name' => 'Кал пассивный',
			'morphology.stem.qalPassive.description' => 'Редкий пассив простой основы.',
			'morphology.stem.qalPassive.examples' => 'это было принято',
			'morphology.stem.niphal.name' => 'Нифаль',
			'morphology.stem.niphal.description' => 'Простая пассивная или рефлексивная основа.',
			'morphology.stem.niphal.examples' => 'его убили|они собрались сами',
			'morphology.stem.piel.name' => 'Пиль',
			'morphology.stem.piel.description' => 'Интенсивная или фактивная активная основа.',
			'morphology.stem.piel.examples' => 'он похвалил|он благословил|он разбил',
			'morphology.stem.pual.name' => 'Пуал',
			'morphology.stem.pual.description' => 'Пассив пиеля.',
			'morphology.stem.pual.examples' => 'его хвалили',
			'morphology.stem.hiphil.name' => 'Хифил',
			'morphology.stem.hiphil.description' => 'Причинно-активная основа.',
			'morphology.stem.hiphil.examples' => 'он заставил написать|он вывел',
			'morphology.stem.hophal.name' => 'Хофал',
			'morphology.stem.hophal.description' => 'Пассив Хифила.',
			'morphology.stem.hophal.examples' => 'его заставили написать',
			'morphology.stem.hithpael.name' => 'Хитпаэль',
			'morphology.stem.hithpael.description' => 'Рефлекторный или реципрокный пилель.',
			'morphology.stem.hithpael.examples' => 'он освятил себя | они гуляли',
			'morphology.stem.nithpael.name' => 'Нитпаэль',
			'morphology.stem.nithpael.description' => 'Редкий рефлексивно-пассивный стебель.',
			'morphology.stem.nithpael.examples' => 'это было искуплено',
			'morphology.aspect.perfect.name' => 'Совершенный вид',
			'morphology.aspect.perfect.description' => 'Завершенное действие обычно переводится как прошлое.',
			'morphology.aspect.perfect.examples' => 'он написал|она говорила',
			'morphology.aspect.imperfect.name' => 'Несовершенный',
			'morphology.aspect.imperfect.description' => 'Незавершенное или будущее действие, часто переводится как будущее или привычное.',
			'morphology.aspect.imperfect.examples' => 'он напишет | он напишет',
			'morphology.aspect.imperative.name' => 'Императив',
			'morphology.aspect.imperative.description' => 'Прямой приказ.',
			'morphology.aspect.imperative.examples' => 'Пишите!|Слушайте!',
			'morphology.aspect.infinitiveConstruct.name' => 'Инфинитивная конструкция',
			'morphology.aspect.infinitiveConstruct.description' => 'Отглагольное существительное в форме конструкции, часто употребляемое с предлогами.',
			'morphology.aspect.infinitiveConstruct.examples' => 'писать | когда пишешь',
			'morphology.aspect.infinitiveAbsolute.name' => 'Инфинитив абсолютный',
			'morphology.aspect.infinitiveAbsolute.description' => 'Самостоятельное отглагольное существительное, часто эмфатическое.',
			'morphology.aspect.infinitiveAbsolute.examples' => 'обязательно умру|напиши тщательно',
			'morphology.aspect.participle.name' => 'Причастие',
			'morphology.aspect.participle.description' => 'Глагольное прилагательное, описывающее продолжающееся действие.',
			'morphology.aspect.participle.examples' => 'пишу|тот, кто слышит',
			'morphology.aspect.consecutiveImperfect.name' => 'Последовательный несовершенный',
			'morphology.aspect.consecutiveImperfect.description' => 'Форма прошедшего повествования: waw + несовершенный.',
			'morphology.aspect.consecutiveImperfect.examples' => 'и он сказал|и они пошли',
			'morphology.aspect.conjunctiveImperfect.name' => 'Союзный имперфект',
			'morphology.aspect.conjunctiveImperfect.description' => 'Несовершенный вид с союзным союзом waw, с будущим или модальным значением.',
			'morphology.aspect.conjunctiveImperfect.examples' => 'и он напишет',
			'morphology.aspect.conjunctivePerfect.name' => 'Союзный совершенный',
			'morphology.aspect.conjunctivePerfect.description' => 'Идеально сочетается с союзным союзом waw, часто будущим или последовательным.',
			'morphology.aspect.conjunctivePerfect.examples' => 'и ты сделаешь, и он будет судить',
			'morphology.aspect.passiveParticiple.name' => 'Пассивное причастие',
			'morphology.aspect.passiveParticiple.description' => 'Пассивная форма причастия qal.',
			'morphology.aspect.passiveParticiple.examples' => 'написано|сохранено',
			'morphology.hebrewMood.jussive.name' => 'Юссив',
			'morphology.hebrewMood.jussive.description' => 'Команда или желание от третьего лица.',
			'morphology.hebrewMood.jussive.examples' => 'Да будет свет|Да благословит тебя Господь',
			'morphology.hebrewMood.cohortative.name' => 'когортативный',
			'morphology.hebrewMood.cohortative.description' => 'Волевой глагол от 1-го лица, например «давайте» или «я буду».',
			'morphology.hebrewMood.cohortative.examples' => 'Пойдём|Я похвалю',
			'morphology.hebrewMood.hSuffix.name' => 'h-суффикс',
			'morphology.hebrewMood.hSuffix.description' => 'Упорное -ah, оканчивающееся на несовершенном, часто похожем на когортативное.',
			'morphology.hebrewMood.hSuffix.examples' => 'Я обязательно приду|позволь мне приблизиться',
			'morphology.tense.present.name' => 'Настоящее',
			'morphology.tense.present.description' => 'Текущее или общее действие.',
			'morphology.tense.present.examples' => 'он любит|они гуляют',
			'morphology.tense.imperfect.name' => 'Несовершенный',
			'morphology.tense.imperfect.description' => 'Непрерывное или повторяющееся действие в прошлом.',
			'morphology.tense.imperfect.examples' => 'он преподавал|они собирались',
			'morphology.tense.future.name' => 'Будущее',
			'morphology.tense.future.description' => 'Действие, которое произойдет.',
			'morphology.tense.future.examples' => 'он придет|они увидят',
			'morphology.tense.aorist.name' => 'Аорист',
			'morphology.tense.aorist.description' => 'Простое прошедшее действие, рассматриваемое в целом.',
			'morphology.tense.aorist.examples' => 'он сказал|они пошли',
			'morphology.tense.perfect.name' => 'Перфект',
			'morphology.tense.perfect.description' => 'Прошлое действие с продолжающимися последствиями в настоящем.',
			'morphology.tense.perfect.examples' => 'было написано | пришло',
			'morphology.tense.pluperfect.name' => 'Плюперфект',
			'morphology.tense.pluperfect.description' => 'Прошлое действие, предшествовавшее другому прошлому событию.',
			'morphology.tense.pluperfect.examples' => 'было написано|ушло',
			'morphology.mood.indicative.name' => 'Изъявительное',
			'morphology.mood.indicative.description' => 'Констатирует факт.',
			'morphology.mood.indicative.examples' => 'он | они написали',
			'morphology.mood.imperative.name' => 'Императив',
			'morphology.mood.imperative.description' => 'Выдает команду.',
			'morphology.mood.imperative.examples' => 'Идите!|Верьте!|Не бойтесь!',
			'morphology.mood.subjunctive.name' => 'Сослагательное наклонение',
			'morphology.mood.subjunctive.description' => 'Выражает возможность, цель или непредвиденное обстоятельство.',
			'morphology.mood.subjunctive.examples' => 'что он мог бы написать|если пойдёт',
			'morphology.mood.optative.name' => 'Оптатив',
			'morphology.mood.optative.description' => 'Выражает желание или отдаленную возможность.',
			'morphology.mood.optative.examples' => 'да будет так | да будет тебе милость',
			'morphology.mood.infinitive.name' => 'инфинитив',
			'morphology.mood.infinitive.description' => 'Отглагольное существительное, например «делать».',
			'morphology.mood.infinitive.examples' => 'писать|верить',
			'morphology.mood.participle.name' => 'Причастие',
			'morphology.mood.participle.description' => 'Отглагольное прилагательное, например «делать» или «сделать».',
			'morphology.mood.participle.examples' => 'тот, кто пишет|говорит',
			'morphology.voice.active.name' => 'Активный',
			'morphology.voice.active.description' => 'Субъект выполняет действие.',
			'morphology.voice.active.examples' => 'он пишет|они учат',
			'morphology.voice.middle.name' => 'Средний',
			'morphology.voice.middle.description' => 'Субъект действует сам по себе или для себя.',
			'morphology.voice.middle.examples' => 'он моется|они достали себе',
			'morphology.voice.passive.name' => 'Пассивный',
			'morphology.voice.passive.description' => 'Субъект получает действие.',
			'morphology.voice.passive.examples' => 'его послали|их научили',
			'morphology.voice.middleOrPassive.name' => 'Средний/Пассивный',
			'morphology.voice.middleOrPassive.description' => 'Форма неоднозначна между средней и пассивной.',
			'morphology.voice.middleOrPassive.examples' => 'был поднят / поднял сам | был собран / собрался сам',
			'morphology.degree.positive.name' => 'Позитивный',
			'morphology.degree.positive.description' => 'Простая форма, ни сравнительная, ни превосходная степень.',
			'morphology.degree.positive.examples' => 'отлично|хорошо',
			'morphology.degree.comparative.name' => 'Сравнительный',
			'morphology.degree.comparative.description' => 'Сравнивает двоих.',
			'morphology.degree.comparative.examples' => 'больше | лучше, чем',
			'morphology.degree.superlative.name' => 'превосходная степень',
			'morphology.degree.superlative.description' => 'Выражает наибольшую степень.',
			'morphology.degree.superlative.examples' => 'величайший|лучший',
			'morphology.literals.rawCode' => 'Необработанный код морфологии в том виде, в котором он указан в исходном коде.',
			'morphology.literals.waw' => 'Еврейский союз вау (וְ) означает «и».',
			'morphology.literals.conjunction' => 'Маркер соединения.',
			'morphology.literals.bet' => 'Префикс-префикс на иврите (בְּ), означающий «в», «в» или «с».',
			'morphology.literals.kaf' => 'Еврейский префикс-предлог каф (כְּ), означающий «как» или «подобно».',
			'morphology.literals.lamed' => 'Еврейский префикс-предлог ламед (לְ), означающий «кому», «для» или «принадлежащий».',
			'morphology.literals.mem' => 'Еврейский префикс-предлог мем (מִן), означающий «из» или «из».',
			'morphology.literals.preposition' => 'Префиксная буква-предлог.',
			'morphology.literals.wawExamples' => 'и|сейчас|но',
			'morphology.literals.betExamples' => 'вначале|с силой',
			'morphology.literals.kafExamples' => 'как лев|как пастух',
			'morphology.literals.lamedExamples' => 'Давиду|за царя',
			'morphology.literals.memExamples' => 'из Египта|из земли',
			'settings.title' => 'Настройки',
			'settings.customize' => 'Настроить',
			'settings.pushNotifications' => 'Push-уведомления',
			'settings.biblePlanReminders' => 'Напоминания о библейских планах',
			'settings.notificationsNotRequested' => 'Включите уведомления.',
			'settings.notificationsNotRequestedDescription' => 'Разрешите Lux отправлять уведомления, чтобы управлять напоминаниями.',
			'settings.notificationsDisabled' => 'Уведомления для Lux отключены.',
			'settings.biblePlanRemindersDisabled' => 'Напоминания о библейских планах отключены.',
			'settings.verseOfTheDayRemindersDisabled' => 'Напоминания о стихе дня отключены.',
			'settings.notificationsDisabledDescription' => 'Включите их в настройках устройства, чтобы управлять напоминаниями.',
			'settings.language' => 'Язык',
			'settings.system' => 'Система',
			'settings.systemLanguageDescription' => 'Использовать язык системы.',
			'settings.toolbarPresets' => 'Наборы панелей инструментов',
			'settings.toolbarPreset' => 'Набор панели инструментов',
			'settings.presetWarning' => 'Выбор набора заменит ярлыки на всех панелях инструментов.',
			'settings.yourContent' => 'Ваш контент',
			'settings.discussionAndAnnouncements' => 'Обсуждение и анонсы',
			'settings.tipsAndUpdates' => 'Советы и обновления',
			'settings.supportLux' => 'Поддержать Lux',
			'settings.rateLux' => 'Оценить Lux',
			'settings.leaveReview' => 'Оставить отзыв в App Store.',
			'settings.supportMessage' => 'Lux создан с убеждением, что Священное Писание должно быть доступно каждому. Лучший способ поддержать Lux — оставить отзыв в App Store.\n\nЕсли что-то мешает вам поставить 5 звёзд, присоединитесь к нашему Discord и расскажите об этом, чтобы мы могли быстро решить проблему.',
			'settings.leaveRating' => 'Оставить оценку',
			'settings.joinDiscord' => 'Присоединиться к Discord',
			'settings.restartGetStarted' => 'Начать знакомство заново',
			'settings.restartGetStartedDescription' => 'Снова показать контрольный список знакомства с приложением.',
			'settings.resetTutorials' => 'Сбросить подсказки',
			'settings.resetTutorialsDescription' => 'Снова показывать полезные подсказки в приложении.',
			'settings.tutorialsReset' => 'Подсказки сброшены.',
			_ => null,
		};
	}
}
