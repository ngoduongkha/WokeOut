import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/pages/home_page.dart';
import 'package:woke_out/pages/authentication_page/welcome_page.dart';
import 'package:woke_out/services/auth_service.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);

    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done)
          return snapshot.hasData ? HomePage() : WelcomePage();
        else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
