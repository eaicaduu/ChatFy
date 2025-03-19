import 'package:flutter/material.dart';

import '../../values/colors.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: getBackgroundColor(context),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: getBackgroundColor(context),
        title: Text("Status"),
        actions: [
          IconButton(
            onPressed: () {
            },
            icon: Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: Center(
        child: Text("Nenhum Status", style: TextStyle(fontSize: 18, color: Colors.grey),),
      )
    );
  }
}

