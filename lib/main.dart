import 'package:bw_sparsh/forget1.dart';
import 'package:bw_sparsh/tab.dart';
import 'package:bw_sparsh/universal.dart'as sparsh;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'list.dart';

void main() {
  runApp(
    const ProviderScope(
      child: SparshApp(),
    ),
  );
}

class SparshApp extends ConsumerWidget {
  const SparshApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(sparsh.themeProvider);
    final themeMode = ref.watch(sparsh.themeModeProvider);
    
    // Set theme based on theme mode
    final currentTheme = themeMode == ThemeMode.dark 
        ? ref.read(sparsh.darkThemeProvider) 
        : appTheme;
    
    return MaterialApp(
      title: 'SPARSH',
      debugShowCheckedModeBanner: false,
      theme: currentTheme.toThemeData(),
      home: const ResponsiveWrapper(
        child: //NotificationsScreen(),
              //NavigationScreen(),
              ForgotPasswordScreen()
      ),
    );
  }
}

/// ResponsiveWrapper to handle different screen sizes
class ResponsiveWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    EdgeInsets padding;
    
    if (screenSize.width > 1200) {
      // Extra large screens
      padding = const EdgeInsets.symmetric(horizontal: 80.0);
    } else if (screenSize.width > 992) {
      // Desktop screens
      padding = const EdgeInsets.symmetric(horizontal: 64.0);
    } else if (screenSize.width > 768) {
      // Tablet screens
      padding = const EdgeInsets.symmetric(horizontal: 32.0);
    } else if (screenSize.width > 480) {
      // Large mobile screens
      padding = const EdgeInsets.symmetric(horizontal: 16.0);
    } else {
      // Small mobile screens
      padding = const EdgeInsets.symmetric(horizontal: 8.0);
    }
    
    return MediaQuery(
      // Override text scaling to ensure consistent text size
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(1.0),
      ),
      child: Container(
        padding: padding,
        child: child,
      ),
    );
  }
}