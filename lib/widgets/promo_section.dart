import 'package:flutter/material.dart';
import 'product_card.dart';

class PromoSection extends StatelessWidget {
  final List<dynamic> products;

  const PromoSection({required this.products, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Deteksi apakah mode gelap diaktifkan
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        double totalWidth = constraints.maxWidth; // Lebar total layar
        double cardWidth = (totalWidth / 3) - 12; // Lebar kartu
        double cardHeight = cardWidth * 2.0; // Tinggi kartu lebih proporsional

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Promo Pengguna Baru!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        'Lihat >',
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

              // Content Section
              Row(
                children: [
                  // Produk Pertama
                  if (products.isNotEmpty)
                    Container(
                      width: cardWidth,
                      height: cardHeight,
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey[800] : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ProductCard(product: products[0]),
                    ),
                  const SizedBox(width: 8),

                  // Produk Kedua
                  if (products.length > 1)
                    Container(
                      width: cardWidth,
                      height: cardHeight,
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.grey[800] : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ProductCard(product: products[1]),
                    ),
                  const SizedBox(width: 8),

                  // Kotak Khusus Promo
                  Container(
                    width: cardWidth,
                    height: cardHeight,
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[800] : Colors.blue[50],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        // Container putih full ke atas
                        Container(
                          height: cardHeight,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Rp. 20.000',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isDarkMode ? Colors.black : Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Khusus Pengguna Baru',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      isDarkMode ? Colors.black : Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Tombol di bagian bawah
                        Positioned(
                          bottom: 8,
                          left: 8,
                          right: 8,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDarkMode
                                  ? Colors.pink
                                  : Colors.blue, // Warna tombol
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Promo diklaim!'),
                                ),
                              );
                            },
                            child: const Text('Ambil'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
