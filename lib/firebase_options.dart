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
        return windows;
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
    apiKey: 'AIzaSyDyG6iK2jM9y6Jvq8_wrgVgN9Fqy0Yx1ac',
    appId: '1:748052178019:web:4ce0160702a386e2148456',
    messagingSenderId: '748052178019',
    projectId: 'mr-buddy-cd7a4',
    authDomain: 'mr-buddy-cd7a4.firebaseapp.com',
    storageBucket: 'mr-buddy-cd7a4.appspot.com',
    measurementId: 'G-XZZG9ZSHHD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJryQ-qSHN3A-1t1h0jrj8e-_4TWceLfw',
    appId: '1:748052178019:android:810fc3d3e6711aba148456',
    messagingSenderId: '748052178019',
    projectId: 'mr-buddy-cd7a4',
    storageBucket: 'mr-buddy-cd7a4.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuHy5fyFNLQ22wQq796aOyFRGcosNRk60',
    appId: '1:748052178019:ios:282896071f3c45f2148456',
    messagingSenderId: '748052178019',
    projectId: 'mr-buddy-cd7a4',
    storageBucket: 'mr-buddy-cd7a4.appspot.com',
    iosBundleId: 'com.example.mrBuddy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBuHy5fyFNLQ22wQq796aOyFRGcosNRk60',
    appId: '1:748052178019:ios:282896071f3c45f2148456',
    messagingSenderId: '748052178019',
    projectId: 'mr-buddy-cd7a4',
    storageBucket: 'mr-buddy-cd7a4.appspot.com',
    iosBundleId: 'com.example.mrBuddy',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDyG6iK2jM9y6Jvq8_wrgVgN9Fqy0Yx1ac',
    appId: '1:748052178019:web:1b1bccb3a6397d6f148456',
    messagingSenderId: '748052178019',
    projectId: 'mr-buddy-cd7a4',
    authDomain: 'mr-buddy-cd7a4.firebaseapp.com',
    storageBucket: 'mr-buddy-cd7a4.appspot.com',
    measurementId: 'G-07ZQ9MLMGJ',
  );
}
