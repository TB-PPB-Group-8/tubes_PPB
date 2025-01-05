import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.grey[300],
      selectedItemColor: isDarkMode ? Colors.pinkAccent : Colors.black,
      unselectedItemColor: isDarkMode ? Colors.white : Colors.black,
      items: [
        _buildCustomBottomNavigationBarItem(
            'assets/images/home_icon.png', 'Beranda', 0, isDarkMode, true),
        _buildCustomBottomNavigationBarItem(
            Icons.shopping_cart, 'Keranjang', 1, isDarkMode, false),
        _buildCustomBottomNavigationBarItem(
            Icons.message, 'Pesan', 2, isDarkMode, false),
        _buildCustomBottomNavigationBarItem(
            Icons.person, 'Akun', 3, isDarkMode, false),
      ],
    );
  }

  BottomNavigationBarItem _buildCustomBottomNavigationBarItem(
      dynamic icon, String label, int index, bool isDarkMode, bool isImage) {
    bool isSelected = currentIndex == index;

    return BottomNavigationBarItem(
      icon: _buildIconWithLabel(icon, label, isSelected, isDarkMode, isImage),
      label: '',
    );
  }

  Widget _buildIconWithLabel(dynamic icon, String label, bool isSelected,
      bool isDarkMode, bool isImage) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        
        if (isImage && icon is String)
          Image.asset(
            icon,
            width: 30,
            height: 30,
          )
        else if (icon is IconData)
          Icon(
            icon,
            size: 30,
            color: isSelected
                ? (isDarkMode ? Colors.pinkAccent : Colors.black) 
                : (isDarkMode
                    ? Colors.white 
                    : Colors.black), 
          ),
        
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            color: isDarkMode
                ? Colors.white 
                : (isSelected
                    ? Colors.black 
                    : Colors.black), 
            fontWeight: FontWeight.normal,
          ),
        ),
        
        if (isSelected)
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 50,
            height: 2,
            color: isDarkMode ? Colors.pinkAccent : Colors.black,
          ),
      ],
    );
  }
}
