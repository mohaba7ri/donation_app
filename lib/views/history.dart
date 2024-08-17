import 'package:dontations_app/controller/login_controller.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/style/images.dart';
import 'package:dontations_app/widgets/Drawer.dart';
import 'package:dontations_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryScreen extends GetView<LoginController> {
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
        child: Column(
          children: [
            Center(
              child: Text("تتبع التقدم والخطة العلاجية",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text("تأتأة متوسطة | الخطة العلاجية".tr,
                  style: robotoHugeBlack),
            ),
            Image.asset(
              Images.file,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 12.0, left: 12.0, bottom: 10),
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "رقم الاختبار: 1",
                          style: robotoMediumWhite,
                        ),
                        Center(
                          child: Text("تأتأة متوسطة | الخطة العلاجية".tr,
                              style: robotoMediumWhite),
                        ),
                        Image.asset(
                          Images.file,
                          scale: 2,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(right: 12.0, left: 12.0, bottom: 10),
              child: SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "رقم الاختبار: 2",
                          style: robotoMediumWhite,
                        ),
                        Center(
                          child: Text("تأتأة عالية | الخطة العلاجية".tr,
                              style: robotoMediumWhite),
                        ),
                        Image.asset(
                          Images.file,
                          scale: 2,
                          color: Colors.white,
                        )
                      ],
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
