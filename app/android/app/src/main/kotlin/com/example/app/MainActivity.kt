package com.example.app
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.opencv.android.OpenCVLoader

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.flutter.result/result"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val open = OpenCVLoader.initDebug();
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                methodCall, result ->
            if (methodCall.method == "detectRoutes"){
                val bytes = methodCall.argument("bytes") as ByteArray?;
                val result_list : MutableList<String> = arrayListOf()
                //model
                //artificial jsons
                result_list.add("{\"PlayerColour\":\"red\",\"cities\":[\"Amsterdam\",\"Essen\"]}")
                result_list.add("{\"PlayerColour\":\"black\",\"cities\":[\"Lisbon\",\"Cadiz\"]}")
                result_list.add("{\"PlayerColour\":\"green\",\"cities\":[\"Madrid\",\"Barcelona\"]}")

                result.success(result_list)
            }
        }
    }
}
