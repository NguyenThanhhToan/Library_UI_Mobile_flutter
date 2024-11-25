// lib/models/book_lending_model.dart
class BookLending {
  final int lendingId;
  final int bookId;
  final String bookName;
  final String? image;
  final String author;
  final String creationDate;
  final String dueDate;
  final String? returnDate;
  final String email;
  final int staffId;

  BookLending({
    required this.lendingId,
    required this.bookId,
    required this.bookName,
    required this.image,
    required this.author,
    required this.creationDate,
    required this.dueDate,
    this.returnDate,
    required this.email,
    required this.staffId,
  });

  factory BookLending.fromJson(Map<String, dynamic> json) {
    return BookLending(
      lendingId: json['lendingId'],
      bookId: json['bookId'],
      bookName: json['bookName'],
      image: json['image'],
      author: json['author'],
      creationDate: json['creationDate'],
      dueDate: json['dueDate'],
      returnDate: json['returnDate'],
      email: json['email'],
      staffId: json['staffid'],
    );
  }
}
