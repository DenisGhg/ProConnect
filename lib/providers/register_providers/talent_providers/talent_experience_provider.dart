import 'package:flutter/material.dart';
import '../../../models/register/talent/experience.dart';

class TalentExperienceProvider with ChangeNotifier {
  List<Experience> _experiences = [];

  List<Experience> get experiences => _experiences;

  void setExperiences(List<Experience> newExperiences) {
    _experiences = newExperiences;
    notifyListeners();
  }

}
