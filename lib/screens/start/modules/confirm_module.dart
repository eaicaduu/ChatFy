import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../values/colors.dart';
import 'confirm_verify.dart';

class ConfirmModule extends StatelessWidget {
  final TextEditingController codeController;
  final bool hasError;
  final String verificationId;
  final String phoneNumber;
  final Function setError;
  final Function resendCode;

  const ConfirmModule({
    super.key,
    required this.codeController,
    required this.hasError,
    required this.verificationId,
    required this.phoneNumber,
    required this.setError,
    required this.resendCode,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message_rounded, size: 120, color: AppColors.global),
            SizedBox(height: 20),
            Text(
              'Digite o código enviado:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            PinCodeTextField(
              appContext: context,
              length: 6,
              controller: codeController,
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
                setError(false);
              },
              onCompleted: (value) => PhoneAuthService().verifyCode(verificationId, value, context, phoneNumber, setError)
            ),
            SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.global,
                overlayColor: Colors.transparent,
              ),
              onPressed: () {
                resendCode();
              },
              child: Text('Reenviar Código', style: TextStyle(fontSize: 18, color: AppColors.global)),
            ),
          ],
        ),
      ),
    );
  }
}
