import 'package:flutter/material.dart';

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
    this.borderWidth
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 10,
        width: width ?? 10,
        alignment: alignment,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.blue,
          borderRadius: BorderRadius.circular(radius ?? 10),
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
