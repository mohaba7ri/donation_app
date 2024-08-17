import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// class AddProjectController extends GetxController {
//   // TextEditingControllers for the input fields
//   final TextEditingController countryC = TextEditingController();
//   final TextEditingController executingAgencyC = TextEditingController();
//   final TextEditingController associationManagerC = TextEditingController();
//   final TextEditingController kuwaitiMOFCApprovalC = TextEditingController();

//   // Controllers for the "Details" section
//   final TextEditingController mosqueAreaC = TextEditingController();
//   final TextEditingController zincCostC = TextEditingController();
//   final TextEditingController concreteCostC = TextEditingController();
//   final TextEditingController buildingSpecificationsC = TextEditingController();
//   final TextEditingController executionPeriodC = TextEditingController();
//   final TextEditingController beneficiariesC = TextEditingController();
//   final TextEditingController mosqueFacilitiesC = TextEditingController();

//   // Method to handle adding the project
//   void addProject() {
//     // Example: Print the values to the console (for now)
//     print("الدولة: ${countryC.text}");
//     print("الجهة المنفذة: ${executingAgencyC.text}");
//     print("مدير الجمعية: ${associationManagerC.text}");
//     print("اعتماد الخارجية الكويتية: ${kuwaitiMOFCApprovalC.text}");

//     print("مساحة المسجد: ${mosqueAreaC.text}");
//     print("تكلفة الزنك: ${zincCostC.text}");
//     print("تكلفة الخرسانة: ${concreteCostC.text}");
//     print("مواصفات البناء: ${buildingSpecificationsC.text}");
//     print("مدة التنفيذ: ${executionPeriodC.text}");
//     print("عدد المستفيدين: ${beneficiariesC.text}");
//     print("مرافق المسجد: ${mosqueFacilitiesC.text}");

//     // Implement further logic here, such as sending data to Firestore
//     // or performing form validation before submission
//   }

//   @override
//   void onClose() {
//     // Dispose of the controllers when the controller is closed
//     countryC.dispose();
//     executingAgencyC.dispose();
//     associationManagerC.dispose();
//     kuwaitiMOFCApprovalC.dispose();
//     mosqueAreaC.dispose();
//     zincCostC.dispose();
//     concreteCostC.dispose();
//     buildingSpecificationsC.dispose();
//     executionPeriodC.dispose();
//     beneficiariesC.dispose();
//     mosqueFacilitiesC.dispose();
//     super.onClose();
//   }
// }

class AddConstructionProjectController extends GetxController {
  // Form key
  final formKey = GlobalKey<FormState>();

  // Controllers for input fields
  final ProjectNameController = TextEditingController();
  final areaController = TextEditingController();
  final zincCostController = TextEditingController();
  final concreteCostController = TextEditingController();
  final beneficiariesController = TextEditingController();
  final executionTimeController = TextEditingController();
  final facilitiesController = TextEditingController();
  final buildingSpecsController = TextEditingController();

  // Selected project type
  var selectedProjectType = ''.obs;

  // List of project types with icons
  final List<Map<String, dynamic>> projectTypes = [
    {'projectName': 'زكاة', 'icon': Icons.monetization_on},
    {'projectName': 'صدقات عامة', 'icon': Icons.volunteer_activism},
    {'projectName': 'وقفيات', 'icon': Icons.build},
    {'projectName': 'كفارات', 'icon': Icons.support_agent},
    {'projectName': 'كفالات', 'icon': Icons.handshake},
    {'projectName': 'إغاثة', 'icon': Icons.local_hospital},
    {'projectName': 'مشاريع دعوية', 'icon': Icons.school},
    {'projectName': 'مشاريع إنشائية', 'icon': Icons.construction},
    {'projectName': 'مشاريع عامة', 'icon': Icons.public},
  ];

  // Method to handle form submission
  void submitForm() {
    if (formKey.currentState!.validate()) {
      // Handle form submission, e.g., saving to the database
      Get.snackbar("Success", "Project added successfully!");
    }
  }

  @override
  void onClose() {
    ProjectNameController.dispose();
    areaController.dispose();
    zincCostController.dispose();
    concreteCostController.dispose();
    beneficiariesController.dispose();
    executionTimeController.dispose();
    facilitiesController.dispose();
    buildingSpecsController.dispose();
    super.onClose();
  }
}
