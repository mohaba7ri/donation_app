import 'package:dontations_app/controller/contries_controller.dart';
import 'package:dontations_app/routes/app_pages.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListCountriesDesktopScreen extends GetView<CountriesController> {
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
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return controller.countries.isEmpty
                    ? Center(child: Text("لا توجد دول متاحة".tr))
                    : ListView.builder(
                        itemCount: controller.countries.length,
                        itemBuilder: (context, index) {
                          final country = controller.countries[index];
                          return InkWell(
                            onTap: () {
                              Get.toNamed(Routes.LISTPROJECTSTYPESDESKTOPSCREEN,
                                  arguments: country['name']);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColor.appBarColor,
                                    borderRadius: BorderRadius.circular(18)),
                                child: ListTile(
                                  title: Text(
                                    country['name'],
                                    style: robotoHugeWhite,
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColor.whiteColor,
                                    size: 32,
                                  ),
                                ),
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
