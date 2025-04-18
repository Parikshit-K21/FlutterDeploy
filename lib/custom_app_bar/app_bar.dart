import 'package:bw_sparsh/Screens/homePAge/homePage.dart';
import 'package:flutter/material.dart';

import 'search.dart';
import 'app_links.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isSearchActive = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    double appBarHeight = isSearchActive ? 100 : 50;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: appBarHeight,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 50,
              automaticallyImplyLeading: false,
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: const Icon(Icons.menu, color: Colors.black),
                  ),
                  Container(
                    height: 25,
                    width: 1.5,
                    color: Colors.grey,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContentPage()),
                      );
                    },
                    child: const Text(
                      "SPARSH",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (screenWidth > 1080)
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildDropdownMenu(
                              context, 'Transactions', transactionLinks),
                          _buildDropdownMenu(context, 'Reports', reportLinks),
                          _buildDropdownMenu(context, 'Masters', masterLinks),
                          _buildDropdownMenu(
                              context, 'Miscellaneous', miscLinks),
                        ],
                      ),
                    ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_active_outlined,
                      color: Colors.black),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.black),
                  onPressed: () {
                    setState(() {
                      isSearchActive = !isSearchActive;
                    });
                  },
                ),
              ],
            ),
            if (isSearchActive)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: SizedBox(
                  height: 40,
                  child: SearchBarWidget(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownMenu(
    BuildContext context,
    String title,
    List<Map<String, dynamic>> links,
  ) {
    return PopupMenuButton<String>(
      tooltip: title,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
      onSelected: (value) {
        _handleNavigation(context, value);
      },
      itemBuilder: (context) => links.map((link) {
        return PopupMenuItem<String>(
          value: link['title'],
          child: link['subLinks'] != null
              ? _buildSubMenu(context, link)
              : Text(link['title']),
        );
      }).toList(),
    );
  }

  Widget _buildSubMenu(BuildContext context, Map<String, dynamic> link) {
    return PopupMenuButton<String>(
      offset: const Offset(200, 0),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              link['title'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(Icons.arrow_right, size: 12),
            ),
          ],
        ),
      ),
      onSelected: (value) {
        _handleNavigation(context, value);
      },
      itemBuilder: (context) => link['subLinks']
          .map<PopupMenuItem<String>>((subLink) => PopupMenuItem<String>(
                value: subLink,
                child: Text('• $subLink'),
              ))
          .toList(),
    );
  }

  void _handleNavigation(BuildContext context, String value) {
    // if (value == 'Rural Retailer Entry/Update') {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => const RetailerRegistrationApp()),
    //   );
    // } else if (value == 'Token Scan') {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const QrCodeScanner()),
    //   );
    // } else if (value == 'Order Update') {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const OrderUpdate()),
    //   );
    // } else if (value == 'Order Entry') {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const OrderEntry()),
    //   );
    // } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('$value clicked')));
    
  }
}
