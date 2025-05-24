import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showAddedToCartFlushbar(BuildContext context) {
  Flushbar(
    message: "🛒 Added to Cart!",
    duration: Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.TOP,
    backgroundGradient: LinearGradient(
      colors: [Colors.orange.shade700, Colors.pink.shade500],
    ),
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(0, 3),
        blurRadius: 3,
      )
    ],
    borderRadius: BorderRadius.circular(12),
    margin: EdgeInsets.all(10),
    animationDuration: Duration(milliseconds: 500),
    icon: Icon(
      Icons.shopping_cart,
      color: Colors.white,
    ),
    forwardAnimationCurve: Curves.easeOut,
    reverseAnimationCurve: Curves.easeIn,
    flushbarStyle: FlushbarStyle.FLOATING,
  ).show(context);
}
