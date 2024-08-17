import 'package:dontations_app/controller/login_controller.dart';
import 'package:dontations_app/routes/app_pages.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/style/images.dart';
import 'package:dontations_app/widgets/Drawer.dart';
import 'package:dontations_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomeScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("أبجد".tr,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 100,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColor.blackColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: ListTile(
                      title: Text(
                        "إدارة الجمل",
                        style: robotoHugeWhite,
                      ),
                      trailing: Image.asset(
                        Images.phrase, // Adjust the path as necessary
                        color: Colors.white,
                      ),
                      onTap: () {
                        Get.toNamed(Routes.MANAGESENTENCESSCREEN);
                      },
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColor.blackColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Center(
                    child: ListTile(
                      title: Text(
                        "إدارة الخطط العلاجية",
                        style: robotoHugeWhite,
                      ),
                      trailing: Image.asset(
                        Images.plan, // Adjust the path as necessary
                        color: Colors.white,
                      ),
                      onTap: () {
                        Get.toNamed(Routes.MANAGEPLANSSCREEN);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
