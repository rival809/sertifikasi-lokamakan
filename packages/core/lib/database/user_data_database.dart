import 'package:core/core.dart';

class UserDataDatabase {
  static UserDataModel userDataModel = UserDataModel();

  static load() async {
    userDataModel = mainStorage.get("userDataModel") ?? UserDataModel();
  }

  static save(UserDataModel userDataModel) async {
    mainStorage.put("userDataModel", userDataModel);

    UserDataDatabase.userDataModel = userDataModel;
  }

  static clear() async {
    // Remove data from storage
    await mainStorage.delete("userDataModel");
    // Reset the in-memory model to default
    userDataModel = UserDataModel();
  }
}
