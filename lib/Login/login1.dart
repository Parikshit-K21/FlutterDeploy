import 'package:bw_sparsh/Login/forgetpass.dart';
import 'package:bw_sparsh/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'footer.dart';
import 'login_otp.dart';
import '../secure_storage.dart';

// State providers
final emailProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');
final rememberMeProvider = StateProvider<bool>((ref) => false);
final errorMessageProvider = StateProvider<String?>((ref) => null);

// Secure storage provider
final secureStorageProvider = Provider<SecureStorage>((ref) => SecureStorage());

// Login provider
final loginProvider = FutureProvider.family<bool, BuildContext>((ref, context) async {
  final secureStorage = ref.read(secureStorageProvider);
  final email = ref.read(emailProvider);
  final password = ref.read(passwordProvider);
  final rememberMe = ref.read(rememberMeProvider);
  
  final storedEmail = await secureStorage.readData('email');
  final storedPassword = await secureStorage.readData('password');
  
  if (email == storedEmail && password == storedPassword) {
    if (rememberMe) {
      await secureStorage.saveData('email', email);
      await secureStorage.saveData('password', password);
    }
    return true;
  } else {
    ref.read(errorMessageProvider.notifier).state = "Invalid email or password";
    return false;
  }
});

class MyLogin extends ConsumerStatefulWidget {
  const MyLogin({super.key});

  @override
  ConsumerState<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends ConsumerState<MyLogin> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  late Animation<Offset> _animation2;
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _loadStoredCredentials();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    
    _animation = Tween<Offset>(
      begin: const Offset(0, 3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    _animation2 = Tween<Offset>(
      begin: const Offset(0, -2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    
    _animationController.forward();
  }

  Future<void> _loadStoredCredentials() async {
    final secureStorage = ref.read(secureStorageProvider);
    final storedEmail = await secureStorage.readData('email');
    final storedPassword = await secureStorage.readData('password');
    
    if (storedEmail != null && storedPassword != null) {
      _emailController.text = storedEmail;
      _passwordController.text = storedPassword;
      
      ref.read(emailProvider.notifier).state = storedEmail;
      ref.read(passwordProvider.notifier).state = storedPassword;
      ref.read(rememberMeProvider.notifier).state = true;
    }
  }

  void _login() async {
    final result = await ref.read(loginProvider(context).future);
    
    if (result && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NotificationsScreen()),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final errorMessage = ref.watch(errorMessageProvider);
    final rememberMe = ref.watch(rememberMeProvider);
    
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "splash_screen.png",
              fit: BoxFit.fill,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 4,
                child: SlideTransition(
                  position: _animation2,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Welcome Back',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          'SPARSH',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 42,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]
                  ),
                ),
              ),
              Flexible(
                flex: 7,
                child: SlideTransition(
                  position: _animation,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),  // Updated padding
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                      boxShadow: [  // Added shadow
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 4,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Log In',
                          style: TextStyle(
                              fontSize: 18,  // Updated font size
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 20),
                        if (errorMessage != null)
                          Text(
                            errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _emailController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Username",
                            hintStyle: const TextStyle(color: Colors.blue),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (value) => ref.read(emailProvider.notifier).state = value,
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Password",
                            hintStyle: const TextStyle(color: Colors.blue),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (value) => ref.read(passwordProvider.notifier).state = value,
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ForgotPasswordScreen()),
                              );
                            },
                            child: const Text("Forgot Password?",
                                style: TextStyle(color: Colors.blue)),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Checkbox(
                                value: rememberMe,
                                onChanged: (value) {
                                  ref.read(rememberMeProvider.notifier).state = value ?? false;
                                },
                              ),
                            ),
                            const Text("Remember Me",
                                style: TextStyle(color: Colors.black)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 50),
                          ),
                          onPressed: _login,
                          child: const Text("Log In",
                              style: TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginWithOtp()),
                            );
                          },
                          child: const Text("Log in With Otp",
                              style: TextStyle(color: Colors.blue, fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Footer(
              text: "© 2025 SPARSH. All rights reserved.",
              backgroundColor: Colors.white,
              textStyle: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                // fontWeight: 
              ),),
            ],
            
          ),
        ],
      ),
    );
  }
}