import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

class DesktopCompanyAccount {
  static late Font arFont;

  static init() async {
    arFont =
        Font.ttf((await rootBundle.load("assets/Alarabiya_Normal_Font.ttf")));
  }

  static createPdf({
    required String companyName,
    required String comNumber,
    required String comIdIssueDate,
    required String comIdIssuePlace,
    required String name,
    required String phoneNumber1,
    required String phoneNumber2,
    required String phoneNumber3,
    required String comJob,
    required String gov,
    required String city,
    required String neighbor,

    // Add arguments based on provided controllers
    required String depName1,
    required String depPhone1,
    required String depIdType1,
    required String depIdNumebr1,
    required String depIdIssuePlace1,
    required String depIdIssueDate1,
    //
    required String depName2,
    required String depPhone2,
    required String depIdType2,
    required String depIdNumebr2,
    required String depIdIssuePlace2,
    required String depIdIssueDate2,
    //
    required String depName3,
    required String depPhone3,
    required String depIdType3,
    required String depIdNumebr3,
    required String depIdIssuePlace3,
    required String depIdIssueDate3,
    required String companyPermission,
  }) async {
    String path = (await getApplicationDocumentsDirectory()).path;
    File file = File(path + "MY_PDF.pdf");

    Document pdf = Document();

    var image = MemoryImage(
        (await rootBundle.load('assets/logo.png')).buffer.asUint8List());
    var conditions = MemoryImage(
        (await rootBundle.load('assets/logo.png')).buffer.asUint8List());
    var comName = MemoryImage(
        (await rootBundle.load('assets/logo.png')).buffer.asUint8List());
    var logo = MemoryImage(
        (await rootBundle.load('assets/logo.png')).buffer.asUint8List());
    var openAccount = MemoryImage(
        (await rootBundle.load('assets/logo.png')).buffer.asUint8List());
    pdf.addPage(_createPage(
      image,
      companyName,
      comNumber,
      comIdIssueDate,
      comIdIssuePlace,
      name,
      comName,
      logo,
      openAccount,
      phoneNumber1,
      phoneNumber2,
      phoneNumber3,
      comJob,
      gov,
      city,
      neighbor,
      depName1,
      depPhone1,
      depIdType1,
      depIdNumebr1,
      depIdIssuePlace1,
      depIdIssueDate1,
      depName2,
      depPhone2,
      depIdType2,
      depIdNumebr2,
      depIdIssuePlace2,
      depIdIssueDate2,
      depName3,
      depPhone3,
      depIdType3,
      depIdNumebr3,
      depIdIssuePlace3,
      depIdIssueDate3,
      companyPermission,
    ));
    pdf.addPage(_createSecondPage("xs", conditions)); // Passing email argument
    Uint8List bytes = await pdf.save();

    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  static Page _createPage(
    var image,
    String companyName,
    String comNumber,
    String comIdIssueDate,
    String comIdIssuePlace,
    String name,
    var comName,
    var logo,
    var openAccount,
    String phoneNumber1,
    String phoneNumber2,
    String phoneNumber3,
    String comJob,
    String gov,
    String city,
    String neighbor,
    String depName1,
    String depPhone1,
    String depIdType1,
    String depIdNumebr1,
    String depIdIssuePlace1,
    String depIdIssueDate1,
    String depName2,
    String depPhone2,
    String depIdType2,
    String depIdNumebr2,
    String depIdIssuePlace2,
    String depIdIssueDate2,
    String depName3,
    String depPhone3,
    String depIdType3,
    String depIdNumebr3,
    String depIdIssuePlace3,
    String depIdIssueDate3,
    String companyPermission,
  ) {
    return Page(
      margin: EdgeInsets.all(4),
      textDirection: TextDirection.rtl,
      theme: ThemeData.withFont(
        base: arFont,
      ),
      pageFormat: PdfPageFormat.a4,
      build: (context) {
        DateTime now = DateTime.now();

        return Padding(
          padding: EdgeInsets.fromLTRB(8, 30, 8, 5),
          child: pw.Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      pw.SizedBox(
                        width: 250,
                        height: 200,
                        child: pw.Image(comName),
                      ),
                      Row(children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: pw.Text(
                            "التاريخ:",
                            style: TextStyle(fontSize: 9),
                          ),
                        ),
                        Text("${now.day}/${now.month}/${now.year}",
                            style:
                                TextStyle(font: Font.timesBold(), fontSize: 9)),
                        SizedBox(width: 175),
                        pw.SizedBox(
                          width: 120,
                          height: 120,
                          child: pw.Image(openAccount),
                        ),
                      ]),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: pw.Text("الفرع:", style: TextStyle(fontSize: 9)),
                      ),
                    ]),
                pw.Image(logo, width: 100, height: 100),
              ]),
              SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          3), // Adjust the radius as needed
                      border: Border.all(color: PdfColors.black, width: 1),
                    ),
                    child: Text(
                      "رقم الحساب",
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  Container(
                    width: 160,
                    height: 22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          3), // Adjust the radius as needed
                      border: Border.all(color: PdfColors.black, width: 1),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: pw.Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      decoration: pw.BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: PdfColors.yellow200, // Background color
                      ),
                      child: pw.Text("* بيانات المنشأة / الشركة",
                          style: pw.TextStyle(
                            fontSize: 12,
                          )),
                    ),
                    pw.Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the radius as needed
                        border: Border.all(width: 1), // Border properties
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.all(10), // Adjust the padding as needed
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 1, bottom: 1),
                              child: _buildInformationRow(
                                "إسم المنشأة / الشركة: ",
                                companyName,
                                "إسم المالك:",
                                name,
                              ),
                            ),
                            pw.Divider(color: PdfColors.grey),
                            Padding(
                              padding: EdgeInsets.only(top: 1, bottom: 1),
                              child: _buildInformationRow2(
                                  "رقم السجل التجاري: ",
                                  comNumber,
                                  "مكان الإصدار:",
                                  comIdIssuePlace,
                                  "تاريخ الإصدار:",
                                  comIdIssueDate),
                            ),
                            pw.Divider(color: PdfColors.grey),
                            Padding(
                              padding: EdgeInsets.only(top: 1, bottom: 1),
                              child: _buildInformationRow01(
                                  "طبيعة عمل المنشأة / الشركة:", comJob),
                            ),
                          ],
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Container(
                      decoration: pw.BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: PdfColors.yellow200, // Background color
                      ),
                      child: pw.Text(" *  العنوان",
                          style: pw.TextStyle(
                            fontSize: 12,
                          )),
                    ),
                    pw.Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            10), // Adjust the radius as needed
                        border: Border.all(width: 1), // Border properties
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.all(10), // Adjust the padding as needed
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildInformationRow01(
                                  "المحافظة:",
                                  gov,
                                ),
                                _buildInformationRow01(
                                  "المدينة/المديرية:",
                                  city,
                                ),
                                _buildInformationRow01(
                                  "الحي:",
                                  neighbor,
                                ),
                                if (phoneNumber1.isEmpty)
                                  _buildPhonesRow(
                                      "رقم الهاتف: ",
                                      "    |       $phoneNumber1     ",
                                      "    |    $phoneNumber2       ",
                                      "     $phoneNumber3       ")
                                else
                                  _buildfullPhonesRow("رقم الهاتف: ",
                                      phoneNumber1, phoneNumber2, phoneNumber3),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 5),
                    pw.Divider(borderStyle: pw.BorderStyle.dashed),
                    _buildCompanyPermissionStatus(
                        "1. المفوضون بالتوقيع", companyPermission),
                    pw.Table(
                      border: pw.TableBorder
                          .all(), // Add borders to the table cells
                      children: [
                        pw.TableRow(
                          children: [
                            // Add the headers in the first row
                            for (var header in [
                              "تاريخ الاصدار",
                              "مكان الاصدار",
                              "رقم الهوية",
                              "نوع الهوية",
                              "رقم الهاتف",
                              "الاسم",
                              "#",
                            ])
                              pw.Container(
                                padding: pw.EdgeInsets.all(
                                    3), // Add padding to each cell
                                alignment: pw.Alignment
                                    .center, // Align content to the center
                                child: pw.Text(header,
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                    )), // Header text
                              ),
                          ],
                        ),
                        // Add remaining rows and data...
                        // Example additional row
                        pw.TableRow(
                          // Set text direction to right-to-left
                          children: [
                            // Example data in the first row
                            for (var i = 0;
                                i <
                                    [
                                      depIdIssueDate1,
                                      depIdIssuePlace1,
                                      depIdNumebr1,
                                      depIdType1,
                                      depPhone1,
                                      depName1,
                                      "1", // Text "1" which you want to style differently
                                    ].length;
                                i++)
                              pw.Container(
                                padding: pw.EdgeInsets.all(
                                    1), // Add padding to each cell
                                alignment: pw.Alignment
                                    .center, // Align content to the center
                                child: i == 0 ||
                                        i == 4 ||
                                        i ==
                                            2 // Check the index for specific data eِlements
                                    ? pw.Text(
                                        [
                                          depIdIssueDate1, // depIdIssueDate1
                                          depIdIssuePlace1,
                                          depIdNumebr1, // depIdNumebr1
                                          depIdType1,
                                          depPhone1, // depPhone1
                                          depName1,
                                          "1", // Text "1" which you want to style differently
                                        ][i]
                                            .toString(),
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                          fontWeight: i == 0 || i == 4 || i == 2
                                              ? pw.FontWeight.bold
                                              : null, // Apply different font style
                                          // Add more font properties as needed
                                        ),
                                      )
                                    : pw.Text(
                                        [
                                          depIdIssueDate1,
                                          depIdIssuePlace1,
                                          depIdNumebr1,
                                          depIdType1,
                                          depPhone1,
                                          depName1,
                                          "1",
                                        ][i]
                                            .toString(),
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                        ),
                                      ),
                              ),
                          ],
                        ),

                        pw.TableRow(
                          // Set text direction to right-to-left
                          children: [
                            // Example data in the first row
                            for (var i = 0;
                                i <
                                    [
                                      depIdIssueDate2,
                                      depIdIssuePlace2,
                                      depIdNumebr2,
                                      depIdType2,
                                      depPhone2,
                                      depName2,
                                      "2", // Text "2" which you want to style differently
                                    ].length;
                                i++)
                              pw.Container(
                                padding: pw.EdgeInsets.all(
                                    3), // Add padding to each cell
                                alignment: pw.Alignment
                                    .center, // Align content to the center
                                child: i == 0 ||
                                        i == 4 ||
                                        i ==
                                            2 // Check the index for specific data elements
                                    ? pw.Text(
                                        [
                                          depIdIssueDate2, // depIdIssueDate2
                                          depIdIssuePlace2,
                                          depIdNumebr2, // depIdNumebr2
                                          depIdType2,
                                          depPhone2, // depPhone2
                                          depName2,
                                          "2", // Text "2" which you want to style differently
                                        ][i]
                                            .toString(),
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                          fontWeight: i == 0 || i == 4 || i == 2
                                              ? pw.FontWeight.bold
                                              : null, // Apply different font style
                                          // Add more font properties as needed
                                        ),
                                      )
                                    : pw.Text(
                                        [
                                          depIdIssueDate2,
                                          depIdIssuePlace2,
                                          depIdNumebr2,
                                          depIdType2,
                                          depPhone2,
                                          depName2,
                                          "2",
                                        ][i]
                                            .toString(),
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                        ),
                                      ),
                              ),
                          ],
                        ),

                        pw.TableRow(
                          // Set text direction to right-to-left
                          children: [
                            // Example data in the first row
                            for (var i = 0;
                                i <
                                    [
                                      depIdIssueDate3,
                                      depIdIssuePlace3,
                                      depIdNumebr3,
                                      depIdType3,
                                      depPhone3,
                                      depName3,
                                      "3", // Text "3" which you want to style differently
                                    ].length;
                                i++)
                              pw.Container(
                                padding: pw.EdgeInsets.all(
                                    3), // Add padding to each cell
                                alignment: pw.Alignment
                                    .center, // Align content to the center
                                child: i == 0 ||
                                        i == 4 ||
                                        i == 2 ||
                                        i ==
                                            6 // Check the index for specific data elements
                                    ? pw.Text(
                                        [
                                          depIdIssueDate3, // depIdIssueDate3
                                          depIdIssuePlace3,
                                          depIdNumebr3, // depIdNumebr3
                                          depIdType3,
                                          depPhone3, // depPhone3
                                          depName3,
                                          "3", // Text "3" which you want to style differently
                                        ][i]
                                            .toString(),
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                          fontWeight: pw.FontWeight
                                              .bold, // Apply different font style
                                          // Add more font properties as needed
                                        ),
                                      )
                                    : pw.Text(
                                        [
                                          depIdIssueDate3,
                                          depIdIssuePlace3,
                                          depIdNumebr3,
                                          depIdType3,
                                          depPhone3,
                                          depName3,
                                          "3",
                                        ][i]
                                            .toString(),
                                        style: pw.TextStyle(
                                          fontSize: 9,
                                        ),
                                      ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    pw.Divider(borderStyle: pw.BorderStyle.dashed),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCompanyPermissionStatus(
                                "2. تفويض الشركة", companyPermission),
                            pw.Text(
                              "تفوض المنشأة / الشركة الموضح بياناتها أعلاه شركة المجربي للصرافة بإجراء أي عمليات من حسابنا \n وذلك بناء على طلب من الاشخاص المفوضون أعلاه عبر: إتصال او رسالة نصية او رسالة واتس اب من أرقامهم الموثقة في بيانات \nحسابنا لدى شركة المجربي للصرافة. ويعتبر هذا التفويض ساري الصلاحية بشكل دائم, مالم نقم بطلب الغاء رسمي له.",
                              style: pw.TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text("الختم",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                  )),
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10), // Adjust the radius as needed
                                  border: Border.all(
                                      width: 1,
                                      style: BorderStyle
                                          .dotted), // Border properties
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    pw.SizedBox(height: 3),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Page _createSecondPage(String email, var conditions) {
    return Page(
        margin: EdgeInsets.all(2),
        textDirection: TextDirection.rtl,
        theme: ThemeData.withFont(
          base: arFont,
        ),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: PdfColors.yellow200, // Background color
                    ),
                    child: pw.Text(" * الشروط والأحكام",
                        style: pw.TextStyle(
                          fontSize: 12,
                        )),
                  ),
                  pw.SizedBox(
                    child: pw.Image(conditions),
                  ),
                  SizedBox(height: 10),
                  pw.Divider(borderStyle: pw.BorderStyle.dashed),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: PdfColors.yellow200, // Background color
                    ),
                    child: pw.Text(
                      " *  نماذج توقيع المفوضون",
                      style: pw.TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Row(children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: PdfColors.black, width: 1),
                            left: BorderSide(color: PdfColors.black, width: 1),
                            right: BorderSide(color: PdfColors.black, width: 1),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 10),
                            child: Text("المفوض الاول",
                                style: TextStyle(
                                    fontSize: 10, color: PdfColors.grey)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: PdfColors.black, width: 1),
                            left: BorderSide(color: PdfColors.black, width: 1),
                            right: BorderSide(color: PdfColors.black, width: 1),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 10),
                            child: Text("المفوض الثاني",
                                style: TextStyle(
                                    fontSize: 10, color: PdfColors.grey)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: PdfColors.black, width: 1),
                            left: BorderSide(color: PdfColors.black, width: 1),
                            right: BorderSide(color: PdfColors.black, width: 1),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 10),
                            child: Text("المفوض الثالث",
                                style: TextStyle(
                                    fontSize: 10, color: PdfColors.grey)),
                          ),
                        ),
                      ),
                    )
                  ]),
                  // pw.Text(
                  //   " *  انا الموقع ادناه أؤكد بأن كافة البيانات والمعلومات الواردة في هذا الطلب صحيحة واتحمل كامل المسؤولية عن ذلك.",
                  //   style: pw.TextStyle(
                  //     fontSize: 10,
                  //   ),
                  // ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: pw.Text(
                          "الاسم:..................................................................",
                          style: pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: pw.Text(
                          "التوقيع:...........................................................",
                          style: pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("البصمة/الختم",
                                style: pw.TextStyle(
                                  fontSize: 10,
                                )),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust the radius as needed
                                border: Border.all(
                                    width: 1,
                                    style: BorderStyle
                                        .dotted), // Border properties
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  pw.Divider(borderStyle: pw.BorderStyle.dashed),
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "الموظف المختص: ........................................",
                            style: pw.TextStyle(
                              fontSize: 10,
                            )),
                        Text("مدير الفرع",
                            style: pw.TextStyle(
                              fontSize: 10,
                            )),
                        Text("إدارة الامتثال",
                            style: pw.TextStyle(
                              fontSize: 10,
                            )),
                        SizedBox(width: 2.5)
                      ])
                ],
              )
            ]),
          );
        });
  }

  static Widget _buildInformationRow(
      String label1, String value1, String label2, String value2) {
    return pw.Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          pw.Text("$label1 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value1),
        ]),
        Row(children: [
          pw.Text("$label2 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value2),
        ]),
        SizedBox(width: 60),
      ],
    );
  }

  static Widget _buildInformationRow0(String label1, String value1) {
    return pw.Row(
      children: [
        pw.Text(".1 ",
            style: pw.TextStyle(
              fontSize: 9,
            )),
        pw.Text("$label1 ",
            style: pw.TextStyle(
              fontSize: 9,
            )),
        _buildTextWithBorder(value1),
      ],
    );
  }

  static Widget _buildInformationRow2(String label1, String value1,
      String label2, String value2, String label3, String value3) {
    return pw.Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          pw.Text("$label1 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildPhoneTextWithBorder(value1),
        ]),
        SizedBox(),
        Row(children: [
          pw.Text("$label2 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value2),
        ]),
        Row(children: [
          pw.Text(" $label3 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildPhoneTextWithBorder(value3),
        ]),
        SizedBox(),
      ],
    );
  }

  static Widget _buildInformationRow01(String label1, String value1) {
    return pw.Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          pw.Text("$label1 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value1),
        ]),
      ],
    );
  }

  static Widget _buildPhonesRow(
      String label1, String value1, String value2, String value3) {
    return pw.Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          pw.Text("$label1 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          SizedBox(width: 20),
          _buildPhoneTextWithBorder(value1),
          SizedBox(width: 20),
          _buildPhoneTextWithBorder(value2),
          SizedBox(width: 20),
          _buildPhoneTextWithBorder(value3),
          SizedBox(width: 20),
        ]),
      ],
    );
  }

  static Widget _buildfullPhonesRow(
      String label1, String value1, String value2, String value3) {
    return pw.Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          pw.Text("$label1 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          SizedBox(width: 10),
          _buildPhoneTextWithBorder(value1),
          Container(height: 10, width: 1, color: PdfColors.grey),
          SizedBox(width: 10),
          _buildPhoneTextWithBorder(value2),
          SizedBox(width: 10),
          Container(height: 10, width: 1, color: PdfColors.grey),
          _buildPhoneTextWithBorder(value3),
        ]),
      ],
    );
  }

  static Widget _buildInformationRow4(
      String label1,
      String value1,
      String label2,
      String value2,
      String label3,
      String value3,
      String label4,
      String value4) {
    return pw.Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          pw.Text("$label1 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value1),
        ]),
        Row(children: [
          pw.Text("$label2 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value2),
        ]),
        Row(children: [
          pw.Text(" $label3 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value3),
        ]),
        Row(children: [
          pw.Text("$label4 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value4),
        ])
      ],
    );
  }

  static Widget _buildInformationRow5(
      String label1,
      String value1,
      String label2,
      String value2,
      String label3,
      String value3,
      String label4,
      String value4,
      String label5,
      String value5) {
    return pw.Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          pw.Text("$label1 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value1),
        ]),
        Row(children: [
          pw.Text("$label2 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value2),
        ]),
        Row(children: [
          pw.Text(" $label3 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value3),
        ]),
        Row(children: [
          pw.Text("$label4 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value4),
        ]),
        Row(children: [
          pw.Text("$label5 ",
              style: pw.TextStyle(
                fontSize: 9,
              )),
          _buildTextWithBorder(value5),
        ])
      ],
    );
  }

  static Widget _buildCheckedStatus(String label1, String value1) {
    return pw.Row(
      children: [
        pw.Text(".2",
            style: pw.TextStyle(
              fontSize: 10,
            )),
        if (label1 == "الاشتراك في تطبيق المجربي موبايلي" &&
            value1 == "نعم") ...[
          _buildCheckBox(true),
        ],
        pw.Text(" $label1 ",
            style: pw.TextStyle(
              fontSize: 10,
            )),
      ],
    );
  }

  static Widget _buildCompanyPermissionStatus(String label1, String value1) {
    return pw.Row(
      children: [
        if (label1 == "تفويض الشركة" && value1 == "نعم") ...[
          _buildCheckBox(true),
        ],
        pw.Text(" $label1 ",
            style: pw.TextStyle(
              fontSize: 10,
            )),
      ],
    );
  }

  static Widget _buildCheckBox(bool checked) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: pw.Container(
        width: 16,
        height: 10,
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.black, width: 1.5),
          borderRadius: pw.BorderRadius.circular(3),
          color: checked ? PdfColors.indigo : PdfColors.black,
        ),
      ),
    );
  }

  static Widget _buildTextWithBorder(String text) {
    return Container(
        child: Padding(
      padding: EdgeInsets.only(left: 4, right: 1),
      child: pw.Text(" $text",
          style: pw.TextStyle(
            fontSize: 9,
          )),
    ));
  }

  static Widget _buildPhoneTextWithBorder(String text) {
    return Container(
        // decoration: BoxDecoration(
        //   border: Border.all(),
        // ),
        child: Padding(
      padding: EdgeInsets.only(left: 4, right: 4),
      child: pw.Text(" $text",
          style: pw.TextStyle(fontSize: 7, font: Font.timesBold())),
    ));
  }
}
