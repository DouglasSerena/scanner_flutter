import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static load() async {
    await dotenv.load(fileName: ".env.local");
  }

  static String get(String name) => dotenv.get(name);
  static int getInt(String name) => int.parse(get(name));
  static bool getBool(String name) => get(name) == "true";
}
