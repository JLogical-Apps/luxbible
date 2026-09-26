package app.luxbible.app

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.provider.OpenableColumns
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

/**
 * A method channel that hands Dart the values an intent delivers to Lux.
 *
 * The value that launched the app is buffered until Dart asks for it, and every later one is pushed
 * over the same channel as it arrives. Bridges are singletons so a value read during a cold launch
 * survives the activity being recreated before Dart is ready.
 */
sealed class LaunchLinkBridge(
    private val channelName: String,
    private val launchMethod: String,
    private val openMethod: String,
) {
    private var channel: MethodChannel? = null
    private var pending: String? = null
    private var isDartReady = false

    /** The value to hand Dart for [intent], or null when the intent does not belong to this bridge. */
    abstract fun read(context: Context, intent: Intent): String?

    /** Handles a method beyond the launch method, returning whether it was recognized. */
    open fun handle(context: Context, call: MethodCall, result: MethodChannel.Result): Boolean = false

    fun register(context: Context, messenger: BinaryMessenger) {
        val appContext = context.applicationContext
        channel = MethodChannel(messenger, channelName).apply {
            setMethodCallHandler { call, result ->
                when {
                    call.method == launchMethod -> {
                        isDartReady = true
                        result.success(pending)
                        pending = null
                    }
                    !handle(appContext, call, result) -> result.notImplemented()
                }
            }
        }
    }

    fun deliver(context: Context, intent: Intent) {
        val value = read(context, intent) ?: return
        if (isDartReady) channel?.invokeMethod(openMethod, value) else pending = value
    }
}

/** Universal links to a passage, as `https://app.luxbible.app/passage/<osisId>`. */
object PassageLinkBridge : LaunchLinkBridge("app.luxbible.app/passage-link", "getLaunchLink", "openPassage") {
    override fun read(context: Context, intent: Intent): String? {
        val uri = intent.takeIf { it.action == Intent.ACTION_VIEW }?.data ?: return null
        val isPassage = uri.scheme == "https" && uri.host == "app.luxbible.app" &&
            uri.pathSegments.size == 2 && uri.pathSegments[0] == "passage"
        return if (isPassage) uri.toString() else null
    }
}

/** Bible plan files opened from elsewhere on the device, delivered to Dart as their contents. */
object BiblePlanOpenBridge : LaunchLinkBridge("app.luxbible.app/bible-plan-open", "getLaunchPlan", "openPlan") {
    const val EXTRA_CONTENTS = "app.luxbible.app.extra.BIBLE_PLAN_CONTENTS"

    override fun read(context: Context, intent: Intent): String? = intent.getStringExtra(EXTRA_CONTENTS)

    /** The contents of the `.lxbp` file [intent] opens or shares, empty when it can't be read. */
    fun readFile(context: Context, intent: Intent): String? {
        val uri = when (intent.action) {
            Intent.ACTION_VIEW -> intent.data
            Intent.ACTION_SEND -> intent.getParcelableExtra<Uri>(Intent.EXTRA_STREAM)
            else -> null
        } ?: return null
        if (uri.scheme != "content" && uri.scheme != "file") return null

        return try {
            val resolver = context.contentResolver
            val name = resolver.query(uri, arrayOf(OpenableColumns.DISPLAY_NAME), null, null, null)?.use { cursor ->
                if (cursor.moveToFirst()) cursor.getString(0) else null
            } ?: uri.lastPathSegment
            if (name?.endsWith(".lxbp", ignoreCase = true) != true) return null
            resolver.openInputStream(uri)?.bufferedReader(Charsets.UTF_8)?.use { it.readText() } ?: ""
        } catch (_: Exception) {
            ""
        }
    }
}

/**
 * Connects the Flutter app to the Verse of the Day widget.
 *
 * Dart pushes the horizon of verses the widget should show, and the bridge stores it and redraws
 * the widget. Widget taps arrive back as `luxbible://` URLs.
 */
object LuxWidgetBridge : LaunchLinkBridge("app.luxbible.app/widgets", "getLaunchLink", "openLink") {
    override fun read(context: Context, intent: Intent): String? {
        val uri = intent.takeIf { it.action == Intent.ACTION_VIEW }?.data ?: return null
        return if (uri.scheme == VerseOfTheDayWidget.SCHEME) uri.toString() else null
    }

    override fun handle(context: Context, call: MethodCall, result: MethodChannel.Result): Boolean {
        if (call.method != "setVerses") return false

        when (val json = call.arguments) {
            is String -> {
                VerseOfTheDayWidgetStore.write(context, json)
                VerseOfTheDayWidget.update(context)
                result.success(null)
            }
            else -> result.error("invalid-arguments", "Expected a JSON string.", null)
        }
        return true
    }
}
