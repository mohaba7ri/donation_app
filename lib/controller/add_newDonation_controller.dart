import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddNewConstructionDonationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchProjects(); // Call fetchProjects when the controller is initialized
  }

  var nameC = TextEditingController();
  var phoneC = TextEditingController();
  var addressC = TextEditingController();
  var emailC = TextEditingController();
  var projectTypeC = TextEditingController();
  var projectNameC = TextEditingController();
  var projectValueC = TextEditingController();
  var locationC = TextEditingController();
  var buildingDetailsC = TextEditingController();
  var executionPeriodC = ''.obs;

  var beneficiariesC = TextEditingController();
  var zincCostC = TextEditingController();
  var concreteCostC = TextEditingController();
  var facilitiesC = TextEditingController();
  final primaryFilter = 0.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var projects = <Map<String, dynamic>>[].obs; // Observable list for projects
  var arenas = <String>[].obs; // Observable list for dropdown values

  var selectedArena = ''.obs; // Observable for the selected dropdown value
  var executionPeriod = ''.obs; // Execution period
  var buildingDetails = ''.obs; // Building details
  var beneficiaries = ''.obs; // Beneficiaries
  var zincCost = ''.obs; // Zinc cost
  var concreteCost = ''.obs; // Concrete cost
  var facilities = ''.obs; // Facilities

  void fetchProjects() async {
    var querySnapshot = await _firestore
        .collection('projects')
        .doc("constructions")
        .collection('Mosque')
        .where('country', isEqualTo: 'اليمن')
        .where('projectType', isEqualTo: 'الجامع الكبير')
        .get();

    projects.value = querySnapshot.docs
        .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
        .toList();

    // Extract arena values from the fetched documents
    arenas.value = querySnapshot.docs
        .map((doc) =>
            doc['arena'] as String) // Assuming 'arena' is a String field
        .where((arena) => arena.isNotEmpty) // Filter out any empty arena values
        .toList();
  }

  void fetchExecutionPeriod() async {
    if (selectedArena.value.isEmpty) {
      executionPeriodC.value =
          ''; // Clear executionPeriod if no arena is selected
      return;
    }

    var querySnapshot = await _firestore
        .collection('projects')
        .doc("constructions")
        .collection('Mosque')
        .where('country', isEqualTo: 'اليمن')
        .where('projectType', isEqualTo: 'الجامع الكبير')
        .where('arena', isEqualTo: selectedArena.value)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var doc = querySnapshot.docs.first; // Assuming you want the first match
      executionPeriodC.value = doc['executionPeriod'] as String? ?? '';
    } else {
      executionPeriodC.value = ''; // No matching arena found
    }
  }

  var selectedArea = '90 متر '.obs;
  var areas = ['90 متر ', '100 متر ', '120 متر '];

  final selectedPrimaryField = ''.obs;
  final selectedAmountRange = '2000 - 3000'.obs;
  final selectedAgent = 'شركة احمد'.obs;
  final List<String> agents = [
    'شركة احمد',
    'مجموعة قاسم',
  ];
  final List<String> amountRanges = [
    '2000 - 3000',
    '3100 - 5000',
    '5100 - 7000',
  ];
  void addDonation() {
    // Handle the donation addition logic here
  }
  void updatePrimaryField(String field) {
    selectedPrimaryField.value = field;
  }

  @override
  void onClose() {
    nameC.dispose();
    phoneC.dispose();
    addressC.dispose();
    emailC.dispose();
    projectTypeC.dispose();
    projectNameC.dispose();
    projectValueC.dispose();
    locationC.dispose();
    buildingDetailsC.dispose();
    beneficiariesC.dispose();
    zincCostC.dispose();
    concreteCostC.dispose();
    facilitiesC.dispose();
    super.onClose();
  }
}
