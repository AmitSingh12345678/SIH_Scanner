import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sih_scanner/Themes/my_theme.dart';
import 'package:sih_scanner/Utility/constants.dart';

class AppExceptionMessages {
  static const String NO_INTERNET_MESSAGE = "No Internet connection";
}

class AppUtility {
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  static getUndismissibleProgressIndicator(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(
              color: MyAppTheme.cyanShade,
            ),
          );
        });
  }


  static void showAppSnackBar(context, msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  static void showAppSnackBarWithDuration(context, msg, duration) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), duration: Duration(seconds: duration)));
  }

  static String getExceptionMessage(e) {
    String fullString = e.toString();
    int idx = fullString.indexOf(':');
    return fullString.substring(idx + 1);
  }


  static Color getColor(int hexCode) {
    return Color(hexCode);
  }
  static Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static Future<bool> showSnackbarIfNoInternet(context) async {
    if (!(await AppUtility.hasNetwork())) {
      // if not network
      AppUtility.showAppSnackBarWithDuration(
          context, AppExceptionMessages.NO_INTERNET_MESSAGE, 30);
      return true;
    }
    return false;
  }

  static String getUniqueId() {
    return Random().nextInt(99999999).toString() +
        DateTime.now().millisecondsSinceEpoch.toString() +
        Random().nextInt(99999999).toString();
  }
}