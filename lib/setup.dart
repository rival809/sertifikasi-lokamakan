import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lokamakan/core.dart';

class Setup {
  static Future initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    if (!kIsWeb) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // Initialize AuthService for development settings
      await AuthService.initialize();

      // Initialize SessionService for Firebase-based session management
      await SessionService.initialize();
    }

    newRouter = router;

    // Set preferred orientation
    // await SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);

    // Load SVG
    await loadSVG();

    // Initialize Hive
    try {
      if (!kIsWeb) {
        var path = await getTemporaryDirectory();
        Hive.init(path.path);
      }

      if (!Hive.isAdapterRegistered(1)) {
        //Theme Model
        Hive.registerAdapter(ThemeModeAdapter());

        //User Data Model
        Hive.registerAdapter(UserDataModelAdapter());
        Hive.registerAdapter(DataUserAdapter());

        // Versioning Model
        Hive.registerAdapter(VersioningModelAdapter());
        Hive.registerAdapter(DataVersioningAdapter());
      }

      mainStorage = await Hive.openBox("lokamakan");

      await ThemeDatabase.load();
    } catch (e) {
      // Fix masalah dengan database
      await Hive.deleteBoxFromDisk('lokamakan');
    }
    //END Initialize Hive

    if (!kIsWeb) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      VersionDatabase.save(packageInfo.version);
    }
  }
}
