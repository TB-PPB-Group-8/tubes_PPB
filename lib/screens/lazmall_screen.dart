import 'package:flutter/material.dart';
import 'package:project_lazada/widgets/header_lazmall.dart';
import 'package:project_lazada/widgets/navigation.dart';
import 'package:shimmer/shimmer.dart';
import '../widgets/product_card.dart';
import '../widgets/carousel_banner.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LazMall extends StatefulWidget {
  @override
  _LazMallState createState() => _LazMallState();
}

class _LazMallState extends State<LazMall> {
  final List<String> banners = [
    'assets/images/banner4.png',
    'assets/images/banner2.webp',
    'assets/images/banner3.webp',
  ];
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        setState(() {
          _products = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderLazMall(
        searchController: _searchController,
      ),
      body: _isLoading
          ? _buildSkeletonLoader()
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

                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: CarouselBanner(banners: banners),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio:
                              cardWidth / (cardWidth * 4 / 3), // rasio 3:4
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final product = _products[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? const Color(0xFF1E1E1E)
                                    : Colors.white,
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
                              child: ProductCard(
                                product: product,
                                crossAxisCount: crossAxisCount,
                                screenWidth: constraints.maxWidth,
                              ),
                            );
                          },
                          childCount: _products.length,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
      bottomNavigationBar: CustomBottomNavigationBarLazMall(),
    );
  }

  Widget _buildSkeletonLoader() {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth ~/ 180;
        if (crossAxisCount < 2) crossAxisCount = 2;

        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                  childCount: 12,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
