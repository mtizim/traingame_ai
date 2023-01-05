package com.example.app

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.util.Log
import com.example.app.Utils.assetFilePath
import com.example.app.entities.Cities
import com.example.app.entities.Routes
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.opencv.android.OpenCVLoader
import org.opencv.android.Utils
import org.opencv.core.*
import org.opencv.imgproc.Imgproc

class MainActivity: FlutterActivity(){
    private val CHANNEL = "com.flutter.result/result"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val open = OpenCVLoader.initDebug()
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                methodCall, result ->
            if (methodCall.method == "detectRoutes"){
                val imgBytes = (methodCall.argument("bytes") as ByteArray?)!!
                val imgBitmap = BitmapFactory.decodeByteArray(imgBytes, 0, imgBytes.size)
                val imgBitmap32 = imgBitmap.copy(Bitmap.Config.ARGB_8888, true)
                val img = Mat()
                Utils.bitmapToMat(imgBitmap32, img)
                Log.i("IMG","cols: "+img.cols().toString()+" rows: "+img.rows().toString())
                val processedPair = changePerspective(img)
                if(!processedPair.second){
                    val resultString = "{\"perspective\":false,\"routes\":[],\"stations\":[]}"
                    Log.i("RESULT",resultString)
                    result.success(resultString)
                }else{
                    val processedImg = processedPair.first
                    val resultPair = predictRectangles(processedImg)
                    val routesString = resultPair.first.joinToString(separator = ",",prefix="\"routes\":[",postfix="]")
                    val stationsString = resultPair.second.joinToString(separator = ",",prefix="\"stations\":[",postfix="]")
                    val resultString = arrayOf("{\"perspective\":true",routesString,stationsString).joinToString(separator = ",", postfix = "}")
                    Log.i("RESULT",resultString)
                result.success(resultString)
                }
            }
        }
    }

    private fun changePerspective(img: Mat):
            Pair<Mat, Boolean> {
        val result = Mat()
        val corners = findCorners(img)
        if(!corners.second){
            return Pair(Mat(), corners.second)
        }
        val cornersLoc = corners.first
        val pts1 = MatOfPoint2f(*cornersLoc)
        val pts2 = MatOfPoint2f(
            Point(0.0, 0.0),
            Point(2000.0, 0.0),
            Point(0.0, 3000.0),
            Point(2000.0, 3000.0)
        )
        val transformMat = Imgproc.getPerspectiveTransform(pts1, pts2)
        Imgproc.warpPerspective(img, result, transformMat, img.size())
        val rectCrop = Rect(0, 0, 2000, 3000)
        return Pair(Mat(result,rectCrop),corners.second)
    }

    private fun findCorners(img: Mat):Pair<Array<Point>, Boolean>{
        val gray = processImage(img)
        val corners = listOf("1_100big.jpg","2_20big.jpg","3_70big.jpg","4_50big.jpg")
        val points = arrayOf(Point(0.0,0.0),Point(0.0,0.0),Point(0.0,0.0),Point(0.0,0.0))
        val maxVals = arrayOf(0.0,0.0,0.0,0.0)
        for((corner_number, corner_name) in corners.withIndex()){
            val rectCrop = Rect((corner_number%2*4.0/5.0*gray.cols()).toInt(), (corner_number/2*4.0/5.0*gray.rows()).toInt(),
                (gray.cols()/5.0).toInt(), (gray.rows()/5.0).toInt())
            val findIn = Mat(gray,rectCrop)
            for(corner_ratio in 80 downTo 50 step 1){
                val result = Mat()
                val corner = processCorner(corner_name, corner_ratio)
                Imgproc.matchTemplate(findIn, corner, result, Imgproc.TM_CCOEFF)
                val maxVal = Core.minMaxLoc(result).maxVal
                val point = Core.minMaxLoc(result).maxLoc
                if (maxVal>maxVals[corner_number]){
                    maxVals[corner_number]=Core.minMaxLoc(result).maxVal
                    val x = point.x
                    val y = point.y
                    Log.i("BESTCORNER",corner_name+" "+corner_ratio.toString()+" "+Core.minMaxLoc(result).maxVal.toString())
                    points[corner_number]=Point(x+corner_number%2*(corner.cols()+4.0/5.0*gray.cols()).toInt(),
                    y+corner_number/2*(corner.rows()+4.0/5.0*gray.rows()).toInt())
                    if (maxVals[corner_number]>20000000){break}
                }
            }
        }
        Log.i("MAXVALS",maxVals.joinToString(transform = {(it/1000000).toString()}))
        var goodImage = true
        for(i in maxVals){
            if(i<12000000){goodImage=false}
        }
        return Pair(points,goodImage)
    }

    private fun processImage(img: Mat): Mat{
        if(img.rows()<img.cols()){
            Core.rotate(img, img, Core.ROTATE_90_CLOCKWISE)
        }
        val gray =  Mat()
        Imgproc.cvtColor(img, gray,  Imgproc.COLOR_BGR2GRAY)
        Imgproc.Canny(gray, gray,70.0,70.0)
        return gray
    }

    private fun processCorner(corner_name: String, corner_ratio: Int): Mat{
        val templateBytes = applicationContext.assets.open(corner_name).readBytes()
        val templateBitmap = BitmapFactory.decodeByteArray(templateBytes, 0, templateBytes.size)
        val templateBitmap32 = templateBitmap.copy(Bitmap.Config.ARGB_8888, true)
        val template = Mat()
        Utils.bitmapToMat(templateBitmap32, template)
        Imgproc.cvtColor(template, template,  Imgproc.COLOR_BGR2GRAY)
        Imgproc.resize(template, template, Size(), corner_ratio/100.0, corner_ratio/100.0)
        Imgproc.medianBlur(template, template, 5)
        Imgproc.Canny(template, template, 100.0, 100.0)
        Log.i("CORNER",template.toString())
        return template
    }

    private fun predictRectangles(img:Mat):Pair<MutableList<String>, MutableList<String>>{
        val routesList : MutableList<String> = arrayListOf()
        val stationsList : MutableList<String> = arrayListOf()
        val labels = listOf("black","blue","empty","green","red","yellow")
        var classifier = Classifier(assetFilePath(this,"mobilenet-large-HOPE2.pt"))
        classifier.setMeanAndStd(floatArrayOf(0.7838f, 0.6432f, 0.3390f),floatArrayOf(0.1693f, 0.1852f, 0.2066f))
        var pts2 = MatOfPoint2f(
            Point(0.0,0.0),
            Point(100.0,0.0),
            Point(0.0,150.0),
            Point(100.0,150.0)
        )
        for(route in Routes.values()){
            val pts1 = MatOfPoint2f(*route.getLocation())
            val transformMat = Imgproc.getPerspectiveTransform(pts1, pts2)
            val resultMat = Mat()
            Imgproc.warpPerspective(img, resultMat, transformMat, img.size())
            val rectCrop = Rect(0, 0, 100, 150)
            val toPredict = Mat(resultMat,rectCrop)
            val predictionBmp : Bitmap =
                Bitmap.createBitmap(toPredict.cols(), toPredict.rows(), Bitmap.Config.RGB_565)
            Utils.matToBitmap(toPredict, predictionBmp)
            val prediction = labels[classifier.predict(predictionBmp)]
            if(prediction!="empty"){
                routesList.add("{\"PlayerColour\":\"${prediction}\",\"route\":\"${route.name}\"}")
            }
        }
        classifier = Classifier(assetFilePath(this,"mobilenet-x5.pt"))
        classifier.setMeanAndStd(floatArrayOf(0.485f, 0.456f, 0.406f),floatArrayOf(0.229f, 0.224f, 0.225f))
        pts2 = MatOfPoint2f(
            Point(0.0,0.0),
            Point(70.0,0.0),
            Point(0.0,70.0),
            Point(70.0,70.0)
        )
        for(city in Cities.values()){
            val pts1 = MatOfPoint2f(*city.getLocation())
            val transformMat = Imgproc.getPerspectiveTransform(pts1, pts2)
            val resultMat = Mat()
            Imgproc.warpPerspective(img, resultMat, transformMat, img.size())
            val rectCrop = Rect(0, 0, 70, 70)
            val toPredict = Mat(resultMat,rectCrop)
            val predictionBmp : Bitmap =
                Bitmap.createBitmap(toPredict.cols(), toPredict.rows(), Bitmap.Config.RGB_565)
            Utils.matToBitmap(toPredict, predictionBmp)
            val prediction = labels[classifier.predict(predictionBmp)]
            if(prediction!="empty"){
                stationsList.add("{\"PlayerColour\":\"${prediction}\",\"city\":\"${city.name}\"}")
            }
        }
        return Pair(routesList,stationsList)
        }
}
