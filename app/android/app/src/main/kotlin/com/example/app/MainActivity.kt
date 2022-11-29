package com.example.app
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.opencv.android.OpenCVLoader
import org.opencv.core.*
import org.opencv.imgcodecs.Imgcodecs
import org.opencv.imgproc.Imgproc

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.flutter.result/result"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val open = OpenCVLoader.initDebug()
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                methodCall, result ->
            if (methodCall.method == "detectRoutes"){
                val imgBytes = (methodCall.argument("bytes") as ByteArray?)!!
                val img = Imgcodecs.imdecode(MatOfByte(*imgBytes), Imgcodecs.IMREAD_UNCHANGED)
                val processedImg = changePerspective(img)
                //model
                //artificial json
                val result_list : MutableList<String> = arrayListOf()
                result_list.add("{\"PlayerColour\":\"red\",\"cities\":[\"Amsterdam\",\"Essen\"]}")
                result_list.add("{\"PlayerColour\":\"black\",\"cities\":[\"Lisbon\",\"Cadiz\"]}")
                result_list.add("{\"PlayerColour\":\"green\",\"cities\":[\"Madrid\",\"Barcelona\"]}")

                result.success(result_list)
            }
        }
    }

    private fun changePerspective(img: Mat): Mat {
        val result = Mat()
        val cornersLoc = findCorners(img)
        val pts1 = MatOfPoint2f(*cornersLoc)
        val pts2 = MatOfPoint2f(
            Point(0.0, 0.0),
            Point(img.cols().toDouble(), 0.0),
            Point(0.0, img.rows().toDouble()),
            Point(img.cols().toDouble(), img.rows().toDouble())
        )
        val transformMat = Imgproc.getPerspectiveTransform(pts1, pts2)
        Imgproc.warpPerspective(img, result, transformMat, img.size())
        return result
    }

    private fun findCorners(img: Mat):Array<Point>{
        val gray = processImage(img)
        val corners = listOf("1_100big.jpg","2_20big.jpg","3_70big.jpg","4_50big.jpg")
        val points = arrayOf(Point(0.0,0.0),Point(0.0,0.0),Point(0.0,0.0),Point(0.0,0.0))
        val maxVals = arrayOf(0.0,0.0,0.0,0.0)
        for((corner_number, corner_name) in corners.withIndex()){
            for(corner_ratio in 100 downTo 59 step 10){
                val result = Mat()
                val corner = processCorner(corner_name, corner_ratio)
                Imgproc.matchTemplate(gray, corner, result, Imgproc.TM_CCOEFF)
                val maxVal = Core.minMaxLoc(result).maxVal
                val point = Core.minMaxLoc(result).maxLoc
                if (maxVal>maxVals[corner_number]){
                    maxVals[corner_number]=Core.minMaxLoc(result).maxVal
                    val x = point.x
                    val y = point.y
                    points[corner_number]=Point(x+corner_number%2*corner.cols(),y+corner_number/2*corner.rows())
                }
            }
        }
        return points
    }

    private fun processImage(img: Mat): Mat{
        val gray =  Mat()
        Imgproc.cvtColor(img, gray,  Imgproc.COLOR_BGR2GRAY)
        Imgproc.Canny(gray, gray,100.0,100.0)
        return gray
    }

    private fun processCorner(corner_name: String, corner_ratio: Int): Mat{
        val templateBytes = applicationContext.assets.open(corner_name).readBytes()
        val template = Imgcodecs.imdecode(MatOfByte(*templateBytes), Imgcodecs.IMREAD_UNCHANGED)
        Imgproc.cvtColor(template, template,  Imgproc.COLOR_BGR2GRAY)
        Imgproc.resize(template, template, Size(), corner_ratio/100.0, corner_ratio/100.0)
        Imgproc.medianBlur(template, template, 5)
        Imgproc.Canny(template, template, 100.0, 100.0)
        return template
    }
}
