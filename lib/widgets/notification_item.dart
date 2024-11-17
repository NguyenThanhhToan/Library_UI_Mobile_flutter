import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

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
          style: GoogleFonts.roboto( // Sử dụng font Roboto cho tiêu đề
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          content,
          style: GoogleFonts.roboto( // Sử dụng font Roboto cho nội dung
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
