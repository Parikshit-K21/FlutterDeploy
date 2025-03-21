import 'package:flutter/material.dart';
import 'package:bw_sparsh/Screens/homePAge/homePage.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int? tappedIndex;

  void onItemTapped(int index, BuildContext context) {
    setState(() {
      tappedIndex = index;
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        tappedIndex = null;
      });
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ContentPage()),
      );
    } else if (index == 1) {
      Scaffold.of(context).openEndDrawer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
  child: Container(
    height: 50.0, // Increased height to prevent overflow
    margin: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 5.0),    
    decoration: BoxDecoration(
      color: Colors.black87, // Changed to black background
      borderRadius: BorderRadius.circular(30),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Home Button
              GestureDetector(
                onTap: () => onItemTapped(0, context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: tappedIndex == 0 
                            ? Colors.blue 
                            : Colors.transparent,
                       
                      ),
                      child: Icon(
                        Icons.home,
                        color: tappedIndex == 0 ? Colors.black : Colors.white,
                        size: 21.0,
                      ),
                    ),
                           ]
               ),
              ),
              // Profile Button
              GestureDetector(
                onTap: () => onItemTapped(1, context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: tappedIndex == 1 
                            ? Colors.blue 
                            : Colors.transparent,
                      ),
                      child: Icon(
                        Icons.person,
                        color: tappedIndex == 1 ? Colors.black : Colors.white,
                        size: 21.0,
                      ),
                    ),
                    ],
                ),
              ),
              // Settings Button
              GestureDetector(
                onTap: () => onItemTapped(2, context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: tappedIndex == 2 
                            ? Colors.blue 
                            : Colors.transparent,
                      ),
                      child: Icon(
                        Icons.settings,
                        color: tappedIndex == 2 ? Colors.black : Colors.white,
                        size: 21.0,
                      ),
                    ),
                     ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
  
  }}