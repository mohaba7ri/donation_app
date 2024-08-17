import 'package:dontations_app/views/add_donation.dart';
import 'package:dontations_app/views/desktop/manageUser_desktop.dart';
import 'package:dontations_app/views/desktop/donations/add_newConstructionDonation_desktop.dart';
import 'package:dontations_app/views/desktop/add_constructionProject_desktop.dart';
import 'package:dontations_app/views/desktop/add_oldConstructionDonation_desktop.dart';
import 'package:dontations_app/views/desktop/countries_managemant_desktop.dart';
import 'package:dontations_app/views/desktop/donation_details_desktop.dart';
import 'package:dontations_app/views/desktop/donations_desktop.dart';
import 'package:dontations_app/views/desktop/home_desktop.dart';
import 'package:dontations_app/views/desktop/list_constructionProjects_desktop.dart';
import 'package:dontations_app/views/desktop/list_construction_types_desktop.dart';
import 'package:dontations_app/views/desktop/list_countries_desktop.dart';
import 'package:dontations_app/views/desktop/list_project_types_desktop.dart';
import 'package:dontations_app/views/desktop/list_projects_subTypes_desktop.dart';
import 'package:dontations_app/views/desktop/project_management/list_construction2_types_desktop.dart';
import 'package:dontations_app/views/desktop/project_management/manage_mosq_projects.dart';
import 'package:dontations_app/views/login.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: _Paths.ADDNEWCONSTRUCTIONDONATIONSCREEN,
      page: () => AddNewConstructionDonationDesktopScreen(),
    ),
    GetPage(
      name: _Paths.ADDOLDCONSTRUCTIONDONATIONSCREEN,
      page: () => AddOldConstructionDonationDesktopScreen(),
    ),
    GetPage(
      name: _Paths.ADDCONSTRUCTIONPROJECTSCREEN,
      page: () => AddConstructionProjectScreen(),
    ),
    GetPage(
      name: _Paths.DONATIONSLISTDESKTOPSCREEN,
      page: () => DonationsListDesktopScreen(),
    ),
    GetPage(
      name: _Paths.DONATIONDETAILSDESKTOPSCREEN,
      page: () => DonationDetailsDesktopScreen(),
    ),
    GetPage(
      name: _Paths.LISTPROJECTSTYPESDESKTOPSCREEN,
      page: () => ListProjectTypesDesktopScreen(),
    ),
    GetPage(
      name: _Paths.LISTPROJECTSSUBTYPESDESKTOPSCREEN,
      page: () => ListProjectSubTypesDesktopScreen(),
    ),
    GetPage(
      name: _Paths.COUNTRIESDESKTOPSCREEN,
      page: () => CountriesDesktopScreen(),
    ),
    GetPage(
      name: _Paths.HOMEDESKTOPSCREEN,
      page: () => HomeDesktopScreen(),
    ),
    GetPage(
      name: _Paths.LISTCONSTRUCTIONTYPESSCREEN,
      page: () => ListConstructionTypesDesktopScreen(),
    ),
    GetPage(
      name: _Paths.LISTCOUNTRIESDESKTOPSCREEN,
      page: () => ListCountriesDesktopScreen(),
    ),
    GetPage(
      name: _Paths.LISTCONSTRUCTIONPROJECTSDESKTOPSCREEN,
      page: () => ListConstructionProjectsDesktopScreen(),
    ),

    GetPage(
      name: _Paths.MANAGEUSERDESKTOPSCREEN,
      page: () => ManageUserDesktopScreen(),
    ),

    GetPage(
      name: _Paths.LISTCONSTRUCTIONTYPES2DESKTOPSCREEN,
      page: () => ListConstructionTypes2DesktopScreen(),
    ),
    GetPage(
      name: _Paths.MANAGEMOSQPROJECTSCREEN,
      page: () => ManageMosqProjectDesktopScreen(),
    ),
    // GetPage(
    //   name: _Paths.SIGNUPSCREEN,
    //   page: () => SignUpScreen(),
    // ),

    // GetPage(
    //   name: _Paths.EDITPROFILESCREEN,
    //   page: () => EditProfileScreen(),
    // ),
    //   GetPage(
    //   name: _Paths.WELCOMESCREEN,
    //   page: () => WelcomeScreen(),
    // ),
    //     GetPage(
    //   name: _Paths.HOMESCREEN,
    //   page: () => HomeScreen(),
    // ),
    //   GetPage(
    //   name: _Paths.STARTTESTSCREEN,
    //   page: () => StartTestScreen(),
    // ),
    //  GetPage(
    //   name: _Paths.MANAGESENTENCESSCREEN,
    //   page: () => ManageSentences(),
    // ),
    //   GetPage(
    //   name: _Paths.MANAGEPLANSSCREEN,
    //   page: () => ManagePlans(),
    // ),
    //  GetPage(
    //   name: _Paths.ADMINHOMESCREEN,
    //   page: () => AdminHomeScreen(),
    // ),
    //    GetPage(
    //   name: _Paths.HISTORYSCREEN,
    //   page: () => HistoryScreen(),
    // ),
    //  GetPage(
    //   name: _Paths.RESULTSCREEN,
    //   page: () => ResultScreen(),
    // ),
    //   GetPage(
    //   name: _Paths.FORGETPASSWORDSCREEN,
    //   page: () => ForgetPasswordScreen(),
    // ),
  ];
}
