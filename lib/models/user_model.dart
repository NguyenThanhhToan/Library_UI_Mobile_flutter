import 'package:intl/intl.dart';

class User {
  final String? username;
  final String? email;
  final String? phone;
  final String? createdDate;
  final String? status;
  final String? dob;
  final String? cardLibrary;

  User({
    required this.username,
    required this.email,
    required this.phone,
    required this.createdDate,
    required this.status,
    required this.dob,
    required this.cardLibrary
  });

  // Factory constructor để tạo đối tượng User từ JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      createdDate: json['createdDate'] != null
          ? DateFormat('dd-MM-yyyy').format(DateTime.parse(json['createdDate']))
          : null, // Kiểm tra null
      status: json['status'],
      dob: json['dob'] != null
          ? DateFormat('dd-MM-yyyy').format(DateTime.parse(json['dob']))
          : null,
      cardLibrary: json['cardLibrary'],
    );
  }

  // Phương thức để chuyển đối tượng User thành JSON (nếu cần gửi đến backend)
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'phone': phone,
      'createdDate': createdDate,
      'status': status,
      'dob:':dob,
      'cardLibrary': cardLibrary
    };
  }
}
