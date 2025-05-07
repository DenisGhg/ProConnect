import 'package:flutter/material.dart';

class SubDomainSelectionProvider with ChangeNotifier {
  // Map pour stocker les choix de l'utilisateur : domaine -> liste de sous-domaines sélectionnés
  final Map<String, List<String>> _selectedSubDomains = {};

  // Getter pour récupérer la Map complète des choix
  Map<String, List<String>> get selectedSubDomains => _selectedSubDomains;

  // Méthode pour enregistrer une nouvelle Map de choix
  void saveSelections(Map<String, List<String>> newSelections) {
    _selectedSubDomains
      ..clear()
      ..addAll(newSelections);
    notifyListeners();
  }

}
