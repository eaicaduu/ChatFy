import 'package:flutter/material.dart';

import 'modules/devices_bar.dart';

class DevicesScreen extends StatelessWidget {
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DevicesBar(),
      body: Placeholder(),
    );
  }
}
