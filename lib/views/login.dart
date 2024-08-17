import 'package:dontations_app/controller/login_controller.dart';
import 'package:dontations_app/routes/app_pages.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/style/images.dart';
import 'package:dontations_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: Image.asset(Images.logo),
              ),
              Center(
                child: Text("تسجيل الدخول".tr,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: ListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    contentPadding: EdgeInsets.all(12.0),
                    subtitle: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomInput(
                            controller: controller.emailC,
                            label: "الايميل",
                            hint: "",
                          ),
                          CustomInput(
                            controller: controller.passC,
                            label: 'كلمة المرور',
                            hint: '',
                            obscureText: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.login();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.blackColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                ),
                                child: Text(
                                  "تسجيل".tr,
                                  style: robotoHugeWhite,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.toNamed(Routes.ADMINHOMESCREEN);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.blackColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                ),
                                child: Text(
                                  "مدير".tr,
                                  style: robotoHugeWhite,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.goToSignUp();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.blackColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 10),
                                ),
                                child: Text(
                                  "لا تمتلك حساب؟ إنشاء حساب",
                                  style: robotoHugeWhite,
                                ),
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (!controller.isLoading.value) {
                                controller.signUpWithPhoneAndPassword(
                                  phoneNumber: '7300150012',
                                  password: '123456',
                                );
                              }
                            },
                            child: Obx(() => controller.isLoading.value
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text("Sign Up")),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 15),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Get.toNamed(Routes.FORGETPASSWORDSCREEN);
                              },
                              child: Text(
                                "هل نسيت كلمة المرور؟",
                                style: robotoMediumBold,
                              )),
                          ElevatedButton(
                            onPressed: () {
                              if (!controller.isLoading.value) {
                                controller.loginWithPhoneAndPassword(
                                  phoneNumber: '730010012',
                                  password: 'yourpassword',
                                );
                              }
                            },
                            child: Obx(() => controller.isLoading.value
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text("Login")),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
