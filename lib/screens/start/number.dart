import 'package:chat/screens/start/modules/number_button.dart';
import 'package:chat/screens/start/modules/number_module.dart';
import 'package:flutter/material.dart';
import '../../values/colors.dart';

class NumberScreen extends StatefulWidget {
  const NumberScreen({super.key});

  @override
  PhoneScreenState createState() => PhoneScreenState();
}

class PhoneScreenState extends State<NumberScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isLoading = false;
  bool _isPhoneValid = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_checkPhoneNumber);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 200), () {
        if (!mounted) return;
        if (_focusNode.canRequestFocus) {
          FocusScope.of(context).requestFocus(_focusNode);
        }
      });
    });
  }

  void _checkPhoneNumber() {
    String phoneNumber = _phoneController.text.trim();
    setState(() {
      _isPhoneValid = phoneNumber.length > 11;
    });
  }

  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getBackgroundColor(context),
      body: Stack(
        children: [
          NumberModule(
            phoneController: _phoneController,
            focusNode: _focusNode,
          ),
          NumberButton(
            phoneController: _phoneController,
            isPhoneValid: _isPhoneValid,
            isLoading: _isLoading,
            setLoading: setLoading,
          )
        ],
      ),
    );
  }
}
