import 'package:flutter/material.dart';

class SignUpProvider with ChangeNotifier {
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _password = '';
  bool _termsAccepted = false;

  // Getters
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get email => _email;
  String get password => _password;
  bool get termsAccepted => _termsAccepted;

  // Setters
  void setFirstName(String value) {
    _firstName = value;
    notifyListeners();
  }

  void setLastName(String value) {
    _lastName = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setTermsAccepted(bool value) {
    _termsAccepted = value;
    notifyListeners();
  }

}
