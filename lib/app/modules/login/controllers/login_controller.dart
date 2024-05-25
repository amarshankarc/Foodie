import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/repostory/signin.dart';

class LoginController extends GetxController {
  TextEditingController otpController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();

  // visiblity of Otp Widget
  RxBool isOtpSend = false.obs;

  @override
  void onInit() {
    isLogIn();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void isLogIn() async {
    await SignIn.authState();
  }

  //validation of phone number
  String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter correct phone number';
    } else if (value.startsWith("+")) {
      value = value.substring(3);
      if (value.length > 10 || value.length < 10) {
        return 'Please enter correct phone number';
      }
    } else if (value.length > 10 || value.length < 10) {
      return 'Please enter correct phone number';
    }
    phoneController.text = value;
    return null;
  }

  //validation of  otp
  String? otpValidator(String? value) {
    if (value == null ||
        value.isEmpty ||
        value.length > 6 ||
        value.length < 6) {
      return 'Please enter Otp';
    }
    return null;
  }
}
