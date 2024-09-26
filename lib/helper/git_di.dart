import 'package:dontations_app/controller/add_musqeDonation_controller.dart';
import 'package:dontations_app/controller/add_constructionProject_controller.dart';
import 'package:dontations_app/controller/add_wellDonation_controller.dart';
import 'package:dontations_app/controller/closest_cost_controller.dart';
import 'package:dontations_app/controller/listDonations_controller.dart';
import 'package:dontations_app/controller/manage_mosqProject_controller.dart';
import 'package:dontations_app/controller/contries_controller.dart';
import 'package:dontations_app/controller/donation_details_controller.dart';
import 'package:dontations_app/controller/donations_desktop_controller.dart';
import 'package:dontations_app/controller/edit_profile_controller.dart';
import 'package:dontations_app/controller/forget_password_controller.dart';
import 'package:dontations_app/controller/home_controller.dart';
import 'package:dontations_app/controller/list_constructionProjects_controller.dart';
import 'package:dontations_app/controller/list_constructionTypes_controller.dart';
import 'package:dontations_app/controller/list_projects_subTypes_controller.dart';
import 'package:dontations_app/controller/list_projects_types_controller.dart';
import 'package:dontations_app/controller/login_controller.dart';
import 'package:dontations_app/controller/managePlans_controller.dart';
import 'package:dontations_app/controller/manageSentences_controller.dart';
import 'package:dontations_app/controller/manageUser_controller.dart';
import 'package:dontations_app/controller/manage_wellProject_controller.dart';
import 'package:dontations_app/views/desktop/manageUser_desktop.dart';
import 'package:get/get.dart';

Future init() async {
  // final sharedPreferences = await SharedPreferences.getInstance();
  // Get.lazyPut(() => sharedPreferences, fenix: true);
  // Get.lazyPut(() => LoginController(sharedPreferences: Get.find()),
  //     fenix: true);

  Get.lazyPut(() => LoginController(), fenix: true);

  Get.lazyPut(() => EditProfileController(), fenix: true);
  Get.lazyPut(() => ManageSentencesController(), fenix: true);
  Get.lazyPut(() => ManagePlansController(), fenix: true);
  Get.lazyPut(() => ForgetPasswordController(), fenix: true);
  Get.lazyPut(() => AddMusqeDonationController(), fenix: true);
  Get.lazyPut(() => AddConstructionProjectController(), fenix: true);
  Get.lazyPut(() => DonationsListController(), fenix: true);
  Get.lazyPut(() => DonationDetailsController(), fenix: true);
  Get.lazyPut(() => ListProjectSubTypesController(), fenix: true);
  Get.lazyPut(() => ListProjectTypesController(), fenix: true);
  Get.lazyPut(() => CountriesController(), fenix: true);
  Get.lazyPut(() => HomeController(), fenix: true);
  Get.lazyPut(() => ListConstructionTypesController(), fenix: true);
  Get.lazyPut(() => ManageMosqProjectController(), fenix: true);
  Get.lazyPut(() => ListConstructionProjectsController(), fenix: true);
  Get.lazyPut(() => ManageUserController(), fenix: true);

  Get.lazyPut(() => AddWellDonationController(), fenix: true);
  Get.lazyPut(() => ManageWellProjectController(), fenix: true);
  Get.lazyPut(() => ClosestCostController(), fenix: true);
  Get.lazyPut(() => ListDonationsController(), fenix: true);
}
