import 'package:bw_sparsh/Login/forgetpass.dart';
import 'package:bw_sparsh/Login/login1.dart';
import 'package:bw_sparsh/Notifications.dart';
import 'package:flutter/material.dart';

import '../APIcaller/LoginApi.dart';
import 'footer.dart';

class LoginWithOtp extends StatefulWidget {
  const LoginWithOtp({super.key});

  @override
  _LoginWithOtpState createState() => _LoginWithOtpState();
}

class _LoginWithOtpState extends State<LoginWithOtp>
    with SingleTickerProviderStateMixin {
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final service = LoginService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              Flexible(
                  flex: 7,
                      child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20)),
                      
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.all(10),
                        child:  Text(
                          'Log In Mobile No.',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),),
                        const SizedBox(height: 20),
                        TextField(
                          controller: mobileController,
                          keyboardType: TextInputType.phone,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Enter no",
                            hintStyle: const TextStyle(color: Colors.blue),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        TextField(
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            hintText: "Enter OTP",
                            hintStyle: const TextStyle(color: Colors.blue),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text("Resend OTP",
                                style: TextStyle(color: Colors.blue)),
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: const StadiumBorder(),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 50),
                          ),
                          onPressed: () {
                            
                          },
                          child: const Text("Verify Now",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                        const SizedBox(height: 20), // Space between buttons
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyLogin()),
                            );
                          },
                          style: TextButton.styleFrom(
                              padding:
                                  EdgeInsets.zero), // Removes default padding
                          child: const Row(
                            mainAxisSize: MainAxisSize
                                .min, // Keeps size minimal to remove gaps
                            children: [
                              Icon(Icons.arrow_back,
                                  color: Colors.black, size: 18),
                              Text(
                                "Go back",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  decoration: TextDecoration
                                      .underline, // Underline text
                                ),
                              ),
                            ],
                          ),
                        ),

                        Spacer(),
                         Footer(
                            text: "Developed By Birla White IT",
                            backgroundColor: Colors.white,
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            fontWeight: FontWeight.bold,
                            ),),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}