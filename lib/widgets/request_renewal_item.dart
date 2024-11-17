import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/models/request_renewal_model.dart';

class RequestRenewalItem extends StatelessWidget {
  final RequestRenewal renewalRequest;

  const RequestRenewalItem({Key? key, required this.renewalRequest}) : super(key: key);

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
            const SizedBox(width: 16),
            // Display renewal information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${renewalRequest.bookName}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Book Lending Code: ${renewalRequest.bookLendingId}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Renewal Date: ${DateFormat("dd-MM-yyyy").format(renewalRequest.renewalDate)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Status: ${renewalRequest.status.toString().split('.').last}',
                    style: TextStyle(
                      fontSize: 14,
                      color: _getStatusColor(renewalRequest.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Display book image from URL using NetworkImage
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image(
                image: NetworkImage(
                  'http://10.0.2.2:8083/uploads/${renewalRequest.image}', // URL path to the book image
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

  // Function to determine color based on status
  Color _getStatusColor(RequestRenewalStatus status) {
    switch (status) {
      case RequestRenewalStatus.PENDING:
        return Colors.orange;
      case RequestRenewalStatus.APPROVED:
        return Colors.green;
      case RequestRenewalStatus.REJECTED:
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}
