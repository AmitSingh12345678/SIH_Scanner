import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sih_scanner/Authentication/firebase_auth.dart';
import 'package:sih_scanner/Authentication/validator.dart';
import 'package:sih_scanner/Pages/home_page.dart';
import 'package:sih_scanner/Pages/register_page.dart';
import 'package:sih_scanner/Themes/my_theme.dart';
import 'package:sih_scanner/Utility/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _form_key = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  bool passwordHidden = true;

  void goToHome(context) async {
    FormState? currentState = _form_key.currentState;
    if (currentState != null && currentState.validate()) {
      AppUtility.getUndismissibleProgressIndicator(context);

      try {
        User? user = await FireAuth.signInUsingEmailPassword(
            email: _emailTextController.text,
            password: _passwordTextController.text,
            context: context);
        if (user != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } 
      } catch (e) {
        // Some problem like user doesn't exist or wrong password
        print(e.toString());
        Navigator.pop(context);
        AppUtility.showAppSnackBar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _form_key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container().hOneForth(context),
                "Login".text.xl4.bold.color(MyAppTheme.BluishColor).make(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 32.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _emailTextController,
                        validator: (value) =>
                            Validator.validateEmail(email: value ?? ""),
                        decoration: const InputDecoration(
                            hintText: "Enter Email", labelText: "Email"),
                        onChanged: (value) {},
                      ),
                      TextFormField(
                          controller: _passwordTextController,
                          validator: (value) =>
                              Validator.validatePassword(password: value ?? ""),
                          obscureText: passwordHidden,
                          decoration: InputDecoration(
                              hintText: "Enter password",
                              labelText: "Password",
                              suffixIcon: InkWell(
                                child: Icon(
                                  passwordHidden
                                      ? Icons.visibility
                                      : Icons.visibility_off_sharp,
                                ),
                                onTap: () {
                                  setState(() {
                                    passwordHidden = !passwordHidden;
                                  });
                                },
                              ))),
                      SizedBox(height: 16,),
                      ElevatedButton(
                        onPressed: () {
                          goToHome(context);
                        },
                        style: MyAppTheme.getAppButtonStyle(
                            MyAppTheme.BluishColor),
                        child: const Text(
                          "Login",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ).py8().wFull(context),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          "Do not have an account?"
                              .text
                              .xl
                              .caption(context)
                              .make(),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ));
                            },
                            child: " Register"
                                .text
                                .color(MyAppTheme.BluishColor)
                                .xl
                                .caption(context)
                                .make(),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
