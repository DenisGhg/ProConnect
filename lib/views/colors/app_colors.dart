import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/themes/theme_provider.dart';

class AppColors {
  static Color blueColor = const Color.fromARGB(255, 33, 150, 243);
  static Color redColor = const Color.fromARGB(255, 244, 67, 54);
  static Color greenColor = const Color.fromARGB(255, 76, 175, 80);
  static Color greyColor = const Color.fromARGB(255, 158, 158, 158);
  static Color whiteColor = const Color.fromARGB(255, 255, 255, 255);
  static Color orangeColor = const Color.fromARGB(255, 255, 152, 0);
  static Color blueColorSecond = const Color.fromARGB(255, 13, 71, 161);
  static Color blackColor = const Color.fromARGB(255, 0, 0, 0);

  // La couleur primaire basée sur le mode sombre/claire
  static Color primaryColor(BuildContext context) {
    bool isDarkMode = context.read<ThemeProvider>().isDarkMode;
    return isDarkMode ? whiteColor : blackColor;
  }

}

