import 'dart:developer';

import 'package:core/core.dart';

Future<void> globalLogout() async {
  try {
    await SessionService.logout();
    await UserDataDatabase.clear();
    newRouter.go(RouterUtils.root);
  } catch (e) {
    log("Logout error: $e");
  }
}
