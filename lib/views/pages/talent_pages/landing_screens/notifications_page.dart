import 'package:flutter/material.dart';
import 'package:pro_connect_projet/views/sizes/app_sizes.dart';
import 'package:pro_connect_projet/views/sizes/text_sizes.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import '../../../../providers/talent_providers/notification_talent_provider.dart';
import '../../../../widgets/app_text.dart';
import '../../../modelsUI/talent/notification_card.dart';


class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();

}

class _NotificationsPageState extends State<NotificationsPage> {

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(minutes: 1), (_) {
      setState(() {}); // Force le rebuild toutes les minutes
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificationTalentProvider>(context);
    final notifications = provider.notifications;

    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: "Notifications (${provider.unreadCount})",
          fontSize: context.largeText,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(context.defaultPagePadding),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: context.referenceSize * 0.6),
            child: NotificationCard(notification: notif),
          );
        },
      ),
    );
  }
}