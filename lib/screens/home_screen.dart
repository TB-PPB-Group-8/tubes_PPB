import 'package:flutter/material.dart';
import 'package:project_lazada/screens/lazmall_screen.dart' show LazMall;
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:project_lazada/themes/theme_provider.dart';
import 'package:project_lazada/widgets/product_card.dart';
import '../widgets/category_grid.dart';
import 'package:project_lazada/widgets/custom_bottom_navigation_bar.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'message_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<String> banners = [
    'assets/images/banner1.png',
    'assets/images/banner2.webp',
    'assets/images/banner3.webp',
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: _buildAppBar(themeProvider),
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

  AppBar _buildAppBar(ThemeProvider themeProvider) {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner, size: 30, color: Colors.black),
            onPressed: () {},
          ),
          Expanded(
            child: Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.red, size: 20),
                  SizedBox(width: 5),
                  Text(
                    'Search...',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              themeProvider.themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCarouselBanner(),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CategoryGrid(
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
          ),
          SizedBox(height: 20),
          _buildPromoSection(),
          SizedBox(height: 20),
          _buildLazFlashSection(context),
        ],
      ),
    );
  }

  Widget _buildCarouselBanner() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.width * 0.5,
              autoPlay: true,
              enlargeCenterPage: false,
              viewportFraction: 1.0,
              clipBehavior: Clip.hardEdge,
            ),
            items: banners.map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildPromoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Promo Pengguna Baru!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    'Lihat >',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(2, (index) {
                if (index == 1) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          width: 150,
                          height: 200,
                          child: ProductCard(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.tealAccent,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'RP 20.000\nkhusus pengguna baru',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {
                                print("Ambil ditekan");
                              },
                              child: Text("Ambil"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      width: 150,
                      height: 200,
                      child: ProductCard(),
                    ),
                  );
                }
              }),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLazFlashSection(BuildContext context) {
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LazMall()),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Text(
                    'Lainnya >',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
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
                itemCount: 10,
                itemBuilder: (context, index) => ProductCard(),
              );
            },
          ),
        ],
      ),
    );
  }
}
