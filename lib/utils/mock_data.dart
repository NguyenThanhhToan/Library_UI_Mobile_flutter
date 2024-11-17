// lib/mock_data.dart
// import 'package:intl/intl.dart';
// import '/models/user_model.dart';
// import '/models/book_lending_model.dart';
// import '/models/reservation_model.dart';
// import '/models/request_renewal_model.dart';
// class MockData {
//   static Future<User> getUserInfo() async {
//     // Giả lập thời gian tải dữ liệu
//     await Future.delayed(Duration(seconds: 1));
//
//     // Trả về dữ liệu người dùng giả lập
//     return User(
//       id: 1,
//       username: 'Nguyen Van A',
//       email: 'nguyenvana@example.com',
//       phone: '0156789',
//       roleName: 'User',
//       createdDate: '2023-01-01',
//       dob: '1990-05-12',
//       status: 'Active',
//     );
//   }
// }

//   static List<BookReservation> getBookReservations() {
//     return [
//       BookReservation(
//         reservationId: 101,
//         creationDate: DateTime.parse("2024-11-01"),
//         email: 'user1@example.com',
//         bookId: 201,
//         status: Status.PENDING,
//       ),
//       BookReservation(
//         reservationId: 102,
//         creationDate: DateTime.parse("2024-11-05"),
//         email: 'user2@example.com',
//         bookId: 202,
//         status: Status.APPROVED,
//       ),
//     ];
//   }
// }

  // static Future<List<BookLending>> getBookLendings() async {
  //   // Giả lập thời gian tải dữ liệu
  //   await Future.delayed(Duration(seconds: 1));
  //
  //   // Trả về dữ liệu BookLending giả lập
  //   return [
  //     BookLending(
  //       lendingId: 1,
  //       bookId: 101,
  //       creationDate: '2024-01-01',
  //       dueDate: '2024-01-15',
  //       returnDate: null,
  //       userId: 1001,
  //       staffId: 2001,
  //     ),
  //     BookLending(
  //       lendingId: 2,
  //       bookId: 102,
  //       creationDate: '2024-02-01',
  //       dueDate: '2024-02-15',
  //       returnDate: '2024-02-10',
  //       userId: 1002,
  //       staffId: 2002,
  //     ),
  //     BookLending(
  //       lendingId: 3,
  //       bookId: 103,
  //       creationDate: '2024-03-01',
  //       dueDate: '2024-03-15',
  //       returnDate: null,
  //       userId: 1003,
  //       staffId: 2003,
  //     ),
  //     BookLending(
  //       lendingId: 4,
  //       bookId: 104,
  //       creationDate: '2024-04-01',
  //       dueDate: '2024-04-15',
  //       returnDate: null,
  //       userId: 1004,
  //       staffId: 2004,
  //     ),
  //     BookLending(
  //       lendingId: 5,
  //       bookId: 105,
  //       creationDate: '2024-05-01',
  //       dueDate: '2024-05-15',
  //       returnDate: '2024-05-10',
  //       userId: 1005,
  //       staffId: 2005,
  //     ),
  //     BookLending(
  //       lendingId: 6,
  //       bookId: 106,
  //       creationDate: '2024-06-01',
  //       dueDate: '2024-06-15',
  //       returnDate: null,
  //       userId: 1006,
  //       staffId: 2006,
  //     ),
  //     BookLending(
  //       lendingId: 7,
  //       bookId: 107,
  //       creationDate: '2024-07-01',
  //       dueDate: '2024-07-15',
  //       returnDate: '2024-07-10',
  //       userId: 1007,
  //       staffId: 2007,
  //     ),
  //     BookLending(
  //       lendingId: 8,
  //       bookId: 108,
  //       creationDate: '2024-08-01',
  //       dueDate: '2024-08-15',
  //       returnDate: null,
  //       userId: 1008,
  //       staffId: 2008,
  //     ),
  //   ];
  // }

//   static Future<List<RequestRenewal>> getRequestRenewals() async {
//     // Giả lập thời gian tải dữ liệu
//     await Future.delayed(const Duration(seconds: 1));
//
//     // Trả về danh sách RequestRenewal giả lập
//     return [
//       RequestRenewal(
//         id: 1,
//         bookLendingId: 101,
//         bookName: 'Nhà Giả Kim',
//         renewalDate: DateFormat("dd-MM-yyyy").parse('15-11-2024'),
//         status: RequestRenewalStatus.PENDING,
//       ),
//       RequestRenewal(
//         id: 2,
//         bookLendingId: 102,
//         bookName: 'Harry Potter',
//         renewalDate: DateFormat("dd-MM-yyyy").parse('20-11-2024'),
//         status: RequestRenewalStatus.APPROVED,
//       ),
//       RequestRenewal(
//         id: 3,
//         bookLendingId: 103,
//         bookName: 'Đắc Nhân Tâm',
//         renewalDate: DateFormat("dd-MM-yyyy").parse('25-11-2024'),
//         status: RequestRenewalStatus.REJECTED,
//       ),
//     ];
//   }