import 'package:flutter/material.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';

import '../../widgets/app_text.dart';
import '../colors/app_colors.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  const ErrorMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return message.isEmpty
        ? const SizedBox.shrink()
        : AppText(
      text: message,
      color: AppColors.redColor,
      fontSize: context.smallText,
    );
  }
}