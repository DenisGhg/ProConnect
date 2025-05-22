import 'package:flutter/material.dart';

class TalentTitleProProvider with ChangeNotifier {
  String? _proTitle;

  String? get proTitle => _proTitle;

  void setProTitle(String value) {
    _proTitle = value;
    notifyListeners();
  }
}
