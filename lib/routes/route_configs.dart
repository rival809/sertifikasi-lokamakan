import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:lokamakan/routes/route_guards.dart';

class RouteConfigs {
  static Widget errorBuilder(BuildContext context, GoRouterState state) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Text(
              "Halaman tidak ditemukan",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24.0),
            BasePrimaryButton(
              isDense: true,
              text: "Kembali ke beranda",
              onPressed: () => GoRouter.of(context).go(RouterUtils.beranda),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  static String? redirect(BuildContext context, GoRouterState state) {
    // Check authentication
    final authGuard = RouteGuards.authGuard(context, state);
    if (authGuard != null) return authGuard;

    // Check role-based access
    // final userData = UserDataDatabase.userDataModel.data;

    final roleChecks = [
      // RouteGuards.checkRoleAccess(
      //   state,
      //   userData?.roleMenuAwalAkhirLayanan ?? "",
      //   RouterUtils.beranda,
      // ),
    ];

    for (final check in roleChecks) {
      if (check != null) return check;
    }

    return state.uri.toString();
  }
}
