package app.luxbible.app

import android.app.AlarmManager
import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.view.View
import android.widget.RemoteViews
import java.util.Calendar
import java.util.Date

/**
 * Shows the Verse of the Day the app last pushed for the current local date.
 *
 * Nothing wakes a home screen widget when the day rolls over, so every redraw schedules the next one
 * for local midnight. The time and locale broadcasts cover the shifts an alarm alone would miss.
 */
class VerseOfTheDayWidget : AppWidgetProvider() {
    override fun onUpdate(context: Context, manager: AppWidgetManager, ids: IntArray) = update(context)

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        if (intent.action.orEmpty() in REFRESH_ACTIONS) update(context)
    }

    override fun onDisabled(context: Context) {
        context.getSystemService(AlarmManager::class.java)?.cancel(midnightIntent(context))
    }

    companion object {
        const val SCHEME = "luxbible"

        private const val HOST = "verse-of-the-day"
        private const val DAY_CHANGED = "app.luxbible.app.VERSE_OF_THE_DAY_DAY_CHANGED"

        private val REFRESH_ACTIONS = setOf(
            DAY_CHANGED,
            Intent.ACTION_TIME_CHANGED,
            Intent.ACTION_TIMEZONE_CHANGED,
            Intent.ACTION_LOCALE_CHANGED,
        )

        fun update(context: Context) {
            val manager = AppWidgetManager.getInstance(context)
            val ids = manager.getAppWidgetIds(ComponentName(context, VerseOfTheDayWidget::class.java))
            if (ids.isEmpty()) return

            val entry = VerseOfTheDayWidgetStore.read(context, Date())
            val views = RemoteViews(context.packageName, R.layout.verse_of_the_day_widget).apply {
                setTextViewText(
                    R.id.widget_text,
                    entry?.text ?: context.getString(R.string.verse_of_the_day_widget_empty),
                )
                setTextViewText(R.id.widget_attribution, entry?.let { "${it.reference} · ${it.translation}" }.orEmpty())
                setViewVisibility(R.id.widget_attribution, if (entry == null) View.GONE else View.VISIBLE)
                setOnClickPendingIntent(R.id.widget_root, openIntent(context, entry))
            }
            ids.forEach { id -> manager.updateAppWidget(id, views) }

            scheduleMidnight(context)
        }

        /** A widget whose horizon has run out links without a date, so Lux opens today's passage. */
        private fun openIntent(context: Context, entry: VerseOfTheDayWidgetEntry?): PendingIntent {
            val uri = Uri.Builder()
                .scheme(SCHEME)
                .authority(HOST)
                .apply { if (entry != null) appendQueryParameter("date", entry.date) }
                .build()
            val intent = Intent(context, MainActivity::class.java).apply {
                action = Intent.ACTION_VIEW
                data = uri
                flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
            }
            return PendingIntent.getActivity(context, 0, intent, PENDING_INTENT_FLAGS)
        }

        private fun scheduleMidnight(context: Context) {
            val midnight = Calendar.getInstance().apply {
                add(Calendar.DAY_OF_YEAR, 1)
                set(Calendar.HOUR_OF_DAY, 0)
                set(Calendar.MINUTE, 0)
                set(Calendar.SECOND, 0)
                set(Calendar.MILLISECOND, 0)
            }
            // Not a wakeup alarm: the widget only has to be right by the time the screen comes on.
            context.getSystemService(AlarmManager::class.java)
                ?.setAndAllowWhileIdle(AlarmManager.RTC, midnight.timeInMillis, midnightIntent(context))
        }

        private fun midnightIntent(context: Context) = PendingIntent.getBroadcast(
            context,
            0,
            Intent(DAY_CHANGED).setClass(context, VerseOfTheDayWidget::class.java),
            PENDING_INTENT_FLAGS,
        )

        private val PENDING_INTENT_FLAGS = PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
    }
}
