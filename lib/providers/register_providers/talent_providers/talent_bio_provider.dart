import 'package:flutter/material.dart';

class TalentBioProvider with ChangeNotifier {
  String? _bio;

  String? get bio => _bio;

  void setbio(String value) {
    _bio = value;
    notifyListeners();
  }
}
