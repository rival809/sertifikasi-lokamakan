import 'package:core/main_storage_service/main_storage.dart';

class VersionDatabase {
  static String version = "";
  static String versionShoreBird = "1";

  static load() async {
    version = mainStorage.get("version");
  }

  static save(String version) async {
    mainStorage.put("version", version);
    VersionDatabase.version = version;
  }
}
