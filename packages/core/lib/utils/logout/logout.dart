import 'dart:developer';

import 'package:core/core.dart';

Future<void> globalLogout() async {
  try {
    SessionDatabase.save("");
    await UserDataDatabase.clear();
    newRouter.go(RouterUtils.root);
  } catch (e) {
    log("Logout error: $e");
  }
}
