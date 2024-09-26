import 'package:dontations_app/controller/listDonations_controller.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/views/desktop/donations/util/pdf_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:html' as html;
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:excel/excel.dart'; // Import the excel package
import 'dart:typed_data'; // For Uint8List
import 'dart:io'; // For File I/O
import 'package:path_provider/path_provider.dart'; // For getting the application directory

class DonationManagementScreen extends GetView<ListDonationsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إدارة التبرعات'), // "Donation Management" in Arabic
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () {
              exportToExcel(controller.donations);
            },
          ),
        ],
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

  Future<void> exportToExcel(List<Map<String, dynamic>> donations) async {
    var excel = Excel.createExcel(); // Create a new Excel instance
    Sheet sheet = excel['Sheet1'];
    var rtlStyle = CellStyle(
      horizontalAlign: HorizontalAlign.Right, // Right-align for RTL text
      verticalAlign: VerticalAlign.Center,
      // textWrapping: excel,
    );
    // Define the header row using CellValue
    sheet.isRTL = true;
    sheet.appendRow([
      TextCellValue('اسم المشروع'), // Project Name
      TextCellValue('اسم المتبرع'), // Donor's Name
      TextCellValue('تكلفة المشروع'), // Project Cost
      TextCellValue('نوع المشروع'), // Project Type
      TextCellValue('الدولة'), // Country
      TextCellValue('عدد المستفيدين'), // Number of Beneficiaries
      TextCellValue('التاريخ'), // Date
      TextCellValue('مدة التنفيذ'), // Execution Period
      TextCellValue('الساحة المختارة'), // Selected Arena
      TextCellValue('الحالة'), // Status
    ]);

    // Add some example data using CellValue
    for (var donation in donations) {
      CellStyle(
        horizontalAlign: HorizontalAlign.Right, // Right-align for RTL text
        verticalAlign: VerticalAlign.Center,
        // textWrapping: excel,
      );
      sheet.appendRow([
        TextCellValue(donation['projectName']),
        TextCellValue(donation['name']),
        TextCellValue(donation['cost']),
        TextCellValue(donation['projectType']),
        TextCellValue(donation['country']),
        TextCellValue(donation['beneficiaries']),
        TextCellValue(donation['date']),
        TextCellValue(donation['executionPeriod']),
        TextCellValue(donation['selectedArena']),
        TextCellValue(donation['status']),
      ]);
    }

    var fileBytes = excel.save(fileName: 'My_Excel_File_Name.xlsx');

    if (kIsWeb) {
      // Web-specific code to download the file
      final blob = html.Blob([fileBytes!],
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'My_Excel_File_Name.xlsx')
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      // For mobile (Android/iOS), use path_provider to save the file
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/My_Excel_File_Name.xlsx');
      await file.writeAsBytes(fileBytes!);
      print('File saved to ${file.path}');
    }
  }

  // Widget _buildDonationTile(Map<String, dynamic> donation) {
  //   final PdfService pdfService = PdfService();
  //   DateTime now = DateTime.now();
  //   final List<String> statusOptions = ['متوقف', 'قيد التنفيذ', 'تم التنفيذ'];

  //   // Ensure the status is valid, or fallback to a default value
  //   final String initialStatus = statusOptions.contains(donation['status'])
  //       ? donation['status']
  //       : 'قيد التنفيذ';
  //   return Container(
  //     margin: EdgeInsets.all(12.0),
  //     padding: EdgeInsets.all(16.0),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(12.0),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.3),
  //           spreadRadius: 2,
  //           blurRadius: 5,
  //           offset: Offset(0, 3), // changes position of shadow
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         ListTile(
  //           title: Row(
  //             children: [
  //               Expanded(
  //                 child: Text(
  //                   'إسم المشروع : ${donation['projectName'] ?? 'اسم المشروع غير متوفر'}',
  //                   style: TextStyle(fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //               Expanded(
  //                 child: Text(
  //                     'اسم المتبرع: ${donation['name'] ?? 'غير متوفر'}'), // Donor's Name in Arabic
  //               )
  //             ],
  //           ),
  //           subtitle: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text('تكلفة المشروع : ${donation['cost'] ?? 'غير محدد'}'),

  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     child: Text(
  //                         'نوع المشروع: ${donation['projectType'] ?? 'غير محدد'}'),
  //                   ),
  //                   Expanded(
  //                     child:
  //                         Text('الدولة: ${donation['country'] ?? 'غير محدد'}'),
  //                   ),
  //                 ],
  //               ),
  //               // Another row for more details
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     child: Text(
  //                         'عدد المستفيدين: ${donation['beneficiaries'] ?? 'غير محدد'}'),
  //                   ),
  //                   Expanded(
  //                     child: Text('التاريخ: ${donation['date'] ?? 'غير محدد'}'),
  //                   ),
  //                 ],
  //               ),
  //               // Keeping other details in columns
  //               Text(
  //                   'مدة التنفيذ: ${donation['executionPeriod'] ?? 'غير محدد'}'), // Execution Period in Arabic

  //               Text(
  //                   'الساحة المختارة: ${donation['selectedArena'] ?? 'غير محدد'}'), // Selected Arena in Arabic
  //             ],
  //           ),
  //           trailing: Obx(
  //             () {
  //               if (controller.isLoading.value) {
  //                 return CircularProgressIndicator();
  //               } else {
  //                 final formattedDate = DateFormat('dd/MM/yyyy').format(now);

  //                 return Row(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     // Expanded(
  //                     //   child:

  //                     //       // DropdownButton<String>(
  //                     //       //   value:
  //                     //       //       initialStatus, // Use the validated status value
  //                     //       //   items: statusOptions.map((String value) {
  //                     //       //     return DropdownMenuItem<String>(
  //                     //       //       value: value,
  //                     //       //       child: Text(value),
  //                     //       //     );
  //                     //       //   }).toList(),
  //                     //       //   onChanged: (value) {
  //                     //       //     if (value != null) {
  //                     //       //       controller.updateDonationStatus(
  //                     //       //           donation['docId'], value);
  //                     //       //     }
  //                     //       //   },
  //                     //       // ),

  //                     //       Text(initialStatus),
  //                     // ),
  //                     Text(donation['status']),
  //                     SizedBox(width: 8.0),
  //                     ElevatedButton.icon(
  //                       onPressed: () async {
  //                         controller.startLoading(); // Start loading

  //                         try {
  //                           final pdf = await pdfService.generatePdf(
  //                             donorName: donation['name'],
  //                             address: donation['projectName'],
  //                             phoneNumber: donation['address'],
  //                             email: donation['email'],
  //                             contryName: donation['country'],
  //                             beneficiaries: donation['beneficiaries'],
  //                             donationAmount: donation['cost'],
  //                             projectType: donation['projectType'],
  //                             executionPeriod: donation['executionPeriod'],
  //                             selectedArena: donation['selectedArena'],
  //                             projectName: donation['projectName'],
  //                             date: donation['date'] ?? formattedDate,
  //                           );

  //                           final bytes = await pdf.save();

  //                           if (!kIsWeb) {
  //                             // Handle saving on mobile/desktop platforms
  //                             // Example: Save as file
  //                             // final file = File('example_report.pdf');
  //                             // await file.writeAsBytes(bytes);
  //                           } else {
  //                             // For web platforms
  //                             final blob =
  //                                 html.Blob([bytes], 'application/pdf');
  //                             final url =
  //                                 html.Url.createObjectUrlFromBlob(blob);
  //                             final anchor = html.AnchorElement(href: url)
  //                               ..setAttribute('download',
  //                                   '${donation['name']} وثيقة تبرع.pdf')
  //                               ..click();
  //                             html.Url.revokeObjectUrl(url);
  //                           }
  //                         } catch (e) {
  //                           // Handle errors if needed
  //                           print('Error generating or saving PDF: $e');
  //                         } finally {
  //                           controller.stopLoading(); // Stop loading
  //                         }
  //                       },
  //                       icon: Icon(
  //                         Icons.print,
  //                         color: Colors.white,
  //                       ),
  //                       label: Text(
  //                         'طباعة',
  //                         style: robotoMediumWhite,
  //                       ), // "Print" in Arabic
  //                       style: ElevatedButton.styleFrom(
  //                         backgroundColor: AppColor
  //                             .buttonColor, // Use your app's button color
  //                         padding: EdgeInsets.symmetric(
  //                             horizontal: 12.0, vertical: 8.0),
  //                       ),
  //                     ),
  //                   ],
  //                 );
  //               }
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildDonationTile(Map<String, dynamic> donation) {
    final PdfService pdfService = PdfService();
    DateTime now = DateTime.now();

    // Define the list of valid status values
    final List<String> statusOptions = ['متوقف', 'قيد التنفيذ', 'تم التنفيذ'];

    // Check if donation['status'] is a valid option, otherwise use a default value
    final String initialStatus = statusOptions.contains(donation['status'])
        ? donation['status']!
        : 'قيد التنفيذ';

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
            offset: Offset(0, 3), // Changes position of shadow
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
                    'اسم المتبرع: ${donation['name'] ?? 'غير متوفر'}', // Donor's Name in Arabic
                  ),
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('تكلفة المشروع : ${donation['cost'] ?? 'غير محدد'}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'نوع المشروع: ${donation['projectType'] ?? 'غير محدد'}',
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'الدولة: ${donation['country'] ?? 'غير محدد'}',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'عدد المستفيدين: ${donation['beneficiaries'] ?? 'غير محدد'}',
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'التاريخ: ${donation['date'] ?? 'غير محدد'}',
                      ),
                    ),
                  ],
                ),
                Text(
                    'مدة التنفيذ: ${donation['executionPeriod'] ?? 'غير محدد'}'),
                Text(
                    'الساحة المختارة: ${donation['selectedArena'] ?? 'غير محدد'}'),
              ],
            ),
            trailing: Obx(
              () {
                if (controller.isLoading.value) {
                  return CircularProgressIndicator();
                } else {
                  final formattedDate = DateFormat('dd/MM/yyyy').format(now);

                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Dropdown with proper value initialization
                      DropdownButton<String>(
                        value: initialStatus, // Ensure value is valid
                        items: statusOptions.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            controller.updateDonationStatus(
                                donation['docId'], value);
                          }
                        },
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton.icon(
                        onPressed: () async {
                          controller.startLoading(); // Start loading
                          try {
                            final pdf = await pdfService.generatePdf(
                              donorName: donation['name'] ?? 'غير متوفر',
                              address: donation['projectName'] ?? 'غير متوفر',
                              phoneNumber: donation['address'] ?? 'غير متوفر',
                              email: donation['email'] ?? 'غير متوفر',
                              contryName: donation['country'] ?? 'غير متوفر',
                              beneficiaries:
                                  donation['beneficiaries'] ?? 'غير محدد',
                              donationAmount: donation['cost'] ?? 'غير محدد',
                              projectType:
                                  donation['projectType'] ?? 'غير محدد',
                              executionPeriod:
                                  donation['executionPeriod'] ?? 'غير محدد',
                              selectedArena:
                                  donation['selectedArena'] ?? 'غير محدد',
                              projectName:
                                  donation['projectName'] ?? 'غير محدد',
                              date: donation['date'] ?? formattedDate,
                            );

                            final bytes = await pdf.save();

                            if (!kIsWeb) {
                              // Handle saving on mobile/desktop platforms
                            } else {
                              // For web platforms
                              final blob =
                                  html.Blob([bytes], 'application/pdf');
                              final url =
                                  html.Url.createObjectUrlFromBlob(blob);
                              final anchor = html.AnchorElement(href: url)
                                ..setAttribute('download',
                                    '${donation['name'] ?? 'وثيقة تبرع'}.pdf')
                                ..click();
                              html.Url.revokeObjectUrl(url);
                            }
                          } catch (e) {
                            // Handle errors if needed
                            print('Error generating or saving PDF: $e');
                          } finally {
                            controller.stopLoading(); // Stop loading
                          }
                        },
                        icon: Icon(
                          Icons.print,
                          color: Colors.white,
                        ),
                        label: Text(
                          'طباعة',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ), // "Print" in Arabic
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor
                              .buttonColor, // Use your app's button color
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8.0),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterAndSearch() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: controller.selectedFilter.value,
                    items: [
                      DropdownMenuItem(
                        value: 'الكل',
                        child: Text('الكل'),
                      ),
                      DropdownMenuItem(
                        value: 'المشاريع الإنشائية',
                        child: Text('المشاريع الإنشائية'),
                      ),
                    ],
                    onChanged: (value) {
                      controller.selectedFilter.value = value ?? 'الكل';
                      controller.applyFilter();
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    value: controller.selectedCountry.value,
                    hint: Text('Select Country'),
                    items: controller.countries.map((country) {
                      return DropdownMenuItem(
                        value: country,
                        child: Text(country),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedCountry.value = value ?? 'الكل';
                      controller.applyFilter();
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
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
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
