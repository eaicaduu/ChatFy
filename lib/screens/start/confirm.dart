import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConfirmScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const ConfirmScreen({super.key, required this.phoneNumber, required this.verificationId});

  @override
  ConfirmScreenState createState() => ConfirmScreenState();
}

class ConfirmScreenState extends State<ConfirmScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final TextEditingController _codeController = TextEditingController();
  bool _isLoading = false;

  void _verifyCode() async {
    String code = _codeController.text.trim();
    if (code.length == 6) {
      setState(() => _isLoading = true);
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
          smsCode: code,
        );
        await _auth.signInWithCredential(credential);
        await _saveSession(widget.phoneNumber);
      } catch (e) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Código incorreto. Tente novamente!'),
        ));
      }
    }
  }

  Future<void> _saveSession(String phoneNumber) async {
    await _db.collection('sessions').doc(phoneNumber).set({'phoneNumber': phoneNumber});
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Confirmação de Código')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message, size: 100, color: Colors.blue),
            SizedBox(height: 20),
            Text('Digite o código enviado para ${widget.phoneNumber}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '123456',
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _verifyCode,
              child: Text('Verificar Código', style: TextStyle(fontSize: 18)),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Reenviar Código', style: TextStyle(fontSize: 18, color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
