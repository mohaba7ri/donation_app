import 'package:dontations_app/controller/contries_controller.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/views/desktop/donations/views/suggest_project_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountriesDesktopScreen extends GetView<CountriesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: Text(
          "الدول التي يتم فيها تنفيذ المشاريع",
          style: robotoHugeWhite,
        ),
        centerTitle: true,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            onPressed: () {
              Get.to(() => SuggestProjectPage());
            },
            child: Text(
              'إقتراح مشروع',
              style: robotoMediumWhite,
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Form for adding a new country
            Text(
              "إضافة دولة جديدة".tr,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: controller.countryNameController,
              decoration: InputDecoration(
                labelText: "إسم الدولة".tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: controller.agent1Controller,
              decoration: InputDecoration(
                labelText: "1 الجهة المنفذة".tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: controller.agent2Controller,
              decoration: InputDecoration(
                labelText: "2 الجهة المنفذة".tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                return ElevatedButton(
                  onPressed:
                      controller.isLoading.value ? null : controller.addCountry,
                  child: controller.isLoading.value
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "إضافة".tr,
                          style: robotoHugeWhite,
                        ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 160, vertical: 15),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),

            // List of countries
            Expanded(
              child: Obx(() {
                return controller.countries.isEmpty
                    ? Center(child: Text("لا توجد دول متاحة".tr))
                    : ListView.builder(
                        itemCount: controller.countries.length,
                        itemBuilder: (context, index) {
                          final country = controller.countries[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: ListTile(
                              title: Text(country['name']),
                              subtitle: Column(
                                children: [
                                  Text("1 الجهة المنفذة: ${country['agent1']}"),
                                  Text("2 الجهة المنفذة: ${country['agent2']}"),
                                  Text(
                                      "تاريخ الإدخال: ${country['entryDate']}"),
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  controller.deleteCountry(country['id']);
                                },
                              ),
                            ),
                          );
                        },
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
