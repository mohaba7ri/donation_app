import 'package:dontations_app/controller/add_wellDonation_controller.dart';
import 'package:dontations_app/views/add_donation.dart';
import 'package:dontations_app/views/desktop/accountant/accountHomeScreen.dart';
import 'package:dontations_app/views/desktop/accountant/listDonationsForAccount.dart';
import 'package:dontations_app/views/desktop/donations/views/add_musqeDonation2_desktop.dart';
import 'package:dontations_app/views/desktop/donations/views/add_wellDonation_desktop.dart';
import 'package:dontations_app/views/desktop/donations/views/listDonations_screen.dart';
import 'package:dontations_app/views/desktop/donations/views/manageDonations_screen.dart';
import 'package:dontations_app/views/desktop/donations/views/print_test_screen.dart';
import 'package:dontations_app/views/desktop/manageUser_desktop.dart';
import 'package:dontations_app/views/desktop/donations/add_newConstructionDonation_desktop.dart';
import 'package:dontations_app/views/desktop/add_constructionProject_desktop.dart';
import 'package:dontations_app/views/desktop/add_oldConstructionDonation_desktop.dart';
import 'package:dontations_app/views/desktop/countries_managemant_desktop.dart';
import 'package:dontations_app/views/desktop/donation_details_desktop.dart';
import 'package:dontations_app/views/desktop/donations_desktop.dart';
import 'package:dontations_app/views/desktop/home_desktop.dart';
import 'package:dontations_app/views/desktop/list_constructionProjects_desktop.dart';
import 'package:dontations_app/views/desktop/donations/list_construction_types_desktop.dart';
import 'package:dontations_app/views/desktop/list_countries_desktop.dart';
import 'package:dontations_app/views/desktop/donations/list_project_types_desktop.dart';
import 'package:dontations_app/views/desktop/list_projects_subTypes_desktop.dart';
import 'package:dontations_app/views/desktop/project_management/list_construction2_types_desktop.dart';
import 'package:dontations_app/views/desktop/project_management/manage_mosq_projects.dart';
import 'package:dontations_app/views/desktop/project_management/manage_well_projects.dart';
import 'package:dontations_app/views/desktop/reception/receptionHomeScreen.dart';
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
      page: () => AddNewConstructionDonation2DesktopScreen(),
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

    GetPage(
      name: _Paths.ADDWELLDONATIONSCREEN,
      page: () => AddWellDonationDesktopScreen(),
    ),
    GetPage(
      name: _Paths.MANAGEWELLPROJECTSSCREEN,
      page: () => ManageWellProjectDesktopScreen(),
    ),
    GetPage(
        name: _Paths.LISTDONATIONSSCREEN, page: () => ListDonationsScreen()),

    GetPage(
        name: _Paths.DONATIONSMANAGESCREEN,
        page: () => DonationManagementScreen()),
    GetPage(
        name: _Paths.ACCOUNTANT_HOMESCREEN,
        page: () => ListDonationsForAccountScreen()),
    GetPage(
        name: _Paths.RECEPTION_HOMESCREEN, page: () => ReceptionHomeScreen()),
    // GetPage(
    //   name: _Paths.PRINTTEST,
    //   page: () => PdfReportPage(),
    // ),
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
