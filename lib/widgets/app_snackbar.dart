import 'package:flutter/material.dart';
import 'package:pro_connect_projet/views/colors/app_colors.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:pro_connect_projet/widgets/app_text.dart';

class AppSnackBar {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppText(text: message, fontSize: context.smallText * 1.2),
        duration: Duration(seconds: 2),
        backgroundColor: AppColors.orangeColor,
      ),
    );
  }
}
