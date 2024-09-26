import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddWellDonationController extends GetxController {
  late final String countryName;
  late final String projectType;
  late final Map<String, dynamic> args;
  @override
  void onInit() {
    super.onInit();

    args = Get.arguments;
    countryName = args['countryName'] as String;
    projectType = args['projectName'] as String;

    fetchArenas(); // Call fetchProjects when the controller is initialized
    fetchAgents();
  }

  var nameC = TextEditingController();
  var phoneC = TextEditingController();
  var addressC = TextEditingController();
  var emailC = TextEditingController();

  var projectNameC = TextEditingController();
  var donationAmountC = TextEditingController();

  final primaryFilter = 0.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var projects = <Map<String, dynamic>>[].obs; // Observable list for projects
  var arenas = <String>[].obs; // Observable list for dropdown values

  final selectedAgent = ''.obs;
  final List<String> agents = <String>[].obs;

  var executionPeriodC = ''.obs;

  var selectedArena = ''.obs;
  var buildingDetails = ''.obs;
  var beneficiaries = ''.obs;
  var cost = ''.obs;
  var facilities = ''.obs;

  void fetchArenas() async {
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

    // Extract arena values from the fetched documents
    arenas.value = querySnapshot.docs
        .map((doc) =>
            doc['arena'] as String) // Assuming 'arena' is a String field
        .where((arena) => arena.isNotEmpty) // Filter out any empty arena values
        .toList();
  }

  void fetchAgents() async {
    try {
      // First, find the document in the 'countries' collection where the name is 'yemen'
      var countrySnapshot = await _firestore
          .collection('countries')
          .where('name', isEqualTo: countryName)
          .get();

      if (countrySnapshot.docs.isNotEmpty) {
        // Assuming there's only one document for 'yemen', get its ID
        var conDocId = countrySnapshot.docs.first.id;

        // Now, fetch the 'agents' subcollection from the 'yemen' document
        var querySnapshot = await _firestore
            .collection('countries')
            .doc(conDocId)
            .collection('agents')
            .get();

        // Extract the agentName values and add them to the agents list
        agents.addAll(querySnapshot.docs
            .map((doc) => doc['agentName'] as String)
            .toList());
      } else {
        print("No country found with the name 'yemen'");
      }
    } catch (e) {
      print("Error fetching agents: $e");
    }
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
        .collection('Well')
        .where('country', isEqualTo: countryName)
        .where('projectType', isEqualTo: projectType)
        .where('arena', isEqualTo: selectedArena.value)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var doc = querySnapshot.docs.first; // Assuming you want the first match
      executionPeriodC.value = doc['executionPeriod'] as String? ?? '';
      buildingDetails.value = doc['buildingDetails'] as String? ?? '';
      beneficiaries.value = doc['beneficiaries'] as String? ?? '';
      // zincCost.value = doc['zincCost'] as String? ?? '';
      cost.value = doc['cost'] as String? ?? '';
      donationAmountC.text = doc['cost'] as String? ?? '';

      facilities.value = doc['facilities'] as String? ?? '';
    } else {
      executionPeriodC.value = ''; // No matching arena found
      print("noooooooooo cannot");
    }
  }

  final selectedPrimaryField = ''.obs;
  final selectedAmountRange = '2000 - 3000'.obs;

  final List<String> amountRanges = [
    '2000 - 3000',
    '3100 - 5000',
    '5100 - 7000',
  ];
  void addDonation() async {
    if (nameC.text.isEmpty || projectNameC.text.isEmpty) {
      Get.snackbar(
        "Error",
        "الرجاء إدخال الاسم وإسم المشروع",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      // Check if the donation already exists
      var existingDonation = await _firestore
          .collection('donations')
          .where('name', isEqualTo: nameC.text)
          .where('projectName', isEqualTo: projectNameC.text)
          .get();

      if (existingDonation.docs.isNotEmpty) {
        Get.snackbar(
          "Error",
          "هذا التبرع موجود بالفعل",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }
      final docRef = _firestore.collection('donations').doc();
      // Data to be inserted
      final donationData = {
        'name': nameC.text,
        'phone': phoneC.text,
        'address': addressC.text,
        'email': emailC.text,
        'projectName': projectNameC.text,
        'donationAmount': donationAmountC.text,
        'selectedArena': selectedArena.value,
        'executionPeriod': '',
        'buildingDetails': buildingDetails.value,
        'beneficiaries': beneficiaries.value,
        'facilities': facilities.value,
        'cost': cost.value,
        'agent': '',
        'timestamp': FieldValue.serverTimestamp(),
        'docId': docRef.id,
        'projectType': projectNameC,
      };

      // Insert the data into Firestore
      await _firestore.collection('donations').add(donationData);
      addStatistics(cost.value);

      Get.snackbar(
        "Success",
        "تمت إضافة التبرع بنجاح",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Clear the form after successful submission
      nameC.clear();
      phoneC.clear();
      addressC.clear();
      emailC.clear();
      projectNameC.clear();
      donationAmountC.clear();
      selectedArena.value = '';
      executionPeriodC.value = '';
      buildingDetails.value = '';
      beneficiaries.value = '';

      facilities.value = '';
      selectedPrimaryField.value = '';
    } catch (e) {
      Get.snackbar(
        "Error",
        "حدث خطأ أثناء إضافة التبرع: $e",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> addStatistics(String donationsAmount) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('statistics').doc('donations');

      // Get the current document snapshot
      DocumentSnapshot snapshot = await docRef.get();

      // Check if the snapshot exists and if 'donationsAmount' field exists
      double currentDonationsAmount = 0.0;
      if (snapshot.exists && snapshot.data() != null) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        currentDonationsAmount = data['donationsAmount'] != null
            ? data['donationsAmount'].toDouble()
            : 0.0;
      }

      // Convert the incoming donationsAmount to a double
      double combinedCost = double.tryParse(donationsAmount) ?? 0.0;

      // Calculate the new total by adding the combinedCost to the current value
      double newDonationsAmount = currentDonationsAmount + combinedCost;

      // Update the document with the incremented 'number' and updated 'donationsAmount'
      await docRef.update({
        'number': FieldValue.increment(1), // Increment the 'number' field
        'donationsAmount': newDonationsAmount // Set the new total
      });

      print('Donations amount added successfully.');
    } catch (e) {
      print('Failed to add to donations amount: $e');
    }
  }

  @override
  void onClose() {
    nameC.dispose();
    phoneC.dispose();
    addressC.dispose();
    emailC.dispose();
    projectNameC.dispose();
    donationAmountC.dispose();

    super.onClose();
  }
}
