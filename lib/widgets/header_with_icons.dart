import 'package:flutter/material.dart';
import '../themes/theme_provider.dart';

class HeaderWithIcons extends StatefulWidget implements PreferredSizeWidget {
  final ThemeProvider themeProvider;
  final Function(String) onSearch;

  const HeaderWithIcons({
    required this.themeProvider,
    required this.onSearch,
    Key? key,
  }) : super(key: key);

  @override
  _HeaderWithIconsState createState() => _HeaderWithIconsState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _HeaderWithIconsState extends State<HeaderWithIcons> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? Theme.of(context).scaffoldBackgroundColor
        : Colors.grey[100];
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final searchBoxColor =
        isDarkMode ? Theme.of(context).cardColor : Colors.red[50];

    return AppBar(
      toolbarHeight: 60,
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: false,
      title: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.qr_code_scanner,
              size: 30,
              color: textColor,
            ),
            onPressed: () {},
          ),
          Expanded(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: searchBoxColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: widget.onSearch,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.red,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: isDarkMode ? Colors.white : Colors.red,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              widget.themeProvider.themeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
              size: 30,
              color: textColor,
            ),
            onPressed: () {
              widget.themeProvider.toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}
