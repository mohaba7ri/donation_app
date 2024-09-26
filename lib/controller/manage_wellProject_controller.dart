import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dontations_app/helper/local_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class ManageWellProjectController extends GetxController {
  late final String countryName;
  late final String projectType;
  final Map<String, dynamic> args = Get.arguments;
  // late String countryName;
  // late String projectType;
  // final String countryName = args['countryName'];
  // final String projectName = args['projectName'];

  var projectTypeC = TextEditingController();
  var projectNameC = TextEditingController();
  var projectValueC = TextEditingController();
  var locationC = TextEditingController();
  var buildingDetailsC = TextEditingController();
  var executionPeriodC = TextEditingController();
  var beneficiariesC = TextEditingController();
  var costC = TextEditingController();
  var concreteCostC = TextEditingController();
  var facilitiesC = TextEditingController();
  var arenaC = TextEditingController();

  var selectedProjectId = ''.obs;
  var isEditing = false.obs;

  var isLoadingAdd = false.obs;
  var isLoadingEdit = false.obs;
  var isLoadingClear = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var projects = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    final Map<String, dynamic> args = Get.arguments;

    countryName = args['countryName'] ?? '';
    projectType = args['projectName'] ?? '';

    fetchProjects();
  }
  // @override
  // void onInit() {
  //   super.onInit();

  //   // Retrieve state from local storage or default values
  //   _retrieveLocalStorageValues();

  //   // Retrieve arguments if local storage values are not set
  //   if (countryName.isEmpty || projectType.isEmpty) {
  //     final Map<String, dynamic>? args = Get.arguments;
  //     if (args != null) {
  //       countryName = args['countryName'] ?? '';
  //       projectType = args['projectName'] ?? '';
  //     }
  //   }

  //   // Save state to local storage
  //   LocalStorageHelper.save('countryName', countryName);
  //   LocalStorageHelper.save('projectName', projectType);

  //   // Fetch projects based on the retrieved or provided state
  //   fetchProjects();
  // }

  // // String countryName = '';
  // // String projectType = '';
  // void _retrieveLocalStorageValues() async {
  //   final countryNameValue = await LocalStorageHelper.get('countryName');
  //   final projectTypeValue = await LocalStorageHelper.get('projectName');

  //   countryName = countryNameValue ?? '';
  //   projectType = projectTypeValue ?? '';
  // }

  void addOrUpdateProject() async {
    if (_isDuplicateArena()) {
      Get.snackbar(
        "",
        "المعذرة هذا النموذج موجود من قبل",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (selectedProjectId.value.isEmpty) {
      // Add new project
      isLoadingAdd.value = true;
    } else {
      // Update existing project
      isLoadingEdit.value = true;
    }

    final projectData = {
      'projectType': projectType,
      'country': countryName,
      'buildingDetails': buildingDetailsC.text,
      'executionPeriod': executionPeriodC.text,
      'beneficiaries': beneficiariesC.text,
      'cost': costC.text,
      'compareCost': costC.text,
      'facilities': facilitiesC.text,
      'arena': arenaC.text,
    };

    try {
      if (selectedProjectId.value.isEmpty) {
        print("oh my god");
        await _firestore
            .collection('projects')
            .doc('constructions') // Replace with the correct document ID
            .collection('Well')
            .add(projectData);
        Get.snackbar(
          "",
          "تمت إضافة النموذج بنجاح",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        await _firestore
            .collection('projects')
            .doc('constructions') // Replace with the correct document ID
            .collection('Well')
            .doc(selectedProjectId.value)
            .update(projectData);
        Get.snackbar(
          "",
          "تم تعديل النموذج بنجاح",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "لم تتم العملية بنجاح",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingAdd.value = false;
      isLoadingEdit.value = false;
    }

    clearForm();
    fetchProjects();
  }

  void fetchProjects() async {
    var querySnapshot = await _firestore
        .collection('projects')
        .doc("constructions")
        .collection('Well')
        .where('country', isEqualTo: countryName)
        .where('projectType', isEqualTo: projectType)
        .get();

    projects.value = querySnapshot.docs
        .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
        .toList();
  }

  bool _isDuplicateArena() {
    for (var project in projects) {
      if (project['arena'] == arenaC.text &&
          project['id'] != selectedProjectId.value) {
        return true;
      }
    }
    return false;
  }

  void selectProject(Map<String, dynamic> project) {
    selectedProjectId.value = project['id'];
    isEditing.value = true;
    // projectNameC.text = project['projectName'] ?? '';
    // projectValueC.text = project['projectValue'] ?? '';
    // locationC.text = project['location'] ?? '';
    buildingDetailsC.text = project['buildingDetails'] ?? '';
    executionPeriodC.text = project['executionPeriod'] ?? '';
    beneficiariesC.text = project['beneficiaries'] ?? '';
    costC.text = project['zincCost'] ?? '';
    facilitiesC.text = project['facilities'] ?? '';
    arenaC.text = project['arena'] ?? '';
  }

  void clearForm() async {
    isLoadingClear.value = true;
    await Future.delayed(Duration(milliseconds: 500));
    selectedProjectId.value = '';
    isEditing.value = false;
    projectNameC.clear();
    projectValueC.clear();
    locationC.clear();
    buildingDetailsC.clear();
    executionPeriodC.clear();
    beneficiariesC.clear();
    costC.clear();
    concreteCostC.clear();
    facilitiesC.clear();
    arenaC.clear();
    isLoadingClear.value = false;
  }

  void deleteProject(String projectId) async {
    await _firestore
        .collection('projects')
        .doc() // Replace with the correct document ID
        .collection('Well')
        .doc(projectId)
        .delete();
    fetchProjects();
    Get.snackbar(
      "",
      "تم حذف النموذج بنجاح",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    projectTypeC.dispose();
    projectNameC.dispose();
    projectValueC.dispose();
    locationC.dispose();
    buildingDetailsC.dispose();
    executionPeriodC.dispose();
    beneficiariesC.dispose();
    costC.dispose();
    concreteCostC.dispose();
    facilitiesC.dispose();
    arenaC.dispose();

    LocalStorageHelper.remove('countryName');
    LocalStorageHelper.remove('projectName');
    super.onClose();
  }
}
