import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:intl/intl.dart';
import '../controllers/cart_controller.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final int crossAxisCount;
  final double screenWidth;

  const ProductCard({
    required this.product,
    required this.crossAxisCount,
    required this.screenWidth,
    Key? key,
  }) : super(key: key);

  void showAddedToCartFlushbar(BuildContext context) {
    Flushbar(
      message: "Added to Cart!",
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

  @override
  Widget build(BuildContext context) {
    final double totalHorizontalPadding =
        16.0 * 2 + 12.0 * (crossAxisCount - 1);
    final double cardWidth =
        (screenWidth - totalHorizontalPadding) / crossAxisCount;
    final double imageHeight = cardWidth * 0.75;

    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final String formattedPrice =
        '\$${NumberFormat("#,##0.00", "en_US").format(product['price'])}';

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: isDarkMode
                ? Colors.black.withOpacity(0.6)
                : Colors.grey.shade300,
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: Container(
                  height: imageHeight,
                  width: cardWidth,
                  color: Colors.white,
                  child: Image.network(
                    product['image'],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 40),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['title'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 7),
                    Text(
                      formattedPrice,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.pinkAccent : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: IconButton(
              onPressed: () {
                context.read<CartController>().addItem(product);
                showAddedToCartFlushbar(context);
              },
              icon: Icon(
                Icons.shopping_cart,
                color: isDarkMode ? Colors.pinkAccent : Colors.black,
                size: 20,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }
}
