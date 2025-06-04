import 'education.dart';
import 'experience.dart';

class TalentProfile {
  final int id;
  final String firstName;
  final String lastName;
  final String title;
  final String bio;
  final String phone;
  final String country;
  final String city;
  final String birthDate;
  final Map<String, List<String>> domains;
  final List<String> skills;
  final List<Experience> experiences;
  final List<Education> educations;
  final List<Map<String, String>> languages;
  final String avatar;

  TalentProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.title,
    required this.bio,
    required this.phone,
    required this.country,
    required this.city,
    required this.birthDate,
    required this.domains,
    required this.skills,
    required this.experiences,
    required this.educations,
    required this.languages,
    required this.avatar,
  });

  factory TalentProfile.fromJson(Map<String, dynamic> json) {
    return TalentProfile(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      title: json['title'],
      bio: json['bio'],
      phone: json['phone'],
      country: json['country'],
      city: json['city'],
      birthDate: json['birthDate'],
      domains: Map<String, List<String>>.from(json['domains'].map((key, val) => MapEntry(key, List<String>.from(val)))),
      skills: List<String>.from(json['skills']),
      experiences: List<Experience>.from(json['experiences'].map((e) => Experience.fromJson(e))),
      educations: List<Education>.from(json['educations'].map((e) => Education.fromJson(e))),
      languages: List<Map<String, String>>.from(json['languages'].map((lang) => Map<String, String>.from(lang))),
      avatar: json['avatar'],
    );
  }
}
