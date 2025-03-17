import 'package:bw_sparsh/Screens/bannerLogin.dart';
import 'package:bw_sparsh/Screens/homePAge/home_tabs.dart';
import 'package:bw_sparsh/pending.dart';
import 'package:flutter/material.dart';
import 'package:bw_sparsh/custom_app_bar/profile_sidebar.dart';
import 'package:bw_sparsh/custom_app_bar/side_bar.dart';
import 'package:bw_sparsh/custom_app_bar/app_bar.dart';
import 'package:bw_sparsh/Logic/carousal.dart';
import '../../custom_app_bar/bottom_nav_bar_mobile.dart';
import 'mostUsed.dart';



class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeBase(isMobile: true)
    );
  }
}



class HomeBase extends StatelessWidget {
  final bool isMobile;

  const HomeBase({
    required this.isMobile,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: CustomAppBar(),
      drawer: CustomSidebar(),
      endDrawer: const ProfileSidebar(),
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 5,
                  ),
                  child: const CustomCarousel(),
                ),
                const SizedBox(height: 5),
                MostlyUsedApps(apps: appData),
                PendingWidget(
                  width: double.infinity,
                  height: 210,
                ),
               const SizedBox(height: 5),
                const HomeTabs(),
              ],
            ),
          ),

          // Splash Screen (on top of main content)
          LoginBanner(),

          // Floating Bottom Navigation Bar
          if (isMobile)
            Positioned(
              left: 20.0,
              right: 20.0,
              bottom: 10.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Container(
                  color: Colors.transparent,
                  child: const CustomBottomNavigationBar(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
final appData = [
    {'name': 'DSR', 'icon': Icons.bar_chart},
    {'name': 'Staff Attendance', 'icon': Icons.person_add},
    {'name': 'DSR Exception', 'icon': Icons.description},
    {'name': 'Token Scan', 'icon': Icons.qr_code_scanner},
  ];