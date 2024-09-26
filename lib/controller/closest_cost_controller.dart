import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ClosestCostController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<DocumentSnapshot> closestDocs = RxList<DocumentSnapshot>();
  RxDouble closestCompareCost = RxDouble(double.infinity);
  RxBool isLoading = false.obs;
  var selectedCostType = ''.obs;
  var combinedCost = ''.obs;

  void updateSelectedCost(String? costType, String compareCost) {
    // If the radio button is selected, append the corresponding cost value; otherwise, append the compare cost
    combinedCost.value = costType?.isNotEmpty == true ? costType! : compareCost;
  }

  var nameC = TextEditingController();
  var phoneC = TextEditingController();
  var addressC = TextEditingController();
  var emailC = TextEditingController();
  var projectNameC = TextEditingController();

  RxString countryName = ''.obs;

  // Future<void> getClosestCosts(String userAmountString) async {
  //   isLoading.value = true;
  //   RxString executionPeriod = ''.obs;
  //   RxString buildingDetails = ''.obs;
  //   RxString beneficiaries = ''.obs;
  //   RxString zincCost = ''.obs;
  //   RxString concreteCost = ''.obs;
  //   RxString facilities = ''.obs;
  //   // Convert the userAmount from String to double
  //   double userAmount = double.tryParse(userAmountString) ?? 0.0;

  //   // List to store documents that are close to the user amount
  //   List<DocumentSnapshot> foundDocs = [];

  //   // Variables to store the closest match across all collections
  //   double closestCompareCostTemp = double.infinity;

  //   // List of subcollections to query
  //   List<String> subcollections = ['Mosque', 'Well'];

  //   try {
  //     for (String subcollection in subcollections) {
  //       QuerySnapshot querySnapshot = await firestore
  //           .collection('projects')
  //           .doc('constructions')
  //           .collection(subcollection)
  //           .get(); // Fetch all documents from each subcollection

  //       // Iterate over the results to find the closest ones
  //       for (var doc in querySnapshot.docs) {
  //         // Convert compareCost from String to double
  //         double compareCost =
  //             double.tryParse(doc['compareCost']?.toString() ?? '') ??
  //                 double.infinity;

  //         // Check if this document is close to the userAmount
  //         if ((compareCost - userAmount).abs() <=
  //             (closestCompareCostTemp - userAmount).abs()) {
  //           if ((compareCost - userAmount).abs() < closestCompareCostTemp) {
  //             foundDocs.clear(); // Clear previous closest documents
  //             closestCompareCostTemp = compareCost;
  //           }
  //           foundDocs.add(doc); // Add the document to the list
  //           countryName.value = doc['country'];
  //           fetchAgents();
  //         }
  //       }
  //     }
  //     // Update the observable variables
  //     closestCompareCost.value = closestCompareCostTemp;
  //     closestDocs.value = foundDocs;
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to fetch the closest costs: $e',
  //         snackPosition: SnackPosition.BOTTOM);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> getClosestCosts(String userAmountString) async {
    isLoading.value = true;
    RxString executionPeriod = ''.obs;
    RxString buildingDetails = ''.obs;
    RxString beneficiaries = ''.obs;
    RxString zincCost = ''.obs;
    RxString concreteCost = ''.obs;
    RxString facilities = ''.obs;

    // Convert the userAmount from String to double
    double userAmount = double.tryParse(userAmountString) ?? 0.0;

    // Variable to store the closest document
    DocumentSnapshot? closestDoc;
    double closestCompareCostTemp = double.infinity;

    // List of subcollections to query
    List<String> subcollections = ['Mosque', 'Well'];

    try {
      for (String subcollection in subcollections) {
        QuerySnapshot querySnapshot = await firestore
            .collection('projects')
            .doc('constructions')
            .collection(subcollection)
            .get(); // Fetch all documents from each subcollection

        // Iterate over the results to find the closest one
        for (var doc in querySnapshot.docs) {
          // Convert compareCost from String to double
          double compareCost =
              double.tryParse(doc['compareCost']?.toString() ?? '') ??
                  double.infinity;

          // Check if this document is closer to the userAmount than the current closest
          if ((compareCost - userAmount).abs() <
              (closestCompareCostTemp - userAmount).abs()) {
            closestCompareCostTemp = compareCost;
            closestDoc = doc; // Update the closest document
          }
        }
      }

      // If a closest document is found, update the values and fetch agents
      if (closestDoc != null) {
        closestCompareCost.value = closestCompareCostTemp;
        closestDocs.value = [closestDoc]; // Store only the closest document
        countryName.value = closestDoc['country'];
        fetchAgents(); // Fetch agents only once for the closest document
      } else {
        Get.snackbar('No Match', 'No costs close to the specified amount.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch the closest costs: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addDonation(
    String projectType,
    String arena,
    String executionPeriod,
    String buildingDetails,
    String beneficiaries,
    String facilities,
    String country,
    String combinedCost,
  ) async {
    isLoading.value = true;
    try {
      String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

      final donationData = {
        'name': nameC.text,
        'phone': phoneC.text,
        'address': addressC.text,
        'email': emailC.text,
        'projectType': projectType,
        'country': country,
        'projectName': projectNameC.text,
        'selectedArena': arena,
        'executionPeriod': executionPeriod,
        'buildingDetails': buildingDetails,
        'beneficiaries': beneficiaries,
        'facilities': facilities,
        'agent': selectedAgent.value,
        'timestamp': FieldValue.serverTimestamp(), // Add a timestamp
        'date': formattedDate,
        'cost': combinedCost,
      };

      await firestore.collection('donations').add(donationData);
      Get.snackbar('', 'تم إضافة التبرع');
      addStatistics(combinedCost);
    } catch (e) {
      Get.snackbar('', ' لم يتم إضافة التبرع بسبب : $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> addStatistics(String donationsAmount) async {
  //   try {
  //     DocumentReference docRef =
  //         FirebaseFirestore.instance.collection('statistics').doc('donations');

  //     await docRef.update(
  //         {'number': FieldValue.increment(1), 'donationsAmount': combinedCost});

  //     print('Donations count incremented successfully.');
  //   } catch (e) {
  //     print('Failed to increment donations count: $e');
  //   }
  // }

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

  final selectedAgent = ''.obs;
  final List<String> agents = <String>[].obs;

  void fetchAgents() async {
    try {
      // Clear the agents list before fetching new data
      agents.clear();

      var countrySnapshot = await firestore
          .collection('countries')
          .where('name', isEqualTo: countryName.value)
          .get();

      if (countrySnapshot.docs.isNotEmpty) {
        var conDocId = countrySnapshot.docs.first.id;

        var querySnapshot = await firestore
            .collection('countries')
            .doc(conDocId)
            .collection('agents')
            .get();

        Set<String> uniqueAgents = {};

        uniqueAgents.addAll(querySnapshot.docs
            .map((doc) => doc['agentName'] as String)
            .toList());

        agents.addAll(uniqueAgents);

        // Check if the currently selected agent is still valid
        if (!agents.contains(selectedAgent.value)) {
          selectedAgent.value = ''; // Reset the selected value if not valid
        }
      } else {
        print("No country found with the name '${countryName.value}'");
      }
    } catch (e) {
      print("Error fetching agents: $e");
    }
  }
}
