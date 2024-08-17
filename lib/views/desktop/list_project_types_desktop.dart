import 'package:dontations_app/controller/add_newDonation_controller.dart';
import 'package:dontations_app/controller/add_constructionProject_controller.dart';
import 'package:dontations_app/controller/donations_desktop_controller.dart';
import 'package:dontations_app/controller/list_projects_types_controller.dart';
import 'package:dontations_app/routes/app_pages.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ListProjectTypesDesktopScreen
    extends GetView<ListProjectTypesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        iconTheme: IconThemeData(color: AppColor.whiteColor),
        title: Text(
          "قائمة المشاريع".tr,
          style: robotoHugeWhite,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Obx(() {
                  if (controller.donations.isEmpty) {
                    return Center(
                      child: Text(
                        "لا توجد مشاريع متاحة".tr,
                        style: robotoMediumBold,
                      ),
                    );
                  } else {
                    return SizedBox(
                      height: MediaQuery.of(context)
                          .size
                          .height, // Adjust the height as needed
                      child: ListView.builder(
                        itemCount: controller.donations.length,
                        itemBuilder: (context, index) {
                          final donation = controller.donations[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColor.appBarColor,
                                  borderRadius: BorderRadius.circular(18)),
                              child: ListTile(
                                leading: Icon(
                                  donation['icon'],
                                  color: AppColor.whiteColor,
                                  size: 32,
                                ),
                                title: Text(
                                  "${donation['projectName']}",
                                  style: robotoHugeWhite,
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColor.whiteColor,
                                  size: 32,
                                ),
                                onTap: () {
                                  Get.toNamed(
                                    Routes.LISTCONSTRUCTIONTYPESSCREEN,
                                    arguments: donation[
                                        'projectName'], // Passing the project name
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
