import 'package:flutter/material.dart';
import '/page/home/user_info_page.dart';
import '/page/home/orders_page.dart';
import '/page/home/reservation_page.dart';
import '/page/home/request_renewal_page.dart';
import '/page/home/home_page.dart';
import '/page/home/notification_page.dart';

class CustomFooter extends StatelessWidget {
  final int currentIndex;

  CustomFooter({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF5DEB3), // Màu nền cho footer
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: BottomAppBar(
        color: Color(0xFF696969),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFooterIcon('assets/images/booklending_ft.png', 0, context),
            _buildFooterIcon('assets/images/reservation_ft.png', 1, context),
            _buildFooterIcon('assets/images/home_ft.png', 2, context),
            _buildFooterIcon('assets/images/renewal.png', 3, context),
            _buildFooterIcon('assets/images/notification.png', 4, context),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterIcon(String imagePath, int index, BuildContext context) {
    bool isActive = currentIndex == index;

    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OrdersPage()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ReservationPage(token: "token")),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage(token: "token")),
            );
            break;
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => RequestRenewalPage(token: "token")),
            );
            break;
          case 4:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NotificationPage()),
            );
            break;
          default:
            break;
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: isActive ? Color(0xFFD3D3D3) : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
              imagePath,
              width: isActive ? 35 : 30,  // Điều chỉnh kích thước hình ảnh khi hoạt động
              height: isActive ? 35 : 30,
            ),
          ),
        ],
      ),
    );
  }
}
