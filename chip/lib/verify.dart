import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyApp extends StatelessWidget {
  final String phoneNumber;
  final bool verify;

  const MyApp({required this.phoneNumber, required this.verify});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phone Verification',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: VerificationScreen(phoneNumber: phoneNumber, verify: verify),
    );
  }
}

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final bool verify;

  const VerificationScreen({required this.phoneNumber, required this.verify});

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController textEditingController = TextEditingController();
  String currentText = "";
  bool _isVerified = false;

  @override
  void initState() {
    super.initState();
    onCreate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Verification'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 280, // Adjust the width as per your preference
                child: PinCodeTextField(
                  appContext: context,
                  controller: textEditingController,
                  length: 6,
                  onChanged: (value) {
                    setState(() {
                      currentText = value;
                    });
                  },
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    selectedColor: Color.fromARGB(255, 0, 0, 0),
                    activeColor: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  verifyCode(currentText);
                },
                child: Text('Verify'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreate() async {
    String accountSid = 'AC8229f48ea5ef04534979017c047510e0';
    String authToken = '25915662f5b85f8107bba9ffcb5ad90e';
    String verificationSid = 'VA00e773b2c8468d263ae1f31e93ea7a66';

    var response = await http.post(
      Uri.parse(
          'https://verify.twilio.com/v2/Services/$verificationSid/Verifications'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization':
            'Basic ' + base64Encode(utf8.encode('$accountSid:$authToken')),
      },
      body: {
        'To': widget.phoneNumber, // Use widget.phoneNumber here
        'Channel': 'sms',
      },
    );

    if (response.statusCode == 201) {
      print("SMS sent successfully");
    } else {
      print("Couldn't send the SMS");
      print(response.statusCode);
    }
  }

  void verifyCode(String code) async {
    String accountSid = 'AC8229f48ea5ef04534979017c047510e0';
    String authToken = '25915662f5b85f8107bba9ffcb5ad90e';
    String verificationSid = 'VA00e773b2c8468d263ae1f31e93ea7a66';

    var response = await http.post(
      Uri.parse(
          'https://verify.twilio.com/v2/Services/$verificationSid/VerificationCheck'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization':
            'Basic ' + base64Encode(utf8.encode('$accountSid:$authToken')),
      },
      body: {
        'To': widget.phoneNumber, // Use widget.phoneNumber here
        'Code': code,
      },
    );

    if (response.statusCode == 200) {
      print("Code Verified Successfully");
      setState(() {
        _isVerified = true;
      });
    } else {
      print("Could not verify the code");
      print(response.body);
    }
  }
}
