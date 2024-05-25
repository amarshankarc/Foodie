import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodie/app/data/repostory/user.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../routes/app_pages.dart';

abstract class SignIn {
  // entry point of the Firebase Authentication SDK.
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for phoneNumber Verification
  static String _verificationId = "";

  static Future<bool> authState() async {
    bool value = false;
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        // User is currently signed out!
        value = false;
      } else {
        // User is signed in!'
        UserData.userInfo = user;
        Get.offNamed(Routes.HOME);
        value = true;
      }
    });
    return value;
  }

  static Future<UserCredential> withGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await auth.signInWithCredential(credential);
  }

  static Future<void> withPhoneNumber({
    required String phoneNumber,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: "+91 $phoneNumber",
      codeSent: (String verificationId, int? resendToken) async {
        _verificationId = verificationId;
      },
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        Get.offAllNamed(Routes.HOME);
      },
      verificationFailed: (FirebaseAuthException error) {
        // Handle Errors
        if (error.code == 'invalid-phone-number') {}
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  static Future<UserCredential> verifyOtp({required String otp}) async {
    // Update the UI - wait for the user to enter the SMS code
    String smsCode = otp;
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    return await auth.signInWithCredential(credential);
  }
}
