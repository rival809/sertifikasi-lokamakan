import 'package:core/core.dart';

class IpDatabase {
  static String host = "https://restaurant-api.dicoding.dev";

  static load() async {
    host = mainStorage.get("host") ?? "https://restaurant-api.dicoding.dev";
  }

  static save(String host) async {
    mainStorage.put("host", host);
    IpDatabase.host = host;
  }
}
