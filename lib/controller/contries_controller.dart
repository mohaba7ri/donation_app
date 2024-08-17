import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CountriesController extends GetxController {
  // List to hold countries (from Firestore)
  var countries = <Map<String, dynamic>>[].obs;

  // Loading state
  var isLoading = false.obs;

  // Text editing controllers for the country name and agent inputs
  var countryNameController = TextEditingController();
  var agent1Controller = TextEditingController();
  var agent2Controller = TextEditingController();

  // Firestore reference
  final CollectionReference countriesRef =
      FirebaseFirestore.instance.collection('countries');

  @override
  void onInit() {
    super.onInit();
    fetchCountries();
  }

  @override
  void onClose() {
    countryNameController.dispose();
    agent1Controller.dispose();
    agent2Controller.dispose();
    super.onClose();
  }

  // Function to add a new country to Firestore
  void addCountry() async {
    if (countryNameController.text.isNotEmpty) {
      // Prevent the button from being pressed twice
      if (isLoading.value) return;

      isLoading.value = true;

      try {
        // Check if the country already exists
        QuerySnapshot existingCountry = await countriesRef
            .where('name', isEqualTo: countryNameController.text)
            .get();

        if (existingCountry.docs.isNotEmpty) {
          Get.snackbar('Error', 'This country already exists.');
        } else {
          String formattedDate =
              DateFormat('dd/MM/yyyy').format(DateTime.now());
          await countriesRef.add({
            'name': countryNameController.text,
            'agent1': agent1Controller.text,
            'agent2': agent2Controller.text,
            'entryDate': formattedDate,
          });
          fetchCountries();
          clearFields();
        }
      } catch (e) {
        Get.snackbar('Error', 'Failed to add country: $e');
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar('Error', 'Please enter the country name.');
    }
  }

  // Function to fetch countries from Firestore
  Future<void> fetchCountries() async {
    try {
      isLoading.value = true;
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('countries').get();
      countries.clear();
      for (var doc in snapshot.docs) {
        countries.add(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching countries: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Function to delete a country from Firestore
  void deleteCountry(String id) async {
    try {
      await countriesRef.doc(id).delete();
      fetchCountries();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete country: $e');
    }
  }

  // Function to clear input fields
  void clearFields() {
    countryNameController.clear();
    agent1Controller.clear();
    agent2Controller.clear();
  }
}
