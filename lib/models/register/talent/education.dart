// Modèle représentant une formation académique
class Education {
  String title;         // Intitulé du diplôme ou formation
  String company;          // Nom de l’établissement
  String description;     // Détails ou spécialité
  DateTime startDate;     // Date de début
  DateTime? endDate;      // Date de fin (nullable si en cours)
  bool isCurrent;         // Indique si l’éducation est toujours en cours

  Education({
    required this.title,
    required this.company,
    required this.description,
    required this.startDate,
    this.endDate,
    this.isCurrent = false,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      title: json['title'],
      company: json['company'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
      isCurrent: json['isCurrent'] ?? false,
    );
  }

}