import 'package:flutter/material.dart';


class Tab123 extends StatelessWidget {
  const Tab123({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      home: const NavigationScreen(),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedTabIndex = 0;
  final List<String> _tabTitles = ['Quick Menu', 'Dashboard', 'Document', 'Trending'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child: Column(
        children: [
        // Top navigation tabs
        Container(
          height: 60,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
          color: Colors.white,
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
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: ElevatedButton(
              onPressed: () {
                setState(() {
                _selectedTabIndex = index;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _selectedTabIndex == index
                  ? Colors.blue
                  : Colors.white,
                foregroundColor: _selectedTabIndex == index
                  ? Colors.white
                  : Colors.blue,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: _selectedTabIndex == index
                  ? Colors.blue
                  : Colors.grey,),
                ),
                elevation: 0,
    shadowColor: Colors.transparent,
    splashFactory: NoSplash.splashFactory,
              
              ),
              child: Text(_tabTitles[index]),
              ),
            ),
            ),
          ),
          ),
        ),
        
        // Selected tab content with header
        Expanded(
          child: Container(
          color: Colors.grey[200],
          child: SingleChildScrollView(
            child: Column(
            children: [
              Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
              child: Text(
                _tabTitles[_selectedTabIndex],
                style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
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
      ),
    );
  }

  Widget _buildGridForTab(int tabIndex) {
    // Define different grid items for each tab, structure of Grid items is at the end
    List<GridItem> items = [];
    
    switch (tabIndex) {
      case 0: // Quick Menu 
        items = [
          GridItem(
            icon: Icons.store,
            title: 'RPL Outlet Tracker',
            color: Colors.blue,
          ),
          GridItem(
            icon: Icons.assignment,
            title: 'DKC Lead Entry',
            color: Colors.orange,
          ),
          GridItem(
            icon: Icons.analytics,
            title: 'RPL Outlet Tracker',
            color: Colors.blue,
          ),
          GridItem(
            icon: Icons.feedback,
            title: 'Training Feed Back',
            color: Colors.green,
          ),
          GridItem(
            icon: Icons.store,
            title: 'RPL Outlet Tracker',
            color: Colors.blue,
          ),
          GridItem(
            icon: Icons.assignment,
            title: 'DKC Lead Entry',
            color: Colors.orange,
          ),
          GridItem(
            icon: Icons.analytics,
            title: 'RPL Outlet Tracker',
            color: Colors.blue,
          ),
          GridItem(
            icon: Icons.feedback,
            title: 'Training Feed Back',
            color: Colors.green,
          ),
        ];
        break;
      case 1: // Dashboard
        items = [
          GridItem(
            icon: Icons.dashboard,
            title: 'Sales Dashboard',
            color: Colors.purple,
          ),
          GridItem(
            icon: Icons.trending_up,
            title: 'Performance',
            color: Colors.red,
          ),
          GridItem(
            icon: Icons.insert_chart,
            title: 'Analytics',
            color: Colors.teal,
          ),
          GridItem(
            icon: Icons.people,
            title: 'Team Stats',
            color: Colors.indigo,
          ),
           GridItem(
            icon: Icons.dashboard,
            title: 'Sales Dashboard',
            color: Colors.purple,
          ),
          GridItem(
            icon: Icons.trending_up,
            title: 'Performance',
            color: Colors.red,
          ),
          GridItem(
            icon: Icons.insert_chart,
            title: 'Analytics',
            color: Colors.teal,
          ),
          GridItem(
            icon: Icons.people,
            title: 'Team Stats',
            color: Colors.indigo,
          ),
        ];
        break;
      case 2: // Document
        items = [
          GridItem(
            icon: Icons.article,
            title: 'Recent Files',
            color: Colors.brown,
          ),
          GridItem(
            icon: Icons.cloud_upload,
            title: 'Upload Document',
            color: Colors.cyan,
          ),
          GridItem(
            icon: Icons.folder,
            title: 'My Documents',
            color: Colors.amber,
          ),
          GridItem(
            icon: Icons.share,
            title: 'Shared With Me',
            color: Colors.deepPurple,
          ),
          GridItem(
            icon: Icons.article,
            title: 'Recent Files',
            color: Colors.brown,
          ),
          GridItem(
            icon: Icons.cloud_upload,
            title: 'Upload Document',
            color: Colors.cyan,
          ),
          GridItem(
            icon: Icons.folder,
            title: 'My Documents',
            color: Colors.amber,
          ),
          GridItem(
            icon: Icons.share,
            title: 'Shared With Me',
            color: Colors.deepPurple,
          ),
        ];
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: .5, // Adjust this value to change item height ratio
        shrinkWrap: true, // Makes grid wrap its content
        physics: const NeverScrollableScrollPhysics(),
        children: items.map((item) => _buildGridItem(item)).toList(), // Prevents grid from scrolling

      ),
    );
  }

  Widget _buildGridItem(GridItem item) {
  return Column(
        mainAxisSize: MainAxisSize.min, // Minimize the column height
    children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: item.color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                item.icon,
                color: item.color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      const SizedBox(height: 8), // Add spacing between box and text
      Text(
        item.title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12
        ),
      )
    ],
  );
}
}

class GridItem {
  final IconData icon;
  final String title;
  final Color color;

  GridItem({
    required this.icon,
    required this.title,
    required this.color,
  });
}