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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAKP_J_b7uN2PKQMDD2wTK2J9kP5FZgyCY',
    appId: '1:960125984155:web:cd2ab3f85a06cde98bd53e',
    messagingSenderId: '960125984155',
    projectId: 'wedding-dc7d7',
    authDomain: 'wedding-dc7d7.firebaseapp.com',
    storageBucket: 'wedding-dc7d7.appspot.com',
    measurementId: 'G-JJHM7D7E1Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDTRujYcqCDL3N945de0pqd_7c03HTBsZI',
    appId: '1:960125984155:android:d2517bb4caa1f2c18bd53e',
    messagingSenderId: '960125984155',
    projectId: 'wedding-dc7d7',
    storageBucket: 'wedding-dc7d7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3hqjQ-1gVrcH-P96scnVwOD_k54RHQHc',
    appId: '1:960125984155:ios:bf31115236c11a5a8bd53e',
    messagingSenderId: '960125984155',
    projectId: 'wedding-dc7d7',
    storageBucket: 'wedding-dc7d7.appspot.com',
    iosClientId: '960125984155-fmu2vg26faotscmhfe0c6dv1otpcj78g.apps.googleusercontent.com',
    iosBundleId: 'com.example.wedding',
  );
}