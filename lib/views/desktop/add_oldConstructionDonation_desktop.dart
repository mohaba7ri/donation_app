import 'package:dontations_app/controller/add_musqeDonation_controller.dart';
import 'package:dontations_app/controller/manage_mosqProject_controller.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AddOldConstructionDonationDesktopScreen
    extends GetView<ManageMosqProjectController> {
  final String projectName = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        iconTheme: IconThemeData(color: AppColor.whiteColor),
        title: Text(
          "إضافة متبرع للمشروع ($projectName)".tr,
          style: robotoHugeWhite,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "بيانات التبرع".tr,
                      style: robotoHugeBlack,
                    ),
                    SizedBox(height: 20.0),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: CustomInput(
                    //         controller: controller.nameC,
                    //         label: "إسم المتبرع".tr,
                    //         hint: "",
                    //       ),
                    //     ),
                    //     SizedBox(width: 20.0),
                    //     Expanded(
                    //       child: IntlPhoneField(
                    //         languageCode: "ar",
                    //         controller: controller.phoneC,
                    //         decoration: InputDecoration(
                    //           labelText: 'رقم الهاتف'.tr,
                    //           border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(12.0),
                    //           ),
                    //         ),
                    //         initialCountryCode: 'KW',
                    //         onChanged: (phone) {},
                    //       ),
                    //     ),
                    //     Expanded(
                    //       child: CustomInput(
                    //         controller: controller.addressC,
                    //         label: "العنوان".tr,
                    //         hint: "",
                    //       ),
                    //     ),
                    //     SizedBox(width: 20.0),
                    //     Expanded(
                    //       child: CustomInput(
                    //         controller: controller.emailC,
                    //         label: "البريد الالكتروني".tr,
                    //         hint: "",
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 20.0),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: CustomInput(
                    //         controller: controller.addressC,
                    //         label: "العنوان".tr,
                    //         hint: "",
                    //       ),
                    //     ),
                    //     SizedBox(width: 20.0),
                    //     Expanded(
                    //       child: CustomInput(
                    //         controller: controller.emailC,
                    //         label: "البريد الالكتروني".tr,
                    //         hint: "",
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 20.0),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: CustomInput(
                    //         controller: controller.projectNameC,
                    //         label: "إسم المشروع".tr,
                    //         hint: "",
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: CustomInput(
                            controller: controller.buildingDetailsC,
                            label: "مبلغ التبرع".tr,
                            hint: "",
                          ),
                        ),
                        Expanded(
                          child: CustomInput(
                            controller: controller.arenaC,
                            label: "المساحة".tr,
                            hint: "",
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(height: 20.0),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: CustomInput(
                    //         controller: controller.projectValueC,
                    //         label: "قيمة المشروع".tr,
                    //         hint: "",
                    //       ),
                    //     ),
                    //     SizedBox(width: 20.0),
                    //     Expanded(
                    //       child: CustomInput(
                    //         controller: controller.locationC,
                    //         label: "المكان".tr,
                    //         hint: "",
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        // Expanded(
                        //   child: CustomInput(
                        //     controller: controller.buildingDetailsC,
                        //     label: "تفاصيل البناء".tr,
                        //     hint: "",
                        //   ),
                        // ),
                        Expanded(
                          child: CustomInput(
                            controller: controller.projectValueC,
                            label: "قيمة المشروع".tr,
                            hint: "",
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
                          child: CustomInput(
                            controller: controller.locationC,
                            label: "المكان".tr,
                            hint: "",
                          ),
                        ),
                        Expanded(
                          child: CustomInput(
                            controller: controller.beneficiariesC,
                            label: "عدد المستفيدين".tr,
                            hint: "",
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
                          child: CustomInput(
                            controller: controller.executionPeriodC,
                            label: "مدة التنفيذ".tr,
                            hint: "",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: CustomInput(
                            controller: controller.zincCostC,
                            label: "تكلفة الزنك".tr,
                            hint: "",
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
                          child: CustomInput(
                            controller: controller.concreteCostC,
                            label: "تكلفة الخرسانة".tr,
                            hint: "",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.buildingDetailsC,
                            maxLines:
                                null, // This allows the text field to expand vertically as the user types
                            decoration: InputDecoration(
                              labelText: "تفاصيل البناء",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
                          child: TextFormField(
                            controller: controller.facilitiesC,
                            maxLines:
                                null, // This allows the text field to expand vertically as the user types
                            decoration: InputDecoration(
                              labelText: "المرافق",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Center(
                      child: SizedBox(
                        width: 400,
                        child: ElevatedButton(
                          onPressed: () {
                            // controller.add();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
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
      ),
    );
  }
}
