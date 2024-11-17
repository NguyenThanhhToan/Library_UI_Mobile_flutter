import 'package:intl/intl.dart';

// Enum cho RequestRenewalStatus với tiện ích chuyển đổi từ chuỗi
enum RequestRenewalStatus { PENDING, APPROVED, REJECTED }

extension RequestRenewalStatusExtension on RequestRenewalStatus {
  static RequestRenewalStatus fromString(String status) {
    return RequestRenewalStatus.values.firstWhere(
          (e) => e.toString().split('.').last == status,
    );
  }

  // Chuyển đổi enum thành String ngắn gọn
  String toShortString() {
    return this.toString().split('.').last;
  }
}

class RequestRenewal {
  final int id;
  final int bookLendingId;
  final String bookName;
  final String image;  // Trường image
  final DateTime renewalDate;
  final RequestRenewalStatus status;

  RequestRenewal({
    required this.id,
    required this.bookLendingId,
    required this.bookName,
    required this.image,  // Thêm tham số image vào constructor
    required this.renewalDate,
    required this.status,
  });

  // Factory constructor để tạo đối tượng từ JSON
  factory RequestRenewal.fromJson(Map<String, dynamic> json) {
    return RequestRenewal(
      id: json['id'],
      bookLendingId: json['bookLendingId'],
      bookName: json['bookName'],
      image: json['image'],  // Thêm trường image vào factory
      renewalDate: DateFormat("dd-MM-yyyy").parse(json['renewalDate']),
      status: RequestRenewalStatusExtension.fromString(json['status']),
    );
  }

  // Phương thức chuyển đổi đối tượng sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookLendingId': bookLendingId,
      'bookName': bookName,
      'image': image,
      'renewalDate': DateFormat("dd-MM-yyyy").format(renewalDate),
      'status': status.toShortString(),  // Dùng phương thức toShortString() cho status
    };
  }
}
