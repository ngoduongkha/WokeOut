import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woke_out/model/baseModel.dart';
import 'package:woke_out/model/homeModel.dart';
import 'package:woke_out/model/loginModel.dart';
import 'package:woke_out/screens/baseView.dart';
import 'package:woke_out/screens/homePage.dart';
import 'package:woke_out/screens/loginPage.dart';

// ignore: must_be_immutable
class LandingPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, loginModel, child) => StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? HomePage()
              : LoginPage(
                  emailController: emailController,
                  passwordController: passwordController,
                  loginModel: loginModel,
                );
        },
      ),
    );
  }
}
