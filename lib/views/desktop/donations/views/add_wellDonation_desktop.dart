import 'package:dontations_app/controller/add_wellDonation_controller.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/widgets/custom_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class AddWellDonationDesktopScreen extends GetView<AddWellDonationController> {
  // final String projectName = Get.arguments;
  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        iconTheme: IconThemeData(color: AppColor.whiteColor),
        title: Text(
          "إضافة تبرع ${controller.countryName}".tr,
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
                    CustomInput(
                      controller: controller.projectNameC,
                      label: "إسم المشروع".tr,
                      hint: "",
                    ),

                    SizedBox(height: 20.0),
                    isSmallScreen
                        ? Column(
                            children: _buildResponsiveInputsForSmallScreen(),
                          )
                        : Row(
                            children: _buildResponsiveInputsForLargeScreen(),
                          ),
                    SizedBox(height: 20.0),

                    isSmallScreen
                        ? Column(
                            children: _buildResponsiveDropdownsForSmallScreen(),
                          )
                        : Row(
                            children: _buildResponsiveDropdownsForLargeScreen(),
                          ),
                    SizedBox(height: 20.0),
                    isSmallScreen
                        ? Obx(() {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical:
                                      8), // Add some margin to float the container
                              padding: EdgeInsets.all(
                                  16), // Add padding inside the container
                              decoration: BoxDecoration(
                                color: Colors.white, // White background color
                                borderRadius: BorderRadius.circular(
                                    12), // Rounded corners
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                        0.1), // Slight shadow color
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                    offset: Offset(0, 3), // Shadow position
                                  ),
                                ],
                              ),
                              child: Column(
                                children:
                                    _buildBenefandDurationForSmallScreen(),
                              ),
                            );
                          })
                        : Obx(
                            () {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical:
                                        8), // Add some margin to float the container
                                padding: EdgeInsets.all(
                                    16), // Add padding inside the container
                                decoration: BoxDecoration(
                                  color: Colors.white, // White background color
                                  borderRadius: BorderRadius.circular(
                                      12), // Rounded corners
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(
                                          0.1), // Slight shadow color
                                      spreadRadius: 2,
                                      blurRadius: 6,
                                      offset: Offset(0, 3), // Shadow position
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children:
                                          _buildBenefandDurationForLargeScreen(),
                                    ),
                                    SizedBox(height: 20.0),
                                    Row(
                                      children:
                                          _buildDetailsAndFacilitiesForLargeScreen(),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                    // SizedBox(height: 20.0),
                    // isSmallScreen
                    //     ? SizedBox()
                    //     : Row(
                    //         children:
                    //             _buildDetailsAndFacilitiesForLargeScreen(),
                    //       ),
                    SizedBox(height: 30.0),
                    Center(
                      child: SizedBox(
                        width: 400,
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

  List<Widget> _buildResponsiveInputsForSmallScreen() {
    return [
      CustomInput(
        controller: controller.nameC,
        label: "إسم المتبرع".tr,
        hint: "",
      ),
      SizedBox(height: 20.0),
      IntlPhoneField(
        languageCode: "ar",
        controller: controller.phoneC,
        decoration: InputDecoration(
          labelText: 'رقم الهاتف'.tr,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        initialCountryCode: 'KW',
        onChanged: (phone) {},
      ),
      SizedBox(height: 20.0),
      CustomInput(
        controller: controller.addressC,
        label: "العنوان".tr,
        hint: "",
      ),
      SizedBox(height: 20.0),
      CustomInput(
        controller: controller.emailC,
        label: "البريد الالكتروني".tr,
        hint: "",
      ),
    ];
  }

  List<Widget> _buildResponsiveInputsForLargeScreen() {
    return [
      Expanded(
        child: CustomInput(
          controller: controller.nameC,
          label: "إسم المتبرع".tr,
          hint: "",
        ),
      ),
      SizedBox(width: 20.0),
      Expanded(
        child: IntlPhoneField(
          languageCode: "ar",
          controller: controller.phoneC,
          decoration: InputDecoration(
            labelText: 'رقم الهاتف'.tr,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          initialCountryCode: 'KW',
          onChanged: (phone) {},
        ),
      ),
      SizedBox(width: 20.0),
      Expanded(
        child: CustomInput(
          controller: controller.addressC,
          label: "العنوان".tr,
          hint: "",
        ),
      ),
      SizedBox(width: 20.0),
      Expanded(
        child: CustomInput(
          controller: controller.emailC,
          label: "البريد الالكتروني".tr,
          hint: "",
        ),
      ),
    ];
  }

  List<Widget> _buildResponsiveDropdownsForSmallScreen() {
    return [
      CustomInput(
        controller: controller.donationAmountC,
        label: "مبلغ التبرع".tr,
        hint: "",
        keyboardType: TextInputType.number,
        disabled: true,
      ),
      SizedBox(height: 20.0),
      Obx(() {
        // Ensure the dropdown is updated when arenas or selectedArena changes
        return DropdownButtonFormField<String>(
          value: controller.selectedArena.value.isNotEmpty
              ? controller.selectedArena.value
              : null,
          items: controller.arenas.map((arena) {
            return DropdownMenuItem<String>(
              value: arena,
              child: Text(arena),
            );
          }).toList(),
          onChanged: (newValue) {
            controller.selectedArena.value = newValue!;
            controller.fetchExecutionPeriod();
          },
          decoration: InputDecoration(
            labelText: "العمق".tr,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        );
      }),
      SizedBox(height: 20.0),
      // Obx(
      //   () => DropdownButtonFormField<String>(
      //     value: controller.selectedAgent.value.isNotEmpty
      //         ? controller.selectedAgent.value
      //         : null, // Set the initial value to null to avoid pre-selecting
      //     items: controller.agents.map((agent) {
      //       return DropdownMenuItem(
      //         value: agent,
      //         child: Text(agent),
      //       );
      //     }).toList(),
      //     onChanged: (value) {
      //       controller.selectedAgent.value = value!;
      //     },
      //     decoration: InputDecoration(
      //       labelText: "الجهة المنفذة".tr,
      //       border: OutlineInputBorder(
      //         borderRadius: BorderRadius.circular(12.0),
      //       ),
      //     ),
      //   ),
      // )
    ];
  }

  List<Widget> _buildResponsiveDropdownsForLargeScreen() {
    return [
      Expanded(
        child: CustomInput(
          controller: controller.donationAmountC,
          label: "مبلغ التبرع".tr,
          hint: "",
          keyboardType: TextInputType.number,
          disabled: true,
        ),
      ),
      SizedBox(width: 15.0),
      Expanded(
        child: Obx(() {
          // Ensure the dropdown is updated when arenas or selectedArena changes
          return DropdownButtonFormField<String>(
            value: controller.selectedArena.value.isNotEmpty
                ? controller.selectedArena.value
                : null,
            items: controller.arenas.map((arena) {
              return DropdownMenuItem<String>(
                value: arena,
                child: Text(arena),
              );
            }).toList(),
            onChanged: (newValue) {
              controller.selectedArena.value = newValue!;
              controller.fetchExecutionPeriod();
            },
            decoration: InputDecoration(
              labelText: "العمق".tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          );
        }),
      ),
      SizedBox(width: 15.0),
      // Expanded(
      //     child: Obx(
      //   () => DropdownButtonFormField<String>(
      //     value: controller.selectedAgent.value.isNotEmpty
      //         ? controller.selectedAgent.value
      //         : null, // Set the initial value to null to avoid pre-selecting
      //     items: controller.agents.map((agent) {
      //       return DropdownMenuItem(
      //         value: agent,
      //         child: Text(agent),
      //       );
      //     }).toList(),
      //     onChanged: (value) {
      //       controller.selectedAgent.value = value!;
      //     },
      //     decoration: InputDecoration(
      //       labelText: "الجهة المنفذة".tr,
      //       border: OutlineInputBorder(
      //         borderRadius: BorderRadius.circular(12.0),
      //       ),
      //     ),
      //   ),
      // ))
    ];
  }

  List<Widget> _buildBenefandDurationForSmallScreen() {
    return [
      ListTile(
        title: Text(
          "مدة التنفيذ",
          style: robotoAppColor,
        ),
        subtitle: Text(
          '${controller.executionPeriodC.value}',
          style: robotoButtonColor,
        ),
      ),
      Divider(
        color: AppColor.buttonColor,
        height: 2,
      ),
      ListTile(
        title: Text(
          "عدد المستفيدين",
          style: robotoAppColor,
        ),
        subtitle: Text(
          '${controller.beneficiaries.value}',
          style: robotoButtonColor,
        ),
      ),
      Divider(
        color: AppColor.buttonColor,
        height: 2,
      ),
      ListTile(
        title: Text(
          "التكلفة",
          style: robotoAppColor,
        ),
        subtitle: Text(
          '${controller.cost.value}',
          style: robotoButtonColor,
        ),
      ),
      Divider(
        color: AppColor.buttonColor,
        height: 2,
      ),
      ListTile(
        title: Text(
          "مواصفات البئر",
          style: robotoAppColor,
        ),
        subtitle: Text(
          '${controller.buildingDetails.value}',
          style: robotoButtonColor,
        ),
      ),
      Divider(
        color: AppColor.buttonColor,
        height: 2,
      ),
      ListTile(
        title: Text(
          "مرافق البئر",
          style: robotoAppColor,
        ),
        subtitle: Text(
          '${controller.facilities.value}',
          style: robotoButtonColor,
        ),
      ),
    ];
  }

  List<Widget> _buildBenefandDurationForLargeScreen() {
    return [
      Expanded(
        child: ListTile(
          title: Text(
            "مدة التنفيذ",
            style: robotoAppColor,
          ),
          subtitle: Text(
            '${controller.executionPeriodC.value}',
            style: robotoButtonColor,
          ),
        ),
      ),
      Container(
        height: 60,
        width: 3,
        color: AppColor.buttonColor,
      ),
      Expanded(
        child: ListTile(
          title: Text(
            "عدد المستفيدين",
            style: robotoAppColor,
          ),
          subtitle: Text(
            '${controller.beneficiaries.value}',
            style: robotoButtonColor,
          ),
        ),
      ),
      Container(
        height: 60,
        width: 3,
        color: AppColor.buttonColor,
      ),
      Expanded(
        child: ListTile(
          title: Text(
            "التكلفة",
            style: robotoAppColor,
          ),
          subtitle: Text(
            '${controller.cost.value}',
            style: robotoButtonColor,
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildDetailsAndFacilitiesForLargeScreen() {
    return [
      Expanded(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: AppColor.buttonColor)),
          child: ListTile(
            title: Text(
              "مواصفات البئر",
              style: robotoAppColor,
            ),
            subtitle: Text(
              '${controller.buildingDetails.value}',
              style: robotoButtonColor,
            ),
          ),
        ),
      ),
      SizedBox(
        width: 5,
      ),
      Expanded(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              border: Border.all(color: AppColor.buttonColor)),
          child: ListTile(
            title: Text(
              "مرافق البئر",
              style: robotoAppColor,
            ),
            subtitle: Text(
              '${controller.facilities.value}',
              style: robotoButtonColor,
            ),
          ),
        ),
      ),
    ];
  }
}
