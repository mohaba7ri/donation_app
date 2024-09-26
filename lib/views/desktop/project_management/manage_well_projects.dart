import 'package:dontations_app/controller/add_musqeDonation_controller.dart';
import 'package:dontations_app/controller/manage_mosqProject_controller.dart';
import 'package:dontations_app/controller/manage_wellProject_controller.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ManageWellProjectDesktopScreen
    extends GetView<ManageWellProjectController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        iconTheme: IconThemeData(color: AppColor.whiteColor),
        title: Text(
          "إدارة نماذج المشروع  (${controller.projectType})".tr,
          style: robotoHugeWhite,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: CustomInput(
                            controller: controller.arenaC,
                            label: "العمق".tr,
                            hint: "",
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
                          child: CustomInput(
                            controller: controller.beneficiariesC,
                            label: "عدد المستفيدين".tr,
                            hint: "",
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
                          child: CustomInput(
                            controller: controller.executionPeriodC,
                            label: "مدة التنفيذ".tr,
                            hint: "",
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    CustomInput(
                      controller: controller.costC,
                      label: "التكلفة".tr,
                      hint: "",
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controller.buildingDetailsC,
                            maxLines: null,
                            decoration: InputDecoration(
                              labelText: "مواصفات البئر".tr,
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.0),
                        Expanded(
                          child: TextFormField(
                            controller: controller.facilitiesC,
                            maxLines: null,
                            decoration: InputDecoration(
                              labelText: "المرافق".tr,
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() {
                          return SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              onPressed: controller.isLoadingAdd.value ||
                                      controller.isLoadingEdit.value
                                  ? null
                                  : () {
                                      controller.addOrUpdateProject();
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: controller.isLoadingAdd.value ||
                                      controller.isLoadingEdit.value
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      controller.selectedProjectId.value.isEmpty
                                          ? "إضافة".tr
                                          : "تعديل".tr,
                                      style: robotoHugeWhite,
                                    ),
                            ),
                          );
                        }),
                        SizedBox(width: 20),
                        Obx(() {
                          return SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              onPressed: controller.isLoadingClear.value
                                  ? null
                                  : () {
                                      controller.clearForm();
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: controller.isLoadingClear.value
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "إعادة".tr,
                                      style: robotoHugeWhite,
                                    ),
                            ),
                          );
                        }),
                      ],
                    ),
                    SizedBox(height: 30.0),
                    Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: controller.projects.map((project) {
                          return ListTile(
                            title: Text(
                                "${project['projectType']} - ${project['arena']}"),
                            subtitle: Text(
                                "عدد المستفيدين :  ${project['beneficiaries']} - التكلفة  :${project['cost']}  - مدة التنفيذ : ${project['executionPeriod']}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    controller.selectProject(project);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    controller.deleteProject(project['id']);
                                  },
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
