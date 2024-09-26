import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/print_color.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';

class PrintForDonor {
  Future<pw.Document> generatePdf(
      {required String donorName,
      required String address,
      required String phoneNumber,
      required String email,
      required String contryName,
      required String projectType,
      required String projectName,
      required String selectedArena,
      required String beneficiaries,
      required String donationAmount,
      required String date}) async {
    final pdf = pw.Document();
    final fontData = await rootBundle.load('assets/Alarabiya_Normal_Font.ttf');
    final ttf = pw.Font.ttf(fontData);

    // Load the logo image
    final imageLogo = pw.MemoryImage(
        (await rootBundle.load('assets/logo.png')).buffer.asUint8List());

    final slogan = pw.MemoryImage(
        (await rootBundle.load('assets/slogan.png')).buffer.asUint8List());
    final accounts = pw.MemoryImage(
        (await rootBundle.load('assets/accounts.png')).buffer.asUint8List());

    final signature = pw.MemoryImage(
        (await rootBundle.load('assets/signature.png')).buffer.asUint8List());
    DateTime now = DateTime.now();

    pdf.addPage(
      pw.Page(
        margin: pw.EdgeInsets.all(2),
        pageFormat: PdfPageFormat.a4,
        textDirection: pw.TextDirection.rtl,
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection:
                pw.TextDirection.rtl, // Set the text direction to RTL
            child: pw.Padding(
              padding: pw.EdgeInsets.all(16),
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // pw.Center(
                  //   child: pw.Image(slogan, width: 160, height: 160),
                  // ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Image(imageLogo, width: 100, height: 100),
                      pw.Padding(
                          padding: const pw.EdgeInsets.only(
                              bottom:
                                  40), // Adjust this value to raise the text
                          child: pw.Image(slogan, width: 200, height: 200)),
                      // pw.Spacer(), // Add a spacer after the slogan
                      // pw.Spacer(), // Add a spacer after the slogan
                      pw.SizedBox(width: 70),
                    ],
                  ),
                  pw.Center(
                      child: pw.Text(
                    "جمعية خيرية نفع عام أشهرت بموجب القرار الوزاري رقم (127/أ) لسنة 2016م",
                    style: pw.TextStyle(
                      fontSize: 11,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.black,
                      font: ttf, // Apply custom font
                    ),
                  )),
                  pw.Center(
                    child: pw.Text(
                      'وثيقة تبرع',
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.blueGrey,
                        font: ttf, // Apply custom font
                      ),
                    ),
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'اسم المتبرع: السيد / $donorName',
                        style: pw.TextStyle(
                          fontSize: 15,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.blueGrey,
                          font: ttf, // Apply custom font
                        ),
                      ),
                      // pw.Padding(
                      //   padding: const pw.EdgeInsets.only(
                      //       bottom: 30), // Adjust this value to raise the text
                      //   child: pw.Text(
                      //     'وثيقة تبرع',
                      //     style: pw.TextStyle(
                      //       fontSize: 24,
                      //       fontWeight: pw.FontWeight.bold,
                      //       color: PdfColors.blueGrey,
                      //       font: ttf, // Apply custom font
                      //     ),
                      //   ),
                      // ),
                      pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.RichText(
                              text: pw.TextSpan(
                                children: [
                                  pw.TextSpan(
                                    text: ' التاريخ:  ',
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        font: ttf,
                                        fontSize: 12), // Custom font for text
                                  ),
                                  pw.TextSpan(
                                    text: ' $date ',
                                    style: pw.TextStyle(
                                        color: PdfColors.blueGrey,
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize:
                                            12), // Default font for numbers
                                  ),
                                ],
                              ),
                            ),
                            // pw.Text(
                            //   'التاريخ: $date',
                            //   style: pw.TextStyle(
                            //     fontSize: 12,
                            //     fontWeight: pw.FontWeight.bold,
                            //     color: PdfColors.black,
                            //     font: ttf, // Apply custom font
                            //   ),
                            // ),
                            pw.SizedBox(height: 10),
                            pw.Text(
                              'طريقة التبرع: كي نت',
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.black,
                                font: ttf, // Apply custom font
                              ),
                            ),
                            pw.Text(
                              'المرجع: كي نت',
                              style: pw.TextStyle(
                                fontSize: 14,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.black,
                                font: ttf, // Apply custom font
                              ),
                            ),
                          ]),
                    ],
                  ),

                  // Header with logo and name
                  // pw.Container(
                  //   padding: pw.EdgeInsets.all(16),
                  //   decoration: pw.BoxDecoration(
                  //     color: PdfColors.blueGrey,
                  //   ),
                  //   child: pw.Column(
                  //     children: [
                  //       pw.SizedBox(height: 10),

                  //     ],
                  //   ),
                  // ),

                  // New container with a column
                  pw.Container(
                    padding: pw.EdgeInsets.all(12),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey200,
                      borderRadius: pw.BorderRadius.circular(12),
                    ),
                    child: pw.Column(
                      children: [
                        // Centered text
                        pw.Container(
                          width: double.infinity,
                          decoration: pw.BoxDecoration(
                            color: CustomColors.buttonColor,
                            borderRadius: pw.BorderRadius.circular(4),
                          ),
                          child: pw.Center(
                              child: pw.Text(
                            'بيانات المتبرع',
                            style: pw.TextStyle(
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                              font: ttf, // Apply custom font
                            ),
                          )),
                        ),

                        pw.SizedBox(height: 6),
                        // Divider

                        // Row with personal information
                        pw.Container(
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(color: PdfColors.black),
                            borderRadius:
                                pw.BorderRadius.all(pw.Radius.circular(8)),
                          ),
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Container(
                                decoration: pw.BoxDecoration(),
                                padding: pw.EdgeInsets.all(8),
                                child: pw.Text(
                                  'العنوان: $address',
                                  style: pw.TextStyle(font: ttf, fontSize: 10),
                                ),
                              ),
                              pw.Divider(
                                height: 1,
                                color: CustomColors.buttonColor,
                              ),
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Expanded(
                                    child: pw.Container(
                                      decoration: pw.BoxDecoration(),
                                      padding: pw.EdgeInsets.all(8),
                                      child: pw.Text(
                                        'الهاتف: $phoneNumber',
                                        style: pw.TextStyle(
                                            font: ttf, fontSize: 10),
                                      ),
                                    ),
                                  ),
                                  pw.Expanded(
                                    child: pw.Container(
                                      decoration: pw.BoxDecoration(
                                        border: pw.Border(
                                          right: pw.BorderSide(
                                              color: PdfColors.black),
                                        ),
                                      ),
                                      padding: pw.EdgeInsets.all(8),
                                      child: pw.Text(
                                        'البريد الإلكتروني: $email',
                                        style: pw.TextStyle(
                                            font: ttf, fontSize: 10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 6),

                  // New container with a column
                  pw.Container(
                    padding: pw.EdgeInsets.all(12),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey200,
                      borderRadius: pw.BorderRadius.circular(12),
                    ),
                    child: pw.Column(
                      children: [
                        // Centered text
                        pw.Container(
                          width: double.infinity,
                          decoration: pw.BoxDecoration(
                            color: CustomColors.buttonColor,
                            borderRadius: pw.BorderRadius.circular(4),
                          ),
                          child: pw.Center(
                            child: pw.Text(
                              'تفاصيل المشروع',
                              style: pw.TextStyle(
                                fontSize: 18,
                                fontWeight: pw.FontWeight.bold,
                                font: ttf, // Apply custom font
                              ),
                            ),
                          ),
                        ),

                        // pw.Divider(color: PdfColors.black),
                        pw.SizedBox(height: 5),
                        // Table with project details (switched)
                        pw.Container(
                          decoration: pw.BoxDecoration(
                            borderRadius: pw.BorderRadius.all(
                                pw.Radius.circular(8)), // Set the radius
                            border: pw.Border.all(
                                color: PdfColors.black), // Set the border color
                          ),
                          child: pw.Table(
                            border: pw.TableBorder(
                              horizontalInside: pw.BorderSide(
                                  color: PdfColors
                                      .black), // Horizontal lines inside the table
                              verticalInside: pw.BorderSide(
                                  color: PdfColors
                                      .black), // Vertical lines inside the table
                            ),
                            children: [
                              // Row for نوع المشروع
                              pw.TableRow(
                                children: [
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(8),
                                    child: pw.Text(
                                      '$projectType',
                                      style: pw.TextStyle(
                                          font: ttf,
                                          fontSize: 9), // Apply custom font
                                    ),
                                  ),
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(8),
                                    child: pw.Text(
                                      'نوع المشروع',
                                      style: pw.TextStyle(
                                          font: ttf,
                                          fontSize: 9), // Apply custom font
                                    ),
                                  ),
                                ],
                              ),
                              // Row for اسم المشروع
                              pw.TableRow(
                                children: [
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(8),
                                    child: pw.RichText(
                                      text: pw.TextSpan(
                                        children: [
                                          pw.TextSpan(
                                            text: '$projectName',
                                            style: pw.TextStyle(
                                                font: ttf,
                                                fontSize:
                                                    9), // Custom font for text
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(8),
                                    child: pw.Text(
                                      'اسم المشروع',
                                      style: pw.TextStyle(
                                          font: ttf,
                                          fontSize: 9), // Apply custom font
                                    ),
                                  ),
                                ],
                              ),
                              // Row for قيمة المشروع
                              pw.TableRow(
                                children: [
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(8),
                                    child: pw.RichText(
                                      text: pw.TextSpan(
                                        children: [
                                          pw.TextSpan(
                                            text: '$donationAmount',
                                            style: pw.TextStyle(
                                                fontSize:
                                                    9), // Default font for numbers
                                          ),
                                          pw.TextSpan(
                                            text: ' دينار كويتي ',
                                            style: pw.TextStyle(
                                                font: ttf,
                                                fontSize:
                                                    9), // Custom font for text
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(8),
                                    child: pw.Text(
                                      'قيمة المشروع',
                                      style: pw.TextStyle(
                                          font: ttf,
                                          fontSize: 9), // Apply custom font
                                    ),
                                  ),
                                ],
                              ),
                              // Row for المكان
                              pw.TableRow(
                                children: [
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(8),
                                    child: pw.Text(
                                      '$contryName',
                                      style: pw.TextStyle(
                                          font: ttf,
                                          fontSize: 9), // Apply custom font
                                    ),
                                  ),
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(8),
                                    child: pw.Text(
                                      'المكان',
                                      style: pw.TextStyle(
                                          font: ttf,
                                          fontSize: 9), // Apply custom font
                                    ),
                                  ),
                                ],
                              ),
                              // Row for تفاصيل البناء
                              pw.TableRow(
                                children: [
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(8),
                                    child: pw.RichText(
                                      text: pw.TextSpan(
                                        children: [
                                          pw.TextSpan(
                                            text:
                                                'حفر بئر سطحي مع خزان ماء مع مضخه كهربائية مع مواضى بعمق ',
                                            style: pw.TextStyle(
                                                font: ttf,
                                                fontSize:
                                                    9), // Custom font for text
                                          ),
                                          pw.TextSpan(
                                            text: '15',
                                            style: pw.TextStyle(
                                                fontSize:
                                                    9), // Default font for numbers
                                          ),
                                          pw.TextSpan(
                                            text: ' الى ',
                                            style: pw.TextStyle(
                                                font: ttf,
                                                fontSize:
                                                    9), // Custom font for text
                                          ),
                                          pw.TextSpan(
                                            text: '30',
                                            style: pw.TextStyle(
                                                fontSize:
                                                    9), // Default font for numbers
                                          ),
                                          pw.TextSpan(
                                            text: ' متر',
                                            style: pw.TextStyle(
                                                font: ttf,
                                                fontSize:
                                                    9), // Custom font for text
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(8),
                                    child: pw.Text(
                                      'تفاصيل البناء',
                                      style: pw.TextStyle(
                                          font: ttf,
                                          fontSize: 9), // Apply custom font
                                    ),
                                  ),
                                ],
                              ),
                              // Row for عدد المستفيدين
                              pw.TableRow(
                                children: [
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(8),
                                    child: pw.RichText(
                                      text: pw.TextSpan(
                                        children: [
                                          pw.TextSpan(
                                            text: '$beneficiaries',
                                            style: pw.TextStyle(
                                                fontSize:
                                                    9), // Default font for numbers
                                          ),
                                          pw.TextSpan(
                                            text: ' مستفيد ',
                                            style: pw.TextStyle(
                                                font: ttf,
                                                fontSize:
                                                    9), // Custom font for text
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  pw.Padding(
                                    padding: pw.EdgeInsets.all(8),
                                    child: pw.Text(
                                      'عدد المستفيدين',
                                      style: pw.TextStyle(
                                          font: ttf,
                                          fontSize: 9), // Apply custom font
                                    ),
                                  ),
                                ],
                              ),
                              // Row for موعد التنفيذ
                              // pw.TableRow(
                              //   children: [
                              //     pw.Padding(
                              //       padding: pw.EdgeInsets.all(8),
                              //       child: pw.RichText(
                              //         text: pw.TextSpan(
                              //           children: [
                              //             pw.TextSpan(
                              //               text: 'من ',
                              //               style: pw.TextStyle(
                              //                   font: ttf,
                              //                   fontSize:
                              //                       9), // Custom font for text
                              //             ),
                              //             pw.TextSpan(
                              //               text: '12 / 8 /2024',
                              //               style: pw.TextStyle(
                              //                   fontSize:
                              //                       9), // Default font for numbers
                              //             ),
                              //             pw.TextSpan(
                              //               text: ' إلى ',
                              //               style: pw.TextStyle(
                              //                   font: ttf,
                              //                   fontSize:
                              //                       9), // Custom font for text
                              //             ),
                              //             pw.TextSpan(
                              //               text: '12 / 11 / 2024',
                              //               style: pw.TextStyle(
                              //                   fontSize:
                              //                       9), // Default font for numbers
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     pw.Padding(
                              //       padding: pw.EdgeInsets.all(8),
                              //       child: pw.Text(
                              //         'موعد التنفيذ',
                              //         style: pw.TextStyle(
                              //             font: ttf,
                              //             fontSize: 9), // Apply custom font
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'الفـــرع:      الجهراء --- سعد العبدالله',
                            style: pw.TextStyle(
                              fontSize: 12,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.blueGrey,
                              font: ttf, // Apply custom font
                            ),
                          ),
                          pw.Row(children: [
                            pw.Text(
                              'التوقيع:    ',
                              style: pw.TextStyle(
                                fontSize: 12,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColors.blueGrey,
                                font: ttf, // Apply custom font
                              ),
                            ),
                            pw.SizedBox(
                              width: 5,
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.only(top: 10),
                              child:
                                  pw.Image(signature, width: 100, height: 100),
                            ),
                          ]),
                        ],
                      ),
                      pw.Column(
                        children: [
                          pw.Text(
                            'الختم',
                            style: pw.TextStyle(
                              fontSize: 14,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.blueGrey,
                              font: ttf, // Apply custom font
                            ),
                          ),
                          pw.Container(
                            decoration: pw.BoxDecoration(
                              borderRadius: pw.BorderRadius.circular(12),
                              border: pw.Border.all(
                                color: PdfColors.black, // Border color
                                width: 2, // Border width
                              ),
                            ),
                            child: pw.Padding(
                              padding: pw.EdgeInsets.all(6),
                              child: pw.Image(imageLogo, width: 60, height: 60),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  pw.Divider(
                    color: CustomColors.buttonColor,
                  ),

                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            'سعــد العبــدالله - ق8 - ش24 - م54 ',
                            style: pw.TextStyle(
                              fontSize: 11,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.blueGrey,
                              font: ttf, // Apply custom font
                            ),
                          ),
                          pw.Text(
                            'حولي - شارع بيروت - مجمع زخرف مقابل سنترال حولي -الدور 3',
                            style: pw.TextStyle(
                              fontSize: 11,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.blueGrey,
                              font: ttf, // Apply custom font
                            ),
                          ),
                        ],
                      ),
                      pw.Column(
                        children: [
                          pw.Text(
                            'Tel. +965 24544051/2',
                            style: pw.TextStyle(
                              fontSize: 9,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                            ),
                          ),
                          pw.Text(
                            'Tel. +965 24544051/2',
                            style: pw.TextStyle(
                              fontSize: 9,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                            ),
                          ),
                        ],
                      ),
                      pw.Column(
                        children: [
                          pw.Text(
                            'الخط الساخن',
                            style: pw.TextStyle(
                              fontSize: 9,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.blue,
                              font: ttf, // Apply custom font
                            ),
                          ),
                          pw.Text(
                            '55502060',
                            style: pw.TextStyle(
                              fontSize: 9,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.black,
                            ),
                          ),
                          pw.Image(accounts, width: 60, height: 60),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    return pdf;
  }
}
