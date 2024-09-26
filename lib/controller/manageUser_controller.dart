import 'dart:convert';
import 'package:crypto/crypto.dart'; // Import the crypto package for hashing
import 'package:dontations_app/widgets/custom_toast.dart';
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

  // Function to hash the password using SHA-256
  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> signUpWithPhoneAndPassword() async {
    if (selectedRole.value.isEmpty) {
      CustomToast.errorToast('الرجاء اختيار دور المستخدم.');
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
        CustomToast.errorToast('رقم الهاتف مسجل مسبقًا.');
        isLoading.value = false;
        return;
      }

      // Hash the password before storing it
      String hashedPassword = hashPassword(passC.text);

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
          'password': hashedPassword, // Store hashed password
          'entryDate': formattedDate,
          'userId': user.uid,
          'role': selectedRole.value,
        });

        CustomToast.successToast('تم إنشاء المستخدم بنجاح.');
        fetchUsers(); // Refresh the user list after adding a new user
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      CustomToast.errorToast('فشل في التسجيل: ${e.toString()}');
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
      CustomToast.errorToast('فشل في جلب المستخدمين: ${e.toString()}');
    }
  }
}
