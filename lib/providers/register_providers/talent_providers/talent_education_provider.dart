import 'package:flutter/material.dart';
import '../../../models/register/talent/education.dart';

class TalentEducationProvider with ChangeNotifier {
  List<Education> _educations = [];

  List<Education> get educations => _educations;

  void setEducations(List<Education> newEducations) {
    _educations = newEducations;
    notifyListeners();
  }

}
