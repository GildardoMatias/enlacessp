package com.example.enlacessp

/*import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
}*/

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.net.ConnectivityManager
import android.net.NetworkInfo
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.widget.Toast
import androidx.annotation.NonNull
import com.android.volley.AuthFailureError
import com.android.volley.Request
import com.android.volley.Response
import com.android.volley.VolleyError
import com.android.volley.toolbox.JsonObjectRequest
import com.android.volley.toolbox.StringRequest
import com.android.volley.toolbox.Volley
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject
import java.io.File
import kotlin.concurrent.thread

class MainActivity() : FlutterActivity() {
    private val CHANNEL = "samples.flutter.dev/battery"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // Note: this method is invoked on the main thread.
            call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else if (call.method == "checkInternet") {
                println("Antes")
                val intent = Intent(context, MyService::class.java)
                context?.startService(intent)
                MyService.startService(this, "Esperando conexion de red...")
                Thread(Runnable {
                    while (!isOnline(this)) {
                    }
                    //wmethod()
                    MyService.stopService(this)
                }).start()
                //val internetStatus = isOnline(context)
                result.success(true)
            } else if (call.method == "checkFile") {
                val f = File("/data/user/0/" + context.getPackageName() + "/app_flutter/myJSONFile.json")
                val intent = Intent(context, MyService::class.java)
                context?.startService(intent)
                MyService.startService(this, "Esperando conexion de red...")
                Thread(Runnable {
                    while (!isOnline(this)) {
                    }
                    //wmethod()
                    if (f.exists()){
                        println("El archivo existe" )
                        //UploadUtility(this).uploadFile("/data/user/0/" + context.getPackageName() + "/app_flutter/myJSONFile.json")
                        subir(this,File("/data/user/0/" + context.getPackageName() + "/app_flutter/myJSONFile.json"))
                        println("\n\nArchivo subido\n\n")
                        subirImagenes(File("/data/user/0/" + context.getPackageName() + "/app_flutter/"))
                        //Para finalizar, borrar archivos
                        File("/data/user/0/" + context.getPackageName() + "/app_flutter/myJSONFile.json").delete()
                        borrarImagenes(File("/data/user/0/" + context.getPackageName() + "/app_flutter/"))
                    }
                    else println("El archivo no existe")
                    MyService.stopService(this)
                }).start()
                result.success(true)
            } else {
                result.notImplemented()
            }
        }
    }
    //Subir todas las imagenes en el directorio de documentos de la app
    //We need to decode json filed
    fun subirImagenes(root: File){
        if (root.exists()) {
            val files = root.listFiles()
            if (files.isNotEmpty()) {
                for (i in 0..files.size - 1) {
                    if (files[i].name.endsWith(".png")) {
                        subir(this,files[i])
                        println("Archivo: ${files[i].name} subido")
                    }
                }
            }
        }
    }
    //Borrar Imágenes
    fun borrarImagenes(root: File): ArrayList < File > {
        val a: ArrayList < File > = ArrayList()
        if (root.exists()) {
            val files = root.listFiles()
            if (files.isNotEmpty()) {
                for (i in 0..files.size - 1) {
                    if (files[i].name.endsWith(".png")) {
                        a.add(files[i])
                        File(files[i].toURI()).delete()
                        println("Archivo: ${files[i].name} borrado")
                    }
                }
            }
        }
        return a!!
    }
    //Recibe un archivo y lo sube al servidor definifo en postUrl
    fun subir (context: Context, file: File) {
        //val postUrl = "http://192.168.1.65/API2/file.php"
        val postUrl = "https://siegeest.app/API2/file.php"
        val imageData = file.readBytes()
        val request = object : VolleyFileUploadRequest(
                Method.POST,
                postUrl,
                Response.Listener {
                    println("response is: $it ${it.statusCode}")
                },
                Response.ErrorListener {
                    println("error is: $it")
                }
        ) {
            override fun getByteData(): MutableMap<String, FileDataPart> {
                var params = HashMap<String, FileDataPart>()
                params["uploaded_file"] = FileDataPart("${file.name}", imageData!!, "${file.extension}")
                return params
            }
        }
        Volley.newRequestQueue(context).add(request)
    }

    private fun getInternetStatus(): Boolean {
        val cm = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val activeNetwork: NetworkInfo? = cm.activeNetworkInfo
        val isConnected: Boolean = activeNetwork?.isConnectedOrConnecting == true
        return isConnected
    }

    fun isOnline(context: Context): Boolean {
        val process = Runtime.getRuntime().exec("/system/bin/ping -c 1 www.google.com")
        val pingResult = process.waitFor()
        return pingResult == 0
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }
        return batteryLevel
    }
}