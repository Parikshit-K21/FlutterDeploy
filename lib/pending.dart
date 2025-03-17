import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'APIcaller/Modals/pendingM.dart';

final pendingDataProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final data = json.decode(pendingDataJson);
  return List<Map<String, dynamic>>.from(data);
});

class PendingWidget extends ConsumerWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;

  const PendingWidget({
    super.key,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(5.0),
  });

  void _showDetailsPopup(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            item['title'],
            style: TextStyle(
              color: Colors.blue[900],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Count: ${item['count']}'),
              const SizedBox(height: 8),
              Text('Status: Pending'),
              // Add more details here as needed
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                'My Pending',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
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
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: InkWell(
                              onTap: () => _showDetailsPopup(context, item),
                              child: ListTile(
                                leading: SizedBox(
                                  width: 40,
                                  height: 30,
                                  child: Image.asset(
                                    item['icon'],
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                title: Text(
                                  item['title'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.blue[900],
                                  ),
                                ),
                                trailing: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    item['count'].toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, stackTrace) => Center(
                      child: Text('Error: $error'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
