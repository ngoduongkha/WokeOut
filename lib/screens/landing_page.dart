import 'package:flutter/material.dart';
import 'package:woke_out/model/app_user_model.dart';
import 'package:woke_out/screens/home_page.dart';
import 'package:woke_out/screens/welcomePage.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<AppUser> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? HomePage() : WelcomePage();
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
