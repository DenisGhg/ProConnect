import 'package:flutter/material.dart';
import '../../../models/register/talent/notification_talent.dart';

class NotificationTalentProvider with ChangeNotifier {
  final List<NotificationTalent> _notifications = [
    NotificationTalent(
      id: "1",
      type: "profile_view",
      title: "Profil consulté",
      body: "Un recruteur a visité votre profil.",
      timestamp: DateTime.now().subtract(Duration(minutes: 15)),
      isRead: false,
      relatedRoute: "/profil",
    ),
    NotificationTalent(
      id: "2",
      type: "message",
      title: "Nouveau message",
      body: "Vous avez reçu un message d’un recruteur.",
      timestamp: DateTime.now().subtract(Duration(hours: 2)),
      isRead: true,
      relatedRoute: "/chat",
    ),
    NotificationTalent(
      id: "3",
      type: "system",
      title: "Mise à jour recommandée",
      body: "Complétez votre profil pour augmenter votre visibilité.",
      timestamp: DateTime.now().subtract(Duration(days: 1)),
      isRead: false,
      relatedRoute: "/edit-profile",
    ),
  ];

  List<NotificationTalent> get notifications => _notifications;

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  void markAsRead(String id) {
    final notif = _notifications.firstWhere((n) => n.id == id);
    if (!notif.isRead) {
      notif.markAsRead();
      notifyListeners();
    }
  }
}