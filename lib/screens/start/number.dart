import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../values/colors.dart';
import 'formatting.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({super.key});

  @override
  PhoneScreenState createState() => PhoneScreenState();
}

class PhoneScreenState extends State<NumberScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }


  Future<void> _sendPhoneNumber() async {
    String phoneNumber = _phoneController.text.trim();
    if (phoneNumber.isEmpty) {
      Fluttertoast.showToast(msg: "Preencha o número de telefone.");
      return;
    }

    if (phoneNumber.length < 14) {
      Fluttertoast.showToast(msg: "Número de telefone inválido.");
      return;
    }

    setState(() => _isLoading = true);

    try {
      FirebaseFirestore.instance.collection('sessions').doc(phoneNumber).get().then((doc) {
        setState(() => _isLoading = false);
        if (doc.exists) {
          Fluttertoast.showToast(msg: "Número já registrado.");
        } else {
          _showPhoneConfirmation(phoneNumber);
        }
      });
    } catch (e) {
      setState(() => _isLoading = false);
      Fluttertoast.showToast(msg: "Erro ao verificar número.");
    }
  }

  void _showPhoneConfirmation(String phoneNumber) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmação"),
        content: Text("Seu número: $phoneNumber"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancelar")),
          TextButton(onPressed: () {}, child: Text("Confirmar")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.perm_phone_msg_rounded, size: 100, color: AppColors.global,),
                SizedBox(height: 10),
                Text("Digite seu número:", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 60, right: 60),
                  child: TextField(
                    maxLength: 15,
                    textAlign: TextAlign.center,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [PhoneFormatter()],
                    focusNode: _focusNode,
                    onChanged: (value) {
                      if (value.length == 11) {
                        if (PhoneFormatter.unmask(value).length == 11) {
                          FocusScope.of(context).unfocus();
                          _sendPhoneNumber();
                        }
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "(00)0 0000-0000",
                      counterText: "",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.global, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.global, width: 2.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColors.global, width: 1.5),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
              ],
            ),
          ),
          Positioned(
            right: 26,
            bottom: 26,
            child: FloatingActionButton(
              onPressed: _isLoading ? null : _sendPhoneNumber,
              backgroundColor: AppColors.global,
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Icon(Icons.send, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}