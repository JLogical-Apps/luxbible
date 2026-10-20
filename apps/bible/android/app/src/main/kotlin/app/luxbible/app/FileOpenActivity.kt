package app.luxbible.app

import android.app.Activity
import android.content.Intent
import android.os.Bundle

/**
 * Receives Lux files, like `.lxbp` plans and `.lxn` notebooks, from other apps and forwards their
 * contents to [MainActivity].
 *
 * The Files app launches its handler inside its own task, so the file intents land here and Lux is
 * started from its own package, which lets the running Lux task take the file instead.
 */
class FileOpenActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val file = FileOpenBridge.readFile(this, intent)
        startActivity(
            Intent(this, MainActivity::class.java).apply {
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
                if (file != null) putExtra(file.first.extraContents, file.second)
            },
        )
        finish()
    }
}
