import 'package:bw_sparsh/Login/firstSc.dart';
import 'package:bw_sparsh/Login/loginPage.dart';
import 'package:bw_sparsh/Reports/RetailerEntry.dart';
import 'package:bw_sparsh/universal.dart'as sparsh;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Screens/Notifications.dart';
import 'Screens/homePAge/homePage.dart';
import 'Screens/sales_order.dart';
import 'pending.dart';
import 'try.dart';

void main() async{  
  WidgetsFlutterBinding.ensureInitialized();
  
  // Preload the font
  await GoogleFonts.pendingFonts([
    GoogleFonts.poppins(), // Replace 'unna' with your font name
  ]);
  runApp(
    const ProviderScope(
      child: SparshApp(),
    ),
  );
}

class SparshApp extends ConsumerWidget {
  const SparshApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(sparsh.themeProvider);
    final themeMode = ref.watch(sparsh.themeModeProvider);
    
    // Set theme based on theme mode
    // ignore: unrelated_type_equality_checks
    final currentTheme = (themeMode == ThemeMode.dark) 
        ? ref.read(sparsh.darkThemeProvider) 
        : appTheme;
    
    return MaterialApp(
      title: 'SPARSH',
      debugShowCheckedModeBanner: false,
      theme: currentTheme.toThemeData(),
      home: ResponsiveWrapper(
        child: //NotificationsScreen(),
              ContentPage(),
              //ForgotPasswordScreen(),
               //MyLogin()
              //Firstsc()
              //OrderSaleScreen()
              //Try()
              //DSR()
             //RetailerRegistrationApp()
             //PendingWidget()
              
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
   
    return MediaQuery(
      // Override text scaling to ensure consistent text size
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(1.0),
      ),
      child: Container(
        child: child,
      ),
    );
  }
}