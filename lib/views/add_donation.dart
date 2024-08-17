import 'package:dontations_app/controller/add_newDonation_controller.dart';
import 'package:dontations_app/controller/manageUser_controller.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/style/images.dart';
import 'package:dontations_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AddDonationScreen extends GetView<AddNewConstructionDonationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        iconTheme: IconThemeData(color: AppColor.buttonColor),
        title: Text(
          "إضافة تبرع".tr,
          style: robotoHugeWhite,
        ),
        centerTitle: true,
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
                        CustomInput(
                          controller: controller.nameC,
                          label: "إسم المتبرع".tr,
                          hint: "",
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IntlPhoneField(
                            controller: controller.phoneC,
                            decoration: InputDecoration(
                              labelText: 'رقم الهاتف'.tr,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            initialCountryCode: 'KW', // Initial country code
                            onChanged: (phone) {},
                          ),
                        ),
                        CustomInput(
                          controller: controller.addressC,
                          label: "العنوان".tr,
                          hint: "",
                        ),
                        CustomInput(
                          controller: controller.emailC,
                          label: "البريد الالكتروني".tr,
                          hint: "",
                        ),
                        CustomInput(
                          controller: controller.projectTypeC,
                          label: 'نوع المشروع'.tr,
                          hint: '',
                        ),
                        CustomInput(
                          controller: controller.projectNameC,
                          label: "إسم المشروع".tr,
                          hint: "",
                        ),
                        CustomInput(
                          controller: controller.projectValueC,
                          label: "قيمة المشروع".tr,
                          hint: "",
                        ),
                        CustomInput(
                          controller: controller.locationC,
                          label: "المكان".tr,
                          hint: "",
                        ),
                        CustomInput(
                          controller: controller.buildingDetailsC,
                          label: "تفاصيل البناء".tr,
                          hint: "",
                        ),
                        CustomInput(
                          controller: controller.beneficiariesC,
                          label: "عدد المستفيدين".tr,
                          hint: "",
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.addDonation();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.buttonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                              ),
                              child: Text(
                                "إضافة".tr,
                                style: robotoHugeWhite,
                              ),
                            ),
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
    );
  }
}
