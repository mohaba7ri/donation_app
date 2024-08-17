import 'package:dontations_app/controller/list_constructionProjects_controller.dart';
import 'package:dontations_app/controller/list_constructionTypes_controller.dart';
import 'package:dontations_app/routes/app_pages.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SettingsDesktopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        iconTheme: IconThemeData(color: AppColor.whiteColor),
        title: Text(
          "الإعدادات",
          style: robotoHugeWhite,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.COUNTRIESDESKTOPSCREEN);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.appBarColor,
                      borderRadius: BorderRadius.circular(18)),
                  child: ListTile(
                    title: Text(
                      "الدول",
                      style: robotoMediumWhiteBold,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColor.whiteColor,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.MANAGEUSERDESKTOPSCREEN);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.appBarColor,
                      borderRadius: BorderRadius.circular(18)),
                  child: ListTile(
                    title: Text(
                      "المستخدمين",
                      style: robotoMediumWhiteBold,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: AppColor.whiteColor,
                      size: 32,
                    ),
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
