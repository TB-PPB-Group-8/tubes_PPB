import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

// CarouselBanner Widget
class CarouselBanner extends StatelessWidget {
  final List<Map<String, String>> imagePathsWithText;

  CarouselBanner({required this.imagePathsWithText});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 250,
        autoPlay: true,
        enlargeCenterPage: true,
        autoPlayInterval: Duration(seconds: 3),
      ),
      items: imagePathsWithText.map((banner) {
        return Builder(
          builder: (BuildContext context) {
            return Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(banner['imagePath']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    padding: EdgeInsets.all(8),
                    child: Text(
                      banner['description']!,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }).toList(),
    );
  }
}
