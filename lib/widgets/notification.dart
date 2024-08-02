import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<String> notifications = [
    "Manager Apprvoe Your Weekly Plan",
    "Manager add comment to your visit",
    "Manager create a visit for you",
    "Other Updates",
  ];

  void handleNotificationTap(String notification) {
    print("Tapped on notification: $notification");
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.notifications,
        size: 40,
        color: Colors.white,
      ),
      offset: const Offset(0, 60), // Adjust offset to control menu size
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
