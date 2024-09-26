import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dontations_app/controller/home_controller.dart';
import 'package:dontations_app/routes/app_pages.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/style/fonts.dart';
import 'package:dontations_app/views/desktop/add_constructionProject_desktop.dart';
import 'package:dontations_app/views/desktop/countries_managemant_desktop.dart';
import 'package:dontations_app/views/desktop/donations/views/listDonations_screen.dart';
import 'package:dontations_app/views/desktop/donations/views/manageDonations_screen.dart';
import 'package:dontations_app/views/desktop/donations_desktop.dart';
import 'package:dontations_app/views/desktop/list_constructionProjects_desktop.dart';
import 'package:dontations_app/views/desktop/list_countries_desktop.dart';
import 'package:dontations_app/views/desktop/donations/list_project_types_desktop.dart';
import 'package:dontations_app/views/desktop/project_management/list_countries2_desktop.dart';
import 'package:dontations_app/views/desktop/settings_Desktop.dart';
import 'package:dontations_app/views/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

// class HomeDesktopScreen extends GetView<HomeController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF6F9FC),
//       drawer: _buildSidebar(), // Use a real drawer
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           // Determine if the screen width is small
//           bool isSmallScreen = constraints.maxWidth < 800;

//           return Scaffold(
//             appBar: isSmallScreen
//                 ? AppBar(
//                     backgroundColor: AppColor.appBarColor,
//                     elevation: 0,
//                     iconTheme: IconThemeData(color: Colors.white),
//                     leading: Builder(
//                       builder: (context) {
//                         return IconButton(
//                           icon: Icon(Icons.menu),
//                           onPressed: () {
//                             Scaffold.of(context).openDrawer();
//                           },
//                         );
//                       },
//                     ),
//                   )
//                 : null, // Only show AppBar on small screens
//             drawer: isSmallScreen ? _buildSidebar() : null,
//             body: isSmallScreen
//                 ? Obx(() => _buildContent())
//                 : Row(
//                     children: [
//                       _buildSidebar(),
//                       Expanded(
//                         child: Obx(() => _buildContent()),
//                       ),
//                     ],
//                   ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildSidebar() {
//     return Container(
//       width: 250,
//       color: AppColor.appBarColor,
//       child: Column(
//         children: [
//           SizedBox(height: 50),
//           Text(
//             'لوحة التحكم',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 30),
//           _buildSidebarItem(Icons.dashboard, 'عام', 0),
//           _buildSidebarItem(Icons.person, 'نماذج المشاريع', 1),
//           _buildSidebarItem(Icons.bar_chart, 'التبرعات', 2),
//           _buildSidebarItem(Icons.message, 'المستخدمين', 3),
//           _buildSidebarItem(Icons.list, 'قائمة المتبرعين', 5),
//           _buildSidebarItem(Icons.settings, 'الإعدادات', 6),
//           _buildSidebarItem(Icons.exit_to_app_rounded, 'تسجيل الخروج', 7),
//         ],
//       ),
//     );
//   }

//   Widget _buildSidebarItem(IconData icon, String title, int index) {
//     return GestureDetector(
//       onTap: () {
//         controller.onMenuItemClicked(index);
//       },
//       child: Obx(() {
//         return Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             color: controller.selectedIndex.value == index
//                 ? Colors.white.withOpacity(0.2)
//                 : Colors.transparent,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               children: [
//                 Icon(icon, color: Colors.white),
//                 SizedBox(width: 16),
//                 Text(
//                   title,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }

//   Widget _buildContent() {
//     switch (controller.selectedIndex.value) {
//       case 0:
//         return DashboardContent();
//       case 1:
//         return ListCountries2DesktopScreen();
//       case 2:
//         return ListCountriesDesktopScreen();
//       case 3:
//         return CountriesDesktopScreen();
//       case 4:
//         return CalendarContent();
//       case 5:
//         return ImageDisplayScreen();
//       case 6:
//         return SettingsDesktopScreen();
//       case 7:
//         return LoginScreen();
//       default:
//         return DashboardContent();
//     }
//   }
// }

class HomeDesktopScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F9FC),
      drawer: _buildSidebar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isSmallScreen = constraints.maxWidth < 800;

          return Scaffold(
            appBar: isSmallScreen
                ? AppBar(
                    backgroundColor: AppColor.appBarColor,
                    elevation: 0,
                    iconTheme: IconThemeData(color: Colors.white),
                    leading: Builder(
                      builder: (context) {
                        return IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        );
                      },
                    ),
                  )
                : null,
            drawer: isSmallScreen ? _buildSidebar() : null,
            body: isSmallScreen
                ? Obx(() => _buildContent())
                : Row(
                    children: [
                      _buildSidebar(),
                      Expanded(
                        child: Obx(() => _buildContent()),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 250,
      color: AppColor.appBarColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'لوحة التحكم',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 30),
          _buildSidebarItem(Icons.dashboard, 'عام', 0),
          _buildSidebarItem(Icons.person, 'نماذج المشاريع', 1),
          _buildExpandableSidebarItem(Icons.bar_chart, 'التبرعات', 2, [
            _buildSubItem('إضافة تبرع', Icons.add, 8),
            _buildSubItem('عرض التبرعات', Icons.list, 9),
            _buildSubItem('إدارة التبرعات', Icons.list, 10),
          ]),
          _buildSidebarItem(Icons.message, 'المستخدمين', 3),
          _buildSidebarItem(Icons.list, 'قائمة المتبرعين', 5),
          _buildSidebarItem(Icons.settings, 'الإعدادات', 6),
          _buildSidebarItem(Icons.exit_to_app_rounded, 'تسجيل الخروج', 7),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, int index) {
    return Obx(() {
      bool isSelected = controller.selectedIndex.value == index;
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color:
              isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          selected: isSelected,
          selectedTileColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          onTap: () {
            controller.onMenuItemClicked(index);
          },
        ),
      );
    });
  }

  Widget _buildExpandableSidebarItem(
      IconData icon, String title, int index, List<Widget> children) {
    return Obx(() {
      bool isSelected = controller.selectedIndex.value == index;
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color:
              isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
        ),
        child: ExpansionTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          // backgroundColor:
          //     isSelected ? Colors.grey.shade300 : Colors.transparent,
          childrenPadding: EdgeInsets.only(left: 40),
          tilePadding: EdgeInsets.symmetric(horizontal: 16),
          children: children,
          onExpansionChanged: (expanded) {
            if (expanded) controller.onMenuItemClicked(index);
          },
        ),
      );
    });
  }

  Widget _buildSubItem(String title, IconData icon, int index) {
    return Obx(() {
      bool isSelected = controller.selectedIndex.value == index;
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color:
              isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          selected: isSelected,
          selectedTileColor: Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          onTap: () {
            controller.onMenuItemClicked(index);
          },
        ),
      );
    });
  }

  Widget _buildContent() {
    switch (controller.selectedIndex.value) {
      case 0:
        return DashboardContent();
      case 1:
        return ListCountries2DesktopScreen();
      case 2:
        return DashboardContent();
      case 3:
        return CountriesDesktopScreen();
      case 4:
        return CalendarContent();
      case 5:
        return ImageDisplayScreen();
      case 6:
        return SettingsDesktopScreen();
      case 7:
        logout(); // Call the logout function
        return SizedBox();
      case 8:
        return ListCountriesDesktopScreen(); // Screen for 'إضافة تبرع'
      case 9:
        return ListDonationsScreen(); // Screen for 'عرض التبرعات'
      case 10:
        return DonationManagementScreen(); // Screen for 'عرض التبرعات'
      default:
        return DashboardContent();
    }
  }
}

Future<void> logout() async {
  try {
    // Get.snackbar('نجاح', 'تم تسجيل الخروج بنجاح.');
    // Navigate to the login screen or any other screen
    Get.offAllNamed(Routes.LOGIN); // Assuming you have a named route for login
  } catch (e) {
    Get.snackbar('خطأ', 'فشل في تسجيل الخروج: ${e.toString()}');
  }
}

class DashboardContent extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F9FC),
      body: _buildDashboard(context),
    );
  }

  Widget _buildDashboard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 800) {
            // Large screen layout
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'نظرة عامة',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() {
                      return _buildStatCard('إجمالي التبرعات',
                          controller.totalDonations.value, Colors.green, 200);
                    }),
                    Obx(() {
                      return _buildStatCard('عدد التبرعات',
                          controller.numberValue.value, Colors.red, 200);
                    }),
                    _buildStatCard('عدد المتبرعين', '924', Colors.blue, 200),
                    _buildStatCard(
                        'المشاريع المكتملة', '78', Colors.purple, 200),
                  ],
                ),
                SizedBox(height: 30),
                // Expanded(
                //   child: Row(
                //     children: [
                //       _buildDonorList(),
                //       _buildDonorList(),
                //     ],
                //   ),
                // ),
                // Expanded(
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child:
                //             _buildDonorList(), // First instance of the donor list
                //       ),
                //       SizedBox(
                //           width: 16), // Add spacing between the lists if needed
                //       Expanded(
                //         child:
                //             _buildDonationStatusList(), // Second instance of the donor list
                //       ),
                //     ],
                //   ),
                // ),
                Obx(
                  () {
                    // Check if the user's role is "محاسب"
                    if (controller.role.value == "محاسب") {
                      return _buildDonationStatusList();
                    } else {
                      return Row(
                        children: [
                          Expanded(
                            child: _buildDonorList(),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: _buildDonationStatusList(),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            );
          } else {
            // Small screen layout
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'نظرة عامة',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      _buildStatCard('إجمالي التبرعات', '123,456', Colors.green,
                          constraints.maxWidth - 40),
                      SizedBox(height: 20),
                      Obx(() {
                        return _buildStatCard(
                            'عدد التبرعات',
                            controller.numberValue.value,
                            Colors.red,
                            constraints.maxWidth - 40);
                      }),
                      SizedBox(height: 20),
                      _buildStatCard(
                          'عدد المتبرعين',
                          controller.numberValue.value,
                          Colors.blue,
                          constraints.maxWidth - 40),
                      SizedBox(height: 20),
                      _buildStatCard('المشاريع المكتملة', '78', Colors.purple,
                          constraints.maxWidth - 40),
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildDonorList(),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildStatCard(String title, var value, Color color, double width) {
    return Container(
      width: width,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 16),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildDonorList() {
  //   return Card(
  //     elevation: 5,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(12.0),
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'قائمة المتبرعين',
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontSize: 22,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           SizedBox(height: 16),
  //           ConstrainedBox(
  //             constraints: BoxConstraints(maxHeight: 300),
  //             child: ListView.builder(
  //               shrinkWrap: true,
  //               itemCount: 10,
  //               itemBuilder: (context, index) {
  //                 return ListTile(
  //                   title: Text('اسم المتبرع'),
  //                   subtitle: Text('email@example.com'),
  //                   trailing: Text('\$2500'),
  //                 );
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Stream<QuerySnapshot> _fetchDonations() {
    return FirebaseFirestore.instance.collection('donations').snapshots();
  }

  Widget _buildDonorList() {
    return StreamBuilder<QuerySnapshot>(
        stream: _fetchDonations(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No donations found'));
          } else {
            // Extracting documents from snapshot
            final List<QueryDocumentSnapshot> donations = snapshot.data!.docs;

            return Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'قائمة المتبرعين',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 300),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: donations.length,
                        itemBuilder: (context, index) {
                          // Extracting data from each document
                          final donor =
                              donations[index].data() as Map<String, dynamic>;
                          final String name =
                              donor['name'] ?? 'لا يوجد إسم للمتبرع';
                          final String projectName =
                              donor['projectName'] ?? 'لا يوجد إسم للمشروع';
                          final String combinedCost =
                              donor['combinedCost']?.toString() ?? '0';

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                title: Text(
                                  name,
                                  style: robotoButtonColorDefault,
                                ),
                                subtitle: Text(
                                  projectName,
                                  style: robotoButtonColorDefault,
                                ),
                                trailing: Text(
                                  '${combinedCost}  د ك ',
                                  style: robotoButtonColorDefault,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  Widget _buildDonationStatusList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _fetchDonations(), // Reusing the same stream
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No donations found'));
        } else {
          // Extracting documents from snapshot
          final List<QueryDocumentSnapshot> donations = snapshot.data!.docs;

          return Container(
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'التبرعات',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 300),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: donations.length,
                      itemBuilder: (context, index) {
                        // Extracting data from each document
                        final donation =
                            donations[index].data() as Map<String, dynamic>;
                        final String projectName =
                            donation['projectName'] ?? 'لا يوجد إسم للمشروع';
                        final String combinedCost =
                            donation['combinedCost']?.toString() ?? '0';
                        final String date = donation['date'] ?? 'غير محدد';
                        final String keyNet =
                            donation['keyNet']?.toString() ?? '0';
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(12)),
                            child: ListTile(
                              title: Text(
                                projectName,
                                style: robotoButtonColorDefault,
                              ),
                              subtitle: Text(
                                "التاريخ: $date - كي نت : $keyNet",
                                style: robotoButtonColorDefault,
                              ),
                              trailing: Text(
                                '${combinedCost} د ك ',
                                style: robotoButtonColorDefault,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class ProfileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile Content',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class ReportsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Reports Content',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class MessagesContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Messages Content',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class CalendarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Calendar Content',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class DonorsListContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("data"));
  }
}

class ImageDisplayScreen extends StatefulWidget {
  @override
  _ImageDisplayScreenState createState() => _ImageDisplayScreenState();
}

class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  String? base64Image;

  @override
  void initState() {
    super.initState();
    _fetchImageFromDatabase();
  }

  void _fetchImageFromDatabase() async {
    try {
      DatabaseReference imageRef = _databaseReference.child("image");
      DataSnapshot snapshot = await imageRef.get();
      setState(() {
        base64Image = snapshot.value as String?;
      });
    } catch (e) {
      print("Failed to load image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Image from Firebase'),
      ),
      body: base64Image != null
          ? Center(
              child: Image.memory(
                base64Decode(base64Image!),
                fit: BoxFit.cover,
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class SettingsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Settings Content',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
