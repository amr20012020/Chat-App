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
    apiKey: 'AIzaSyCmBc5DCv1dCbLUT0WLkY1GIY29jaDqh6w',
    appId: '1:278030139118:web:0769410c97216ff8b03dff',
    messagingSenderId: '278030139118',
    projectId: 'chat-app-e9c0e',
    authDomain: 'chat-app-e9c0e.firebaseapp.com',
    storageBucket: 'chat-app-e9c0e.appspot.com',
    measurementId: 'G-VHGJQRHMZ8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC5DnerzfG2mcXy5QK5WPTeadi-8U4zUMY',
    appId: '1:278030139118:android:0e3601006d9a51d0b03dff',
    messagingSenderId: '278030139118',
    projectId: 'chat-app-e9c0e',
    storageBucket: 'chat-app-e9c0e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCMZV85YJrWgDHoeeuC78jZUl2WK4Z2cak',
    appId: '1:278030139118:ios:f3d94ddf5938e7d4b03dff',
    messagingSenderId: '278030139118',
    projectId: 'chat-app-e9c0e',
    storageBucket: 'chat-app-e9c0e.appspot.com',
    iosClientId: '278030139118-o24rf13ctk8809vt74vo31ekn6pg2ng8.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCMZV85YJrWgDHoeeuC78jZUl2WK4Z2cak',
    appId: '1:278030139118:ios:f3d94ddf5938e7d4b03dff',
    messagingSenderId: '278030139118',
    projectId: 'chat-app-e9c0e',
    storageBucket: 'chat-app-e9c0e.appspot.com',
    iosClientId: '278030139118-o24rf13ctk8809vt74vo31ekn6pg2ng8.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );
}
