// lib/page/user_info_page.dart
import 'package:flutter/material.dart';
import '/layouts/custom_header.dart';
import '/layouts/custom_footer.dart';
import '/widgets/colors.dart'; // Import colors.dart to access gradient

class IntroPage extends StatelessWidget {
  final String token;
  final int currentIndex;

  IntroPage({required this.token, this.currentIndex = 5});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.homeBackground, // Use gradient from colors.dart
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Set Scaffold background to transparent
        appBar: CustomHeader(title: "Introduction"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome message (title)
                Text(
                  'Welcome to the Library Management App!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Change text color to black
                  ),
                ),
                const SizedBox(height: 16),

                // Content using Roboto font
                Text(
                  'This app is designed to help you easily manage and explore the library\'s knowledge base. '
                      'We provide modern features to help you borrow books, renew, search for documents, and many other useful features.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontFamily: 'Roboto', // Apply Roboto font
                  ),
                ),
                const SizedBox(height: 24),

                // Usage rules (title)
                Text(
                  'Usage Rules:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Change text color to black
                  ),
                ),
                const SizedBox(height: 8),

                // List of rules
                _buildRule('1. Adhere to the borrowing and renewal time regulations.'),
                _buildRule('2. Keep your account information secure and do not share it with others.'),
                _buildRule('3. Use materials for the right purposes, and do not violate copyright laws.'),
                _buildRule('4. Take care of borrowed books and report any issues you find.'),
                const SizedBox(height: 24),

                // Thank you section
                Text(
                  'Thank you for using the app! We hope you have a great experience at the library.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontFamily: 'Roboto', // Apply Roboto font
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomFooter(currentIndex: 5),
      ),
    );
  }

  // Function to build rule list items
  Widget _buildRule(String ruleText) {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 18), // Green check icon
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            ruleText,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontFamily: 'Roboto', // Apply Roboto font
            ),
          ),
        ),
      ],
    );
  }
}
