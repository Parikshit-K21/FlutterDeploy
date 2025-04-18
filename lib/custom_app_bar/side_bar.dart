import 'package:flutter/material.dart';
import 'app_links.dart';
import 'package:bw_sparsh/Reports/RetailerEntry.dart';
import 'package:bw_sparsh/Logic/QR_scanner.dart';
import 'package:bw_sparsh/Reports/order_update.dart';

class CustomSidebar extends StatefulWidget {
  const CustomSidebar({super.key});

  @override
  State<CustomSidebar> createState() => _CustomSidebarState();
}

class _CustomSidebarState extends State<CustomSidebar> {
  Map<String, bool> expandedSections = {
    'Transactions': false,
    'Reports': false,
    'Masters': false,
    'Miscellaneous': false,
  };

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned(
          child: SizedBox(
            width: screenWidth * 0.7,
            child: Drawer(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 90,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                        ),
                        alignment: Alignment.center,
                        child: Image.asset(
                          'logo.png',
                          height: 70,
                          width: 140,
                          fit: BoxFit.fill,
                        ),
                      ),
                      _buildCollapsibleMenu(
                          'Transactions', transactionLinks, Icons.receipt_long),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child:
                            const Divider(color: Colors.blue, thickness: 0.8),
                      ),
                      _buildCollapsibleMenu(
                          'Reports', reportLinks, Icons.insert_chart),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child:
                            const Divider(color: Colors.blue, thickness: 0.8),
                      ),
                      _buildCollapsibleMenu(
                          'Masters', masterLinks, Icons.settings_applications),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child:
                            const Divider(color: Colors.blue, thickness: 0.8),
                      ),
                      _buildCollapsibleMenu(
                          'Miscellaneous', miscLinks, Icons.more_horiz),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child:
                            const Divider(color: Colors.blue, thickness: 0.8),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCollapsibleMenu(
      String title, List<Map<String, dynamic>> links, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                expandedSections[title] = !expandedSections[title]!;
              });
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              child: Row(
                children: [
                  Icon(icon, color: Colors.black, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Icon(
                    expandedSections[title]!
                        ? Icons.expand_less
                        : Icons.expand_more,
                    color: Colors.black,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          if (expandedSections[title]!)
            Column(
              children: links
                  .map((link) => _buildSubMenuItem(context, link))
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildSubMenuItem(BuildContext context, Map<String, dynamic> link) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 4.0), // Space between submenu items
      child: PopupMenuButton<String>(
        offset: const Offset(280, 0), // Adjust dropdown position
        child: Padding(
          padding: const EdgeInsets.only(
              left: 20.0), // Shift submenu items slightly right
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                link['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(Icons.arrow_right, size: 12),
              ),
            ],
          ),
        ),
        onSelected: (value) {
          if (value == 'Rural Retailer Entry/Update') {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const RetailerRegistrationPage()),
            );
          } else if (value == 'Token Scan') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TokenScanPage()),
            );
          } else if (value == 'Order Update') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrderUpdate()),
            );
          // } else if (value == 'Order Entry') {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => const OrderEntry()),
          //   );
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('$value clicked')));
          }
        },
        itemBuilder: (context) => link['subLinks']
            .map<PopupMenuItem<String>>(
              (subLink) => PopupMenuItem<String>(
                value: subLink,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0), // Padding between sublinks
                  child: Text(
                    '• $subLink',
                    style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 12.0,
                        color: Color.fromARGB(255, 2, 27, 48)),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
