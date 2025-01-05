import 'package:flutter/material.dart';

class CustomBottomNavigationBarLazMall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 12),
      color: isDarkMode
          ? Colors.grey[900]
          : const Color(0xFFF8C8C8), 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildCustomBottomNavigationBarItem(
              'assets/images/icon_lazmall.png', true, isDarkMode),
          _buildCustomBottomNavigationBarItem(
              'assets/images/mulai_dari_1rb.png', false, false),
          _buildCustomBottomNavigationBarItem(
              'assets/images/icon_lazsubsidi.png', false, isDarkMode),
          _buildCustomBottomNavigationBarItem(
              'assets/images/icon_keranjang.png', false, isDarkMode),
        ],
      ),
    );
  }

  Widget _buildCustomBottomNavigationBarItem(
      String icon, bool isSelected, bool isDarkMode) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          icon,
          height: 36, 
          color: isDarkMode ? Colors.white : null, 
        ),
        if (isSelected)
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 50,
            height: 2,
            color:
                isDarkMode ? Colors.white : Colors.black, 
          ),
      ],
    );
  }
}
