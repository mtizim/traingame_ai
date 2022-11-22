package com.example.app
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.opencv.android.OpenCVLoader
class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.flutter.result/result"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        OpenCVLoader.initDebug();
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                methodCall, result ->
            if (methodCall.method == "EmptyList"){
                val list = emptyList<String>();
                result.success(list)
            }
        }
    }
}
