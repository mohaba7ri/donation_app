import 'package:dontations_app/controller/list_constructionProjects_controller.dart';
import 'package:dontations_app/controller/list_constructionTypes_controller.dart';
import 'package:dontations_app/routes/app_pages.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ListConstructionProjectsDesktopScreen
    extends GetView<ListConstructionProjectsController> {
  final String projectName = Get.arguments;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        iconTheme: IconThemeData(color: AppColor.whiteColor),
        title: Text(
          "$projectName".tr,
          style: robotoHugeWhite,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.ADDNEWCONSTRUCTIONDONATIONSCREEN,
                        arguments: projectName);
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
                    style: robotoHugeWhite,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: searchController,
              onChanged: (query) {
                // Update the search results when the query changes
                controller.searchDonations(query);
              },
              decoration: InputDecoration(
                hintText: "ابحث عن مشروع",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey.shade200,
                filled: true,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Obx(() {
                      if (controller.filteredDonations.isEmpty) {
                        return Center(
                          child: Text(
                            "لا توجد مشاريع متاحة".tr,
                            style: robotoMediumBold,
                          ),
                        );
                      } else {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: ListView.builder(
                            itemCount: controller.filteredDonations.length,
                            itemBuilder: (context, index) {
                              final donation =
                                  controller.filteredDonations[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.whiteColor,
                                    borderRadius: BorderRadius.circular(18),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      donation['projectName'],
                                      style: robotoMediumBlack,
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Get.toNamed(
                                                Routes
                                                    .ADDOLDCONSTRUCTIONDONATIONSCREEN,
                                                arguments:
                                                    donation['projectName']);
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor:
                                                AppColor.appBarColor,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                          ),
                                          child: Text(
                                            "إضافة متبرع",
                                            style: TextStyle(
                                                color: AppColor.whiteColor),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        TextButton(
                                          onPressed: () {},
                                          style: TextButton.styleFrom(
                                            backgroundColor: AppColor.blueColor,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                          ),
                                          child: Text(
                                            "عرض",
                                            style: TextStyle(
                                                color: AppColor.whiteColor),
                                          ),
                                        ),
                                        // SizedBox(width: 8),
                                        // TextButton(
                                        //   onPressed: () {
                                        //     // Handle "طباعة" (Print) action
                                        //   },
                                        //   style: TextButton.styleFrom(
                                        //     backgroundColor: Colors.green[800],
                                        //     padding: EdgeInsets.symmetric(
                                        //         horizontal: 10, vertical: 5),
                                        //   ),
                                        //   child: Text(
                                        //     "طباعة",
                                        //     style: TextStyle(
                                        //         color: AppColor.whiteColor),
                                        //   ),
                                        // ),
                                        SizedBox(width: 8),
                                        TextButton(
                                          onPressed: () {
                                            // Handle "تعديل" (Edit) action
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.yellow[800],
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                          ),
                                          child: Text(
                                            "تعديل",
                                            style: TextStyle(
                                                color: AppColor.whiteColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Text(
                                      "قيمة المشروع: ${donation['value']} | إجمالي التبرعات: ${donation['totalDonations']} | عدد المتبرعين: ${donation['donorCount']}",
                                    ),
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.ADDCONSTRUCTIONPROJECTSCREEN,
                                        arguments: donation['projectName'],
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
          ],
        ),
      ),
    );
  }
}
