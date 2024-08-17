import 'package:dontations_app/controller/login_controller.dart';
import 'package:dontations_app/routes/app_pages.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/style/images.dart';
import 'package:dontations_app/widgets/Drawer.dart';
import 'package:dontations_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartTestScreen extends GetView<LoginController> {
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
              child: Text(": قراءة الجملة التالية بوضوح".tr,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Text(
                  "التحدث بثقة يمكن ان يساعد \n .في تحسين تجربة التواصل".tr,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.RESULTSCREEN);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.blackColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: Text(
                    "... بدء التشخيص",
                    style: robotoHugeWhite,
                  ),
                ),
              ),
            ),
            SizedBox(
              child: Image.asset(Images.logo),
            ),
            // Obx(() => Text(
            //       controller.text.value,
            //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            //     )),
            // SizedBox(height: 20),
            // Obx(() => FloatingActionButton(
            //       onPressed: controller.isListening.value
            //           ? controller.stopListening
            //           : controller.startListening,
            //       child: Icon(controller.isListening.value
            //           ? Icons.mic
            //           : Icons.mic_none),
            //     )),
            // SizedBox(height: 20),
            // Obx(() => Text(
            //       controller.isListening.value
            //           ? "استمر في التحدث..."
            //           : controller.getFluencyFeedback(),
            //       style: TextStyle(fontSize: 18, color: Colors.red),
            //     )),
          ],
        ),
      ),
    );
  }
}
