import 'package:firebase_auth/firebase_auth.dart';

Future<void> sendOtp(String phoneNumber) async {
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) async {
      await FirebaseAuth.instance.signInWithCredential(credential);
    },
    verificationFailed: (FirebaseAuthException e) {
      print("Verification failed: ${e.message}");
    },
    codeSent: (String verificationId, int? resendToken) {
      // Store verificationId if needed
    },
    codeAutoRetrievalTimeout: (String verificationId) {
      print("Code retrieval timeout: $verificationId");
    },
  );
}

Future<void> verifyOtp(String verificationId, String smsCode) async {
  PhoneAuthCredential credential = PhoneAuthProvider.credential(
    verificationId: verificationId,
    smsCode: smsCode,
  );

  await FirebaseAuth.instance.signInWithCredential(credential);
}
