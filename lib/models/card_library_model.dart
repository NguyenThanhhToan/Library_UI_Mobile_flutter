import 'package:intl/intl.dart';

class CardLibrary {
  final String cardNumber;
  final String userName;
  final String issued;
  final String expired;

  CardLibrary({
    required this.cardNumber,
    required this.userName,
    required this.issued,
    required this.expired,
  });

  // Factory constructor để tạo đối tượng User từ JSON
  factory CardLibrary.fromJson(Map<String, dynamic> json) {
    return CardLibrary(
      cardNumber: json['cardNumber'],
      userName: json['userName'],
      issued: json['issued'],
      expired: json['expired']
    );
  }

  // Phương thức để chuyển đối tượng User thành JSON (nếu cần gửi đến backend)
  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'userName': userName,
      'issued': issued,
      'expired':expired
    };
  }
}
