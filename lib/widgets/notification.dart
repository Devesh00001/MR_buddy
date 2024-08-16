import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mr_buddy/features/welcome/provider/welcome_provider.dart';
import 'package:mr_buddy/notifiction_service.dart';
import 'package:provider/provider.dart';

import '../features/welcome/model/user.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<String> notifications = [];

  void handleNotificationTap(String notification) {
    final provider = Provider.of<WelcomeProvider>(context, listen: false);
    User currentUser = provider.user!;
    NotificationService service = NotificationService();
    service.deleteNotificationForUser(currentUser.name, notification);
    log("Delete: $notification");
  }

  getNotifictions() async {
    final provider = Provider.of<WelcomeProvider>(context, listen: false);
    User currentUser = provider.user!;
    NotificationService service = NotificationService();
    notifications =
        (await service.getNotificationsForUser(currentUser.name)) ?? [];
  }

  @override
  void initState() {
    getNotifictions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.notifications,
        size: 25,
        color: Colors.white,
      ),
      offset: const Offset(0, 60),
      itemBuilder: (BuildContext context) {
        return notifications.asMap().entries.map((entry) {
          int index = entry.key;
          String notification = entry.value;
          Color? backgroundColor =
              index % 2 == 0 ? Colors.white : Colors.pink[50];
          return PopupMenuItem(
            child: Container(
              color: backgroundColor,
              child: SizedBox(
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    notification,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            onTap: () {
              handleNotificationTap(notification);
            },
          );
        }).toList();
      },
    );
  }
}
