import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  final NameC = TextEditingController();
  final emailC = TextEditingController();
  final phoneC = TextEditingController();

  void updateProfile() {
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
