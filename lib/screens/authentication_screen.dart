import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:student_cover/constants.dart';
import 'package:student_cover/screens/create_account.dart';
import 'package:student_cover/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:student_cover/services/AlertManager.dart';

class AuthenticationScreen extends StatefulWidget {
  static final String screenName = "AuthenticationScreen";
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  String _phoneNumber = "";
  String _otp = "";
  bool _isOtpSent = false;
  bool _isLoading = false;
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  late AlertManager _alertManager;

  @override
  void initState() {
    super.initState();
    _alertManager = AlertManager(context: context);
  }

  void sendOtp() async {
    try {
      if (_phoneNumber.length != 10) {
        _alertManager.showSnackBar("Please enter a valid 10 digit phone number", SnackbarType.warning);
        return;
      }

      setState(() {
        _isLoading = true;
      });
      DataSnapshot userSnapshot = await _firebaseDatabase.ref("/USERS_ARCHIVE").child(_phoneNumber).get();
      if (userSnapshot.exists) {
        final userData = userSnapshot.value as Map<Object?, Object?>;
        String baseUrl = "https://student-cover-crm-functions.netlify.app/send-otp";
        await http.post(Uri.parse(baseUrl), headers: {'Content-Type': 'application/json'}, body: jsonEncode({"phoneNumber": _phoneNumber, "email": userData['emailId'].toString()}));
        await _alertManager.showAlertDialog('OTP Sent');
        setState(() {
          _isOtpSent = true;
        });
      } else {
        Navigator.pushReplacementNamed(context, CreateAccount.screenName);
      }
    } catch (e) {
      await _alertManager.showAlertDialog(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void verifyOtp() async {
    try {

      
      setState(() {
        _isLoading = true;
      });
      String baseUrl = "https://student-cover-crm-functions.netlify.app/verify-otp";
      http.Response response = await http.post(Uri.parse(baseUrl), body: jsonEncode({"userPhoneOTP": _otp, "userMailOTP": _otp, "phoneNumber": _phoneNumber}));
      debugPrint(response.body.toString());
    } catch (e) {
      await _alertManager.showAlertDialog(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Hero(tag: "sc_logo", child: Image.asset("images/student_cover_logo.png", width: 72, height: 72)),
              ),
              const SizedBox(height: 40),
              const Text(
                "Welcome to\nStudent Cover",
                style: TextStyle(color: textPrimary, fontSize: 34, fontWeight: FontWeight.w800, height: 1.2),
              ),
              const SizedBox(height: 12),
              const Text(
                "Login with your registered phone number.",
                style: TextStyle(color: textSecondary, fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 48),
              TextField(
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 16),
                decoration: kAuthenticationInputDecoration.copyWith(labelText: "Phone Number", hintText: "10 Digit Phone Number"),
                onChanged: (String text) {
                  setState(() {
                    _phoneNumber = text;
                  });
                },
              ),
              const SizedBox(height: 24),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                reverseDuration: Duration(milliseconds: 200),
                child: _isOtpSent
                    ? TextField(
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 16),
                        decoration: kAuthenticationInputDecoration.copyWith(labelText: "OTP"),
                      )
                    : SizedBox.shrink(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: !_isOtpSent ? sendOtp : verifyOtp,
                  style: kPrimaryButtonStyle.copyWith(shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)))),
                  child: Text(
                    _isLoading
                        ? "Loading..."
                        : _isOtpSent
                        ? "Verify"
                        : "Send OTP",
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("Don't have an account? ", style: TextStyle(color: textSecondary, fontSize: 15)),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Create Account screen
                    },
                    child: const Text(
                      "Create Account",
                      style: TextStyle(color: kPrimaryDark, fontSize: 15, fontWeight: FontWeight.bold),
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
