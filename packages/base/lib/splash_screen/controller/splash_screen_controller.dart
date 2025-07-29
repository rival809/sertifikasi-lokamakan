import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../view/splash_screen_view.dart';

class SplashScreenController extends State<SplashScreenView> {
  static late SplashScreenController instance;
  late SplashScreenView view;

  @override
  void initState() {
    instance = this;
    _checkAuthStatus();

    super.initState();
  }

  Future<void> _checkAuthStatus() async {
    // Simulasi loading awal
    await Future.delayed(const Duration(seconds: 3));

    String route = "";

    route = RouterUtils.beranda;

    // Navigasi berdasarkan status login
    if (mounted) {
      newRouter.go(route);
    }
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
