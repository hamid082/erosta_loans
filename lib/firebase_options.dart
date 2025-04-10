// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyAVkdLgv2PcZCamYvw00aoG-mQmVTHndw4',
    appId: '1:402423441604:android:4de1d43ac4e9f6acb04191',
    messagingSenderId: '402423441604',
    projectId: 'viserlab-global-app',
    storageBucket: 'viserlab-global-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDdMJxGkkvLqa2d7i2sGJz8Bxr229Ugk5Y',
    appId: '1:402423441604:ios:11780177c8ef368fb04191',
    messagingSenderId: '402423441604',
    projectId: 'viserlab-global-app',
    storageBucket: 'viserlab-global-app.appspot.com',
    androidClientId: '402423441604-9q7ijduna5mlv3cdthr14tcjos9vf1kc.apps.googleusercontent.com',
    iosClientId: '402423441604-fics19q83chishqneflj4q0bannjri6b.apps.googleusercontent.com',
    iosBundleId: 'dev.vlab.rapidloan',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDb8Dk3KEKz6oFb3eVh5Ix49VFhcEuXioM',
    appId: '1:402423441604:web:0cabe0188e4f80e8b04191',
    messagingSenderId: '402423441604',
    projectId: 'viserlab-global-app',
    authDomain: 'viserlab-global-app.firebaseapp.com',
    storageBucket: 'viserlab-global-app.appspot.com',
    measurementId: 'G-BLRBH5LGBH',
  );

}