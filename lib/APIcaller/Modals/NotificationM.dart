import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

List<NotificationItem> getSampleNotifications() {
  return [
    NotificationItem(
      id: '1',
      title: 'Order Confirmed',
      message: 'Your order #12345 has been confirmed and is being processed.',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      status: 'confirmed',
      type: 'order',
      isRead: false,
    ),
    NotificationItem(
      id: '2',
      title: 'Payment Successful',
      message: 'Payment of ₹1,500 has been processed successfully.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      status: 'completed',
      type: 'payment',
      isRead: true,
    ),
    NotificationItem(
      id: '3',
      title: 'New Offer Available',
      message: 'Special 20% discount on all electronics. Limited time offer!',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      status: 'active',
      type: 'promotion',
      isRead: false,
    ),
    NotificationItem(
      id: '4',
      title: 'Delivery Update',
      message: 'Your package is out for delivery.',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      status: 'in_progress',
      type: 'delivery',
      isRead: false,
    ),
    NotificationItem(
      id: '5',
      title: 'Account Update',
      message: 'Your profile has been successfully updated.',
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      status: 'completed',
      type: 'account',
      isRead: true,
    ),
  ];
}
class NotificationItem {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final String status;
  final String type;
  final bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.status,
    required this.type,
    this.isRead = false,
  });

  // Convert NotificationItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'status': status,
      'type': type,
      'isRead': isRead,
    };
  }

  // Create NotificationItem from API response
  factory NotificationItem.fromApiResponse(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      timestamp: json['timestamp'] != null 
          ? DateTime.parse(json['timestamp'].toString())
          : DateTime.now(),
      status: json['status']?.toString() ?? 'pending',
      type: json['type']?.toString() ?? 'general',
      isRead: json['isRead'] as bool? ?? false,
    );
  }

  NotificationItem copyWith({
    String? id,
    String? title,
    String? message,
    DateTime? timestamp,
    String? status,
    String? type,
    bool? isRead,
  }) {
    return NotificationItem(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  String toString() {
    return 'NotificationItem(id: $id, title: $title, message: $message, timestamp: $timestamp, status: $status, type: $type, isRead: $isRead)';
  }

  
}


final notificationsProvider = StateNotifierProvider<NotificationsNotifier, List<NotificationItem>>((ref) {
  return NotificationsNotifier();
});

class NotificationsNotifier extends StateNotifier<List<NotificationItem>> {
  NotificationsNotifier() : super([]);

  // Update notifications from API response
  void updateFromApi(List<Map<String, dynamic>> apiResponse) {
    state = apiResponse.map((item) => NotificationItem.fromApiResponse(item)).toList();
  }

  // Add a new notification
  void addNotification(NotificationItem notification) {
    state = [...state, notification];
  }

  // Mark notification as read
  void markAsRead(String id) {
    state = state.map((notification) {
      if (notification.id == id) {
        return notification.copyWith(isRead: true);
      }
      return notification;
    }).toList();
  }

  // Remove a notification
  void removeNotification(String id) {
    state = state.where((notification) => notification.id != id).toList();
  }

  // Format date components
  String getFormattedDay(DateTime date) => date.day.toString().padLeft(2, '0');
  
  String getFormattedMonth(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                   'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[date.month - 1];
  }
  
  String getFormattedYear(DateTime date) => date.year.toString();
  
  String getFormattedTime(DateTime date) {
    final hour = date.hour > 12 ? date.hour - 12 : date.hour;
    final amPm = date.hour >= 12 ? 'pm' : 'am';
    return '${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}$amPm';
  }

  // Load notifications from JSON string
  void loadFromJson(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    state = jsonList.map((json) => NotificationItem.fromApiResponse(json)).toList();
  }

  // Convert notifications to JSON string
  String toJsonString() {
    return json.encode(state.map((notification) => notification.toJson()).toList());
  }

  // Get formatted display data for a notification
  Map<String, String> getFormattedDisplayData(NotificationItem notification) {
    return {
      'day': getFormattedDay(notification.timestamp),
      'month': getFormattedMonth(notification.timestamp),
      'year': getFormattedYear(notification.timestamp),
      'time': getFormattedTime(notification.timestamp),
    };
  }
 
}

// Example API service class
class NotificationService {
  Future<List<Map<String, dynamic>>> fetchNotifications() async {
    try {
      // Replace with your actual API endpoint
      final response = await http.get(
        Uri.parse('your-api-endpoint/notifications'),
        headers: {
          'Content-Type': 'application/json',
          // Add any required headers (e.g., authorization)
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load notifications: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching notifications: $e');
    }
  }
}

// Example usage in a widget:
/*
class NotificationsScreen extends ConsumerStatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  final _notificationService = NotificationService();

  Future<void> _fetchNotifications() async {
    try {
      final apiResponse = await _notificationService.fetchNotifications();
      ref.read(notificationsProvider.notifier).updateFromApi(apiResponse);
    } catch (e) {
      // Handle error (show snackbar, dialog, etc.)
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(notificationsProvider);
    
    return Scaffold(
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final displayData = ref.read(notificationsProvider.notifier)
              .getFormattedDisplayData(notification);
          
          return ListTile(
            title: Text(notification.title),
            subtitle: Text(notification.message),
            trailing: Text('${displayData['time']}'),
            onTap: () {
              ref.read(notificationsProvider.notifier)
                 .markAsRead(notification.id);
            },
          );
        },
      ),
    );
  }
}
*/
