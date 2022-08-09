import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sih_scanner/Authentication/firebase_auth.dart';
import 'package:sih_scanner/Authentication/validator.dart';
import 'package:sih_scanner/Pages/home_page.dart';
import 'package:sih_scanner/Pages/login_page.dart';
import 'package:sih_scanner/Themes/my_theme.dart';
import 'package:sih_scanner/Utility/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _form_key = GlobalKey<FormState>();

  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  bool passwordHidden = true;

  void goToHome(context) async {
    FormState? currentState = _form_key.currentState;
    if (currentState != null && currentState.validate()) {
      AppUtility.getUndismissibleProgressIndicator(context);
      try {
        User? user = await FireAuth.registerUsingEmailPassword(
          name: _nameTextController.text,
          email: _emailTextController.text,
          password: _passwordTextController.text,
        );
        Navigator.pop(context);
        if (user != null) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        }
      } catch (e) {
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
                children: [

                  Container().hOneForth(context),
                  "Register".text.xl4.bold.color(MyAppTheme.BluishColor).make(),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 32.0,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameTextController,
                          validator: (value) =>
                              Validator.validateName(name: value ?? ""),
                          decoration: const InputDecoration(
                              hintText: "Enter name", labelText: "Name"),
                          onChanged: (value) {},
                        ),
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
                            validator: (value) => Validator.validatePassword(
                                password: value ?? ""),
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
                            "Register",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ).wFull(context).py8(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            "Already have an account?"
                                .text
                                .xl
                                .caption(context)
                                .make(),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ));
                              },
                              child: " Login"
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
        ));
  }
}