import 'package:flutter/material.dart';
import 'package:woke_out/screens/workout/do_exercise_page.dart';
import 'package:woke_out/screens/workout/result_page.dart';
import 'package:woke_out/screens/workout/exercise_detail_page.dart';
import 'package:woke_out/screens/workout/exercise_list.dart';
import 'package:woke_out/screens/landing_page.dart';
import 'package:woke_out/screens/home_page.dart';
import 'package:woke_out/screens/login_page.dart';
import 'package:woke_out/screens/workout/resting_page.dart';
import 'package:woke_out/screens/signup_page.dart';
import 'package:woke_out/screens/welcome_page/welcome_page.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case 'landing':
        return MaterialPageRoute(builder: (_) => LandingPage());
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case 'welcome':
        return MaterialPageRoute(builder: (_) => WelcomePage());
      case 'signup':
        return MaterialPageRoute(builder: (_) => SignupPage());
      case 'exerciseList':
        List<dynamic> args = settings.arguments;
        return MaterialPageRoute(builder: (_) => ExerciseListPage(muscleName: args[0], imgPath: args[1],));
      case 'exerciseDetailPage':
        return MaterialPageRoute(builder: (_) => DetailPage(exercise: settings.arguments,));
      case 'doExercisePage':
        return MaterialPageRoute(builder: (_) => DoExercisePage());
      case 'restPage':
        return MaterialPageRoute(builder: (_) => RestPage(player: settings.arguments,));
      case 'resultPage':
        return MaterialPageRoute(builder: (_) => ResultPage());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            );
          },
        );
    }
  }
}
