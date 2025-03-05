import 'package:bw_sparsh/universal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'color.dart';
import 'universal.dart';


final orderDetailsProvider = StateProvider<String>((ref) => '''
[
  {
    "companyName": "Venture Private Limited",
    "dmsNumber": "DMS-0525416526",
    "location": "Agra",
    "customerName": "Pioneer Steels",
    "date": "03-09-2024",
    "productsCount": "02",
    "totalAmount": "25256.14",
    "status": "Completed"
  },
  {
    "companyName": "Venture Private Limited",
    "dmsNumber": "DMS-0525416526",
    "location": "Agra",
    "customerName": "Pioneer Steeln",
    "date": "03-09-2024",
    "productsCount": "02",
    "totalAmount": "25256.14",
    "status": "Cancelled"
  },
  {
    "companyName": "Venture Private Limited",
    "dmsNumber": "DMS-0525416526",
    "location": "Agra",
    "customerName": "Pioneer Stoets",
    "date": "03-09-2024",
    "productsCount": "02",
    "totalAmount": "25256.14",
    "status": "Completed"
  },
  {
    "companyName": "Venture Private Limited",
    "dmsNumber": "DMS-0525416526",
    "location": "Agra",
    "customerName": "Pioneer Steels",
    "date": "03-09-2024",
    "productsCount": "02",
    "totalAmount": "25256.14",
    "status": "In Progress"
  }
]
''');


class OrderDetail {
  // ... (OrderDetail model class - remains the same) ...
  final String companyName;
  final String dmsNumber;
  final String location;
  final String customerName;
  final String date;
  final String productsCount;
  final String totalAmount;
  final String status;

  OrderDetail({
    required this.companyName,
    required this.dmsNumber,
    required this.location,
    required this.customerName,
    required this.date,
    required this.productsCount,
    required this.totalAmount,
    required this.status,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      companyName: json['companyName'] ?? '',
      dmsNumber: json['dmsNumber'] ?? '',
      location: json['location'] ?? '',
      customerName: json['customerName'] ?? '',
      date: json['date'] ?? '',
      productsCount: json['productsCount'] ?? '',
      totalAmount: json['totalAmount'] ?? '',
      status: json['status'] ?? '',
    );
  }
}


class OrderSaleScreen extends ConsumerWidget {
  const OrderSaleScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jsonData = ref.watch(orderDetailsProvider);
    final List<dynamic> decodedJson = jsonDecode(jsonData);
    final List<OrderDetail> orderDetails =
        decodedJson.map((item) => OrderDetail.fromJson(item)).toList();

    var theme = AppTheme();  // You already have this

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Order Details'),
        backgroundColor: theme.primaryColor, // Use theme.primary instead of Colors.blue[700]
      ),
      body: ListView.builder(
        itemCount: orderDetails.length,
        itemBuilder: (context, index) {
          final order = orderDetails[index];

          return Container(
            margin: EdgeInsets.symmetric(
              vertical: theme.spacing.xsmall,  // Use theme spacing
              horizontal: theme.spacing.small,
            ),
            child: Card(
              elevation: 2,  // Use theme elevation
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(theme.radius.medium), // Use theme radius
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          theme.spacing.medium,
                          theme.spacing.xsmall,
                          theme.spacing.xlarge,
                          theme.spacing.xsmall,
                        ),
                        child: Text(
                          order.companyName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: theme.fontSizes.large,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: StatusColorWidget(status: order.status),
                      ),
                    ],
                  ),


                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 1, 10.0, 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${order.dmsNumber}',
                              style: TextStyle( fontWeight: FontWeight.bold),),
                        Text(order.location),
                        const SizedBox(height: 6),
                        Text('Customer: ${order.customerName}'),
                        Text('Date: ${order.date}'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [  
                        Text('Products: ${order.productsCount}', 
                                style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                        Column(
                          children: [
                             Text(
                              'Total',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '₹ ${order.totalAmount}',
                              style:  TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: theme.fontSizes.large,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                      ])
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}