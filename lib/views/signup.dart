import 'package:dontations_app/controller/manageUser_controller.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/style/images.dart';
import 'package:dontations_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

// class SignUpScreen extends GetView<AddUserController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           // backgroundColor: Colors.black,
//           // iconTheme: IconThemeData(color: AppColor.whiteColor),
//           // title: Text(
//           //   "إنشاء حساب".tr,
//           //   style: robotoMediumWhite,
//           // ),
//           // centerTitle: true,
//           ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               child: Image.asset(Images.logo),
//             ),
//             Text(
//               "إنشاء حساب".tr,
//               style: robotoHugeBlack,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 child: ListTile(
//                   tileColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(22.0),
//                   ),
//                   contentPadding: EdgeInsets.all(12.0),
//                   subtitle: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         CustomInput(
//                           controller: controller.NameC,
//                           label: "الاسم".tr,
//                           hint: "",
//                         ),
//                         CustomInput(
//                           controller: controller.passC,
//                           label: 'كلمة المرور'.tr,
//                           hint: '',
//                           obscureText: true,
//                         ),
//                         CustomInput(
//                           controller: controller.emailC,
//                           label: "الايميل الالكتروني".tr,
//                           hint: "",
//                         ),
//                         CustomInput(
//                           controller: controller.NameC,
//                           label: "العمر".tr,
//                           hint: "",
//                         ),
//                         // Padding(
//                         //   padding: const EdgeInsets.all(8.0),
//                         //   child: IntlPhoneField(
//                         //     controller: controller.phoneC,
//                         //     decoration: InputDecoration(
//                         //       labelText: 'phone_number'.tr,
//                         //       border: OutlineInputBorder(
//                         //         borderRadius: BorderRadius.circular(12.0),
//                         //       ),
//                         //     ),
//                         //     initialCountryCode: 'SA', // Initial country code
//                         //     onChanged: (phone) {},
//                         //   ),
//                         // ),

//                         // CustomInput(
//                         //   controller: controller.confirmPassC,
//                         //   label: 'confirm_password'.tr,
//                         //   hint: '',
//                         //   obscureText: true,
//                         // ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 controller.signUp();
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: AppColor.blackColor,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 30, vertical: 10),
//                               ),
//                               child: Text(
//                                 "تسجيل".tr,
//                                 style: robotoHugeWhite,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
