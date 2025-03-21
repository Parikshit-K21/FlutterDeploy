import 'package:bw_sparsh/Screens/dsr_Visit.dart';
import 'package:flutter/material.dart';

class MostlyUsedApps extends StatelessWidget {
  final List<Map<String, dynamic>> apps;

  const MostlyUsedApps({super.key, required this.apps});

  @override
  Widget build(BuildContext context) {


    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 4.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Background color as in the image
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SingleChildScrollView(
scrollDirection: Axis.horizontal,
child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mostly Use Apps',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Wrap(
            spacing: 10.0, // Space between widgets in the row
            runSpacing: 10.0, // Space between rows
            children: apps.map((app) {
              return _buildAppItem(app,context);
            }).toList(),
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildAppItem(Map<String, dynamic> app, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(app['name']=="DSR"){
          Navigator.push(context, 
          MaterialPageRoute(builder: (context) => DSR()));
        }
      },
      child: 
    
    SizedBox(
      width: 80.0, // Adjust width as needed
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(
              app['icon'], // Icon data from the JSON
              size: 30.0,
              color: Colors.blue[800],
              // Icon color as in the image
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            app['name'], // App name from the JSON
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    )
    );
  }
}

