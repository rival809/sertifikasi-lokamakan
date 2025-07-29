import 'package:core/main_storage_service/main_storage.dart';

class SessionDatabase {
  static String token = "";

  static load() async {
    token = mainStorage.get("token") ?? "";
  }

  static save(String token) async {
    mainStorage.put("token", token);
    SessionDatabase.token = token;
  }
}
