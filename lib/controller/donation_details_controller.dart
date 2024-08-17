import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DonationDetailsController extends GetxController {
  var projectName = "مشروع بناء مسجد";
  var executingAgency = "جمعية خيرية";
  var executionPeriod = "6 شهور";
  var beneficiaries = 150;
  var projectType = "بناء";
  var location = "الرياض";
  var buildingDetails = "تفاصيل البناء هنا";
  var executionDate = "10-08-2024";

  var donors = [
    {"name": "أحمد", "amount": 5000, "currency": "KWD"},
    {"name": "محمد", "amount": 3000, "currency": "KWD"},
    {"name": "فاطمة", "amount": 2000, "currency": "KWD"},
  ].obs;

  void updateProjectDetails({
    required String newProjectType,
    required String newLocation,
    required String newBuildingDetails,
    required String newExecutionDate,
  }) {
    projectType = newProjectType;
    location = newLocation;
    buildingDetails = newBuildingDetails;
    executionDate = newExecutionDate;
  }

  void addDonor(String name, double amount, String currency) {
    donors.add({"name": name, "amount": amount, "currency": currency});
  }
}
