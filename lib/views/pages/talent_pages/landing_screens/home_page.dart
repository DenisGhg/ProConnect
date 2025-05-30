import 'package:flutter/material.dart';

import '../../../../widgets/app_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(child: AppText(text: "Home Page"),),
    );;
  }
}
