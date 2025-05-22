import 'package:flutter/material.dart';

class TalentLanguageProvider with ChangeNotifier {
  final Map<String, String> _selectedLanguages = {};

  Map<String, String> get selectedLanguages => _selectedLanguages;

  void setSelectedLanguages(Map<String, String> newLanguages) {
    _selectedLanguages
      ..clear()
      ..addAll(newLanguages);
    notifyListeners();
  }
}
