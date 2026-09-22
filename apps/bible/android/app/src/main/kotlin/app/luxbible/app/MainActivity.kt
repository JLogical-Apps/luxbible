package app.luxbible.app

import android.content.Intent
import com.ryanheise.audioservice.AudioServiceActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : AudioServiceActivity() {
    private val bridges = listOf(LuxWidgetBridge, BiblePlanOpenBridge, PassageLinkBridge)

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        bridges.forEach { it.register(this, flutterEngine.dartExecutor.binaryMessenger) }
        deliver(intent)
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
