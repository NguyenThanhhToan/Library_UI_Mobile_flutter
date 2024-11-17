import 'package:flutter/material.dart';
import '/models/user_model.dart'; // Đảm bảo rằng bạn đã có User model
import '/services/api_service.dart'; // Để gọi API update user

class UpdateProfileForm extends StatefulWidget {
  final User user;
  final VoidCallback onUpdateSuccess;

  UpdateProfileForm({required this.user, required this.onUpdateSuccess});

  @override
  _UpdateProfileFormState createState() => _UpdateProfileFormState();
}

class _UpdateProfileFormState extends State<UpdateProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _usernameController;
  late TextEditingController _phoneController;
  late TextEditingController _dobController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.username);
    _phoneController = TextEditingController(text: widget.user.phone);
    _dobController = TextEditingController(text: widget.user.dob);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  void _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Gọi API để cập nhật thông tin người dùng
        String response = await ApiService().fetchUpdateUser(
          name: _usernameController.text,
          dob: _dobController.text,
          phone: _phoneController.text,
        );

        // Hiển thị thông báo thành công
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response)));

        widget.onUpdateSuccess(); // Gọi callback để thông báo thành công
        Navigator.pop(context); // Quay lại trang trước
      } catch (error) {
        // Hiển thị thông báo lỗi
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $error')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      constraints: BoxConstraints(maxWidth: 600), // Điều chỉnh chiều rộng tối đa cho container
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // TextFormField for Username
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a username';
                }
                return null;
              },
            ),
            SizedBox(height: 10), // Space between fields
            // TextFormField for Phone Number
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
              ),
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 10) {
                  return 'Please enter a valid phone number';
                }
                return null;
              },
            ),
            SizedBox(height: 10), // Space between fields
            // TextFormField for Date of Birth
            TextFormField(
              controller: _dobController,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                hintText: 'Enter your date of birth',
              ),
              keyboardType: TextInputType.datetime,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your date of birth';
                }
                return null;
              },
            ),
            SizedBox(height: 20), // Space before button
            // Submit button
            ElevatedButton(
              onPressed: _updateProfile,
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
