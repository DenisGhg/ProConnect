// Modèle représentant une expérience professionnelle
class Experience {
  String title;          // Titre du poste
  String company;        // Nom de l’entreprise
  String description;    // Description du poste
  DateTime startDate;    // Date de début
  DateTime? endDate;     // Date de fin (nullable si poste actuel)
  bool isCurrent;        // Indique si c’est le poste actuel

  Experience({
    required this.title,
    required this.company,
    required this.description,
    required this.startDate,
    this.endDate,
    this.isCurrent = false,
  });
}