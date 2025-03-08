// Add this method in your NotificationsNotifier class or where you need to generate sample data
import 'package:bw_sparsh/APIcaller/Modals/NotificationM.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


// Updated NotificationsScreen with sample data
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize with sample data
    final notifier = ref.read(notificationsProvider.notifier);
    notifier.updateFromApi(
      getSampleNotifications().map((n) => n.toJson()).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh logic here if needed
            },
          ),
        ],
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text('No notifications'),
            )
          : ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                final displayData = ref
                    .read(notificationsProvider.notifier)
                    .getFormattedDisplayData(notification);

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: notification.isRead 
                        ? Colors.grey[200] 
                        : Colors.blue[100],
                    child: Icon(
                      _getNotificationIcon(notification.type),
                      color: notification.isRead 
                          ? Colors.grey 
                          : Colors.blue,
                    ),
                  ),
                  title: Text(
                    notification.title,
                    style: TextStyle(
                      fontWeight: notification.isRead 
                          ? FontWeight.normal 
                          : FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.message),
                      const SizedBox(height: 4),
                      Text(
                        '${displayData['day']} ${displayData['month']} ${displayData['year']} at ${displayData['time']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    if (!notification.isRead) {
                      ref
                          .read(notificationsProvider.notifier)
                          .markAsRead(notification.id);
                    }
                  },
                );
              },
            ),
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'order':
        return Icons.shopping_bag;
      case 'payment':
        return Icons.payment;
      case 'promotion':
        return Icons.local_offer;
      case 'delivery':
        return Icons.local_shipping;
      case 'account':
        return Icons.person;
      default:
        return Icons.notifications;
    }
  }
}
