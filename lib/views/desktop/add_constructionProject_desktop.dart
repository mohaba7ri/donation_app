import 'package:dontations_app/controller/add_musqeDonation_controller.dart';
import 'package:dontations_app/controller/add_constructionProject_controller.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

// class AddProjectScreen extends GetView<AddProjectController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColor.appBarColor,
//         iconTheme: IconThemeData(color: AppColor.buttonColor),
//         title: Text(
//           "إضافة مشروع".tr,
//           style: robotoHugeWhite,
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Container(
//             width: MediaQuery.of(context).size.width *
//                 0.8, // Adjust width as needed
//             constraints: BoxConstraints(
//               maxWidth:
//                   1200, // Optional: Add a maximum width to prevent excessive stretching
//             ),
//             child: Card(
//               elevation: 5.0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(22.0),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "معلومات المشروع".tr,
//                       style: robotoHugeBlack,
//                     ),
//                     SizedBox(height: 20.0),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: CustomInput(
//                             controller: controller.countryC,
//                             label: "الدولة".tr,
//                             hint: "",
//                           ),
//                         ),
//                         SizedBox(width: 20.0),
//                         Expanded(
//                           child: CustomInput(
//                             controller: controller.executingAgencyC,
//                             label: "الجهة المنفذة".tr,
//                             hint: "",
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20.0),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: CustomInput(
//                             controller: controller.associationManagerC,
//                             label: "مدير الجمعية".tr,
//                             hint: "",
//                           ),
//                         ),
//                         SizedBox(width: 20.0),
//                         Expanded(
//                           child: CustomInput(
//                             controller: controller.kuwaitiMOFCApprovalC,
//                             label: "اعتماد الخارجية الكويتية".tr,
//                             hint: "",
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 30.0),
//                     Text(
//                       "التفاصيل".tr,
//                       style: robotoHugeBlack,
//                     ),
//                     SizedBox(height: 20.0),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: CustomInput(
//                             controller: controller.mosqueAreaC,
//                             label: "مساحة المسجد".tr,
//                             hint: "",
//                           ),
//                         ),
//                         SizedBox(width: 20.0),
//                         Expanded(
//                           child: CustomInput(
//                             controller: controller.zincCostC,
//                             label: "تكلفة الزنك".tr,
//                             hint: "",
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20.0),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: CustomInput(
//                             controller: controller.concreteCostC,
//                             label: "تكلفة الخرسانة".tr,
//                             hint: "",
//                           ),
//                         ),
//                         SizedBox(width: 20.0),
//                         Expanded(
//                           child: CustomInput(
//                             controller: controller.buildingSpecificationsC,
//                             label: "مواصفات البناء".tr,
//                             hint: "",
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20.0),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: CustomInput(
//                             controller: controller.executionPeriodC,
//                             label: "مدة التنفيذ".tr,
//                             hint: "",
//                           ),
//                         ),
//                         SizedBox(width: 20.0),
//                         Expanded(
//                           child: CustomInput(
//                             controller: controller.beneficiariesC,
//                             label: "عدد المستفيدين".tr,
//                             hint: "",
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20.0),
//                     CustomInput(
//                       controller: controller.mosqueFacilitiesC,
//                       label: "مرافق المسجد".tr,
//                       hint: "",
//                     ),
//                     SizedBox(height: 30.0),
//                     Center(
//                       child: SizedBox(
//                         width: 200,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             controller.addProject();
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColor.buttonColor,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 30, vertical: 15),
//                           ),
//                           child: Text(
//                             "إضافة".tr,
//                             style: robotoHugeWhite,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class AddConstructionProjectScreen
    extends GetView<AddConstructionProjectController> {
  final String projectName = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "إضافة نموذج ($projectName)",
          style: robotoHugeWhite,
        ),
        centerTitle: true,
        backgroundColor: AppColor.appBarColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomInput(
                      controller: controller.areaController,
                      label: "المساحة",
                      hint: "",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Expanded(
                    child: CustomInput(
                      controller: controller.zincCostController,
                      label: "تكلفة الزنك",
                      hint: "",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: CustomInput(
                      controller: controller.concreteCostController,
                      label: "تكلفة الخرسانة",
                      hint: "",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomInput(
                      controller: controller.beneficiariesController,
                      label: "عدد المستفيدين ",
                      hint: "",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: CustomInput(
                      controller: controller.executionTimeController,
                      label: "مدة التنفيذ ",
                      hint: "",
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.facilitiesController,
                      maxLines:
                          null, // This allows the text field to expand vertically as the user types
                      decoration: InputDecoration(
                        labelText: "المرافق",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextFormField(
                      controller: controller.buildingSpecsController,
                      maxLines:
                          null, // This allows the text field to expand vertically as the user types
                      decoration: InputDecoration(
                        labelText: "مواصفات البناء",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.submitForm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 160, vertical: 15),
                  ),
                  child: Text(
                    "إضافة",
                    style: robotoHugeWhite,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
