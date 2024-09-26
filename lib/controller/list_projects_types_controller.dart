import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListProjectTypesController extends GetxController {
  var donations = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDonations();
  }

  void fetchDonations() {
    donations.value = [
      // {
      //   'projectName': 'زكاة',
      //   'icon': Icons.monetization_on, // Example icon
      // },
      // {
      //   'projectName': 'صدقات عامة',
      //   'icon': Icons.volunteer_activism, // Example icon
      // },
      // {
      //   'projectName': 'وقفيات',
      //   'icon': Icons.build, // Example icon
      // },
      // {
      //   'projectName': 'كفارات',
      //   'icon': Icons.support_agent, // Example icon
      // },
      // {
      //   'projectName': 'كفالات',
      //   'icon': Icons.handshake, // Example icon
      // },
      // {
      //   'projectName': 'إغاثة',
      //   'icon': Icons.local_hospital, // Example icon
      // },
      // {
      //   'projectName': 'مشاريع دعوية',
      //   'icon': Icons.school, // Example icon
      // },
      {
        'projectName': 'مشاريع إنشائية',
        'icon': Icons.construction, // Example icon
      },
      {
        'projectName': 'مشاريع عامة',
        'icon': Icons.public, // Example icon
      },
    ];
  }
}
