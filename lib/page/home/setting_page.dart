// settings_page.dart

import 'package:demo_app/page/auth/login_page.dart';
import 'package:flutter/material.dart';
import '/layouts/custom_header.dart';
import '/widgets/colors.dart';
import 'user_info_page.dart';
import 'card_library_page.dart';
import '/widgets/change_password_item.dart'; // Import ChangePasswordItem
import '/services/api_service.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage();

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Method to show the password change dialog
  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChangePasswordItem(
          onPasswordChanged: () {
            // Handle any action after password is changed, e.g., show a message
            print("Password successfully changed!");
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.homeBackground, // Use gradient from colors.dart
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Set Scaffold background to transparent
        appBar: CustomHeader(title: 'Settings'), // Change title to 'Settings'
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // Personal information
              ListTile(
                title: Text('Personal Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserInfoPage(),
                    ),
                  );
                },
              ),
              Divider(),

              // Change password
              ListTile(
                title: Text('Change Password',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: _showChangePasswordDialog, // Show the password change dialog
              ),
              Divider(),

              // Library card
              ListTile(
                title: Text('Library Card',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardLibraryPage(),
                    ),
                  );
                },
              ),
              Divider(),

              // Logout
              ListTile(
                title: Text('Logout', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.exit_to_app),
                onTap: () async {
                  try {
                    // Call logout API
                    await ApiService().fetchLogout(); // Replace userToken with the actual token you store

                    // Navigate to the Login page and clear the navigation stack
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  } catch (error) {
                    // Show error message if logout fails
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logout failed: $error')),
                    );
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}