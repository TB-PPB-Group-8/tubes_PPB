import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges; // Pastikan untuk menggunakan alias jika ada konflik nama

class NotificationBadge extends StatelessWidget {
  final int notificationCount;
  final VoidCallback onTap;

  NotificationBadge({
    required this.notificationCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      badgeStyle: badges.BadgeStyle(
        badgeColor: Colors.red,
        elevation: 0,
      ),
      position: badges.BadgePosition.topEnd(top: -10, end: -10),
      badgeContent: Text(
        notificationCount > 0 ? notificationCount.toString() : '',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
      child: IconButton(
        icon: Icon(Icons.notifications),
        onPressed: onTap,
      ),
    );
  }
}
