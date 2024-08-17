import 'package:dontations_app/controller/add_newDonation_controller.dart';
import 'package:dontations_app/controller/add_constructionProject_controller.dart';
import 'package:dontations_app/controller/donations_desktop_controller.dart';
import 'package:dontations_app/routes/app_pages.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class DonationsListDesktopScreen extends GetView<DonationsListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        iconTheme: IconThemeData(color: AppColor.buttonColor),
        title: Text(
          "قائمة التبرعات".tr,
          style: robotoHugeWhite,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the Add Donation Screen
                    Get.toNamed(Routes.LISTPROJECTSTYPESDESKTOPSCREEN);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    "إضافة تبرع جديد".tr,
                    style: robotoHugeBlack,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "قائمة التبرعات".tr,
                        style: robotoHugeBlack,
                      ),
                      SizedBox(height: 20.0),
                      Expanded(
                        child: Obx(() {
                          if (controller.donations.isEmpty) {
                            return Center(
                              child: Text(
                                "لا توجد تبرعات متاحة".tr,
                                style: robotoMediumBold,
                              ),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: controller.donations.length,
                              itemBuilder: (context, index) {
                                final donation = controller.donations[index];
                                return ListTile(
                                  title: Text(
                                    "إسم المشروع: ${donation['projectName']}",
                                    style: robotoMediumBold,
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Text(
                                        "عدد المتبرعين ${donation['donorNumber']} - ${donation['amount']} ${donation['currency']}",
                                        style: robotoMediumBold,
                                      ),
                                      Text(
                                        "قيمة المشروع: ${donation['amount']}",
                                        style: robotoMediumBold,
                                      ),
                                      Text(
                                        "المكان: ${donation['country']}",
                                        style: robotoMediumBold,
                                      ),
                                    ],
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios),
                                  onTap: () {
                                    // Navigate to donation details or edit
                                  },
                                );
                              },
                            );
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
