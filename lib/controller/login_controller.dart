// import 'dart:async';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dontations_app/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:file_picker/file_picker.dart';

// class LoginController extends GetxController {
//   TextEditingController emailC = TextEditingController();
//   TextEditingController passC = TextEditingController();

//   void login() {
//     Get.offAllNamed(Routes.HOMESCREEN);
//   }

//   void goToSignUp() {
//     Get.toNamed(Routes.SIGNUPSCREEN);
//   }

//   void goToLogin() {
//     Get.toNamed(Routes.LOGIN);
//   }

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   var isLoading = false.obs;

//   // Sign up with phone number and password
//   Future<void> signUpWithPhoneAndPassword({
//     required String phoneNumber,
//     required String password,
//   }) async {
//     try {
//       isLoading.value = true;

//       // Create user with anonymous authentication (or another method)
//       UserCredential userCredential =
//           await _auth.createUserWithEmailAndPassword(
//         email:
//             '$phoneNumber@myapp.com', // Use phone number as part of the email
//         password: password,
//       );

//       User? user = userCredential.user;

//       if (user != null) {
//         // Save phone number and other details in Firestore
//         await _firestore.collection('users').doc(user.uid).set({
//           'phone': phoneNumber,
//           'password': password, // Store hashed password if necessary
//           'entryDate': DateTime.now().toLocal().toString(),
//           'userId': user.uid,
//         });

//         Get.snackbar('Success', 'User created successfully.');
//       }

//       isLoading.value = false;
//     } catch (e) {
//       isLoading.value = false;
//       Get.snackbar('Error', 'Failed to sign up: ${e.toString()}');
//     }
//   }

//   Future<void> loginWithPhoneAndPassword({
//     required String phoneNumber,
//     required String password,
//   }) async {
//     try {
//       isLoading.value = true;

//       // Query Firestore for the user with the matching phone number
//       QuerySnapshot querySnapshot = await _firestore
//           .collection('users')
//           .where('phone', isEqualTo: phoneNumber)
//           .limit(1)
//           .get();

//       if (querySnapshot.docs.isNotEmpty) {
//         // Assuming only one user will match
//         var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;

//         // Check if the password matches (consider hashing the password)
//         if (userData['password'] == password) {
//           Get.snackbar('Success', 'Logged in successfully.');
//           // Proceed to your app's home screen or dashboard
//         } else {
//           Get.snackbar('Error', 'Incorrect password.');
//         }
//       } else {
//         Get.snackbar('Error', 'No account found with this phone number.');
//       }

//       isLoading.value = false;
//     } catch (e) {
//       isLoading.value = false;
//       Get.snackbar('Error', 'Login failed: ${e.toString()}');
//     }
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dontations_app/routes/app_pages.dart';
// import 'package:dontations_app/widgets/custom_toast.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:crypto/crypto.dart';
// import 'dart:convert';
// import 'package:get_storage/get_storage.dart'; // Import GetStorage

// class LoginController extends GetxController {
//   TextEditingController emailC = TextEditingController();
//   TextEditingController passC = TextEditingController();

//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   final box = GetStorage(); // Create a storage box

//   var isLoading = false.obs;

//   // Function to hash passwords
//   String hashPassword(String password) {
//     var bytes = utf8.encode(password);
//     var digest = sha256.convert(bytes);
//     return digest.toString();
//   }

//   // Login with phone number and password
//   Future<void> loginWithPhoneAndPassword({
//     required String phoneNumber,
//     required String password,
//   }) async {
//     try {
//       if (phoneNumber.isEmpty || password.isEmpty) {
//         Get.snackbar('خطأ', 'رقم الهاتف وكلمة المرور لا يمكن أن يكونا فارغين.');
//         return;
//       }

//       isLoading.value = true;

//       // Fetch user data from Firestore
//       QuerySnapshot querySnapshot = await _firestore
//           .collection('users')
//           .where('phone', isEqualTo: phoneNumber)
//           .limit(1)
//           .get();

//       if (querySnapshot.docs.isNotEmpty) {
//         var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;

//         // Check if the hashed password matches
//         if (userData['password'] == hashPassword(password)) {
//           // Get username and role
//           String username = userData['username'];
//           String role = userData['role'];

//           // Store data in GetStorage
//           box.write('username', username);
//           box.write('role', role);
//           box.write('isLoggedIn', true);

//           Get.offAllNamed(Routes.HOMEDESKTOPSCREEN);
//         } else {
//           CustomToast.errorToast('كلمة المرور غير صحيحة.');
//         }
//       } else {
//         CustomToast.errorToast('لم يتم العثور على حساب بهذا الرقم.');
//       }

//       isLoading.value = false;
//     } catch (e) {
//       isLoading.value = false;
//       CustomToast.errorToast('فشل تسجيل الدخول: ${e.toString()}');
//     }
//   }

//   void goToLogin() {
//     Get.toNamed(Routes.LOGIN);
//   }

//   @override
//   void onClose() {
//     emailC.dispose();
//     passC.dispose();
//     super.onClose();
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dontations_app/routes/app_pages.dart';
import 'package:dontations_app/widgets/custom_toast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final box = GetStorage(); // Create a storage box

  var isLoading = false.obs;

  // Function to hash passwords
  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  // Login with phone number and password
  Future<void> loginWithPhoneAndPassword({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      if (phoneNumber.isEmpty || password.isEmpty) {
        Get.snackbar('خطأ', 'رقم الهاتف وكلمة المرور لا يمكن أن يكونا فارغين.');
        return;
      }

      isLoading.value = true;

      // Fetch user data from Firestore
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('phone', isEqualTo: phoneNumber)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;

        // Check if the hashed password matches
        if (userData['password'] == hashPassword(password)) {
          // Get username and role
          String username = userData['username'];
          String role = userData['role'];

          // Store data in GetStorage
          box.write('username', username);
          box.write('role', role);
          box.write('isLoggedIn', true);

          // Navigate based on user role
          navigateToRoleBasedScreen(role);
        } else {
          CustomToast.errorToast('كلمة المرور غير صحيحة.');
        }
      } else {
        CustomToast.errorToast('لم يتم العثور على حساب بهذا الرقم.');
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      CustomToast.errorToast('فشل تسجيل الدخول: ${e.toString()}');
    }
  }

  // Navigate to different screens based on the user's role
  void navigateToRoleBasedScreen(String role) {
    switch (role) {
      case 'إدارة العمل الخيري':
        Get.offAllNamed(Routes
            .HOMEDESKTOPSCREEN); // Replace with your donation management screen route
        break;
      case 'المحاسب':
        Get.offAllNamed(Routes
            .ACCOUNTANT_HOMESCREEN); // Replace with your accountant screen route
        break;
      // case 'إدارة المشاريع':
      //   Get.offAllNamed(Routes
      //       .PROJECT_MANAGEMENT_HOMESCREEN); // Replace with your project management screen route
      //   break;
      case 'موظف':
        Get.offAllNamed(Routes
            .RECEPTION_HOMESCREEN); // Replace with your employee screen route
        break;
      default:
        Get.offAllNamed(
            Routes.HOMEDESKTOPSCREEN); // Default screen for unknown roles
        break;
    }
  }

  void goToLogin() {
    Get.toNamed(Routes.LOGIN);
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}
