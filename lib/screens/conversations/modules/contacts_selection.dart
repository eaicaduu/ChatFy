import 'package:chat/screens/conversations/contacts_new.dart';
import 'package:flutter/material.dart';
import '../../../values/colors.dart';

class ContactsSelection extends StatelessWidget {
  const ContactsSelection({super.key});

  void openNewContactsScreen(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: getBackgroundColor(context),
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        margin: const EdgeInsets.only(top: 16.0),
        height: MediaQuery.of(context).size.height * 0.8,
        child: NewContactScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                onTap: () {
                  openNewContactsScreen(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Icon(
                          Icons.person_add_alt_1_outlined,
                          size: 32,
                          color: AppColors.global,
                        ),
                      ),
                      const Text(
                        "Novo Contato",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.2),
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Icon(
                          Icons.group_add_outlined,
                          size: 32,
                          color: AppColors.global,
                        ),
                      ),
                      const Text(
                        "Criar Grupo",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
