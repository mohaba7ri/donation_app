import 'dart:convert';

import 'package:dontations_app/controller/home_controller.dart';
import 'package:dontations_app/style/app_color.dart';
import 'package:dontations_app/views/desktop/add_constructionProject_desktop.dart';
import 'package:dontations_app/views/desktop/countries_managemant_desktop.dart';
import 'package:dontations_app/views/desktop/donations_desktop.dart';
import 'package:dontations_app/views/desktop/list_constructionProjects_desktop.dart';
import 'package:dontations_app/views/desktop/list_countries_desktop.dart';
import 'package:dontations_app/views/desktop/list_project_types_desktop.dart';
import 'package:dontations_app/views/desktop/project_management/list_countries2_desktop.dart';
import 'package:dontations_app/views/desktop/settings_Desktop.dart';
import 'package:dontations_app/views/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeDesktopScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F9FC),
      drawer: _buildSidebar(), // Use a real drawer
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determine if the screen width is small
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
                : null, // Only show AppBar on small screens
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
        children: [
          SizedBox(height: 50),
          Text(
            'لوحة التحكم',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 30),
          _buildSidebarItem(Icons.dashboard, 'عام', 0),
          _buildSidebarItem(Icons.person, 'نماذج المشاريع', 1),
          _buildSidebarItem(Icons.bar_chart, 'التبرعات', 2),
          _buildSidebarItem(Icons.message, 'المستخدمين', 3),
          _buildSidebarItem(Icons.list, 'قائمة المتبرعين', 5),
          _buildSidebarItem(Icons.settings, 'الإعدادات', 6),
          _buildSidebarItem(Icons.exit_to_app_rounded, 'تسجيل الخروج', 7),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String title, int index) {
    return GestureDetector(
      onTap: () {
        controller.onMenuItemClicked(index);
      },
      child: Obx(() {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: controller.selectedIndex.value == index
                ? Colors.white.withOpacity(0.2)
                : Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(icon, color: Colors.white),
                SizedBox(width: 16),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildContent() {
    switch (controller.selectedIndex.value) {
      case 0:
        return DashboardContent();
      case 1:
        return ListCountries2DesktopScreen();
      case 2:
        return ListCountriesDesktopScreen();
      case 3:
        return CountriesDesktopScreen();
      case 4:
        return CalendarContent();
      case 5:
        return ImageDisplayScreen();
      case 6:
        return SettingsDesktopScreen();
      case 7:
        return LoginScreen();
      default:
        return DashboardContent();
    }
  }
}

class DashboardContent extends StatelessWidget {
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
                    _buildStatCard(
                        'إجمالي التبرعات', '123,456', Colors.green, 200),
                    _buildStatCard('عدد التبرعات', '157', Colors.red, 200),
                    _buildStatCard('عدد المتبرعين', '924', Colors.blue, 200),
                    _buildStatCard(
                        'المشاريع المكتملة', '78', Colors.purple, 200),
                  ],
                ),
                SizedBox(height: 30),
                Expanded(
                  child: _buildDonorList(),
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
                      _buildStatCard('عدد التبرعات', '157', Colors.red,
                          constraints.maxWidth - 40),
                      SizedBox(height: 20),
                      _buildStatCard('عدد المتبرعين', '924', Colors.blue,
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

  Widget _buildStatCard(String title, String value, Color color, double width) {
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
            offset: Offset(0, 3), // changes position of shadow
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

  Widget _buildDonorList() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
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
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('اسم المتبرع'),
                    subtitle: Text('email@example.com'),
                    trailing: Text('\$2500'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
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
