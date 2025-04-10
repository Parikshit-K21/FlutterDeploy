import 'package:flutter/material.dart';
import 'package:login/Pages/widgets.dart';

class Excelpage extends StatefulWidget {
  const Excelpage({Key? key}) : super(key: key);

  @override
  State<Excelpage> createState() => __ExcelpageState();
}

class __ExcelpageState extends State<Excelpage> {
  final _formKey = GlobalKey<FormState>();
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Excel Report'),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                       Text(
                        'Confidential',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    
                  
                  Column( children: [
                  const SizedBox(height: 20),

                  buildDropdownField("Select Report Type", ["A","B","C","D"],Colors.blue),
                  const SizedBox(height: 8),
                  buildDropdownField("Output Type", ["A","B","C","D"],Colors.blue),
                  const SizedBox(height: 8),
                  buildTextField(label:"Start Date", color:  Colors.blue),
                  const SizedBox(height: 8),
                  buildTextField(label:"End Date",color: Colors.blue),
                  const SizedBox(height: 8),
                  buildTextField(label: "Specific Codes (Seperated List)* ",color:Colors.blue, height: 80),
                  const SizedBox(height: 8),
                  ElevatedButtonWidget('Go',Colors.blue),
                  SizedBox(height: 8),

                  Row( 
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButtonWidget('Copy',Colors.grey),
                      ElevatedButtonWidget('Excel',Colors.green),
                      ElevatedButtonWidget('CSV',Colors.blue),
                      ElevatedButtonWidget('PDF',Colors.orange),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 200,
                    width: 400,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      verticalDirection: VerticalDirection.up,
                      crossAxisAlignment: CrossAxisAlignment.end ,
                      children: [
                      Icon(
                        Icons.warning,
                        color: Colors.red,
                        size: 40,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                        'Report will be displayed here',
                        // textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                      ]
                    ),
                  ),
                ],
                  )
                   ],
           )
      )              
   )
            
          ),
        )
    );
    
  }
}
