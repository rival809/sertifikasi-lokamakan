import 'package:core/core.dart';
import 'package:flutter/material.dart';

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
}
