


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

/// Error Message  For Non Future Functions
void errM(Function() f, {String msg = "", String title = "Error"}) {
  try {
    f();
  } catch (e) {
    if (msg.isEmpty) {
      msg = '';
    }

    showMsg(msg, title);
  }
}
/// Error Message  For  Future Functions
Future errMAsync(Future<void> Function() f,
    {String msg = "",
      String title = "Error",
      isShowMsg = true,
      dialogDismiss = false}) async {
  try {
    await f();
  } catch (e) {
    if (msg.isEmpty) {
      // message which will show when the Error Occurs
      msg = 'Hint: Something Went Wrong.check your network ';
    }
    if (dialogDismiss) {
      // Get.back();
    }
    if (isShowMsg) {
      // showMsg(msg, title);
    }
  }
}

void showMsg(String msg, String title, {leadingIcon, isSuccess = false}) {
  /// Write the Way you Want to Show the Message to the User
  /// For Example [SnackBar] or [Show Toast]
  Get.snackbar(
    title,
    msg,
    icon: leadingIcon,
    maxWidth: Get.width,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor:
    isSuccess ? Colors.black : Colors.red,
    colorText: Colors.white,
    borderRadius: 8,
    padding: const EdgeInsets.all(10),
    margin: const EdgeInsets.only(left: 16,right: 16,bottom: 10),
  );
}
