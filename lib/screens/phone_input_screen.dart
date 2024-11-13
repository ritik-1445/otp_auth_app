import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'otp_verification_screen.dart';
import 'package:country_code_picker/country_code_picker.dart';

final phoneNumberProvider = StateProvider<String>((ref) => '');

class PhoneInputScreen extends ConsumerWidget {
  final TextEditingController phoneController = TextEditingController();
  String countryCode = "+91";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneNumber = ref.watch(phoneNumberProvider);

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Please enter your mobile number",
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 11),
            const Text(
              "You’ll receive a 6 digit code \nto verify next.",
              style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(106, 108, 123, 1),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.zero,
              ),
              child: Row(
                children: [
                  CountryCodePicker(
                    onChanged: (country) {
                      countryCode = country.dialCode ?? "+91";
                      ref.read(phoneNumberProvider.notifier).state =
                          countryCode + phoneController.text;
                    },
                    initialSelection: 'IN',
                    favorite: ['+1', 'US', '+91', 'IN'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    alignLeft: false,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      maxLength: 13,
                      decoration: const InputDecoration(
                        hintText: "Mobile Number",
                        border: InputBorder.none,
                        counterText: "",
                      ),
                      onChanged: (value) {
                        ref.watch(phoneNumberProvider.notifier).state =
                            countryCode + value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 56,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(46, 59, 98, 1),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: phoneNumber.length >= 13
                    ? () async {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: phoneNumber,
                          verificationCompleted:
                              (PhoneAuthCredential credential) {
                            print("Verification completed: $credential");
                          },
                          verificationFailed: (FirebaseAuthException e) {
                            print("Verification failed: ${e}");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Verification failed. Try again.")),
                            );
                          },
                          codeSent: (String verificationId, int? resendToken) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OtpVerificationScreen(
                                    verificationId: verificationId),
                              ),
                            );
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {
                            print("Code retrieval timeout: $verificationId");
                          },
                        );
                      }
                    : null,
                child: const Text(
                  "CONTINUE",
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
