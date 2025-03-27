
import 'package:flutter/material.dart';
import '../../../values/colors.dart';
import 'number_verify.dart';

void showPhoneConfirmation(String phoneNumber, BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: isLoading ? null : () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        backgroundColor: isLoading ? Colors.grey : Colors.red,
                        foregroundColor: getBackgroundColor(context),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: const Text("Alterar", style: TextStyle(fontSize: 16)),
                    ),
                    ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                        setState(() => isLoading = true);
                        verifyPhoneNumber(phoneNumber, context, () {
                          setState(() => isLoading = false);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isLoading ? Colors.grey : AppColors.global,
                        foregroundColor: getBackgroundColor(context),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      child: isLoading
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : const Text("Confirmar", style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      );
    },
  );
}
