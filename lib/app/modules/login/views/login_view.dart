import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/app/data/repostory/signin.dart';
import 'package:foodie/app/utils/asset_helper.dart';
import 'package:foodie/app/utils/my_theme.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.isLogIn();
    return Scaffold(
      body: Column(
        children: [
          MyTheme.space(height: .25),

          /// FireBase Icon Widget
          SvgPicture.asset(
            AssetHelper.firebase,
            height: Get.height * .3,
          ),
          MyTheme.space(height: .25),

          /// Google SignIn Button
          Padding(
            padding: _buttonPadding(),
            child: InkWell(
              onTap: () async {
                await SignIn.withGoogle();
                controller.isLogIn();
              },
              child: Container(
                height: Get.height * .07,
                padding: _insideButton(),
                decoration: _boxDecoration(),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: MyTheme.white,
                      child: SvgPicture.asset(AssetHelper.google),
                    ),
                    MyTheme.space(width: .21),
                    Text(
                      "Google",
                      style: MyTheme.poppinsBold(
                          color: MyTheme.white, fontSize: .024),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),

          MyTheme.space(height: .02),

          ///  SignIn With Phone Button
          Padding(
            padding: _buttonPadding(),
            child: InkWell(
              onTap: () async {
                showModalBottomSheet(
                    useSafeArea: true,
                    isScrollControlled: true,
                    context: context,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          height: Get.height * .5,
                          padding: _buttonPadding(),
                          child: Column(
                            children: [
                              MyTheme.space(height: .05),
                              Form(
                                key: controller.phoneFormKey,
                                child: IgnorePointer(
                                  ignoring: controller.isOtpSend.value,
                                  child: TextFormField(
                                    style: MyTheme.poppinsBold(fontSize: .024),
                                    controller: controller.phoneController,
                                    validator: controller.phoneValidator,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: "Phone Number",
                                      labelStyle: MyTheme.poppinsNormal(
                                          color: Colors.grey, fontSize: .020),
                                    ),
                                  ),
                                ),
                              ),
                              MyTheme.space(height: .03),
                              Obx(
                                () => controller.isOtpSend.isTrue
                                    ? Form(
                                        key: controller.otpFormKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Otp",
                                              style: MyTheme.poppinsNormal(
                                                  color: Colors.grey,
                                                  fontSize: .016),
                                            ),
                                            Pinput(
                                              listenForMultipleSmsOnAndroid:
                                                  true,
                                              validator:
                                                  controller.otpValidator,
                                              androidSmsAutofillMethod:
                                                  AndroidSmsAutofillMethod
                                                      .smsUserConsentApi,
                                              controller:
                                                  controller.otpController,
                                              keyboardType:
                                                  TextInputType.number,
                                              defaultPinTheme: PinTheme(
                                                  textStyle:
                                                      MyTheme.poppinsNormal(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black,
                                                          fontSize: .018),
                                                  height: Get.height * .075,
                                                  width: Get.width / 6 - 10,
                                                  decoration: BoxDecoration(
                                                      color: MyTheme.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      // boxShadow: [MyTheme.regularBoxShadow()],
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: Get.width *
                                                              .005))),
                                              errorPinTheme: PinTheme(
                                                  textStyle:
                                                      MyTheme.poppinsNormal(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black,
                                                          fontSize: .018),
                                                  height: Get.height * .075,
                                                  width: Get.width / 6 - 10,
                                                  decoration: BoxDecoration(
                                                      color: MyTheme.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      // boxShadow: [MyTheme.regularBoxShadow()],
                                                      border: Border.all(
                                                          color: Colors.red,
                                                          width: Get.width *
                                                              .005))),
                                              submittedPinTheme: PinTheme(
                                                  textStyle:
                                                      MyTheme.poppinsNormal(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black,
                                                          fontSize: .018),
                                                  height: Get.height * .075,
                                                  width: Get.width / 6 - 10,
                                                  decoration: BoxDecoration(
                                                      color: MyTheme.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      // boxShadow: [MyTheme.regularBoxShadow()],
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: Get.width *
                                                              .005))),
                                              focusedPinTheme: PinTheme(
                                                  textStyle:
                                                      MyTheme.poppinsNormal(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black,
                                                          fontSize: .018),
                                                  height: Get.height * .075,
                                                  width: Get.width / 6 - 10,
                                                  decoration: BoxDecoration(
                                                      color: MyTheme.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      // boxShadow: [MyTheme.regularBoxShadow()],
                                                      border: Border.all(
                                                          color: Colors.grey,
                                                          width: Get.width *
                                                              .005))),
                                              length: 6,
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                              MyTheme.space(height: .03),
                              InkWell(
                                onTap: () async {
                                  switch (controller.isOtpSend.value) {
                                    case true:
                                      if (controller.otpFormKey.currentState!
                                          .validate()) {
                                        await SignIn.verifyOtp(
                                            otp: controller.otpController.text);
                                        controller.isLogIn();
                                      }
                                    case false:
                                      if (controller.phoneFormKey.currentState!
                                          .validate()) {
                                        await SignIn.withPhoneNumber(
                                            phoneNumber: controller
                                                .phoneController.text);
                                        controller.isOtpSend.value = true;
                                      }
                                  }
                                },
                                child: Container(
                                  width: Get.width,
                                  height: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom ==
                                          0
                                      ? Get.height * .05
                                      : 0,
                                  decoration:
                                      _boxDecoration(color: Colors.green),
                                  child: Center(
                                    child: Text(
                                      "Submit",
                                      style: MyTheme.poppinsBold(
                                          color: MyTheme.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Container(
                height: Get.height * .07,
                padding: _insideButton(),
                decoration: _boxDecoration(color: Colors.green),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: MyTheme.white,
                    ),
                    MyTheme.space(width: .25),
                    Text(
                      "Phone",
                      style: MyTheme.poppinsBold(
                          color: MyTheme.white, fontSize: .024),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

BoxDecoration _boxDecoration({Color? color}) {
  return BoxDecoration(
      color: color ?? Colors.blue, borderRadius: BorderRadius.circular(60));
}

// Padding inside button
EdgeInsets _insideButton() {
  return MyTheme.symmetricPadding(width: .04, height: .01);
}

// Button Padding or padding between button and UI
EdgeInsets _buttonPadding() {
  return MyTheme.symmetricPadding(width: .05);
}
