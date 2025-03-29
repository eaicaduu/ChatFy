import 'package:flutter/material.dart';
import '../../values/colors.dart';
import 'modules/confirm_module.dart';
import 'modules/confirm_verify.dart';

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
  int? resendToken;

  void setError(bool error) {
    setState(() {
      hasError = error;
    });
  }

  void resendCode() {
    PhoneAuthService().sendVerificationCode(widget.phoneNumber, context, (String verificationId, int? token) {
      if (token != null) {
        setState(() {
          resendToken = token;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Código reenviado com sucesso!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao reenviar código.")),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      body: ConfirmModule(
        codeController: _codeController,
        hasError: hasError,
        verificationId: widget.verificationId,
        phoneNumber: widget.phoneNumber,
        setError: setError,
        resendCode: resendCode,
      ),
    );
  }
}
