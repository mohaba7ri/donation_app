import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyA5Av1LKFbbkQJj_gkfMs-s4KFylJnFLuU",
      authDomain: "donations-app-9263e.firebaseapp.com",
      projectId: "donations-app-9263e",
      storageBucket: "donations-app-9263e.appspot.com",
      databaseURL: "https://donations-app-9263e-default-rtdb.firebaseio.com/",
      messagingSenderId: "129380867499",
      appId: "1:129380867499:web:6dad76aaf52cfcf79cc6ee");

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAizr9rOJHnOyZhF-w3YlBajyXrHCsOcKo',
    appId: '1:976738004608:android:59fbbac97f4d151342c065',
    messagingSenderId: 'XXXX',
    projectId: 'adaapp-89451',
    // storageBucket: 'yemen-soft-d1a17.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZfv1HlS3O01GY8E7gSEX7lXw5rvNj7VQ',
    appId: '1:782864682414:ios:933e65ef5ed880fe1e4c3f',
    messagingSenderId: '782864682414',
    projectId: 'yemen-soft-d1a17',
    storageBucket: 'yemen-soft-d1a17.appspot.com',
    iosClientId:
        '782864682414-gkmcus8nof3i8qv5716moq132em6mgns.apps.googleusercontent.com',
    iosBundleId: 'com.example.yemenSoft',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZfv1HlS3O01GY8E7gSEX7lXw5rvNj7VQ',
    appId: '1:782864682414:ios:933e65ef5ed880fe1e4c3f',
    messagingSenderId: '782864682414',
    projectId: 'yemen-soft-d1a17',
    storageBucket: 'yemen-soft-d1a17.appspot.com',
    iosClientId:
        '782864682414-gkmcus8nof3i8qv5716moq132em6mgns.apps.googleusercontent.com',
    iosBundleId: 'com.example.yemenSoft',
  );
}
