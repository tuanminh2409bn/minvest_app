package com.minvest.aisignals

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import com.facebook.FacebookSdk
import com.facebook.appevents.AppEventsLogger
import androidx.core.view.WindowCompat
class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        FacebookSdk.sdkInitialize(applicationContext)
        AppEventsLogger.activateApp(application)
        WindowCompat.setDecorFitsSystemWindows(window, false)
    }
}