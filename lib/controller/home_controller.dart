import 'package:dontations_app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  void onMenuItemClicked(int index) {
    selectedIndex.value = index;
  }
}
