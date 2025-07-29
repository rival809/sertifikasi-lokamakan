import 'package:core/core.dart';
import 'package:lokamakan/routes/package_routes/base_routes.dart';
import 'package:lokamakan/routes/route_configs.dart';

final GoRouter router = GoRouter(
  navigatorKey: Get.navigatorKey,
  initialLocation: RouterUtils.root,
  errorBuilder: RouteConfigs.errorBuilder,
  routes: <RouteBase>[
    ...baseRoutes,
  ],
);
