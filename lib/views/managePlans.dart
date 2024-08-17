import 'package:dontations_app/controller/managePlans_controller.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManagePlans extends GetView<ManagePlansController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('إدارة الخطط',
            style: TextStyle(fontSize: 24, color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text('مستوى الخطة: ', textAlign: TextAlign.right),
                SizedBox(width: 10),
                Obx(() => DropdownButton<int>(
                      value: controller.selectedLevel.value,
                      items: [1, 2, 3].map((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          controller.selectedLevel.value = newValue;
                        }
                      },
                    )),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
                onPressed: controller.addPlan,
                child: Text('رفع خطة',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.plans.length,
                    itemBuilder: (context, index) {
                      var plan = controller.plans[index];
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0), // Add some margin for spacing
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Text(
                            '${plan['file'].name} (مستوى ${plan['level']})',
                            textAlign: TextAlign.right,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => controller.deletePlan(index),
                              ),
                              IconButton(
                                icon: Icon(Icons.visibility),
                                onPressed: () => controller.viewPlan(plan),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
