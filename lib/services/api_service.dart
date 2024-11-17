import 'package:demo_app/models/card_library_model.dart';
import 'package:demo_app/page/home/reservation_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '/models/user_model.dart';
import '/models/book_lending_model.dart';
import '/models/request_renewal_model.dart';
import '/models/reservation_model.dart';
import '/models/userNotification_model.dart';

class ApiService {
  final String baseUrl = 'http://10.0.2.2:8083/api/v1';

  // Lưu token vào SharedPreferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Lấy token từ SharedPreferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // lib/services/api_service.dart
  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _saveToken(data['token']); // Lưu token nếu đăng nhập thành công
      return data['token']; // Trả về token
    } else {
      return null; // Trả về null nếu có lỗi
    }
  }


  // Hàm lấy thông tin người dùng
  Future<User?> fetchUserInfo() async {
    String? token = await _getToken();
    if (token == null) {
      throw Exception('Token is null');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/users/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Thêm token vào header
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data['data']); // Trả về đối tượng User nếu thành công
    } else {
      throw Exception('Failed to load user information');
    }
  }

  // Hàm lấy danh sách sách đang mượn
  Future<List<BookLending>> fetchBookLendings() async {
    String? token = await _getToken();
    if (token == null) {
      throw Exception('Token is null');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/users/book-lending/getme'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Thêm token vào header
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<BookLending> bookLendings = (data['data'] as List)
          .map((item) => BookLending.fromJson(item))
          .toList();
      return bookLendings; // Trả về danh sách BookLending nếu thành công
    } else {
      throw Exception('Failed to load book lending information');
    }
  }

  // Hàm yêu cầu gia hạn
  Future<String> fetchRequestRenewal(int bookLendingId, String renewalDate,
      String description) async {
    String? token = await _getToken();
    if (token == null) {
      throw Exception('Token is null');
    }

    final String url = '$baseUrl/users/request-renewal/create';

    // Dữ liệu gửi đi trong body
    final Map<String, dynamic> requestBody = {
      'bookLendingId': bookLendingId,
      'renewalDate': renewalDate,
      'description': description,
    };

    // Chuyển đổi body sang định dạng JSON
    final String jsonBody = json.encode(requestBody);

    try {
      // Gửi yêu cầu POST
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Thêm token vào header
        },
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        // Nếu API trả về thành công, trả về thông báo thành công
        return 'Request renewal created successfully';
      } else {
        // Nếu có lỗi trong việc gọi API
        return 'Failed to create request renewal: ${response.body}';
      }
    } catch (e) {
      // Xử lý khi có lỗi kết nối hoặc các lỗi khác
      return 'Error: $e';
    }
  }

  // Hàm lấy thông tin yêu cầu gia hạn
  Future<List<RequestRenewal>> fetchGetRequestRenewal() async {
    String? token = await _getToken();
    if (token == null) {
      throw Exception('Token is null');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/users/request-renewal/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Thêm token vào header
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<RequestRenewal> requestRenewals = (data['data'] as List)
          .map((item) => RequestRenewal.fromJson(item))
          .toList();
      return requestRenewals; // Trả về danh sách RequestRenewal nếu thành công
    } else {
      throw Exception('Failed to load request renewal information');
    }
  }

  Future<List<Reservation>> fetchGetReservation() async {
    String? token = await _getToken();
    if (token == null) {
      throw Exception('Token is null');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/users/book-reservations/history'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Thêm token vào header
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Reservation> reservation = (data['data'] as List)
          .map((item) => Reservation.fromJson(item))
          .toList();
      return reservation; // Trả về danh sách RequestRenewal nếu thành công
    } else {
      throw Exception('Failed to load request renewal information');
    }
  }

  Future<List<UserNotification>> fetchNotification() async {
    String? token = await _getToken();
    if (token == null) {
      throw Exception('Token is null');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/users/notification/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Thêm token vào header
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<UserNotification> userNotification = (data['data'] as List)
          .map((item) => UserNotification.fromJson(item))
          .toList();
      return userNotification; // Trả về danh sách Notifications nếu thành công
    } else {
      throw Exception('Failed to load book lending information');
    }
  }

  // thay đổi mật khẩu
  Future<String> fetchChangePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    String? token = await _getToken(); // Lấy token từ storage hoặc API
    if (token == null) {
      throw Exception('Token is null');
    }

    final response = await http.patch(
      Uri.parse('$baseUrl/users/change-password'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Thêm token vào header
      },
      body: jsonEncode({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
        'confirmPassword': confirmPassword,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['message']; // Trả về thông báo thành công
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Failed to change password');
    }
  }

  Future<CardLibrary> fetchCardLibrary() async {
    String? token = await _getToken();
    if (token == null) {
      throw Exception('Token is null');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/users/card-library/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Thêm token vào header
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return CardLibrary.fromJson(data['data']); // Trả về đối tượng User nếu thành công
    } else {
      throw Exception('Failed to load your card');
    }
  }

  // Cập nhật thông tin người dùng
  Future<String> fetchUpdateUser({
    required String name,
    required String dob,
    required String phone,
  }) async {
    String? token = await _getToken(); // Lấy token từ storage hoặc API
    if (token == null) {
      throw Exception('Token is null');
    }

    final response = await http.put(
      Uri.parse('$baseUrl/users/update/me'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token', // Thêm token vào header
      },
      body: jsonEncode({
        'username': name,
        'dob': dob,
        'phone': phone,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['message'] ?? 'Profile updated successfully'; // Trả về thông báo thành công
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Failed to update user profile');
    }
  }

  // logout
  Future<void> fetchLogout() async {
    String? token = await _getToken();
    if (token == null) {
      throw Exception('Token is null');
    }

    final url = Uri.parse('$baseUrl/auth/logout');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Giữ header Content-Type là JSON
          'Authorization': 'Bearer $token', // Thêm token vào header
        },
        body: jsonEncode({}),  // Có thể để body rỗng nếu không cần dữ liệu thêm
      );

      if (response.statusCode == 200) {
        // Logout thành công
        print('Logout successful');
      } else {
        // Xử lý lỗi từ server
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        throw Exception(responseData['message'] ?? 'Logout failed');
      }
    } catch (e) {
      // Xử lý lỗi
      throw Exception('Error during logout: $e');
    }
  }
}
