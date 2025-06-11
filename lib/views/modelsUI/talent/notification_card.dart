import 'package:flutter/material.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'package:provider/provider.dart';
import '../../../models/register/talent/notification_talent.dart';
import '../../../providers/talent_providers/notification_talent_provider.dart';
import '../../../widgets/app_text.dart';
import '../../colors/app_colors.dart';

class NotificationCard extends StatelessWidget {
  final NotificationTalent notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.getNotificationColor(notification.isRead, context),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(context.referenceSize),
      ),
      child: ListTile(
        onTap: () {
          Provider.of<NotificationTalentProvider>(
            context,
            listen: false,
          ).markAsRead(notification.id);
        },
        leading: Icon(
          _getIcon(notification.type),
          color: notification.isRead ? AppColors.greyColor : AppColors.blueColor,
        ),
        title: AppText(
          text: notification.title,
          fontWeight: FontWeight.bold,
        ),
        subtitle: AppText(
          text: notification.body,
          fontSize: context.mediumText * 0.8,
        ),
        trailing: AppText(
          text: _formatTime(notification.timestamp),
          fontSize: context.smallText,

        ),
      ),
    );
  }

  //Pour retourner une icône en fonction du type de notification
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

  //Pour le formatage de l'affichage de la durée depuis l'envoie de la notification
  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inSeconds < 60) return 'maintenant';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min';
    if (diff.inHours < 24) return '${diff.inHours} h';
    return '${diff.inDays} j';
  }
}
