import 'package:get/get.dart';

class DonationsListController extends GetxController {
  // List to hold donation data as a list of maps
  var donations = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch initial data (for example, from a database or API)
    fetchDonations();
  }

  // Method to fetch donations
  void fetchDonations() {
    // Simulated data fetch
    donations.value = [
      {
        'donorNumber': '36',
        'projectName': 'بناء مسجد',
        'amount': 1000.0,
        'currency': 'KW',
        'country': 'غانا',
      },
      {
        'donorNumber': '12',
        'projectName': 'حفر بئر',
        'amount': 2000.0,
        'currency': 'KW',
        'country': 'اليمن',
      },
      // Add more donations as needed
    ];
  }

  // Method to navigate to the AddDonationScreen
  void navigateToAddDonation() {
    // Get.to(() => AddDonationScreen());
  }
}
