import 'package:core/core.dart';

class IpDatabase {
  //dev
  // static String host = "http://172.27.77.155:8000";
  //prod
  // static String host = "http://192.168.99.47:8000";
  //prod public
  static String host = "https://apisakti.bapenda.jabarprov.go.id";

  static load() async {
    //dev
    // host = mainStorage.get("host") ?? "172.27.77.155";
    //prod
    host = mainStorage.get("host") ?? "https://apisakti.bapenda.jabarprov.go.id";
  }

  static save(String host) async {
    mainStorage.put("host", host);

    IpDatabase.host = host;
  }
}
