import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ManageUserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var NameC = TextEditingController();
  var phoneC = TextEditingController();
  var passC = TextEditingController();
  var selectedRole = ''.obs;
  var isLoading = false.obs;
  String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  var users = [].obs; // List to store users

  final List<String> roles = [
    'إدارة المشاريع',
    'إدارة العمل الخيري',
    'محاسب',
    'متبرع',
  ];

  @override
  void onInit() {
    super.onInit();
    fetchUsers(); // Fetch users when the controller is initialized
  }

  @override
  void onClose() {
    NameC.dispose();
    phoneC.dispose();
    passC.dispose();
    super.onClose();
  }

  Future<void> signUpWithPhoneAndPassword() async {
    if (selectedRole.value.isEmpty) {
      Get.snackbar('خطأ', 'الرجاء اختيار دور المستخدم.');
      return;
    }

    try {
      isLoading.value = true;

      // Check if the phone number is already registered
      QuerySnapshot existingUser = await _firestore
          .collection('users')
          .where('phone', isEqualTo: phoneC.text)
          .get();

      if (existingUser.docs.isNotEmpty) {
        Get.snackbar('خطأ', 'رقم الهاتف مسجل مسبقًا.');
        isLoading.value = false;
        return;
      }

      // Create user with anonymous authentication (or another method)
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email:
            '${phoneC.text}@myapp.com', // Use phone number as part of the email
        password: passC.text,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Save phone number and other details in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'name': NameC.text,
          'phone': phoneC.text,
          'password': passC.text, // Consider hashing the password
          'entryDate': formattedDate,
          'userId': user.uid,
          'role': selectedRole.value,
        });

        Get.snackbar('نجاح', 'تم إنشاء المستخدم بنجاح.');
        fetchUsers(); // Refresh the user list after adding a new user
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('خطأ', 'فشل في التسجيل: ${e.toString()}');
    }
  }

  void fetchUsers() async {
    try {
      isLoading.value = true;

      QuerySnapshot querySnapshot = await _firestore.collection('users').get();
      users.value = querySnapshot.docs.map((doc) => doc.data()).toList();

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('خطأ', 'فشل في جلب المستخدمين: ${e.toString()}');
    }
  }
}
