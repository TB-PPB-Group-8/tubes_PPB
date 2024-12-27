import 'package:flutter/material.dart';

class DarkModeToggle extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onChanged;

  const DarkModeToggle({
    super.key,
    required this.isDarkMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isDarkMode,
      onChanged: onChanged,
    );
  }
}