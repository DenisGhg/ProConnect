import 'package:flutter/material.dart';

class ProfilTypeProvider with ChangeNotifier{
  String _profilType = "";

  get profilType => _profilType;

  void setProfilType(String type){
    _profilType = type;
    notifyListeners();
  }
}