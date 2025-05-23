import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/carousel_banner.dart';
import '../widgets/laz_flash_section.dart';
import '../widgets/category_grid.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/header_with_icons.dart';
import '../themes/theme_provider.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'message_screen.dart';
import 'lazmall_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<dynamic> _products = [];
  List<dynamic> _filteredProducts = [];
  bool _isLoading = true;
  bool _isSearchEmpty = false;

  final List<String> banners = [
    'assets/images/banner1.png',
    'assets/images/banner2.webp',
    'assets/images/banner3.webp',
  ];

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
          _filteredProducts = _products;
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  void _handleSearch(String query) {
    setState(() {
      _filteredProducts = _products.where((product) {
        final productTitle = product['title'].toLowerCase();
        return productTitle.contains(query.toLowerCase());
      }).toList();

      // Cek apakah hasil pencarian kosong atau tidak
      if (_filteredProducts.isEmpty) {
        _isSearchEmpty = true;
      } else {
        _isSearchEmpty = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: HeaderWithIcons(
        themeProvider: themeProvider,
        onSearch: _handleSearch, // Menangani pencarian
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  List<Widget> get _screens => [
        _buildHomeContent(),
        CartScreen(),
        MessageScreen(),
        ProfileScreen(),
      ];

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (_isSearchEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Produk tidak ditemukan",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          if (!_isSearchEmpty) CarouselBanner(banners: banners),
          if (!_isSearchEmpty) const SizedBox(height: 16.0),
          if (!_isSearchEmpty)
            CategoryGrid(crossAxisSpacing: 7.0, mainAxisSpacing: 7.0),
          const SizedBox(height: 16.0),
          if (!_isSearchEmpty)
            LazFlashSection(
              isLoading: _isLoading,
              products: _filteredProducts,
              onMorePressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LazMall()),
                );
              },
            ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
