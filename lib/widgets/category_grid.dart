import 'package:flutter/material.dart';

class CategoryGrid extends StatelessWidget {
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  CategoryGrid({
    this.crossAxisSpacing = 5.0, // Default spacing
    this.mainAxisSpacing = 8.0, // Default spacing
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'image': 'assets/images/lazmall.png',
        'label': 'LazMall',
      },
      {
        'image': 'assets/images/lucky_egg.png',
        'label': 'Lucky Egg',
        'borderColor': Color(0xFFF65949),
        'backgroundColor': Color(0xFFF65949),
      },
      {
        'image': 'assets/images/dana.png',
        'label': 'Dana',
      },
      {
        'image': 'assets/images/lazlive.png',
        'label': 'LazLive',
        'borderColor': Color(0xFFA7A4F4),
        'backgroundColor': Color(0xFFA7A4F4),
      },
      {
        'image': 'assets/images/mulai_dari_1rb.png',
        'label': 'Mulai dari 1RB',
        'borderColor': Color(0xFFFDCD10),
        'backgroundColor': Color(0xFFFDCD10),
      },
      {
        'image': 'assets/images/lazmart.png',
        'label': 'LazMart',
      },
      {
        'image': 'assets/images/lazlook.png',
        'label': 'LazLook',
      },
      {
        'image': 'assets/images/lazbeauty.png',
        'label': 'LazBeauty',
      },
      {
        'image': 'assets/images/ulasan_berhadiah.png',
        'label': 'Ulasan Berhadiah',
      },
      {
        'image': 'assets/images/tiket.png',
        'label': 'Tiket',
        'borderColor': Color(0xFFC2D0CA),
        'backgroundColor': Color(0xFFC2D0CA),
      },
    ];

    return GridView.builder(
      itemCount: categories.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 55,
              height: 55,
              padding: category.containsKey('borderColor')
                  ? EdgeInsets.all(4)
                  : EdgeInsets.zero,
              decoration: BoxDecoration(
                color: category['backgroundColor'] ?? Colors.transparent,
                border: category.containsKey('borderColor')
                    ? Border.all(
                        color: category['borderColor'],
                        width: 1,
                      )
                    : null,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                category['image']!,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 4),
            Text(
              category['label']!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}
