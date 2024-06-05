// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCyKXYJ-owDTDlkYatWmAjqyDH4H-osRV0',
    appId: '1:359954007543:android:5278ac3ff3ef94b7acdaf2',
    messagingSenderId: '359954007543',
    projectId: 'aitravelplanner-72fed',
    storageBucket: 'aitravelplanner-72fed.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCuFNTHR5CRlXCWBE21-9OKQp6OMQh16Ks',
    appId: '1:359954007543:ios:c1329b3c0faa07efacdaf2',
    messagingSenderId: '359954007543',
    projectId: 'aitravelplanner-72fed',
    storageBucket: 'aitravelplanner-72fed.appspot.com',
    androidClientId: '359954007543-2qkdh4n5s3hhjbog8egsjevlt8hkhvgj.apps.googleusercontent.com',
    iosClientId: '359954007543-i2lj9cvlltnhas7sbeae858ggiip552o.apps.googleusercontent.com',
    iosBundleId: 'com.aitravelplanner.aiTravelPlanner',
  );

}