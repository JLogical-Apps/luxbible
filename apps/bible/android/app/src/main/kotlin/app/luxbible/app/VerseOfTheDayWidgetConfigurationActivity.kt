package app.luxbible.app

import android.app.Activity
import android.appwidget.AppWidgetManager
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.view.View
import android.view.WindowInsets
import android.widget.FrameLayout
import android.widget.RadioGroup
import android.widget.SeekBar
import android.widget.TextView
import java.text.NumberFormat
import java.util.Date

/**
 * Lets the user pick a widget's background theme and opacity over their own wallpaper.
 *
 * Every change is saved and drawn right away, so leaving by Back keeps it just like Done does.
 */
class VerseOfTheDayWidgetConfigurationActivity : Activity() {
    private var widgetId = AppWidgetManager.INVALID_APPWIDGET_ID
    private var appearance = VerseOfTheDayWidgetAppearance()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        widgetId = intent.getIntExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, AppWidgetManager.INVALID_APPWIDGET_ID)
        if (widgetId !in VerseOfTheDayWidget.getIds(this)) {
            finish()
            return
        }

        // Below Android 12 a canceled configuration removes the new widget, so confirm it up front.
        setResult(RESULT_OK, Intent().putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId))
        setContentView(R.layout.verse_of_the_day_widget_configuration)
        appearance = VerseOfTheDayWidgetStore.readAppearance(this, widgetId)

        findViewById<RadioGroup>(R.id.configuration_theme).apply {
            check(appearance.theme.radioId)
            setOnCheckedChangeListener { _, radioId ->
                select(appearance.copy(theme = VerseOfTheDayWidgetTheme.entries.first { it.radioId == radioId }))
            }
        }

        findViewById<SeekBar>(R.id.configuration_opacity).apply {
            progress = appearance.opacity / OPACITY_STEP
            setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
                override fun onProgressChanged(seekBar: SeekBar, progress: Int, isFromUser: Boolean) =
                    select(appearance.copy(opacity = progress * OPACITY_STEP))

                override fun onStartTrackingTouch(seekBar: SeekBar) {}

                override fun onStopTrackingTouch(seekBar: SeekBar) {}
            })
        }

        findViewById<View>(R.id.configuration_done).setOnClickListener { finish() }

        applyInsets()
        render()
        VerseOfTheDayWidget.update(this)
    }

    private fun select(appearance: VerseOfTheDayWidgetAppearance) {
        if (appearance == this.appearance) return
        this.appearance = appearance
        VerseOfTheDayWidgetStore.writeAppearance(this, widgetId, appearance)
        VerseOfTheDayWidget.update(this)
        render()
    }

    private fun render() {
        findViewById<TextView>(R.id.configuration_opacity_value).text =
            NumberFormat.getPercentInstance().format(appearance.opacity / 100.0)

        val preview = findViewById<FrameLayout>(R.id.configuration_preview)
        val views = VerseOfTheDayWidget.getViews(this, VerseOfTheDayWidgetStore.read(this, Date()), appearance)
        preview.removeAllViews()
        preview.addView(views.apply(this, preview))
    }

    /** Android 15 always draws this window edge to edge, so the panel pads itself above the navigation bar. */
    private fun applyInsets() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.VANILLA_ICE_CREAM) return

        val panel = findViewById<View>(R.id.configuration_panel)
        val panelPadding = panel.paddingBottom
        findViewById<View>(R.id.configuration_root).setOnApplyWindowInsetsListener { root, insets ->
            val bars = insets.getInsets(WindowInsets.Type.systemBars())
            root.setPadding(bars.left, bars.top, bars.right, 0)
            panel.setPadding(panel.paddingLeft, panel.paddingTop, panel.paddingRight, panelPadding + bars.bottom)
            insets
        }
    }

    private val VerseOfTheDayWidgetTheme.radioId
        get() = when (this) {
            VerseOfTheDayWidgetTheme.AUTO -> R.id.configuration_theme_auto
            VerseOfTheDayWidgetTheme.LIGHT -> R.id.configuration_theme_light
            VerseOfTheDayWidgetTheme.DARK -> R.id.configuration_theme_dark
        }

    companion object {
        private const val OPACITY_STEP = 5
    }
}
