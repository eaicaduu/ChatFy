import 'package:flutter/material.dart';
import '../../../values/colors.dart';
import 'confirm_verify.dart';


void showPhoneConfirmation(
    String phoneNumber, BuildContext context, Function cancelLoading) {
  bool isLoading = false;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    backgroundColor: Colors.white,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.sms, size: 50, color: AppColors.global),
                const SizedBox(height: 10),
                const Text(
                  "Confirmar seu número",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  phoneNumber,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AnimatedOpacity(
                      opacity: isLoading ? 0.0 : 1.0,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 300),
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: getBackgroundColor(context),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: const Text("Alterar",
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      transform: isLoading
                          ? Matrix4.translationValues(-100, 0, 0)
                          : Matrix4.translationValues(0, 0, 0),
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                          setState(() => isLoading = true);
                          PhoneAuthService().sendVerificationCode(phoneNumber, context, () {
                            setState(() => isLoading = false);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          isLoading ? Colors.grey : AppColors.global,
                          foregroundColor: getBackgroundColor(context),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        child: isLoading
                            ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : const Text("Confirmar",
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20)
              ],
            ),
          );
        },
      );
    },
  ).whenComplete(() {
    cancelLoading();
  });
}
