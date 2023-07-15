import 'dart:convert';

import 'package:flutter/material.dart';
import 'story.dart';
import 'verify.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _accountTypeController = TextEditingController();

  bool _isVerified = false;

  @override
  Widget build(BuildContext context) {
    final double headingFontSize =
        1.7 * Theme.of(context).textTheme.headline6!.fontSize!;

    return Scaffold(
      appBar: AppBar(
        title: Text('DashBoard'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          shrinkWrap: true,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: headingFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                controller: _accountTypeController,
                decoration: InputDecoration(
                  labelText: 'Account Type',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle sign up logic here
                  String name = _nameController.text;
                  String email = _emailController.text;
                  String phone = _phoneController.text;
                  String password = _passwordController.text;
                  String confirmPassword = _confirmPasswordController.text;
                  String accountType = _accountTypeController.text;

                  // Create a signup object
                  signup newSignUp = signup(
                    name: name,
                    email: email,
                    phone: phone,
                    password: password,
                    confirm: confirmPassword,
                    account: accountType,
                    isVerified: _isVerified,
                  );


                  // Generate JSON representation of the signup data
                  String jsonData = jsonEncode(newSignUp);

                  // Print the JSON data
                  print(jsonData);

                  // Reset input fields
                  _nameController.clear();
                  _emailController.clear();
                  _phoneController.clear();
                  _passwordController.clear();
                  _confirmPasswordController.clear();
                  _accountTypeController.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(phoneNumber: phone, verify: _isVerified,)
                    ),
                  );
                },
                child: Text('Sign Up'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class signup {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirm;
  final String account;
  final bool isVerified;

  signup({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.confirm,
    required this.account,
    required this.isVerified,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': '+91$phone',
      'password': password,
      'confirm': confirm,
      'account': account,
      'is_verified': isVerified,
    };
  }
}

void main() {
  runApp(MaterialApp(
    home: SignUpPage(),
  ));
}