import 'package:dontations_app/controller/add_musqeDonation_controller.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/views/desktop/donations/util/printForDonor.dart';
import 'package:dontations_app/views/desktop/donations/views/print_test_screen.dart';
import 'package:dontations_app/widgets/custom_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'dart:html' as html;

import '../util/pdf_service.dart';
import 'package:intl/intl.dart';

class AddNewConstructionDonation2DesktopScreen
    extends GetView<AddMusqeDonationController> {
  // final String projectName = Get.arguments;
  // final PdfService pdfService = PdfService();
  PrintForDonor pdfService = PrintForDonor();
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
          "إضافة تبرع ${controller.projectType}".tr,
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
                    CustomInput(
                      controller: controller.projectNameC,
                      label: "إسم المشروع".tr,
                      hint: "",
                    ),
                    isSmallScreen
                        ? Column(
                            children: _buildResponsiveInputsForSmallScreen(),
                          )
                        : Row(
                            children: _buildResponsiveInputsForLargeScreen(),
                          ),
                    SizedBox(height: 20.0),
                    // isSmallScreen
                    //     ? Column(
                    //         children:
                    //             _buildResponsiveTextFieldsForSmallScreen(),
                    //       )
                    //     : Row(
                    //         children:
                    //             _buildResponsiveTextFieldsForLargeScreen(),
                    //       ),
                    // SizedBox(height: 20.0),
                    isSmallScreen
                        ? Column(
                            children: _buildResponsiveDropdownsForSmallScreen(),
                          )
                        : Row(
                            children: _buildResponsiveDropdownsForLargeScreen(),
                          ),
                    SizedBox(height: 10.0),
                    // Obx(
                    //   () => DropdownButtonFormField<String>(
                    //     value: controller.agents
                    //             .contains(controller.selectedAgent.value)
                    //         ? controller.selectedAgent.value
                    //         : null, // Ensure the selected value is valid; otherwise, set to null
                    //     items: controller.agents.map((agent) {
                    //       return DropdownMenuItem(
                    //         value: agent,
                    //         child: Text(agent),
                    //       );
                    //     }).toList(),
                    //     onChanged: (value) {
                    //       controller.selectedAgent.value =
                    //           value ?? ''; // Update the selected value or reset
                    //     },
                    //     decoration: InputDecoration(
                    //       labelText: "الجهة المنفذة".tr,
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(12.0),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Obx(
                      () {
                        // Check if the user's role is "إدارة العمل الخيري"
                        if (controller.role.value == "إدارة العمل الخيري") {
                          return DropdownButtonFormField<String>(
                            value: controller.agents
                                    .contains(controller.selectedAgent.value)
                                ? controller.selectedAgent.value
                                : null, // Ensure the selected value is valid; otherwise, set to null
                            items: controller.agents.map((agent) {
                              return DropdownMenuItem(
                                value: agent,
                                child: Text(agent),
                              );
                            }).toList(),
                            onChanged: (value) {
                              controller.selectedAgent.value = value ??
                                  ''; // Update the selected value or reset
                            },
                            decoration: InputDecoration(
                              labelText: "الجهة المنفذة".tr,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          );
                        } else {
                          // Return an empty Container or a SizedBox if the role doesn't match
                          return SizedBox.shrink();
                        }
                      },
                    ),

                    SizedBox(height: 10.0),
                    buildCostSelection(
                      zincCost: controller.zincCost.value ?? 'f',
                      concreteCost: controller.concreteCost.value ?? 'sss',
                      compareCost: controller.combinedCost.value ?? 'dddd',
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
                          onPressed: () async {
                            controller.addDonation();
                            final now = DateTime.now();
                            final formattedDate =
                                DateFormat('dd/MM/yyyy').format(now);

                            controller.getClosestCost(
                                controller.donationAmountC.text);

                            final pdf = await pdfService.generatePdf(
                              donorName: controller.nameC.text,
                              address: controller.addressC.text,
                              phoneNumber: controller.phoneC.text,
                              email: controller.emailC.text,
                              contryName: controller.countryName,
                              beneficiaries: controller.beneficiaries.value,
                              donationAmount: controller.donationAmountC.text,
                              // beneficiaries: controller.arenas,
                              projectType: controller.projectType,

                              selectedArena: controller.selectedArena.value,
                              projectName: controller.projectNameC.text,
                              date: formattedDate,
                            );

                            if (!kIsWeb) {
                              // For non-web platforms, save the PDF to the device
                              final bytes = await pdf.save();
                              // Implement your file saving logic here (e.g., using a file system package)
                              // Example for desktop or mobile:
                              // final file = File('example_report.pdf');
                              // await file.writeAsBytes(bytes);
                            } else {
                              // For web, create a Blob and trigger a download
                              final bytes = await pdf.save();
                              final blob =
                                  html.Blob([bytes], 'application/pdf');
                              final url =
                                  html.Url.createObjectUrlFromBlob(blob);
                              final anchor = html.AnchorElement(href: url)
                                ..setAttribute('download',
                                    '${controller.nameC.text} وثيقة تبرع.pdf')
                                ..click();
                              html.Url.revokeObjectUrl(url);
                            }
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

  Widget buildCostSelection({
    required String zincCost,
    required String concreteCost,
    required String compareCost,
  }) {
    // Determine if radio buttons should be shown
    bool showRadioButtons = zincCost.isNotEmpty && concreteCost.isNotEmpty;

    // If no specific cost type is selected, default to compareCost
    controller.updateSelectedCost(
        showRadioButtons ? null : compareCost, compareCost);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('إعتماد قيمة',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        if (showRadioButtons) // Show radio buttons only if both costs are available
          Row(
            children: [
              // Radio button for "تكلفة الزنك"
              Obx(
                () => Radio<String>(
                  value: zincCost,
                  groupValue: controller.selectedCostType.value,
                  onChanged: (value) {
                    controller.updateSelectedCost(value, compareCost);
                    controller.selectedCostType.value = value ?? '';
                  },
                ),
              ),
              Text('تكلفة الزنك', style: TextStyle(fontSize: 14)),

              // Radio button for "تكلفة الخرسانة"
              Obx(
                () => Radio<String>(
                  value: concreteCost,
                  groupValue: controller.selectedCostType.value,
                  onChanged: (value) {
                    controller.updateSelectedCost(value, compareCost);
                    controller.selectedCostType.value = value ?? '';
                  },
                ),
              ),
              Text('تكلفة الخرسانة', style: TextStyle(fontSize: 14)),
            ],
          ),

        // Display the currently combined cost
        // Obx(
        //   () => Text(
        //     'التكلفة: ${controller.combinedCost.value}',
        //     style: TextStyle(fontSize: 14, color: Colors.grey),
        //   ),
        // ),
      ],
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
      CustomInput(
        controller: controller.emailC,
        label: "رقم الكي نت".tr,
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
      SizedBox(width: 20.0),
      Expanded(
        child: CustomInput(
          controller: controller.emailC,
          label: "رقم الكي نت".tr,
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
            labelText: "المساحة".tr,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        );
      }),
      SizedBox(height: 20.0),
      // DropdownButtonFormField<String>(
      //   value: controller.selectedAmountRange.value.isNotEmpty
      //       ? controller.selectedAmountRange.value
      //       : controller.amountRanges.first,
      //   items: controller.amountRanges.map((range) {
      //     return DropdownMenuItem(
      //       value: range,
      //       child: Text(range),
      //     );
      //   }).toList(),
      //   onChanged: (value) {
      //     controller.selectedAmountRange.value = value!;
      //   },
      //   decoration: InputDecoration(
      //     labelText: "مدى المبلغ".tr,
      //     border: OutlineInputBorder(
      //       borderRadius: BorderRadius.circular(12.0),
      //     ),
      //   ),
      // ),
      // SizedBox(height: 20.0),
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
              labelText: "المساحة".tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          );
        }),
      ),
      SizedBox(width: 15.0),
      // Expanded(
      //   child: DropdownButtonFormField<String>(
      //     value: controller.selectedAmountRange.value.isNotEmpty
      //         ? controller.selectedAmountRange.value
      //         : controller.amountRanges.first,
      //     items: controller.amountRanges.map((range) {
      //       return DropdownMenuItem(
      //         value: range,
      //         child: Text(range),
      //       );
      //     }).toList(),
      //     onChanged: (value) {
      //       controller.selectedAmountRange.value = value!;
      //     },
      //     decoration: InputDecoration(
      //       labelText: "مدى المبلغ".tr,
      //       border: OutlineInputBorder(
      //         borderRadius: BorderRadius.circular(12.0),
      //       ),
      //     ),
      //   ),
      // ),
      // SizedBox(width: 15.0),
      // Expanded(
      //   child: DropdownButtonFormField<String>(
      //     value: controller.selectedAgent.value.isNotEmpty
      //         ? controller.selectedAgent.value
      //         : controller.agents.first,
      //     items: controller.agents.map((range) {
      //       return DropdownMenuItem(
      //         value: range,
      //         child: Text(range),
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

  // List<Widget> _buildResponsiveTextFieldsForSmallScreen() {
  //   return [
  //     Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "حدد معيار التصفية الرئيسي".tr,
  //           style: TextStyle(fontSize: 16.0),
  //         ),
  //         Obx(
  //           () => Row(
  //             mainAxisAlignment:
  //                 MainAxisAlignment.center, // Centering the row contents
  //             children: [
  //               Row(
  //                 children: [
  //                   Radio<int>(
  //                     value: 0,
  //                     groupValue: controller.primaryFilter.value,
  //                     onChanged: (value) {
  //                       controller.primaryFilter.value = value!;
  //                     },
  //                   ),
  //                   Text("المساحة".tr),
  //                 ],
  //               ),
  //               SizedBox(width: 20.0), // Space between the two options
  //               Row(
  //                 children: [
  //                   Radio<int>(
  //                     value: 1,
  //                     groupValue: controller.primaryFilter.value,
  //                     onChanged: (value) {
  //                       controller.primaryFilter.value = value!;
  //                     },
  //                   ),
  //                   Text("مدى المبلغ".tr),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   ];
  // }

  // List<Widget> _buildResponsiveTextFieldsForLargeScreen() {
  //   return [
  //     Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "حدد معيار التصفية الرئيسي".tr,
  //           style: TextStyle(fontSize: 16.0),
  //         ),
  //         Obx(
  //           () => Row(
  //             children: [
  //               Row(
  //                 children: [
  //                   Radio<int>(
  //                     value: 0,
  //                     groupValue: controller.primaryFilter.value,
  //                     onChanged: (value) {
  //                       controller.primaryFilter.value = value!;
  //                     },
  //                   ),
  //                   Text("المساحة".tr),
  //                 ],
  //               ),
  //               SizedBox(width: 20.0), // Space between the two options
  //               Row(
  //                 children: [
  //                   Radio<int>(
  //                     value: 1,
  //                     groupValue: controller.primaryFilter.value,
  //                     onChanged: (value) {
  //                       controller.primaryFilter.value = value!;
  //                     },
  //                   ),
  //                   Text("مدى المبلغ".tr),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   ];
  // }

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
          "التكلفة زنك",
          style: robotoAppColor,
        ),
        subtitle: Text(
          '${controller.zincCost.value}',
          style: robotoButtonColor,
        ),
      ),
      Divider(
        color: AppColor.buttonColor,
        height: 2,
      ),
      ListTile(
        title: Text(
          "التكلفة خرسانة",
          style: robotoAppColor,
        ),
        subtitle: Text(
          '${controller.concreteCost.value}',
          style: robotoButtonColor,
        ),
      ),
      Divider(
        color: AppColor.buttonColor,
        height: 2,
      ),
      ListTile(
        title: Text(
          "تفاصيل البناء",
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
          "المرافق",
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
            "التكلفة زنك",
            style: robotoAppColor,
          ),
          subtitle: Text(
            '${controller.zincCost.value}',
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
            "التكلفة خرسانة",
            style: robotoAppColor,
          ),
          subtitle: Text(
            '${controller.concreteCost.value}',
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
              "تفاصيل البناء",
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
              "المرافق",
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

  // List<Widget> _buildDetailsAndFacilitiesForSmallScreen() {
  //   return [
  //     TextFormField(
  //       controller: controller.buildingDetailsC,
  //       maxLines: null,
  //       decoration: InputDecoration(
  //         labelText: "تفاصيل البناء".tr,
  //         border: OutlineInputBorder(),
  //       ),
  //     ),
  //     SizedBox(height: 20.0),
  //     TextFormField(
  //       controller: controller.facilitiesC,
  //       maxLines: null,
  //       decoration: InputDecoration(
  //         labelText: "المرافق".tr,
  //         border: OutlineInputBorder(),
  //       ),
  //     ),
  //   ];
  // }
}
