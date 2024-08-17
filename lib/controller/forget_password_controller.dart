import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final NameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();

  void updatePassword() {
    // Implement the update profile logic here
  }

  @override
  void onClose() {
    NameC.dispose();
    emailC.dispose();
    phoneC.dispose();
    super.onClose();
  }
}
