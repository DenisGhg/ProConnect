import 'package:flutter/material.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';

import 'app_text.dart';

class AppButton extends StatefulWidget {
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
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> with SingleTickerProviderStateMixin {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) {
    setState(() => _scale = 0.95);
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _scale = 1.0);
  }

  void _onTapCancel() {
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final double height = widget.height ?? context.adjustAppSize(context.screenHeight, 0.06);
    final double width = widget.width ?? context.adjustAppSize(context.screenWidth, 0.943);
    final EdgeInsetsGeometry padding = widget.padding ?? EdgeInsets.all(context.screenWidth * 0.027);

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: Container(
          height: height,
          width: width,
          alignment: widget.alignment ?? Alignment.center,
          padding: padding,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? Colors.blue,
            borderRadius: BorderRadius.circular(widget.radius ?? context.screenHeight * 0.027),
            border: Border.all(
              color: widget.borderColor ?? Colors.transparent,
              width: widget.borderWidth ?? 0,
            ),
            boxShadow: _scale < 1
                ? []
                : [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0, 4),
                blurRadius: 6,
              )
            ],
          ),
          child: widget.child ?? AppText(text: ""),
        ),
      ),
    );
  }
}