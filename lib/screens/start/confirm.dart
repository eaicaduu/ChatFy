
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../values/colors.dart';
import 'modules/number_verify.dart';

class ConfirmScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  const ConfirmScreen({super.key, required this.phoneNumber, required this.verificationId});

  @override
  ConfirmScreenState createState() => ConfirmScreenState();
}

class ConfirmScreenState extends State<ConfirmScreen> {
  final TextEditingController _codeController = TextEditingController();
  bool hasError = false;

  void setError(bool error) {
    setState(() {
      hasError = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.message, size: 120, color: AppColors.global),
              SizedBox(height: 20),
              Text(
                'Digite o código enviado:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: _codeController,
                keyboardType: TextInputType.number,
                textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.circle,
                  fieldHeight: 60,
                  fieldWidth: 60,
                  activeColor: hasError ? Colors.red : AppColors.global,
                  inactiveColor: Colors.grey,
                  selectedColor: hasError ? Colors.red : AppColors.global,
                ),
                onChanged: (value) {
                  setState(() {
                    hasError = false;
                  });
                },
                onCompleted: (value) => verifyCode(value, widget.verificationId, context, widget.phoneNumber, setError),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: Text('Reenviar Código', style: TextStyle(fontSize: 18, color: AppColors.global)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
