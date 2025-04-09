import 'package:flutter/material.dart';

class MailProvider with ChangeNotifier {
  final TextEditingController _mailController = TextEditingController();

  TextEditingController get mailController => _mailController;

  void updateMail(String value){
    _mailController.text = value;
    notifyListeners();
  }
}