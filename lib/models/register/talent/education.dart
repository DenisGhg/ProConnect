// Modèle représentant une formation académique
class Education {
  String diploma;         // Intitulé du diplôme ou formation
  String school;          // Nom de l’établissement
  String description;     // Détails ou spécialité
  DateTime startDate;     // Date de début
  DateTime? endDate;      // Date de fin (nullable si en cours)
  bool isCurrent;         // Indique si l’éducation est toujours en cours

  Education({
    required this.diploma,
    required this.school,
    required this.description,
    required this.startDate,
    this.endDate,
    this.isCurrent = false,
  });
}