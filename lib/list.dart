import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'universal.dart'; // Import the theme configuration

// Notification model
class NotificationItem {
  final String day;
  final String month;
  final String year;
  final String time;
  final String title;
  final String status; // "Success", "Warning", "Cancel"
  
  const NotificationItem({
    required this.day,
    required this.month,
    required this.year,
    required this.time,
    required this.title,
    required this.status,
  });
}

// Provider for notifications list
final notificationsProvider = Provider<List<NotificationItem>>((ref) {
  return [
    NotificationItem(
      day: '25',
      month: 'Dec',
      year: '2023',
      time: '04:06pm',
      title: 'Staff Attendance Report send to Client',
      status: 'Success',
    ),
    NotificationItem(
      day: '25',
      month: 'Dec',
      year: '2023',
      time: '04:06pm',
      title: 'Token Scan Details Dashboard Updated',
      status: 'Pending',
    ),
    NotificationItem(
      day: '01',
      month: 'Jan',
      year: '2024',
      time: '04:06pm',
      title: 'Sales Dashboard Report Transferred',
      status: 'Success',
    ),
    NotificationItem(
      day: '09',
      month: 'Jan',
      year: '2024',
      time: '04:06pm',
      title: 'DSR Data Download In Excel',
      status: 'Cancel',
    ),
    NotificationItem(
      day: '01',
      month: 'Jan',
      year: '2024',
      time: '04:06pm',
      title: 'Party Organize Birta White 2024',
      status: 'Success',
    ),
    NotificationItem(
      day: '09',
      month: 'Jan',
      year: '2024',
      time: '04:06pm',
      title: 'Account Department Share Data In Sparsh',
      status: 'Success',
    ),
    NotificationItem(
      day: '09',
      month: 'Jan',
      year: '2024',
      time: '04:06pm',
      title: 'Loyalty Token Report Share To Client',
      status: 'Success',
    ),
  ];
});

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsProvider);
    final appTheme = ref.watch(themeProvider);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appTheme.primaryColor,
        elevation: 0,
        title: Text(
          'Notifications',
          style: TextStyle(
            color: appTheme.onPrimaryColor,
            fontSize: appTheme.fontSizes.large,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appTheme.onPrimaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: appTheme.backgroundColor,
          child: notifications.isEmpty
              ? Center(
                  child: Text(
                    'No notifications',
                    style: TextStyle(
                      color: appTheme.textColor,
                      fontSize: appTheme.fontSizes.medium,
                    ),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return NotificationCard(notification: notification);
                  },
                ),
        ),
      ),
    );
  }
}

class NotificationCard extends ConsumerWidget {
  final NotificationItem notification;

  const NotificationCard({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appTheme = ref.watch(themeProvider);
    
    // Get status color based on the status
    Color statusColor;
    switch (notification.status.toLowerCase()) {
      case 'success':
        statusColor = appTheme.successColor;
        break;
      case 'pending':
        statusColor = appTheme.warningColor;
        break;
      case 'cancel':
        statusColor = appTheme.errorColor;
        break;
      default:
        statusColor = appTheme.neutralColor;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Date container
          Container(
            width: 80,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            decoration: BoxDecoration(
              color: appTheme.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  notification.day,
                  style: TextStyle(
                    color: appTheme.onPrimaryColor,
                    fontSize: appTheme.fontSizes.large,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  notification.month,
                  style: TextStyle(
                    color: appTheme.onPrimaryColor,
                    fontSize: appTheme.fontSizes.small,
                  ),
                ),
                Text(
                  notification.year,
                  style: TextStyle(
                    color: appTheme.onPrimaryColor,
                    fontSize: appTheme.fontSizes.small,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification.time,
                  style: TextStyle(
                    color: appTheme.onPrimaryColor,
                    fontSize: appTheme.fontSizes.xsmall,
                  ),
                ),
              ],
            ),
          ),
          
          // Notification content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      color: appTheme.textColor,
                      fontSize: appTheme.fontSizes.medium,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    notification.status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: appTheme.fontSizes.medium,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}