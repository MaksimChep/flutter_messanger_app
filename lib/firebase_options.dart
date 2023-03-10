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
    apiKey: 'AIzaSyC9A2T662i2lTB1Q-5_AiGKpTCmQNHg4OQ',
    appId: '1:337361179623:web:27ae3ecf6bad3a668e2342',
    messagingSenderId: '337361179623',
    projectId: 'fluttermessengerapp-fb552',
    authDomain: 'fluttermessengerapp-fb552.firebaseapp.com',
    databaseURL: 'https://fluttermessengerapp-fb552-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fluttermessengerapp-fb552.appspot.com',
    measurementId: 'G-0EMQ4SGH5H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZvb-3OVoV00veW9C4Zegm7p5L42e58IE',
    appId: '1:337361179623:android:4b38a67488ec09cf8e2342',
    messagingSenderId: '337361179623',
    projectId: 'fluttermessengerapp-fb552',
    databaseURL: 'https://fluttermessengerapp-fb552-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fluttermessengerapp-fb552.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAdQDIZ5ccz6iNJZOYyysdHhWJCxFjbpzw',
    appId: '1:337361179623:ios:96558cd729166e768e2342',
    messagingSenderId: '337361179623',
    projectId: 'fluttermessengerapp-fb552',
    databaseURL: 'https://fluttermessengerapp-fb552-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fluttermessengerapp-fb552.appspot.com',
    androidClientId: '337361179623-cet2psbqaeo2ttl4repfk58rf9i16n34.apps.googleusercontent.com',
    iosClientId: '337361179623-6ca079ff1a3ag6sons5iqu3jkilivut9.apps.googleusercontent.com',
    iosBundleId: 'com.chepurnykh.flutterMessengerApp',
  );
}
