import 'package:flutter/material.dart';

// =========================== PROVIDER POUR LES SKILLS ===========================

class SkillSelectionProvider with ChangeNotifier {
  final List<String> _selectedSkills = [];

  List<String> get selectedSkills => List.unmodifiable(_selectedSkills);

  void addSkill(String skill) {
    if (!_selectedSkills.contains(skill)) {
      _selectedSkills.add(skill);
      notifyListeners();
    }
  }

  void removeSkill(String skill) {
    _selectedSkills.remove(skill);
    notifyListeners();
  }

  void setSkills(List<String> newSkills) {
    _selectedSkills
      ..clear()
      ..addAll(newSkills);
    notifyListeners();
  }
}