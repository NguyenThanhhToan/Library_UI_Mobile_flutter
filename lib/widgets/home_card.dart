import 'package:flutter/material.dart';
import 'colors.dart';

class CustomCard extends StatelessWidget {
  final String imagePath; // Đường dẫn ảnh thay vì icon
  final VoidCallback onTap;
  final bool showSnackBar;
  final String snackBarMessage;

  const CustomCard({
    required this.imagePath,
    required this.onTap,
    this.showSnackBar = false,
    this.snackBarMessage = '',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 13.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Bo tròn các góc của Card
      ),
      child: InkWell(
        onTap: () {
          if (showSnackBar && snackBarMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(snackBarMessage),
                duration: Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.black87,
              ),
            );
          } else {
            onTap();
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12), // Bo tròn các góc của Card và hình ảnh
          child: Image.asset(
            imagePath,
            width: double.infinity, // Chiều rộng 100%
            height: 150, // Đặt chiều cao theo nhu cầu của bạn
            fit: BoxFit.cover, // Đảm bảo ảnh lấp đầy khung hình
          ),
        ),
      ),
    );
  }
}
