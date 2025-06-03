import 'package:flutter/widgets.dart';

extension ScreenSize on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  double get statusBarHeight => MediaQuery.of(this).padding.top;

  double get bottomBarHeight => MediaQuery.of(this).padding.bottom;

  double get defaultSpacing => MediaQuery.of(this).size.height  * 0.01;

  double get defaultPagePadding => MediaQuery.of(this).size.width  * 0.055;

  double get referenceSize => MediaQuery.of(this).size.width * 0.0278; // 10 pixel sur mon écran

  double get safeHeight => screenHeight - statusBarHeight - bottomBarHeight;

  double adjustAppSize(double baseSize, double factor) {
    return baseSize * factor;
  }
}