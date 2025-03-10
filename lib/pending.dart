import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'APIcaller/Modals/pendingM.dart';

final pendingDataProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  // If fetching from a real JSON file:
  // final response = await http.get(Uri.parse('YOUR_JSON_URL'));
  // final data = json.decode(response.body);

  // For demonstration, use the string directly:
  final data = json.decode(pendingDataJson);
  return List<Map<String, dynamic>>.from(data);
});

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('My Pending')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer(
            builder: (context, ref, child) {
              final pendingData = ref.watch(pendingDataProvider);

              return pendingData.when(
                data: (data) {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final item = data[index];
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          leading: Image.asset(item['icon']), // Assuming you have icons
                          title: Text(item['title']),
                          trailing: Text(item['count'].toString()),
                        ),
                      );
                    },
                  );
                },
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => Center(child: Text('Error: $error')),
              );
            },
          ),
        ),
      ),
    );
  }
}