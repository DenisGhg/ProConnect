import 'package:flutter/material.dart';

class TalentPersonalInfoProvider with ChangeNotifier {
  String? _country;
  String? _city;
  String? _phoneNumber;
  String? _dateOfBirth;

  // Getters sécurisés
  String? get country => _country;
  String? get city => _city;
  String? get phoneNumber => _phoneNumber;
  String? get dateOfBirth => _dateOfBirth;

  // Setters contrôlés
  void setCountry(String value) {
    _country = value;
    notifyListeners();
  }

  void setCity(String value) {
    _city = value;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  void setDateOfBirth(String value) {
    _dateOfBirth = value;
    notifyListeners();
  }

  // Optionnel : méthode de validation ou de reset
  void clearAll() {
    _country = null;
    _city = null;
    _phoneNumber = null;
    _dateOfBirth = null;
    notifyListeners();
  }
}
