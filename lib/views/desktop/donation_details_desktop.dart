import 'package:dontations_app/controller/donation_details_controller.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DonationDetailsDesktopScreen extends GetView<DonationDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        iconTheme: IconThemeData(color: AppColor.buttonColor),
        title: Text(
          "تفاصيل المشروع".tr,
          style: robotoHugeWhite,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "تفاصيل المشروع".tr,
                      style: robotoHugeBlack,
                    ),
                    SizedBox(height: 20.0),
                    _buildDetailRow("إسم المشروع".tr, controller.projectName),
                    _buildDetailRow(
                        "الجهة المنفذة".tr, controller.executingAgency),
                    _buildDetailRow(
                        "مدة التنفيذ".tr, controller.executionPeriod),
                    _buildDetailRow(
                        "عدد المستفيدين".tr, "${controller.beneficiaries}"),
                    _buildDetailRow("نوع المشروع".tr, controller.projectType),
                    _buildDetailRow("المكان".tr, controller.location),
                    _buildDetailRow(
                        "تفاصيل البناء".tr, controller.buildingDetails),
                    _buildDetailRow(
                        "موعد التنفيذ".tr, controller.executionDate),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "المتبرعين".tr,
                      style: robotoHugeBlack,
                    ),
                    SizedBox(height: 20.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.donors.length,
                      itemBuilder: (context, index) {
                        final donor = controller.donors[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            title: Text(
                              donor['name'].toString(),
                              style: robotoMediumBold,
                            ),
                            subtitle: Text(
                              "${donor['amount']} ${donor['currency']}",
                              style: robotoMedium,
                            ),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              // Handle on tap if needed
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            "$label:",
            style: robotoHugeBlack,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              value,
              style: robotoHugeBlack,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
