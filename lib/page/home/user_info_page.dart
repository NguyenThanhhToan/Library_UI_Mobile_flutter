import 'package:flutter/material.dart';
import '/layouts/custom_header.dart';
import '/models/user_model.dart';
import '/services/api_service.dart';
import '/widgets/colors.dart';
import '/widgets/update_profile_form.dart'; // Ensure you have imported UpdateProfileForm

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  late Future<User?> _userInfo;

  @override
  void initState() {
    super.initState();
    _userInfo = ApiService().fetchUserInfo();
  }

  // Function to refresh user info after updating
  void _refreshUserInfo() {
    setState(() {
      _userInfo = ApiService().fetchUserInfo();
    });
  }

  // Function to display the update profile form
  void _showUpdateProfileForm(User user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: UpdateProfileForm(
            user: user,
            onUpdateSuccess: _refreshUserInfo, // Gọi hàm làm mới dữ liệu
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.homeBackground,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomHeader(title: 'User Information'),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<User?>(
            future: _userInfo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                User? user = snapshot.data;
                if (user != null) {
                  return ListView(
                    children: [
                      SizedBox(height: screenHeight * 0.10),
                      Center(
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, size: 80, color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 40),
                      buildInfoRow(Icons.person, 'Name', user.username),
                      buildInfoRow(Icons.email, 'Email', user.email),
                      buildInfoRow(Icons.phone, 'Phone Number', user.phone),
                      buildInfoRow(Icons.date_range, 'Date of Birth', user.dob),
                      buildInfoRow(Icons.date_range, 'Created Date', user.createdDate),
                      buildInfoRow(Icons.credit_card, 'Library Card', user.cardLibrary),
                      SizedBox(height: 20),
                      // Button to update user information
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            _showUpdateProfileForm(user); // Show the update form
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text('Update Information'),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              } else {
                return Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(IconData icon, String label, String? value) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.blue),
            SizedBox(width: 10),
            Text(
              '$label: ${value ?? ' '}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Divider(color: Colors.white),
        SizedBox(height: 15),
      ],
    );
  }
}
