import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts
import '/layouts/custom_header.dart';
import '/layouts/custom_footer.dart';
import '/widgets/colors.dart';
import '/models/userNotification_model.dart'; // Model for Notification
import '/widgets/notification_item.dart'; // Widget for individual notifications
import '/services/api_service.dart'; // API service

class NotificationPage extends StatefulWidget {
  final int currentIndex;

  const NotificationPage({Key? key, this.currentIndex = 4}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<UserNotification>> _notifications;

  @override
  void initState() {
    super.initState();
    // Call API to fetch notification list
    _notifications = ApiService().fetchNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.homeBackground,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomHeader(title: "Notifications"),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: FutureBuilder<List<UserNotification>>(
            future: _notifications,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No notifications'));
              } else {
                final notifications = snapshot.data!;
                return ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    return NotificationItem(
                      title: notifications[index].title,
                      content: notifications[index].content,
                    );
                  },
                );
              }
            },
          ),
        ),
        bottomNavigationBar: CustomFooter(currentIndex: widget.currentIndex),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String content;

  const NotificationItem({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const Icon(Icons.notifications, size: 40, color: Colors.blue),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16, // Default font size for title
          ),
        ),
        subtitle: Text(
          content,
          style: GoogleFonts.roboto(
            fontSize: 14, // Roboto font for content
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
