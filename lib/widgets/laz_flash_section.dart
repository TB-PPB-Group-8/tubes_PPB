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
                    // Hitung jumlah kolom berdasar lebar container, minimal 2 kolom
                    int crossAxisCount = constraints.maxWidth ~/ 180;
                    if (crossAxisCount < 2) crossAxisCount = 2;

                    // Hitung lebar card (kurangi padding & spacing)
                    double totalHorizontalPadding =
                        16 * 2 + (crossAxisCount - 1) * 10;
                    double cardWidth =
                        (constraints.maxWidth - totalHorizontalPadding) /
                            crossAxisCount;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: cardWidth /
                            (cardWidth *
                                4 /
                                3), // rasio 3:4 sesuai aspek ratio sebelumnya
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? const Color(0xFF1E1E1E)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(isDarkMode ? 0.5 : 0.1),
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ProductCard(
                            product: products[index],
                            crossAxisCount: crossAxisCount,
                            screenWidth: constraints.maxWidth,
                          ),
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
