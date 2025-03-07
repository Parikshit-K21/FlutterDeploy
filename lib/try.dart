import 'package:bw_sparsh/APIcaller/LoginApi.dart';
import 'package:flutter/material.dart';
import 'package:bw_sparsh/try.dart';

class Try extends StatelessWidget {
   Try({super.key});

  final service= LoginService();

   Future<void> _call() async {
  try {
    var a = await service.loginWithUserIdAndPassword(userId: "7077", password: "birla");
    
    // If 'a' is a custom object, you might want to print specific fields
    // Assuming it returns a User object with properties like name, id, etc.
    // print('User ID: ${a.loginId}');
    // print('Name: ${a.password}');
    print('Email: ${a.emailAddress}');
    print('Phone: ${a.mobileNumber}');
    
    // If 'a' is a Map
    if (a is Map) {
      a.forEach((key, value) {
        print('$key: $value');
      });
    }
  } catch (e) {
    print('Error fetching user: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      body: Container(
        child: Column(
          children: [
            Container(
              child: Text("Hello"),
            ),
            ElevatedButton (
            onPressed:  _call ,
             child: Text("Click"))
          ],
      ),
    )
    );
  }
}