import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/screens/home_page.dart';
import 'package:woke_out/screens/welcome_page/welcome_page.dart';
import 'package:woke_out/services/auth_service.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);

    return StreamBuilder<User>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        return snapshot.hasData ? HomePage() : WelcomePage();
      },
    );
  }
}
