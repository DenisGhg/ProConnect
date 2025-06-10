class NotificationTalent {
  final String id; // identifiant unique
  final String type; // e.g. "profile_view", "message", "system"
  final String title; // Titre affiché dans la notif
  final String body; // Contenu court
  final String? senderId; // Qui a déclenché l’action (recruteur, système, etc.)
  final String? targetId; // ID du contenu ciblé (profil, projet, etc.)
  final String? relatedRoute; // Route à ouvrir si clic
  final DateTime timestamp; // Quand ça a été généré
  bool isRead; // Si l’utilisateur l’a lue
  final String? icon; // (optionnel) icône spécifique

  NotificationTalent({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.timestamp,
    this.senderId,
    this.targetId,
    this.relatedRoute,
    this.isRead = false,
    this.icon,
  });

  void markAsRead(){
    isRead = true;
  }

  // 🔄 Pour Firebase ou autres
  factory NotificationTalent.fromMap(Map<String, dynamic> map) => NotificationTalent(
    id: map['id'],
    type: map['type'],
    title: map['title'],
    body: map['body'],
    senderId: map['senderId'],
    targetId: map['targetId'],
    relatedRoute: map['relatedRoute'],
    timestamp: DateTime.parse(map['timestamp']),
    isRead: map['isRead'] ?? false,
    icon: map['icon'],
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'type': type,
    'title': title,
    'body': body,
    'senderId': senderId,
    'targetId': targetId,
    'relatedRoute': relatedRoute,
    'timestamp': timestamp.toIso8601String(),
    'isRead': isRead,
    'icon': icon,
  };
}

