import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic>? product;
  final int crossAxisCount;
  final double screenWidth;

  const ProductCard({
    required this.product,
    required this.crossAxisCount,
    required this.screenWidth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double totalHorizontalPadding =
        16.0 * 2 + 12.0 * (crossAxisCount - 1);
    final double cardWidth =
        (screenWidth - totalHorizontalPadding) / crossAxisCount;
    final double imageHeight = cardWidth * 0.75;

    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final String formattedPrice = product != null
        ? '\$${NumberFormat("#,##0.00", "en_US").format(product!['price'])}'
        : 'Unknown Price';

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
              if (product != null)
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: Container(
                    height: imageHeight,
                    width: cardWidth,
                    color: Colors.white,
                    child: Image.network(
                      product!['image'],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 40),
                    ),
                  ),
                )
              else
                Container(
                  height: imageHeight,
                  width: cardWidth,
                  color: Colors.white,
                  child: Icon(
                    Icons.image,
                    size: 50,
                    color: isDarkMode
                        ? Colors.grey.shade600
                        : Colors.grey.shade700,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product?['title'] ?? 'Unknown Product',
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to Cart!')),
                );
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
