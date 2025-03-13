import 'package:flutter/material.dart';

void navigate(BuildContext context, Widget page) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeInOut));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    ),
  );
}
