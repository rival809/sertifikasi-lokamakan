import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lokamakan/setup.dart';
import 'package:core/core.dart';

void main() async {
  await Setup.initialize();
  final brightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
  Get.mainTheme.value =
      brightness == Brightness.light ? themeDataLight : themeDataDark;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Get.mainTheme,
      builder: (BuildContext context, ThemeData value, Widget? child) {
        return MaterialApp.router(
          routerConfig: newRouter,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
              child: child!,
            );
          },
          title: 'Sertifikasi',
          debugShowCheckedModeBanner: false,
          theme: value,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('id', 'ID'),
          ],
        );
      },
    );
  }
}
