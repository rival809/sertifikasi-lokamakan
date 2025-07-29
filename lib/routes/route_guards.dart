import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';

class RouteGuards {
  static String? checkRoleAccess(
      GoRouterState state, String role, String path) {
    if (state.fullPath!.contains(path)) {
      if (StringUtils.trimString(role) == "1") {
        return state.uri.toString();
      }
      return "/";
    }
    return null;
  }

  static String? authGuard(BuildContext context, GoRouterState state) {
    final isLoginRoute = state.uri.toString().contains(RouterUtils.login);

    if (!SessionService.isLoggedIn) {
      // If we're not on the login page and there's no user, go to login
      return isLoginRoute ? null : RouterUtils.login;
    }

    // If we're on login page and have a user, redirect to home
    if (isLoginRoute) {
      return RouterUtils.beranda;
    }

    return null;
  }
}
