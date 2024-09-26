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

class ListDonationsForAccountController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  var searchQuery = ''.obs;
  var donations =
      <Map<String, dynamic>>[].obs; // Populate with your donation data
  var filteredDonations =
      <Map<String, dynamic>>[].obs; // Will hold filtered results
  var isLoading = true.obs;
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
  }

  void fetchDonations() async {
    try {
      startLoading();
      var snapshot = await firestore.collection('donations').get();
      donations.value = snapshot.docs.map((doc) => doc.data()).toList();
      applySearchFilter(); // Apply filter right after fetching
      stopLoading();
    } catch (e) {
      print("Error fetching donations: $e");
      stopLoading();
    }
  }

  void applySearchFilter() {
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value.toLowerCase();
      filteredDonations.value = donations.where((donation) {
        return (donation['projectName']?.toLowerCase().contains(query) ??
                false) ||
            (donation['name']?.toLowerCase().contains(query) ?? false) ||
            (donation['keyNet']?.toLowerCase().contains(query) ?? false);
      }).toList();
    } else {
      // If search query is empty, show all donations
      filteredDonations.value = donations;
    }
  }
}
