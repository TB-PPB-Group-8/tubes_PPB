import 'package:flutter/material.dart';

class CustomBottomNavigationBarLazMall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      color: Color(0xFFF8C8C8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildCustomBottomNavigationBarItem(
              'assets/images/icon_lazmall.png', 'LazMall', true),
          _buildCustomBottomNavigationBarItem(
              'assets/images/mulai_dari_1rb.png', 'Choice', false),
          _buildCustomBottomNavigationBarItem(
              'assets/images/icon_lazsubsidi.png', 'LazSubsidy', false),
          _buildCustomBottomNavigationBarItem(
              'assets/images/icon_keranjang.png', 'Keranjang', false),
        ],
      ),
    );
  }

  Widget _buildCustomBottomNavigationBarItem(
      String icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          icon,
          height: 24,
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
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
