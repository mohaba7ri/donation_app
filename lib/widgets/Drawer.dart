import 'package:dontations_app/style/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper/alertExitApp.dart';
import '../style/app_color.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final sharedPreferences = snapshot.data!;
          final username = sharedPreferences.getString('name') ?? 'Asma';
          final phone =
              sharedPreferences.getString('phone') ?? 'asma@gmail.com';
          final profileImageUrl =
              sharedPreferences.getString('profileImage') ?? '';

          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Directionality(
                textDirection: TextDirection.rtl,
                child: UserAccountsDrawerHeader(
                  accountName: Text(
                    username,
                    style: robotoHugeWhite,
                  ),
                  accountEmail: Text(
                    phone,
                    style: robotoHugeWhite,
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: profileImageUrl.isNotEmpty
                        ? ClipOval(
                            child: Image.network(
                              profileImageUrl,
                              fit: BoxFit.cover,
                              width: 90.0,
                              height: 90.0,
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            size: 90.0,
                            color: Colors.black,
                          ),
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                  ),
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('الصفحة الرئيسية'),
                  onTap: () {
                    // Get.toNamed(Routes.HOMESCREEN);
                  },
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  leading: const Icon(Icons.published_with_changes_sharp),
                  title: const Text('تتبع التقدم والخطة العلاجية'),
                  onTap: () {
                    // Get.toNamed(Routes.HISTORYSCREEN);
                  },
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('تعديل الملف الشخصي'),
                  onTap: () {
                    // Get.toNamed(Routes.EDITPROFILESCREEN);
                  },
                ),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('تسجيل خروج'),
                  onTap: () {
                    alertExitApp();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
