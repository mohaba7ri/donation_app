import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dontations_app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  var numberValue = "....".obs;
  var totalDonations = "....".obs;
  var role = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchNumber();
    final box = GetStorage();
    role.value = box.read('role') ?? '';
  }

  void fetchNumber() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('statistics')
          .doc('donations')
          .get();

      // Get the 'number' field from the document and update the reactive variable
      numberValue.value = snapshot.get('number').toString();
      totalDonations.value = snapshot.get('donationsAmount').toString();
    } catch (e) {
      print("Error fetching data: $e");
      numberValue.value = "Error!";
      totalDonations.value = "Error!";
    }
  }

  void onMenuItemClicked(int index) {
    selectedIndex.value = index;
  }
}
