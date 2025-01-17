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
    apiKey: 'AIzaSyD29Q2v_iwQnnhflBHuQX59nNstHndPU4E',
    appId: '1:78951738748:web:a845112f6d2bc6baa948f9',
    messagingSenderId: '78951738748',
    projectId: 'ssni-344',
    authDomain: 'ssni-344.firebaseapp.com',
    storageBucket: 'ssni-344.appspot.com',
    measurementId: 'G-Y2659G61ND',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAUqI-EDTURY8IoXRerVIhft3ogLLYPFZo',
    appId: '1:78951738748:android:0bb2860ad964d0b6a948f9',
    messagingSenderId: '78951738748',
    projectId: 'ssni-344',
    storageBucket: 'ssni-344.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBeqgpMiZYAWWp7679r9bKFvez8wrjaXZE',
    appId: '1:1093099052997:ios:f2523303b00acd93fd75ac',
    messagingSenderId: '1093099052997',
    projectId: 'haidz556-2a773',
    storageBucket: 'haidz556-2a773.appspot.com',
    iosBundleId: 'com.example.midTerm1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBeqgpMiZYAWWp7679r9bKFvez8wrjaXZE',
    appId: '1:1093099052997:ios:f2523303b00acd93fd75ac',
    messagingSenderId: '1093099052997',
    projectId: 'haidz556-2a773',
    storageBucket: 'haidz556-2a773.appspot.com',
    iosBundleId: 'com.example.midTerm1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD29Q2v_iwQnnhflBHuQX59nNstHndPU4E',
    appId: '1:78951738748:web:38f09dabae28ef15a948f9',
    messagingSenderId: '78951738748',
    projectId: 'ssni-344',
    authDomain: 'ssni-344.firebaseapp.com',
    storageBucket: 'ssni-344.appspot.com',
    measurementId: 'G-MC19M8HZKV',
  );
}
