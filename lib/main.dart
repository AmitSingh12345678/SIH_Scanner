import 'package:flutter/material.dart';
import 'package:sih_scanner/Pages/splash_screen.dart';
import 'Themes/my_theme.dart';
import 'package:permission_handler/permission_handler.dart';

Future  main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Permission.camera.request();
    await Permission.microphone.request();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,
      home: SplashScreen(),
    );
  }
}
