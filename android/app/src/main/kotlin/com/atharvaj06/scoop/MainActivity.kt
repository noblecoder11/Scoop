package com.atharvaj06.scoop
import android.view.WindowManager.LayoutParams
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
getWindow().addFlags(WindowManager.LayoutParams.FLAG_SECURE);
}

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        window.addFlags(LayoutParams.FLAG_SECURE)
        super.configureFlutterEngine(flutterEngine)
    }
}