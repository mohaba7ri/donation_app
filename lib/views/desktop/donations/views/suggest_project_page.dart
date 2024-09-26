import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dontations_app/controller/closest_cost_controller.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/views/desktop/donations/util/pdf_service.dart';
import 'package:dontations_app/widgets/custom_input.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'dart:html' as html;
import 'package:intl/intl.dart';

class SuggestProjectPage extends GetView<ClosestCostController> {
  final TextEditingController amountController = TextEditingController();
  final PdfService pdfService = PdfService();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'إقتراح مشروع',
          style: robotoHugeWhite,
        ),
        backgroundColor: AppColor.appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'إدخل المبلغ',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              onPressed: () {
                controller.getClosestCosts(amountController.text);
              },
              child: Text(
                'إقتراح',
                style: robotoMediumWhiteBold,
              ),
            ),
            SizedBox(height: 20),
            Obx(() {
              if (controller.isLoading.value) {
                return Center(
                    child: CircularProgressIndicator(
                  color: AppColor.appBarColor,
                ));
              } else if (controller.closestDocs.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.closestDocs.length,
                    itemBuilder: (context, index) {
                      var data = controller.closestDocs[index].data()
                          as Map<String, dynamic>;

                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 8,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: isSmallScreen
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'تكلفة المقارنة: ${data['compareCost'] ?? 'غير متوفرة'}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.info_outline,
                                          size: 20, color: Colors.blue),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'تفاصيل: ${data['details'] ?? ''}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.timer,
                                          size: 20, color: Colors.green),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'مدة التنفيذ: ${data['executionPeriod'] ?? 'غير متوفرة'}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.build,
                                          size: 20, color: Colors.orange),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'تفاصيل البناء: ${data['buildingDetails'] ?? 'غير متوفرة'}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.people,
                                          size: 20, color: Colors.red),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'عدد المستفيدين: ${data['beneficiaries'] ?? 'غير متوفر'}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.attach_money,
                                          size: 20, color: Colors.purple),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'التكلفة: ${data['cost'] ?? 'غير متوفرة'}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.home,
                                          size: 20, color: Colors.teal),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'المرافق: ${data['facilities'] ?? 'غير متوفرة'}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical:
                                            8), // Add some margin to float the container
                                    padding: EdgeInsets.all(
                                        16), // Add padding inside the container

                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomInput(
                                                controller: controller.nameC,
                                                label: "إسم المتبرع".tr,
                                                hint: "",
                                              ),
                                            ),
                                            SizedBox(width: 20.0),
                                            Expanded(
                                              child: CustomInput(
                                                controller:
                                                    controller.projectNameC,
                                                label: "إسم المشروع".tr,
                                                hint: "",
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10.0),
                                        Obx(
                                          () => DropdownButtonFormField<String>(
                                            value: controller.agents.contains(
                                                    controller
                                                        .selectedAgent.value)
                                                ? controller.selectedAgent.value
                                                : null, // Ensure the selected value is valid; otherwise, set to null
                                            items:
                                                controller.agents.map((agent) {
                                              return DropdownMenuItem(
                                                value: agent,
                                                child: Text(agent),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              controller.selectedAgent.value =
                                                  value ??
                                                      ''; // Update the selected value or reset
                                            },
                                            decoration: InputDecoration(
                                              labelText: "الجهة المنفذة".tr,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        buildCostSelection(
                                          zincCost: data['zincCost'] ?? '',
                                          concreteCost:
                                              data['concreteCost'] ?? '',
                                          compareCost: data['cost'] ?? '',
                                        ),
                                        Row(
                                          children:
                                              _buildResponsiveInputsForLargeScreen(),
                                        ),
                                        SizedBox(height: 10.0),
                                        Row(
                                          children:
                                              _buildBenefandDurationForLargeScreen(
                                            executionPeriod:
                                                data['executionPeriod'] ?? '',
                                            beneficiaries:
                                                data['beneficiaries'] ?? '',
                                            zincCost: data['zincCost'] ?? '',
                                            concreteCost:
                                                data['concreteCost'] ?? '',
                                            cost: data['cost'] ?? '',
                                            country: data['country'] ?? '',
                                            arena: data['arena'] ?? '',
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        Row(
                                          children:
                                              _buildDetailsAndFacilitiesForLargeScreen(
                                            buildingDetails:
                                                data['buildingDetails'] ?? '',
                                            facilities:
                                                data['facilities'] ?? '',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 30.0),
                                  Center(
                                    child: SizedBox(
                                        width: 400,
                                        child: Obx(
                                          () => ElevatedButton(
                                            onPressed: controller
                                                    .isLoading.value
                                                ? () {}
                                                : () async {
                                                    final now = DateTime.now();
                                                    final formattedDate =
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(now);

                                                    final pdf = await pdfService
                                                        .generatePdf(
                                                      donorName:
                                                          controller.nameC.text,
                                                      address: controller
                                                          .addressC.text,
                                                      phoneNumber: controller
                                                          .phoneC.text,
                                                      email: controller
                                                          .emailC.text,
                                                      contryName:
                                                          data['country'],
                                                      beneficiaries:
                                                          data['beneficiaries'],
                                                      donationAmount: controller
                                                          .combinedCost.value,
                                                      // beneficiaries: controller.arenas,
                                                      projectType:
                                                          data['projectType'],
                                                      executionPeriod: data[
                                                          'executionPeriod'],
                                                      selectedArena:
                                                          data['arena'],
                                                      projectName: controller
                                                          .projectNameC.text,
                                                      date: formattedDate,
                                                    );

                                                    if (!kIsWeb) {
                                                      // For non-web platforms, save the PDF to the device
                                                      final bytes =
                                                          await pdf.save();
                                                      // Implement your file saving logic here (e.g., using a file system package)
                                                      // Example for desktop or mobile:
                                                      // final file = File('example_report.pdf');
                                                      // await file.writeAsBytes(bytes);
                                                    } else {
                                                      // For web, create a Blob and trigger a download
                                                      final bytes =
                                                          await pdf.save();
                                                      final blob = html.Blob(
                                                          [bytes],
                                                          'application/pdf');
                                                      final url = html.Url
                                                          .createObjectUrlFromBlob(
                                                              blob);
                                                      final anchor =
                                                          html.AnchorElement(
                                                              href: url)
                                                            ..setAttribute(
                                                                'download',
                                                                '${controller.nameC.text} وثيقة تبرع.pdf')
                                                            ..click();
                                                      html.Url.revokeObjectUrl(
                                                          url);
                                                    }
                                                    controller.addDonation(
                                                      data['projectType'] ?? '',
                                                      data['arena'] ?? '',
                                                      data['executionPeriod'] ??
                                                          '',
                                                      data['buildingDetails'] ??
                                                          '',
                                                      data['beneficiaries'] ??
                                                          '',
                                                      data['facilities'] ?? '',
                                                      data['country'] ?? '',
                                                      controller
                                                          .combinedCost.value,
                                                    );
                                                  },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColor.buttonColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 15),
                                            ),
                                            child: controller.isLoading.value
                                                ? CircularProgressIndicator(
                                                    color: Colors.white,
                                                  )
                                                : Text(
                                                    "إضافة".tr,
                                                    style: robotoHugeWhite,
                                                  ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                      );
                    },
                  ),
                );
              } else {
                return Center(child: Text('لا توجد  بيانات'));
              }
            }),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildResponsiveInputsForLargeScreen() {
    return [
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
}

// List<Widget> _buildArenaForLargeScreen({
//   required String executionPeriod,
//   required String beneficiaries,

// }) {
//   return [
//     Expanded(
//       child: ListTile(
//         title: Text(
//           "الدولة",
//           style: robotoAppColor,
//         ),
//         subtitle: Text(
//           country.isNotEmpty ? country : 'غير متوفرة',
//           style: robotoButtonColor,
//         ),
//       ),
//     ),
//     Container(
//       height: 60,
//       width: 3,
//       color: AppColor.buttonColor,
//     ),
//     Expanded(
//       child: ListTile(
//         title: Text(
//           "مدة التنفيذ",
//           style: robotoAppColor,
//         ),
//         subtitle: Text(
//           executionPeriod.isNotEmpty ? executionPeriod : 'غير متوفرة',
//           style: robotoButtonColor,
//         ),
//       ),
//     ),
//     Container(
//       height: 60,
//       width: 3,
//       color: AppColor.buttonColor,
//     ),
//     Expanded(
//       child: ListTile(
//         title: Text(
//           "عدد المستفيدين",
//           style: robotoAppColor,
//         ),
//         subtitle: Text(
//           beneficiaries.isNotEmpty ? beneficiaries : 'غير متوفرة',
//           style: robotoButtonColor,
//         ),
//       ),
//     ),
//     zincCost.isNotEmpty
//         ? Container(
//             height: 60,
//             width: 3,
//             color: AppColor.buttonColor,
//           )
//         : SizedBox(),
//     zincCost.isNotEmpty
//         ? Expanded(
//             child: ListTile(
//               title: Text(
//                 "التكلفة زنك",
//                 style: robotoAppColor,
//               ),
//               subtitle: Text(
//                 zincCost.isNotEmpty ? zincCost : ' ',
//                 style: robotoButtonColor,
//               ),
//             ),
//           )
//         : SizedBox(),
//     concreteCost.isNotEmpty
//         ? Container(
//             height: 60,
//             width: 3,
//             color: AppColor.buttonColor,
//           )
//         : SizedBox(),
//     concreteCost.isNotEmpty
//         ? Expanded(
//             child: ListTile(
//               title: Text(
//                 "التكلفة خرسانة",
//                 style: robotoAppColor,
//               ),
//               subtitle: Text(
//                 concreteCost.isNotEmpty ? concreteCost : ' ',
//                 style: robotoButtonColor,
//               ),
//             ),
//           )
//         : SizedBox(),
//     cost.isNotEmpty
//         ? Container(
//             height: 60,
//             width: 3,
//             color: AppColor.buttonColor,
//           )
//         : SizedBox(),
//     cost.isNotEmpty
//         ? Expanded(
//             child: ListTile(
//               title: Text(
//                 "التكلفة",
//                 style: robotoAppColor,
//               ),
//               subtitle: Text(
//                 cost.isNotEmpty ? cost : 'غير متوفرة',
//                 style: robotoButtonColor,
//               ),
//             ),
//           )
//         : SizedBox(),
//   ];
// }

List<Widget> _buildBenefandDurationForLargeScreen({
  required String executionPeriod,
  required String beneficiaries,
  required String zincCost,
  required String concreteCost,
  required String cost,
  required String country,
  required String arena,
}) {
  return [
    Expanded(
      child: ListTile(
        title: Text(
          "الدولة",
          style: robotoAppColor,
        ),
        subtitle: Text(
          country.isNotEmpty ? country : 'غير متوفرة',
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
          "المساحة",
          style: robotoAppColor,
        ),
        subtitle: Text(
          arena.isNotEmpty ? arena : 'غير متوفرة',
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
          "مدة التنفيذ",
          style: robotoAppColor,
        ),
        subtitle: Text(
          executionPeriod.isNotEmpty ? executionPeriod : 'غير متوفرة',
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
          beneficiaries.isNotEmpty ? beneficiaries : 'غير متوفرة',
          style: robotoButtonColor,
        ),
      ),
    ),
    zincCost.isNotEmpty
        ? Container(
            height: 60,
            width: 3,
            color: AppColor.buttonColor,
          )
        : SizedBox(),
    zincCost.isNotEmpty
        ? Expanded(
            child: ListTile(
              title: Text(
                "التكلفة زنك",
                style: robotoAppColor,
              ),
              subtitle: Text(
                zincCost.isNotEmpty ? zincCost : ' ',
                style: robotoButtonColor,
              ),
            ),
          )
        : SizedBox(),
    concreteCost.isNotEmpty
        ? Container(
            height: 60,
            width: 3,
            color: AppColor.buttonColor,
          )
        : SizedBox(),
    concreteCost.isNotEmpty
        ? Expanded(
            child: ListTile(
              title: Text(
                "التكلفة خرسانة",
                style: robotoAppColor,
              ),
              subtitle: Text(
                concreteCost.isNotEmpty ? concreteCost : ' ',
                style: robotoButtonColor,
              ),
            ),
          )
        : SizedBox(),
    cost.isNotEmpty
        ? Container(
            height: 60,
            width: 3,
            color: AppColor.buttonColor,
          )
        : SizedBox(),
    cost.isNotEmpty
        ? Expanded(
            child: ListTile(
              title: Text(
                "التكلفة",
                style: robotoAppColor,
              ),
              subtitle: Text(
                cost.isNotEmpty ? cost : 'غير متوفرة',
                style: robotoButtonColor,
              ),
            ),
          )
        : SizedBox(),
  ];
}

List<Widget> _buildDetailsAndFacilitiesForLargeScreen({
  required String buildingDetails,
  required String facilities,
}) {
  return [
    Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: AppColor.buttonColor),
        ),
        child: ListTile(
          title: Text(
            "تفاصيل البناء",
            style: robotoAppColor,
          ),
          subtitle: Text(
            buildingDetails.isNotEmpty ? buildingDetails : 'غير متوفرة',
            style: robotoButtonColor,
          ),
        ),
      ),
    ),
    SizedBox(width: 5),
    Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: AppColor.buttonColor),
        ),
        child: ListTile(
          title: Text(
            "المرافق",
            style: robotoAppColor,
          ),
          subtitle: Text(
            facilities.isNotEmpty ? facilities : 'غير متوفرة',
            style: robotoButtonColor,
          ),
        ),
      ),
    ),
  ];
}
