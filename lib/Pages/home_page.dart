import 'package:flutter/material.dart';
import 'package:sih_scanner/Authentication/firebase_auth.dart';
import 'package:sih_scanner/Pages/go_to_web_portal.dart';
import 'package:sih_scanner/Pages/login_page.dart';
import 'package:sih_scanner/Themes/my_theme.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppTheme.BluishColor,
      body: SafeArea(
          child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/sih_scanner.png",
              fit: BoxFit.contain,
            ).wThreeForth(context).p4(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.teal, // This is what you need!
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => WebPortal()),
                );
              },
              icon: Icon(
                Icons.file_upload_outlined,
                size: 36,
                color: Colors.white,
              ).p4(),
              label: "Upload Document".text.xl2.bold.white.make().p8(),
            ).wThreeForth(context),
            SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // This is what you need!
              ),
              onPressed: () {
                FireAuth.signOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              icon: Icon(
                Icons.logout_outlined,
                size: 36,
                color: Colors.white,
              ).p4(),
              label: "LogOut".text.xl2.bold.white.make().p8(),
            ).wThreeForth(context)
          ],
        ),
      )),
    );
  }
}
