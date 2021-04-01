import 'package:flutter/material.dart';
import 'package:woke_out/landing_page.dart';
import 'package:woke_out/screens/home/home_screen.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case 'landing':
        return MaterialPageRoute(builder: (_) => LandingPage());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}