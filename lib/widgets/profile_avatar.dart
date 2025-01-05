import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final bool isDarkMode;

  const ProfileAvatar({required this.isDarkMode, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[850] : Colors.blueAccent,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: MediaQuery.of(context).size.width / 2 - 50,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: isDarkMode ? Colors.grey[800] : Colors.white,
            child: Icon(
              Icons.person,
              color: isDarkMode ? Colors.white : Colors.blueAccent,
              size: 60,
            ),
          ),
        ),
      ],
    );
  }
}
