package com.atharvaj06.scoop
import android.view.WindowManager.LayoutParams
import io.flutter.embedding.android.FlutterActivity

@Override
protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
getWindow().addFlags(WindowManager.LayoutParams.FLAG_SECURE);
}

class MainActivity: FlutterActivity() {
}
