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
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.grey[300],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      items: [
        _buildCustomBottomNavigationBarItem(
            'assets/images/home_icon.png', 'Beranda', 0),
        _buildCustomBottomNavigationBarItem(
            Icons.shopping_cart, 'Keranjang', 1),
        _buildCustomBottomNavigationBarItem(Icons.message, 'Pesan', 2),
        _buildCustomBottomNavigationBarItem(Icons.person, 'Akun', 3),
      ],
    );
  }

  BottomNavigationBarItem _buildCustomBottomNavigationBarItem(
      dynamic icon, String label, int index) {
    bool isSelected = currentIndex == index;
    return BottomNavigationBarItem(
      icon: _buildIconWithLabel(icon, label, isSelected),
      label: '',
    );
  }

  Widget _buildIconWithLabel(dynamic icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Menampilkan ikon, baik gambar (String) atau ikon (IconData)
        if (icon is String)
          Image.asset(
            icon,
            width: 30,
            height: 30,
          )
        else if (icon is IconData)
          Icon(
            icon,
            size: 30,
          ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 11,
            color: isSelected ? Colors.black : Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        if (isSelected)
          Container(
            margin: EdgeInsets.only(top: 4),
            width: 50,
            height: 2,
            color: Colors.black,
          ),
      ],
    );
  }
}
