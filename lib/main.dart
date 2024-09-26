import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helper/git_di.dart' as di;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      options: const FirebaseOptions(
          apiKey: "AIzaSyA5Av1LKFbbkQJj_gkfMs-s4KFylJnFLuU",
          authDomain: "donations-app-9263e.firebaseapp.com",
          projectId: "donations-app-9263e",
          storageBucket: "donations-app-9263e.appspot.com",
          databaseURL:
              "https://donations-app-9263e-default-rtdb.firebaseio.com/",
          messagingSenderId: "129380867499",
          appId: "1:129380867499:web:6dad76aaf52cfcf79cc6ee"),
    );
  } catch (e) {}
  await di.init();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String> _getInitialRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      await prefs.setBool('isFirstTime', false);
      return Routes.LOGIN;
    } else {
      return Routes.LOGIN;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getInitialRoute(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          return GetMaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('ar', 'SA'), // Arabic, UAE
            ],
            locale: const Locale('ar', 'SA'),
            title: 'donation',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: snapshot.data,
            getPages: AppPages.routes,
          );
        }
      },
    );
  }
}
