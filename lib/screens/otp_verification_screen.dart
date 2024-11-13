import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'profile_selection_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String verificationId;
  OtpVerificationScreen({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String otpCode = '';
  bool isLoading = false;

  Future<void> _verifyOtp() async {
    setState(() {
      isLoading = true;
    });
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpCode,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfileSelectionScreen()),
      );
    } catch (e) {
      print('Error verifying OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP. Please try again.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _requestOtpAgain() {
    print("Requesting OTP again...");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP resent successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title Text
            const Text(
              "Verify OTP",
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Subtitle Text
            const Text(
              "Code is sent to 9999999999",
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(106, 108, 123, 1),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            OtpPinField(
              maxLength: 6,
              onSubmit: (otp) {
                setState(() {
                  otpCode = otp;
                });
              },
              onChange: (otp) {
                setState(() {
                  otpCode = otp;
                });
              },
              otpPinFieldStyle: const OtpPinFieldStyle(
                textStyle: TextStyle(fontSize: 18),
                defaultFieldBorderColor: Colors.black,
                activeFieldBorderColor: Colors.blue,
              ),
              fieldWidth: 40,
              fieldHeight: 55,
              otpPinFieldDecoration:
                  OtpPinFieldDecoration.defaultPinBoxDecoration,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: "Didn't receive the code? ",
                    style: const TextStyle(
                        fontSize: 14, color: Color.fromRGBO(106, 108, 123, 1)),
                    children: [
                      TextSpan(
                        text: 'Request Again',
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(6, 29, 40, 1),
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = _requestOtpAgain,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 56,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(46, 59, 98, 1),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: isLoading || otpCode.length != 6 ? null : _verifyOtp,
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "VERIFY AND CONTINUE",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
