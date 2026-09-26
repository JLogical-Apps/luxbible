package app.luxbible.app

import android.app.Activity
import android.content.Intent
import android.os.Bundle

/**
 * Receives `.lxbp` files from other apps and forwards their contents to [MainActivity].
 *
 * The Files app launches its handler inside its own task, so the file intents land here and Lux is
 * started from its own package, which lets the running Lux task take the file instead.
 */
class BiblePlanOpenActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val contents = BiblePlanOpenBridge.readFile(this, intent)
        startActivity(
            Intent(this, MainActivity::class.java).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
                if (contents != null) putExtra(BiblePlanOpenBridge.EXTRA_CONTENTS, contents)
            },
        )
        finish()
    }
}
