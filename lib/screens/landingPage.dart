import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woke_out/model/baseModel.dart';
import 'package:woke_out/screens/baseView.dart';
import 'package:woke_out/screens/homePage.dart';
import 'package:woke_out/screens/loginPage.dart';
import 'package:woke_out/screens/welcomePage.dart';

// ignore: must_be_immutable
class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<BaseModel>(
      builder: (context, __, child) => StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? HomePage()
              : WelcomePage();
        },
      ),
    );
  }
}
