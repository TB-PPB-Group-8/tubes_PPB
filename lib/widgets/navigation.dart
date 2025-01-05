import 'package:flutter/material.dart';

class CustomBottomNavigationBarLazMall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70, 
      padding:
          EdgeInsets.symmetric(vertical: 12), 
      color: Color(0xFFF8C8C8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildCustomBottomNavigationBarItem(
              'assets/images/icon_lazmall.png', true),
          _buildCustomBottomNavigationBarItem(
              'assets/images/mulai_dari_1rb.png', false),
          _buildCustomBottomNavigationBarItem(
              'assets/images/icon_lazsubsidi.png', false),
          _buildCustomBottomNavigationBarItem(
              'assets/images/icon_keranjang.png', false),
        ],
      ),
    );
  }

  Widget _buildCustomBottomNavigationBarItem(String icon, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          icon,
          height: 36, 
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
