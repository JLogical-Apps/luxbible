package app.luxbible.app

import android.content.Context
import android.content.SharedPreferences
import org.json.JSONObject
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale

/** A single day's Verse of the Day, written by the Flutter app and read by the widget. */
data class VerseOfTheDayWidgetEntry(
    /** The local calendar date this verse belongs to, formatted as `yyyy-MM-dd`. */
    val date: String,
    val reference: String,
    val translation: String,
    val text: String,
)

enum class VerseOfTheDayWidgetTheme { AUTO, LIGHT, DARK }

data class VerseOfTheDayWidgetAppearance(
    val theme: VerseOfTheDayWidgetTheme = VerseOfTheDayWidgetTheme.AUTO,
    /** The background's opacity, as a percentage. */
    val opacity: Int = 100,
)

/**
 * The horizon of verses the app last pushed, held as the JSON both platforms share.
 *
 * The app owns every user-facing string in it, so the widget never has to resolve a passage, a
 * translation fallback, or a book name of its own.
 */
object VerseOfTheDayWidgetStore {
    private const val PREFERENCES = "verse_of_the_day_widget"
    private const val PAYLOAD_KEY = "verseOfTheDay"

    fun write(context: Context, json: String) {
        context.preferences.edit().putString(PAYLOAD_KEY, json).apply()
    }

    /**
     * The entry for the local day [date] falls on, or null when the horizon does not reach it.
     *
     * Every field is required, so a payload left behind by an older install whose shape has since
     * changed reads as nothing rather than as blanks.
     */
    fun read(context: Context, date: Date): VerseOfTheDayWidgetEntry? {
        val json = context.preferences.getString(PAYLOAD_KEY, null) ?: return null
        val isoDate = SimpleDateFormat("yyyy-MM-dd", Locale.US).format(date)

        return runCatching {
            val entries = JSONObject(json).getJSONArray("entries")
            (0 until entries.length())
                .map { entries.getJSONObject(it) }
                .firstOrNull { it.getString("date") == isoDate }
                ?.let {
                    VerseOfTheDayWidgetEntry(
                        date = isoDate,
                        reference = it.getString("reference"),
                        translation = it.getString("translation"),
                        text = it.getString("text"),
                    )
                }
        }.getOrNull()
    }

    fun readAppearance(context: Context, id: Int) = VerseOfTheDayWidgetAppearance().let { default ->
        VerseOfTheDayWidgetAppearance(
            theme = VerseOfTheDayWidgetTheme.entries
                .firstOrNull { it.name == context.preferences.getString(themeKey(id), null) }
                ?: default.theme,
            opacity = context.preferences.getInt(opacityKey(id), default.opacity),
        )
    }

    fun writeAppearance(context: Context, id: Int, appearance: VerseOfTheDayWidgetAppearance) {
        context.preferences.edit().putAppearance(id, appearance).apply()
    }

    fun deleteAppearances(context: Context, ids: IntArray) {
        context.preferences.edit()
            .apply { ids.forEach { removeAppearance(it) } }
            .apply()
    }

    /** A restored widget can be given an ID another one had before, so every old value is read before any key changes. */
    fun restoreAppearances(context: Context, oldIds: IntArray, newIds: IntArray) {
        val appearances = oldIds.map { readAppearance(context, it) }
        context.preferences.edit()
            .apply {
                oldIds.forEach { removeAppearance(it) }
                newIds.zip(appearances).forEach { (id, appearance) -> putAppearance(id, appearance) }
            }
            .apply()
    }

    private fun SharedPreferences.Editor.putAppearance(id: Int, appearance: VerseOfTheDayWidgetAppearance) =
        putString(themeKey(id), appearance.theme.name).putInt(opacityKey(id), appearance.opacity)

    private fun SharedPreferences.Editor.removeAppearance(id: Int) = remove(themeKey(id)).remove(opacityKey(id))

    private fun themeKey(id: Int) = "theme.$id"

    private fun opacityKey(id: Int) = "opacity.$id"

    private val Context.preferences
        get() = getSharedPreferences(PREFERENCES, Context.MODE_PRIVATE)
}
