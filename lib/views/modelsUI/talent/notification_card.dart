import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/register/talent/notification_talent.dart';
import '../../../providers/talent_providers/notification_talent_provider.dart';
import '../../colors/app_colors.dart';

class NotificationCard extends StatelessWidget {
  final NotificationTalent notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.getNotificationColor(notification.isRead, context),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: () {
          Provider.of<NotificationTalentProvider>(context, listen: false)
              .markAsRead(notification.id);
        },
        leading: Icon(
          _getIcon(notification.type),
          color: notification.isRead ? Colors.grey : Colors.blue,
        ),
        title: Text(
          notification.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(notification.body),
        trailing: Text(
          _formatTime(notification.timestamp),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case "profile_view":
        return Icons.visibility;
      case "message":
        return Icons.message;
      case "system":
        return Icons.notifications;
      default:
        return Icons.info;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 60) return '${diff.inMinutes} min';
    if (diff.inHours < 24) return '${diff.inHours} h';
    return '${diff.inDays} j';
  }
}