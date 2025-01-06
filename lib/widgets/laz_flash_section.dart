import 'package:flutter/material.dart';
import 'product_card.dart';

class LazFlashSection extends StatelessWidget {
  final bool isLoading;
  final List<dynamic> products;
  final VoidCallback onMorePressed;

  const LazFlashSection({
    required this.isLoading,
    required this.products,
    required this.onMorePressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Deteksi apakah mode gelap diaktifkan
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'LazFlash',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: onMorePressed,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    'Lainnya >',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth ~/ 180;
                    crossAxisCount = crossAxisCount < 2 ? 2 : crossAxisCount;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 3 / 4,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ProductCard(product: products[index]),
                        );
                      },
                    );
                  },
                ),
        ],
      ),
    );
  }
}
