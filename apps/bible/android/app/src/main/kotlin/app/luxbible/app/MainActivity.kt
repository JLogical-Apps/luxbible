package app.luxbible.app

import android.content.Intent
import com.ryanheise.audioservice.AudioServiceActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : AudioServiceActivity() {
    private val bridges = listOf(LuxWidgetBridge, BiblePlanOpenBridge, PassageLinkBridge)

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        bridges.forEach { it.register(this, flutterEngine.dartExecutor.binaryMessenger) }
        // Reopening from Recents restores the intent that first started the task, which was already handled.
        if ((intent.flags and Intent.FLAG_ACTIVITY_LAUNCHED_FROM_HISTORY) == 0) deliver(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        deliver(intent)
    }

    private fun deliver(intent: Intent?) {
        if (intent != null) bridges.forEach { it.deliver(this, intent) }
    }
}
