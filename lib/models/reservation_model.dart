// lib/models/book_reservation_dto.dart
import 'package:intl/intl.dart';

class Reservation {
  final int reservationId;
  final DateTime creationDate;
  final String email;
  final int bookId;
  final String bookName;
  final String image;
  final Status status;



  Reservation({
    required this.reservationId,
    required this.creationDate,
    required this.email,
    required this.bookId,
    required this.bookName,
    required this.image,
    required this.status,
  });

  // Factory constructor để tạo đối tượng từ JSON
  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      reservationId: json['reservationId'],
      creationDate: DateFormat("dd-MM-yyyy").parse(json['creationDate']),
      email: json['email'],
      bookId: json['bookId'],
      bookName: json['bookName'],
      image: json['image'],
      status: StatusExtension.fromString(json['status']),

    );
  }

  // Phương thức chuyển đổi sang JSON (nếu cần)
  Map<String, dynamic> toJson() {
    return {
      'reservationId': reservationId,
      'creationDate': DateFormat("dd-MM-yyyy").format(creationDate),
      'email': email,
      'bookId': bookId,
      'bookName': bookName,
      'status': status.toString().split('.').last, // Chuyển status sang String
    };
  }
}

// Enum cho Status với tiện ích chuyển đổi từ chuỗi
enum Status { PENDING, APPROVED, REJECTED }

extension StatusExtension on Status {
  static Status fromString(String status) {
    return Status.values.firstWhere((e) => e.toString().split('.').last == status);
  }
}
