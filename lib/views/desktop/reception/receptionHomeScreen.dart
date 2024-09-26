import 'package:dontations_app/controller/listDonationsforAccount_controller.dart';
import 'package:dontations_app/routes/app_pages.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/views/desktop/list_countries_desktop.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReceptionHomeScreen extends GetView<ListDonationsForAccountController> {
  // Ensure to initialize the controller
  ReceptionHomeScreen({Key? key}) : super(key: key) {
    Get.put(
        ListDonationsForAccountController()); // Initialize the controller if not already done
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // Set the desired height
        child: AppBar(
          backgroundColor: AppColor.appBarColor,
          title: Text('مرحباً بك', style: robotoHugeWhite),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.redColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
                onPressed: () {
                  Get.offAndToNamed(Routes.LOGIN);
                },
                child: SizedBox(
                  child: Text(
                    'تسجيل الخروج',
                    style: robotoMediumWhite,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // New donation button
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.buttonColor,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Get.to(
                      ListCountriesDesktopScreen()); // Navigate to add donation page
                },
                child: Text(
                  'إضافة تبرع جديد',
                  style: robotoMediumWhite,
                ),
              ),
            ),

            SizedBox(height: 20), // Space between button and list

            Text('قائمة التبرعات', style: TextStyle(fontSize: 20)),

            SizedBox(height: 10), // Space between title and donations list
            Expanded(
              child: Obx(() {
                // Check if donations are still loading
                if (controller.donations.isEmpty &&
                    controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.filteredDonations.isEmpty) {
                  return Center(child: Text('لا توجد تبرعات متاحة.'));
                } else {
                  return ListView.builder(
                    itemCount: controller.filteredDonations.length,
                    itemBuilder: (context, index) {
                      final donation = controller.filteredDonations[index];
                      return _buildDonationTile(donation);
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonationTile(Map<String, dynamic> donation) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        // Gradient background with a subtle effect
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Dim shadow
            blurRadius: 10, // Softening the shadow edges
            spreadRadius: 2,
            offset: Offset(0, 6), // Shadow position (downwards)
          ),
        ],
        border:
            Border.all(color: Colors.grey.shade300), // Adding a light border
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project name
          Text(
            'إسم المشروع: ${donation['projectName'] ?? 'اسم المشروع غير متوفر'}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 8), // Space between rows

          // Donor name
          Row(
            children: [
              Icon(Icons.person, color: Colors.grey.shade600, size: 20),
              SizedBox(width: 8),
              Text(
                'اسم المتبرع: ${donation['name'] ?? 'غير متوفر'}',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
            ],
          ),
          SizedBox(height: 5),

          // KeyNet field
          Row(
            children: [
              Icon(Icons.payment, color: Colors.grey.shade600, size: 20),
              SizedBox(width: 8),
              Text(
                'كي نت: ${donation['keyNet'] ?? 'غير معرف'}',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
            ],
          ),
          SizedBox(height: 5),

          // Project cost
          Row(
            children: [
              Icon(Icons.monetization_on,
                  color: Colors.grey.shade600, size: 20),
              SizedBox(width: 8),
              Text(
                'تكلفة المشروع: ${donation['cost'] ?? 'غير محدد'}',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
            ],
          ),
          SizedBox(height: 5),

          // Date of the donation
          Row(
            children: [
              Icon(Icons.calendar_today, color: Colors.grey.shade600, size: 20),
              SizedBox(width: 8),
              Text(
                'التاريخ: ${donation['date'] ?? 'غير محدد'}',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
