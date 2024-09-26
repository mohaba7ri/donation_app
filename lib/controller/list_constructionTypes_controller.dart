import 'package:get/get.dart';

class ListConstructionTypesController extends GetxController {
  // List to hold donation data as a list of maps
  var donations = <Map<String, dynamic>>[].obs;

  var masajidDonations = <Map<String, dynamic>>[].obs;
  var abaarDonations = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDonations();
    categorizeDonations();

    // args = Get.arguments;
    // countryName = args['countryName'] as String;
    // projectType = args['projectType'] as String;
  }

  // Method to fetch donations
  void fetchDonations() {
    donations.value = [
      {'projectName': 'المساجد'},
      {'projectName': 'المسجد النموذجي ( محراب )'},
      {'projectName': 'الجامع الكبير'},
      {'projectName': 'مشروع إعمار'},
      {'projectName': 'آبار سطحية'},
      {'projectName': 'آبار ارتوازية'},
      {'projectName': 'بناء الكليات'},
    ];
  }

  void categorizeDonations() {
    masajidDonations.value = donations
        .where((donation) =>
            donation['projectName'].contains('مسجد') ||
            donation['projectName'].contains('الجامع'))
        .toList();
    abaarDonations.value = donations
        .where((donation) => donation['projectName'].contains('آبار'))
        .toList();
  }
}
