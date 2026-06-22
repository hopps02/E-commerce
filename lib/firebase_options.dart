// Firebase config for the For You (4U) project `for-you-28810`.
// Values come from the platform google-services.json / GoogleService-Info.plist;
// these are client identifiers (safe to ship), not secrets.
// ignore_for_file: type=lint

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Firebase is not configured for web in this app.');
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError('Firebase is not configured for $defaultTargetPlatform.');
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKuvcXUeueY9ELf6ZMAdtl_iJftTiF3FA',
    appId: '1:582336010861:android:c732d0c36c25935c6ffd64',
    messagingSenderId: '582336010861',
    projectId: 'for-you-28810',
    storageBucket: 'for-you-28810.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBeRLIrKUn1NH97vViqC8nhjp6IOwo-qs0',
    appId: '1:582336010861:ios:af86b2869d6b900d6ffd64',
    messagingSenderId: '582336010861',
    projectId: 'for-you-28810',
    storageBucket: 'for-you-28810.firebasestorage.app',
    iosBundleId: 'com.Utrr.foryou',
  );
}
