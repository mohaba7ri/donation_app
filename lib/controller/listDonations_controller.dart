// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class ListDonationsController extends GetxController {
//   final FirebaseFirestore firestore = FirebaseFirestore.instance;
//   var donations = <Map<String, dynamic>>[].obs;
//   var filteredDonations = <Map<String, dynamic>>[].obs;
//   var selectedFilter = 'الكل'.obs;
//   var searchQuery = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchDonations();
//   }

//   void fetchDonations() async {
//     try {
//       var snapshot = await firestore.collection('donations').get();
//       donations.value = snapshot.docs.map((doc) => doc.data()).toList();
//       applyFilter(); // Apply initial filter and search
//     } catch (e) {
//       print("Error fetching donations: $e");
//     }
//   }

//   void applyFilter() {
//     filteredDonations.value = donations.where((donation) {
//       bool matchesFilter = true;
//       bool matchesSearch = true;

//       // Apply filter
//       if (selectedFilter.value == 'المشاريع الإنشائية') {
//         matchesFilter = ['Musqe', 'Well'].contains(donation['projectType']);
//       }

//       // Apply search
//       if (searchQuery.value.isNotEmpty) {
//         final query = searchQuery.value.toLowerCase();
//         matchesSearch =
//             (donation['projectName']?.toLowerCase().contains(query) ?? false) ||
//                 (donation['name']?.toLowerCase().contains(query) ?? false);
//       }

//       return matchesFilter && matchesSearch;
//     }).toList();
//   }

//   void printDonation(Map<String, dynamic> donation) {
//     print(donation);
//   }
// }

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListDonationsController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var donations = <Map<String, dynamic>>[].obs;
  var filteredDonations = <Map<String, dynamic>>[].obs;
  var selectedFilter = 'الكل'.obs;
  var searchQuery = ''.obs;
  var countries = <String>[].obs;
  var selectedCountry = 'الكل'.obs; // Set default to 'الكل'
  var isLoading = false.obs;
  void startLoading() {
    isLoading.value = true;
  }

  void stopLoading() {
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchDonations();
    fetchCountries(); // Fetch countries on initialization
  }

  void fetchDonations() async {
    try {
      var snapshot = await firestore.collection('donations').get();
      donations.value = snapshot.docs.map((doc) => doc.data()).toList();
      applyFilter(); // Apply initial filter and search
    } catch (e) {
      print("Error fetching donations: $e");
    }
  }

  // Future<void> fetchDonations() async {
  //   try {
  //     final donationsRef = FirebaseFirestore.instance.collection('donations');
  //     final querySnapshot = await donationsRef.get();

  //     donations.value = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   } catch (e) {
  //     print('Error fetching donations: $e');
  //   }
  // }

  void fetchCountries() async {
    try {
      var snapshot = await firestore.collection('countries').get();
      var fetchedCountries =
          snapshot.docs.map((doc) => doc['name'] as String).toList();
      countries.value = [
        'الكل',
        ...fetchedCountries
      ]; // Ensure 'الكل' is the first and only instance
    } catch (e) {
      print("Error fetching countries: $e");
    }
  }

  void applyFilter() {
    filteredDonations.value = donations.where((donation) {
      bool matchesFilter = true;
      bool matchesSearch = true;
      bool matchesCountry = true;
      bool keyNet = true;

      // Apply type filter
      if (selectedFilter.value == 'المشاريع الإنشائية') {
        matchesFilter = ['Musqe', 'Well'].contains(donation['projectType']);
      }

      // Apply country filter
      if (selectedCountry.value != 'الكل') {
        matchesCountry = donation['country'] == selectedCountry.value;
      }

      // Apply search
      if (searchQuery.value.isNotEmpty) {
        final query = searchQuery.value.toLowerCase();
        matchesSearch =
            (donation['projectName']?.toLowerCase().contains(query) ?? false) ||
                (donation['name']?.toLowerCase().contains(query) ?? false) ||
                (donation['keyNet']?.toLowerCase().contains(query) ?? false);
      }

      return matchesFilter && matchesSearch && matchesCountry;
    }).toList();
  }

  void printDonation(Map<String, dynamic> donation) {
    print(donation);
  }

  void applySearchFilter() {
    // Apply search logic
    filteredDonations.value = donations.where((donation) {
      if (searchQuery.value.isNotEmpty) {
        final query = searchQuery.value.toLowerCase();
        return (donation['projectName']?.toLowerCase().contains(query) ??
                false) ||
            (donation['name']?.toLowerCase().contains(query) ?? false) ||
            (donation['keyNet']?.toLowerCase().contains(query) ?? false);
      }
      return true; // If the search query is empty, return all donations
    }).toList();
  }

  Future<void> updateDonationStatus(String donationId, String newStatus) async {
    try {
      // Get a reference to the Firestore collection where donations are stored
      final donationsRef = FirebaseFirestore.instance.collection('donations');

      // Update the status field of the specific donation document
      await donationsRef.doc(donationId).update({'status': newStatus});

      // Optionally, you can refresh the donations list after updating the status
      fetchDonations(); // Assuming you have a method to fetch donations
    } catch (e) {
      // Handle errors if needed
      print('Error updating donation status: $e');
    }
  }
}
