import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hinText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final Color? enableBorderColor;
  final Color? focusedBorderColor;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
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
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.start,
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: obscureText ?? false,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hinText,
        labelText: labelText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        hintStyle: TextStyle(

        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: enableBorderColor ?? Colors.grey, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor ?? Colors.blue.shade900, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
