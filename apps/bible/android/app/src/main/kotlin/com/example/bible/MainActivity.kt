package app.luxbible.app

import android.content.Intent
import android.net.Uri
import android.provider.OpenableColumns
import com.ryanheise.audioservice.AudioServiceActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : AudioServiceActivity() {
    companion object {
        private var pendingPlan: String? = null
        private var isDartReady = false
        private var pendingPassageLink: String? = null
        private var isPassageLinkDartReady = false
    }

    private var channel: MethodChannel? = null
    private var passageLinkChannel: MethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "app.luxbible.app/bible-plan-open").apply {
            setMethodCallHandler { call, result ->
                if (call.method == "getLaunchPlan") {
                    isDartReady = true
                    result.success(pendingPlan)
                    pendingPlan = null
                } else {
                    result.notImplemented()
                }
            }
        }
        passageLinkChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "app.luxbible.app/passage-link").apply {
            setMethodCallHandler { call, result ->
                if (call.method == "getLaunchLink") {
                    isPassageLinkDartReady = true
                    result.success(pendingPassageLink)
                    pendingPassageLink = null
                } else {
                    result.notImplemented()
                }
            }
        }
        readPlan(intent)?.let(::deliverPlan)
        readPassageLink(intent)?.let(::deliverPassageLink)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        readPlan(intent)?.let(::deliverPlan)
        readPassageLink(intent)?.let(::deliverPassageLink)
    }

    private fun deliverPlan(contents: String) {
        if (isDartReady) channel?.invokeMethod("openPlan", contents) else pendingPlan = contents
    }

    private fun deliverPassageLink(link: String) {
        if (isPassageLinkDartReady) passageLinkChannel?.invokeMethod("openPassage", link)
        else pendingPassageLink = link
    }

    private fun readPassageLink(intent: Intent?): String? {
        if (intent?.action != Intent.ACTION_VIEW) return null
        val uri = intent.data ?: return null
        return if (uri.scheme == "https" && uri.host == "app.luxbible.app" && uri.pathSegments.size == 2 && uri.pathSegments[0] == "passage") uri.toString() else null
    }

    private fun readPlan(intent: Intent?): String? {
        val uri = when (intent?.action) {
            Intent.ACTION_VIEW -> intent.data
            Intent.ACTION_SEND -> intent.getParcelableExtra<Uri>(Intent.EXTRA_STREAM)
            else -> null
        } ?: return null
        if (uri.scheme != "content" && uri.scheme != "file") return null
        return try {
            val name = contentResolver.query(uri, arrayOf(OpenableColumns.DISPLAY_NAME), null, null, null)?.use { cursor ->
                if (cursor.moveToFirst()) cursor.getString(0) else null
            } ?: uri.lastPathSegment
            if (name?.endsWith(".lxbp", ignoreCase = true) != true) return null
            contentResolver.openInputStream(uri)?.bufferedReader(Charsets.UTF_8)?.use { it.readText() } ?: ""
        } catch (_: Exception) {
            ""
        }
    }
}
