import 'package:flutter/material.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';

import 'app_text.dart';

class AppButton extends StatelessWidget {
  final Function()? onTap;
  final double? height;
  final double? width;
  final AlignmentGeometry? alignment;
  final Color? backgroundColor;
  final double? radius;
  final Widget? child;
  final Color? borderColor;
  final double? borderWidth;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    super.key,
    this.onTap,
    this.height,
    this.width,
    this.alignment,
    this.backgroundColor,
    this.radius,
    this.child,
    this.borderColor,
    this.borderWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? context.adjustAppSize(context.screenHeight, 0.06),
        width: width ?? context.adjustAppSize(context.screenWidth, 0.943),
        alignment: alignment ?? Alignment.center,
        padding: padding ?? EdgeInsets.all(context.screenWidth * 0.027),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.blue,
          borderRadius: BorderRadius.circular(radius ?? context.screenHeight * 0.027),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0,
          )
        ),
        child: child ?? AppText(text: ""),
      ),
    );
  }
}
