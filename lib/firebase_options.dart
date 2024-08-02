// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

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
  /// Identificar de qual plataforma o usuário está acessando
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

  /// /// Configurações para web
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBhfvD3yJhUoCy3p5sdaWpk4lPbneu_uMA',
    appId: '1:592388319148:web:19bea9c95552e034a77c09',
    messagingSenderId: '592388319148',
    projectId: 'taverna-dos-combos',
    authDomain: 'taverna-dos-combos.firebaseapp.com',
    storageBucket: 'taverna-dos-combos.appspot.com',
    measurementId: 'G-4R67BFXQ6C',
  );

  /// Configurações para android

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD32Z4CtvqQgPNHUiqWMmK7zNEte5AaOtI',
    appId: '1:592388319148:android:c5b17943e32bd753a77c09',
    messagingSenderId: '592388319148',
    projectId: 'taverna-dos-combos',
    storageBucket: 'taverna-dos-combos.appspot.com',
  );

  /// Configurações para iOS

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAkE1gchEKCUBaEWcXPrPyFDfR1H4HXScs',
    appId: '1:592388319148:ios:7b7d3e899f80112fa77c09',
    messagingSenderId: '592388319148',
    projectId: 'taverna-dos-combos',
    storageBucket: 'taverna-dos-combos.appspot.com',
    iosBundleId: 'com.example.tavernadoscombos',
  );

  /// Configurações para macOS

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAkE1gchEKCUBaEWcXPrPyFDfR1H4HXScs',
    appId: '1:592388319148:ios:7b7d3e899f80112fa77c09',
    messagingSenderId: '592388319148',
    projectId: 'taverna-dos-combos',
    storageBucket: 'taverna-dos-combos.appspot.com',
    iosBundleId: 'com.example.tavernadoscombos',
  );

  /// Configurações para windows

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBhfvD3yJhUoCy3p5sdaWpk4lPbneu_uMA',
    appId: '1:592388319148:web:120220b722edfb34a77c09',
    messagingSenderId: '592388319148',
    projectId: 'taverna-dos-combos',
    authDomain: 'taverna-dos-combos.firebaseapp.com',
    storageBucket: 'taverna-dos-combos.appspot.com',
    measurementId: 'G-2EJCJ65TMF',
  );

}
