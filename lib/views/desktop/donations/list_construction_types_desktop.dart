import 'package:dontations_app/controller/list_constructionTypes_controller.dart';
import 'package:dontations_app/routes/app_pages.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ListConstructionTypesDesktopScreen
    extends GetView<ListConstructionTypesController> {
  final String countryName = Get.arguments;
  // final String projectName = Get.arguments;

  Widget buildSection(
      BuildContext context,
      String sectionTitle,
      List<Map<String, dynamic>> donations,
      Function(Map<String, dynamic>) onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            sectionTitle,
            style: robotoHugeBlack.copyWith(fontSize: 24),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: donations.length,
          itemBuilder: (context, index) {
            final donation = donations[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.appBarColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ListTile(
                  title: Text(
                    "${donation['projectName']}",
                    style: robotoHugeWhite,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: AppColor.whiteColor,
                    size: 32,
                  ),
                  onTap: () => onTap(donation),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        iconTheme: IconThemeData(color: AppColor.whiteColor),
        title: Text(
          "$countryName".tr,
          style: robotoHugeWhite,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.donations.isEmpty) {
                  return Center(
                    child: Text(
                      "لا توجد مشاريع متاحة".tr,
                      style: robotoMediumBold,
                    ),
                  );
                } else {
                  return ListView(
                    children: [
                      buildSection(
                        context,
                        'المساجد',
                        controller.masajidDonations,
                        (donation) {
                          Get.toNamed(
                            Routes.ADDNEWCONSTRUCTIONDONATIONSCREEN,
                            arguments: {
                              'countryName': countryName,
                              'projectName': donation['projectName'],
                            },
                          );
                        },
                      ),
                      buildSection(
                        context,
                        'الآبار',
                        controller.abaarDonations,
                        (donation) {
                          Get.toNamed(
                            Routes.ADDWELLDONATIONSCREEN,
                            arguments: {
                              'countryName': countryName,
                              'projectName': donation['projectName'],
                            },
                          );
                        },
                      ),
                    ],
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
