import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:woke_out/model/base_model.dart';
import 'package:woke_out/screens/base_view.dart';
import 'package:woke_out/screens/home_page.dart';
import 'package:woke_out/screens/welcome_page.dart';

// ignore: must_be_immutable
class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<BaseModel>(
      builder: (context, __, child) => StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return snapshot.hasData ? HomePage() : WelcomePage();
        },
      ),
    );
  }
}
