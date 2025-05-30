import 'package:flutter/material.dart';

import '../../../../widgets/app_text.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: AppText(text: "Dashboard"),),
    );
  }
}
