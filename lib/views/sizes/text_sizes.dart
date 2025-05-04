import 'package:flutter/widgets.dart';

extension AdaptiveTextSize on BuildContext {
  //double get screenWidth => MediaQuery.of(this).size.width;

  //double get defaultText => MediaQuery.of(this).size.width * 2;

  double get smallText => MediaQuery.of(this).size.width * 0.03;

  double get mediumText => MediaQuery.of(this).size.width * 0.045;

  double get largeText => MediaQuery.of(this).size.width * 0.06;

  double adjustTextSize(double baseSize, double factor) {
    return baseSize * factor;
  }
}