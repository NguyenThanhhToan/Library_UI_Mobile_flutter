import 'package:flutter/material.dart';

class CardLibraryItem extends StatelessWidget {
  final String cardNumber;
  final String userName;
  final String issuedDate;
  final String expiredDate;

  const CardLibraryItem({
    Key? key,
    required this.cardNumber,
    required this.userName,
    required this.issuedDate,
    required this.expiredDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250, // Chiều cao của Card
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Đoạn này làm nổi bật cardNumber
              Text(
                '    cardNumber: $cardNumber',
                style: const TextStyle(
                  fontWeight: FontWeight.bold, // Chữ đậm
                  fontSize: 22,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 10),
              Divider(color: Colors.grey.shade300),
              const SizedBox(height: 10),

              // Row cho ảnh bên trái và thông tin bên phải
              Row(
                children: [
                  // Ảnh với kích thước lớn hơn
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/banner1.jpg', // Đường dẫn đến ảnh
                      width: 150, // Đổi kích thước hình ảnh
                      height: 100, // Đổi kích thước hình ảnh
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Thông tin bên phải sẽ được thay bằng Column để hiển thị theo chiều dọc
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tên người dùng
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              size: 20,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              userName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold, // Chữ đậm
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Ngày cấp và ngày hết hạn (theo chiều dọc)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 18,
                                  color: Colors.blueAccent,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Issued: $issuedDate',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold, // Chữ đậm
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.event_busy,
                                  size: 18,
                                  color: Colors.redAccent,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Expired: $expiredDate',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold, // Chữ đậm
                                    fontSize: 14,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
