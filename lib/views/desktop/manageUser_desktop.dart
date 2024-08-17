import 'package:dontations_app/controller/manageUser_controller.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/style/images.dart';
import 'package:dontations_app/widgets/custom_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ManageUserDesktopScreen extends GetView<ManageUserController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: Text(
          "المستخدمين".tr,
          style: robotoHugeWhite,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                        Row(
                          children: [
                            Expanded(
                              child: CustomInput(
                                controller: controller.NameC,
                                label: "الاسم".tr,
                                hint: "",
                              ),
                            ),
                            Expanded(
                              child: CustomInput(
                                controller: controller.phoneC,
                                label: "رقم الهاتف".tr,
                                hint: "",
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomInput(
                                controller: controller.passC,
                                label: 'كلمة المرور'.tr,
                                hint: '',
                                obscureText: true,
                              ),
                            ),
                            Expanded(
                              child: Obx(() {
                                return DropdownButton<String>(
                                  value: controller.selectedRole.value.isEmpty
                                      ? null
                                      : controller.selectedRole.value,
                                  hint: Text("اختر نوع المستخدم".tr),
                                  onChanged: (newValue) {
                                    controller.selectedRole.value = newValue!;
                                  },
                                  items: controller.roles.map((role) {
                                    return DropdownMenuItem<String>(
                                      value: role,
                                      child: Text(role),
                                    );
                                  }).toList(),
                                );
                              }),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(() {
                            return ElevatedButton(
                              onPressed: controller.isLoading.value
                                  ? null
                                  : () {
                                      controller.signUpWithPhoneAndPassword();
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 160, vertical: 15),
                              ),
                              child: controller.isLoading.value
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "إضافة".tr,
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Divider(),
            Text(
              "قائمة المستخدمين".tr,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Obx(() {
              if (controller.isLoading.value) {
                return CircularProgressIndicator();
              }

              if (controller.users.isEmpty) {
                return Text("لا توجد بيانات ".tr);
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.users.length,
                itemBuilder: (context, index) {
                  final user = controller.users[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          title: Text(user['name']),
                          subtitle: Text("${user['phone']} - ${user['role']}"),
                          trailing: Icon(
                            Icons.edit,
                            color: AppColor.buttonColor,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
