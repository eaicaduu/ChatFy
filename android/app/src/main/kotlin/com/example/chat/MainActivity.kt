package com.example.chat

import android.Manifest
import android.content.pm.PackageManager
import android.database.Cursor
import android.os.Build
import android.provider.ContactsContract
import android.telephony.TelephonyManager
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNELPHONE = "com.example.chat/phone"
    private val CHANNELCONTACTS = "com.example.chat/contacts"
    private val REQUEST_CODE_CONTACTS = 100
    private val REQUEST_CODE_PHONE = 101

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNELPHONE).setMethodCallHandler { call, result ->
            when (call.method) {
                "getPhoneNumber" -> {
                    if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_STATE) == PackageManager.PERMISSION_GRANTED) {
                        val phoneNumber = getPhoneNumber()
                        if (phoneNumber != null) {
                            result.success(phoneNumber)
                        } else {
                            result.error("UNAVAILABLE", "Número de telefone não disponível", null)
                        }
                    } else {
                        ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.READ_PHONE_STATE), REQUEST_CODE_PHONE)
                        result.error("PERMISSION_DENIED", "Permissão para acessar o número de telefone negada", null)
                    }
                }
                "getAndroidVersion" -> {
                    val androidVersion = android.os.Build.VERSION.SDK_INT // Retorna o código numérico da versão
                    result.success(androidVersion)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }


        // Canal para obter os contatos
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNELCONTACTS).setMethodCallHandler { call, result ->
            if (call.method == "getContacts") {
                if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_CONTACTS) == PackageManager.PERMISSION_GRANTED) {
                    val contacts = getContacts()
                    result.success(contacts)
                } else {
                    ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.READ_CONTACTS), REQUEST_CODE_CONTACTS)
                    result.error("PERMISSION_DENIED", "Permissão para acessar os contatos negada", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    // Função para obter o número de telefone
    private fun getPhoneNumber(): String? {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (ActivityCompat.checkSelfPermission(this, Manifest.permission.READ_PHONE_NUMBERS) != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(this, arrayOf(Manifest.permission.READ_PHONE_NUMBERS), REQUEST_CODE_PHONE)
                return null
            }
        }
        val telephonyManager = getSystemService(TELEPHONY_SERVICE) as TelephonyManager
        return telephonyManager.line1Number
    }

    // Função para obter os contatos
    private fun getContacts(): List<Map<String, String>> {
        val contactList = mutableListOf<Map<String, String>>()
        val cursor: Cursor? = contentResolver.query(
            ContactsContract.CommonDataKinds.Phone.CONTENT_URI,
            arrayOf(
                ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME,
                ContactsContract.CommonDataKinds.Phone.NUMBER
            ),
            null, null, null
        )

        cursor?.use {
            val nameIndex = it.getColumnIndex(ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME)
            val numberIndex = it.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER)

            while (it.moveToNext()) {
                val name = it.getString(nameIndex)
                val number = it.getString(numberIndex)
                contactList.add(mapOf("name" to name, "number" to number))
            }
        }
        return contactList
    }

    // Tratar a resposta das permissões
    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        when (requestCode) {
            REQUEST_CODE_PHONE -> {
                if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    // Permissão concedida, você pode acessar o número de telefone
                    val phoneNumber = getPhoneNumber()
                    if (phoneNumber != null) {
                        Toast.makeText(this, "Número de telefone: $phoneNumber", Toast.LENGTH_SHORT).show()
                    } else {
                        Toast.makeText(this, "Número de telefone não disponível", Toast.LENGTH_SHORT).show()
                    }
                } else {
                    // Permissão negada
                    Toast.makeText(this, "Permissão para acessar o número de telefone negada", Toast.LENGTH_SHORT).show()
                }
            }
            REQUEST_CODE_CONTACTS -> {
                if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    // Permissão concedida, você pode acessar os contatos
                    val contacts = getContacts()
                    // Aqui você pode processar os contatos, por exemplo, enviá-los para o Flutter
                    Toast.makeText(this, "Contatos carregados", Toast.LENGTH_SHORT).show()
                } else {
                    // Permissão negada
                    Toast.makeText(this, "Permissão para acessar os contatos negada", Toast.LENGTH_SHORT).show()
                }
            }
        }
    }
}
