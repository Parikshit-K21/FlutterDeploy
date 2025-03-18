import 'package:bw_sparsh/Reports/Order_page.dart';
import 'package:bw_sparsh/Screens/Notifications.dart';
import 'package:flutter/material.dart';
// Import your universal.dart
import '../../universal.dart';

class HomeTabs extends StatefulWidget {
  const HomeTabs({super.key});

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  int _selectedTabIndex = 0;
  final List<String> _tabTitles = [
    'Quick Menu',
    'Dashboard',
    'Document',
    'Trending',
  ];

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = AppTheme();

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Set mainAxisSize to min
        children: [
          // Top navigation tabs
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(vertical: appTheme.spacing.small),
            decoration: BoxDecoration(
              color: appTheme.surfaceColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  _tabTitles.length,
                      (index) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: appTheme.spacing.xsmall,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedTabIndex = index;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        _selectedTabIndex == index
                            ? appTheme.primaryColor
                            : appTheme.surfaceColor,
                        foregroundColor:
                        _selectedTabIndex == index
                            ? appTheme.onPrimaryColor
                            : appTheme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            appTheme.buttonBorderRadius,
                          ),
                          side: BorderSide(
                            color:
                            _selectedTabIndex == index
                                ? appTheme.primaryColor
                                : appTheme.neutralColor,
                          ),
                        ),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: Text(
                        _tabTitles[index],
                        style: TextStyle(fontSize: appTheme.fontSizes.small),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Selected tab content with header
          Flexible(
            fit: FlexFit.loose, // Use Flexible with FlexFit.loose
            child: Container(
              color: appTheme.backgroundColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: appTheme.spacing.xsmall,
                        vertical: appTheme.spacing.xsmall,
                      ),
                      child: Text(
                        _tabTitles[_selectedTabIndex],
                        style: TextStyle(
                          fontSize: appTheme.fontSizes.medium,
                          fontWeight: FontWeight.bold,
                          color: appTheme.textColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 140,
                      child: _buildGridForTab(_selectedTabIndex),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridForTab(int tabIndex) {
    final AppTheme appTheme = AppTheme();
    List<GridItem> items = [];

    switch (tabIndex) {
      case 0: // Quick Menu
        items = [
          GridItem(
            icon: Icons.store,
            title: 'RPL Outlet Tracker',
            color: appTheme.primaryColor,
          ),
          GridItem(
            icon: Icons.assignment,
            title: 'DKC Lead Entry',
            color: appTheme.warningColor,
          ),
          GridItem(
            icon: Icons.analytics,
            title: 'RPL Outlet Tracker',
            color: appTheme.primaryColor,
          ),
          GridItem(
            icon: Icons.feedback,
            title: 'Training Feed Back',
            color: appTheme.successColor,
          ),
          // ... Add other items similarly
        ];
        break;
      case 1: // Dashboard
        items = [
          GridItem(
            icon: Icons.dashboard,
            title: 'Sales Dashboard',
            color: appTheme.secondaryColor,
          ),
          GridItem(
            icon: Icons.trending_up,
            title: 'Performance',
            color: appTheme.errorColor,
          ),
          // ... Add other items similarly
        ];
        break;
      case 2: // Document
        items = [
          GridItem(
            icon: Icons.article,
            title: 'Recent Files',
            color: appTheme.neutralColor,
          ),
          GridItem(
            icon: Icons.cloud_upload,
            title: 'Upload Document',
            color: appTheme.infoColor,
          ),
          // ... Add other items similarly
        ];
        break;
    }

    return Padding(
      padding: EdgeInsets.all(appTheme.spacing.medium),
      child: GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: appTheme.spacing.medium,
        mainAxisSpacing: appTheme.spacing.medium,
        childAspectRatio: .5,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: items.map((item) => _buildGridItem(item)).toList(),
      ),
    );
  }

  Widget _buildGridItem(GridItem item) {
    final AppTheme appTheme = AppTheme();

    return GestureDetector(
      onTap: () {
        if (item.title == 'RPL Outlet Tracker') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NotificationsScreen()),
          );
        } else if (item.title == 'DKC Lead Entry') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderEntry()),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(appTheme.spacing.small),
            decoration: BoxDecoration(
              color: appTheme.surfaceColor,
              borderRadius: BorderRadius.circular(appTheme.cardBorderRadius),
              boxShadow: [BoxShadow(color: Colors.black, blurRadius: 1)],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(appTheme.spacing.medium),
                  decoration: BoxDecoration(
                    color: item.color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item.icon, color: item.color, size: 24),
                ),
                SizedBox(height: appTheme.spacing.small),
              ],
            ),
          ),
          SizedBox(height: appTheme.spacing.small),
          Text(
            item.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: appTheme.fontSizes.xsmall,
              color: appTheme.textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class GridItem {
  final IconData icon;
  final String title;
  final Color color;

  GridItem({required this.icon, required this.title, required this.color});
}
