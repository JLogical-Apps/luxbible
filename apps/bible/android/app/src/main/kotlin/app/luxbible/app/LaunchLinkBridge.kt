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

/** App links into Lux, as `https://app.luxbible.app/passage/<osisId>` or `https://app.luxbible.app/plans/<planId>`. */
object AppLinkBridge : LaunchLinkBridge("app.luxbible.app/app-link", "getLaunchLink", "openLink") {
    private val sections = setOf("passage", "plans")

    override fun read(context: Context, intent: Intent): String? {
        val uri = intent.takeIf { it.action == Intent.ACTION_VIEW }?.data ?: return null
        val isAppLink = uri.scheme == "https" && uri.host == "app.luxbible.app" &&
            uri.pathSegments.size == 2 && uri.pathSegments[0] in sections
        return if (isAppLink) uri.toString() else null
    }
}

/** Lux files opened from elsewhere on the device, delivered to Dart as their contents. */
sealed class FileOpenBridge(
    channelName: String,
    launchMethod: String,
    openMethod: String,
    private val fileExtension: String,
) : LaunchLinkBridge(channelName, launchMethod, openMethod) {
    val extraContents = "app.luxbible.app.extra.${fileExtension.uppercase()}_CONTENTS"

    override fun read(context: Context, intent: Intent): String? = intent.getStringExtra(extraContents)

    companion object {
        private val bridges by lazy { listOf(BiblePlanOpenBridge, NotebookOpenBridge) }

        /**
         * The bridge for the Lux file [intent] opens or shares, paired with the file's contents, which
         * are empty when the file can't be read.
         */
        fun readFile(context: Context, intent: Intent): Pair<FileOpenBridge, String>? {
            val uri = when (intent.action) {
                Intent.ACTION_VIEW -> intent.data
                Intent.ACTION_SEND -> intent.getParcelableExtra<Uri>(Intent.EXTRA_STREAM)
                else -> null
            } ?: return null
            if (uri.scheme != "content" && uri.scheme != "file") return null

            val resolver = context.contentResolver
            val name = try {
                resolver.query(uri, arrayOf(OpenableColumns.DISPLAY_NAME), null, null, null)?.use { cursor ->
                    if (cursor.moveToFirst()) cursor.getString(0) else null
                } ?: uri.lastPathSegment
            } catch (_: Exception) {
                uri.lastPathSegment
            }
            val bridge = bridges.firstOrNull { name?.endsWith(".${it.fileExtension}", ignoreCase = true) == true }
                ?: return null

            val contents = try {
                resolver.openInputStream(uri)?.bufferedReader(Charsets.UTF_8)?.use { it.readText() } ?: ""
            } catch (_: Exception) {
                ""
            }
            return bridge to contents
        }
    }
}

object BiblePlanOpenBridge :
    FileOpenBridge("app.luxbible.app/bible-plan-open", "getLaunchPlan", "openPlan", fileExtension = "lxbp")

object NotebookOpenBridge :
    FileOpenBridge("app.luxbible.app/notebook-open", "getLaunchNotebook", "openNotebook", fileExtension = "lxn")

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
