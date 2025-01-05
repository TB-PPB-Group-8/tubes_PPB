import 'package:flutter/material.dart';
import 'package:project_lazada/widgets/header_lazmall.dart'; // Tambahkan ini
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
        searchController: _searchController, // Gunakan HeaderLazMall
      ),
      body: _isLoading
          ? _buildSkeletonLoader()
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: CarouselBanner(banners: banners),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.50,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final product = _products[index];
                        return ProductCard(product: product);
                      },
                      childCount: _products.length,
                    ),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: CustomBottomNavigationBarLazMall(),
    );
  }

  Widget _buildSkeletonLoader() {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.50,
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
  }
}
