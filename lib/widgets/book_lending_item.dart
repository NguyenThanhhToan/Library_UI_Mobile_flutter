import 'package:flutter/material.dart';
import '/models/book_lending_model.dart';
import '/services/api_service.dart';

class BookLendingItem extends StatelessWidget {
  final BookLending lending;

  const BookLendingItem({Key? key, required this.lending}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main container displaying book information
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book image section
              Container(
                width: 60,
                height: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.blueGrey[100], // Placeholder for image
                  image: DecorationImage(
                    image: NetworkImage(
                        'http://10.0.2.2:8083/uploads/${lending.image}'), // URL to the book image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 16.0), // Space between image and book details

              // Book lending details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lending.bookName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text('Date borrowed: ${lending.creationDate}'),
                    Text('Due date: ${lending.dueDate}'),
                    Text('Status: ${lending.returnDate ?? "Not returned"}'),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Renewal icon at the top-right corner
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.blueAccent,
              size: 24,
            ),
            onPressed: () {
              _showRenewalForm(context, lending.lendingId);
            },
          ),
        ),
      ],
    );
  }

  // Method to show the book renewal form
  void _showRenewalForm(BuildContext context, int bookLendingId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Renew Book'),
          content: RenewalForm(bookLendingId: bookLendingId),
        );
      },
    );
  }
}

class RenewalForm extends StatefulWidget {
  final int bookLendingId;

  const RenewalForm({Key? key, required this.bookLendingId}) : super(key: key);

  @override
  _RenewalFormState createState() => _RenewalFormState();
}

class _RenewalFormState extends State<RenewalForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newDueDateController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  // Method to send renewal request
  Future<void> _submitRenewalRequest() async {
    if (_formKey.currentState!.validate()) {

      final apiService = ApiService();
      final result = await apiService.fetchRequestRenewal(
        widget.bookLendingId,
        _newDueDateController.text,
        _reasonController.text,
      );

      // Display a message to the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
      Navigator.of(context).pop(); // Close dialog after submission
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _newDueDateController,
            decoration: InputDecoration(
              labelText: 'New Due Date',
              hintText: 'Select a new due date',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a new due date';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _reasonController,
            decoration: InputDecoration(
              labelText: 'Renewal Reason',
              hintText: 'Enter reason for renewal',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a reason for renewal';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitRenewalRequest,
            child: Text('Submit Request'),
          ),
        ],
      ),
    );
  }
}
