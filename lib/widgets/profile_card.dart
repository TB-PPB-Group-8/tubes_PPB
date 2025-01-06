import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String email;
  final String name;
  final String password;

  const ProfileCard({
    required this.email,
    required this.name,
    required this.password,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? Colors.grey[800] : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        color: cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildInfoRow(Icons.email, "Email: $email", textColor),
              const Divider(),
              _buildInfoRow(Icons.person, "Name: $name", textColor),
              const Divider(),
              _buildInfoRow(Icons.lock, "Password: $password", textColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color textColor) {
    return Row(
      children: [
        Icon(icon, color: textColor),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}
