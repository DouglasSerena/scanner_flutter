import 'package:flutter/material.dart';
import 'package:scanner_flutter/application.dart';
import 'package:scanner_flutter/infra/databases/back4app/back4app_helper.dart';
import 'package:scanner_flutter/infra/databases/firebase/firebase_helper.dart';
import 'package:scanner_flutter/infra/databases/sqlite/sqlite_helper.dart';
import 'package:scanner_flutter/shared/environment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Environment.load();

  switch (Environment.get("DATABASE")) {
    case "FIREBASE":
      await FirebaseHelper.connect();
      break;
    case "SQLITE":
      await SqliteHelper.connect();
      break;
    case "BACK4APP":
      await Back4appHelper.connect();
      break;
  }

  runApp(const Application());
}
