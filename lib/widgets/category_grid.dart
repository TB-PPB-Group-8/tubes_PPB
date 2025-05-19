import 'package:flutter/material.dart';

class CategoryGrid extends StatelessWidget {
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  CategoryGrid({
    this.crossAxisSpacing = 5.0,
    this.mainAxisSpacing = 8.0,
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
        'label': 'Choice',
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
        'label': 'Reward',
      },
      {
        'image': 'assets/images/tiket.png',
        'label': 'Tiket',
        'borderColor': Color(0xFFC2D0CA),
        'backgroundColor': Color(0xFFC2D0CA),
      },
    ];

    double screenWidth = MediaQuery.of(context).size.width;
    const double defaultMaxWidth = 430; // batas layar max untuk 5 kolom

    // Ubah crossAxisCount sesuai lebar layar
    int crossAxisCount = screenWidth <= defaultMaxWidth ? 5 : 10;

    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GridView.builder(
      itemCount: categories.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        double totalSpacing = (crossAxisCount - 1) * crossAxisSpacing;
        double itemWidth = (screenWidth - totalSpacing) / crossAxisCount;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: itemWidth * 0.7,
              height: itemWidth * 0.7,
              padding: category.containsKey('borderColor')
                  ? const EdgeInsets.all(4)
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
                category['image'],
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: itemWidth * 0.8,
              child: Text(
                category['label'],
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
