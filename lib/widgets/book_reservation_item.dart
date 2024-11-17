// lib/widgets/book_reservation_widget.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/models/reservation_model.dart';

class ReservationItem extends StatelessWidget {
  final Reservation reservation;

  const ReservationItem({Key? key, required this.reservation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Reservation information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${reservation.bookName}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Reservation Code: ${reservation.reservationId}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Creation Date: ${DateFormat("dd-MM-yyyy").format(reservation.creationDate)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Status: ${reservation.status.toString().split('.').last}',
                    style: TextStyle(
                      fontSize: 14,
                      color: _getStatusColor(reservation.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Book image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(
                image: NetworkImage(
                  'http://10.0.2.2:8083/uploads/${reservation.image}', // URL path to the book image
                ),
                width: 85,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  // Function to determine the color based on the status
  Color _getStatusColor(Status status) {
    switch (status) {
      case Status.PENDING:
        return Colors.orange;
      case Status.APPROVED:
        return Colors.green;
      case Status.REJECTED:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
