import 'package:get/get.dart';

class ListConstructionProjectsController extends GetxController {
  // List to hold donation data as a list of maps
  var donations = <Map<String, dynamic>>[].obs;
  var filteredDonations = <Map<String, dynamic>>[].obs;

  var donations2 = <Map<String, dynamic>>[].obs;
  var filteredDonations2 = <Map<String, dynamic>>[].obs;
  @override
  void onInit() {
    super.onInit();
    // Fetch initial data (for example, from a database or API)
    fetchDonations();
    filteredDonations.value = donations;
    filteredDonations2.value = donations2;
  }

  // Method to fetch donations
  void fetchDonations() {
    // Simulated data fetch
    donations.value = [
      {
        'projectName': 'مسجد الرحمة',
      },
      {
        'projectName': 'مسجد الفرقان',
      },
      {
        'projectName': 'مسجد الخير',
      },
      {
        'projectName': 'مسجد النور',
      },
      {
        'projectName': 'مسجد الهدى',
      },
      {
        'projectName': 'مسجد الفاروق',
      },
      {
        'projectName': 'مسجد التوحيد',
      },
    ];

    donations2.value = [
      {
        'projectName': 'مسجد الرحمة',
      },
      {
        'projectName': 'مسجد الفرقان',
      },
      {
        'projectName': 'مسجد الخير',
      },
      {
        'projectName': 'مسجد النور',
      },
      {
        'projectName': 'مسجد الهدى',
      },
      {
        'projectName': 'مسجد الفاروق',
      },
      {
        'projectName': 'مسجد التوحيد',
      },
    ];
  }

  void searchDonations(String query) {
    if (query.isEmpty) {
      filteredDonations.value = donations;
    } else {
      filteredDonations.value = donations
          .where((donation) => donation['projectName']
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
  }
}
