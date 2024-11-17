// my_app.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/login_page.dart';
import 'home/home_page.dart';

class MyApp extends StatelessWidget {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // Lấy token từ SharedPreferences
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<String?>(
        future: getToken(),
        builder: (context, snapshot) {
          // Kiểm tra trạng thái của Future
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Hiển thị vòng xoay khi chờ
          } else if (snapshot.hasData && snapshot.data != null) {
            return HomePage(token: snapshot.data!); // Nếu đã đăng nhập, chuyển đến HomePage
          } else {
            return HomePage(token: 'token',); // Nếu chưa đăng nhập, chuyển đến LoginPage
          }
        },
      ),
    );
  }
}
