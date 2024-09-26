import 'package:dontations_app/controller/listDonations_controller.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/views/desktop/donations/util/pdf_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
import 'package:intl/intl.dart';

class ListDonationsForAccountSscreen extends GetView<ListDonationsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor,
        title: Text('قائمة التبرعات'),
      ),
      body: Column(
        children: [
          _buildFilterAndSearch(),
          Expanded(
            child: Obx(
              () => controller.donations.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: controller.filteredDonations.length,
                      itemBuilder: (context, index) {
                        final donation = controller.filteredDonations[index];
                        return _buildDonationTile(donation);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonationTile(Map<String, dynamic> donation) {
    final PdfService pdfService = PdfService();
    DateTime now = DateTime.now();

    return Container(
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    'إسم المشروع : ${donation['projectName'] ?? 'اسم المشروع غير متوفر'}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                      'اسم المتبرع: ${donation['name'] ?? 'غير متوفر'}'), // Donor's Name in Arabic
                )
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(' كي نت : ${donation['keyNet'] ?? 'غير معرف'}'),

                Text('تكلفة المشروع : ${donation['cost'] ?? 'غير محدد'}'),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                          'نوع المشروع: ${donation['projectType'] ?? 'غير محدد'}'),
                    ),
                    Expanded(
                      child:
                          Text('الدولة: ${donation['country'] ?? 'غير محدد'}'),
                    ),
                  ],
                ),
                // Another row for more details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                          'عدد المستفيدين: ${donation['beneficiaries'] ?? 'غير محدد'}'),
                    ),
                    Expanded(
                      child: Text('التاريخ: ${donation['date'] ?? 'غير محدد'}'),
                    ),
                  ],
                ),
                // Keeping other details in columns
                Text(
                    'مدة التنفيذ: ${donation['executionPeriod'] ?? 'غير محدد'}'), // Execution Period in Arabic

                Text(
                    'الساحة المختارة: ${donation['selectedArena'] ?? 'غير محدد'}'), // Selected Arena in Arabic
              ],
            ),
            // trailing: Obx(
            //   () {
            //     if (controller.isLoading.value) {
            //       return CircularProgressIndicator();
            //     } else {
            //       final formattedDate = DateFormat('dd/MM/yyyy').format(now);

            //       return ElevatedButton.icon(
            //         onPressed: () async {
            //           controller.startLoading(); // Start loading

            //           try {
            //             final pdf = await pdfService.generatePdf(
            //               donorName: donation['name'],
            //               address: donation['projectName'],
            //               phoneNumber: donation['address'],
            //               email: donation['email'],
            //               contryName: donation['country'],
            //               beneficiaries: donation['beneficiaries'],
            //               donationAmount: donation['cost'],
            //               projectType: donation['projectType'],
            //               executionPeriod: donation['executionPeriod'],
            //               selectedArena: donation['selectedArena'],
            //               projectName: donation['projectName'],
            //               date: donation['date'] ?? formattedDate,
            //             );

            //             final bytes = await pdf.save();

            //             if (!kIsWeb) {
            //               // Handle saving on mobile/desktop platforms
            //               // Example: Save as file
            //               // final file = File('example_report.pdf');
            //               // await file.writeAsBytes(bytes);
            //             } else {
            //               // For web platforms
            //               final blob = html.Blob([bytes], 'application/pdf');
            //               final url = html.Url.createObjectUrlFromBlob(blob);
            //               final anchor = html.AnchorElement(href: url)
            //                 ..setAttribute('download',
            //                     '${donation['name']} وثيقة تبرع.pdf')
            //                 ..click();
            //               html.Url.revokeObjectUrl(url);
            //             }
            //           } catch (e) {
            //             // Handle errors if needed
            //             print('Error generating or saving PDF: $e');
            //           } finally {
            //             controller.stopLoading(); // Stop loading
            //           }
            //         },
            //         icon: Icon(
            //           Icons.print,
            //           color: Colors.white,
            //         ),
            //         label: Text(
            //           'طباعة',
            //           style: robotoMediumWhite,
            //         ), // "Print" in Arabic
            //         style: ElevatedButton.styleFrom(
            //           backgroundColor:
            //               AppColor.buttonColor, // Use your app's button color
            //           padding:
            //               EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            //         ),
            //       );
            //     }
            //   },
            // ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterAndSearch() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          decoration: InputDecoration(
            labelText: 'بحث',
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            controller.searchQuery.value = value;
            controller.applyFilter();
          },
        ),
      );
    });
  }
}
