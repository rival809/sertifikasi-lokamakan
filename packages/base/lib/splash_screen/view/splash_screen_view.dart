import 'package:core/core.dart';
import 'package:flutter/material.dart';
import '../controller/splash_screen_controller.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  Widget build(context, SplashScreenController controller) {
    controller.view = this;

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Image.asset(
            MediaRes.images.logo.logo,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  State<SplashScreenView> createState() => SplashScreenController();
}
