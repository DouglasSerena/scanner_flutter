import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:scanner_flutter/shared/environment.dart';

class Back4appHelper {
  static ParseObject getObject(String name) {
    return ParseObject(name);
  }

  static Future connect() async {
    await Parse().initialize(
      Environment.get("BACK4APP_KEY_APPLICATION_ID"),
      Environment.get("BACK4APP_KEY_PARSE_SERVER_URL"),
      clientKey: Environment.get("BACK4APP_KEY_CLIENT_KEY"),
      autoSendSessionId: true,
    );
  }
}
