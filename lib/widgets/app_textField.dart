import 'package:flutter/material.dart';
import 'package:pro_connect_projet/views/colors/app_colors.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hinText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final Widget? suffix;
  final Widget? prefix;
  final Color? enableBorderColor;
  final Color? focusedBorderColor;
  final FocusNode? focusNode;
  final int? maxLines;
  final bool readOnly;
  final Function()? onTap;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  const AppTextField({
    super.key,
    this.controller,
    this.hinText,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText,
    this.onChanged,
    this.enableBorderColor,
    this.focusedBorderColor,
    this.suffix,
    this.prefix,
    this.focusNode,
    this.onSubmitted,
    this.maxLines,
    this.readOnly = false,
    this.onTap,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.start,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      maxLines: maxLines ?? 1,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hinText,
        labelText: labelText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        suffix: suffix,
        prefix: prefix,
        labelStyle: TextStyle(
          color: AppColors.greyColor,
        ),
        hintStyle: TextStyle(

        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: enableBorderColor ?? AppColors.greyColor, width: context.screenWidth *0.0042),
          borderRadius: BorderRadius.circular(context.screenWidth * 0.027),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor ?? AppColors.blueColorSecond, width: context.screenWidth *0.0042),
          borderRadius: BorderRadius.circular(context.screenWidth * 0.027),
        ),
      )
    );
  }
}
