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
    }

    private var channel: MethodChannel? = null

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
        readPlan(intent)?.let(::deliverPlan)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        readPlan(intent)?.let(::deliverPlan)
    }

    private fun deliverPlan(contents: String) {
        if (isDartReady) channel?.invokeMethod("openPlan", contents) else pendingPlan = contents
    }

    private fun readPlan(intent: Intent?): String? {
        val uri = when (intent?.action) {
            Intent.ACTION_VIEW -> intent.data
            Intent.ACTION_SEND -> intent.getParcelableExtra<Uri>(Intent.EXTRA_STREAM)
            else -> null
        } ?: return null
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
