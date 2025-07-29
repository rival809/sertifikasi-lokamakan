import 'package:flutter/material.dart';
import '../controller/splash_screen_controller.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  Widget build(context, SplashScreenController controller) {
    controller.view = this;

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  @override
  State<SplashScreenView> createState() => SplashScreenController();
}
