import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scanner_flutter/infra/databases/firebase/firebase_options.dart';

class FirebaseHelper {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future connect() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
