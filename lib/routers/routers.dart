import 'package:flutter/material.dart';
import 'package:woke_out/pages/statistic/date_record_page.dart';
import 'package:woke_out/pages/workout/do_exercise_page.dart';
import 'package:woke_out/pages/workout/result_page.dart';
import 'package:woke_out/pages/workout/exercise_detail_page.dart';
import 'package:woke_out/pages/workout/exercise_list.dart';
import 'package:woke_out/pages/landing_page.dart';
import 'package:woke_out/pages/home_page.dart';
import 'package:woke_out/pages/authentication_page/login_page.dart';
import 'package:woke_out/pages/workout/resting_page.dart';
import 'package:woke_out/pages/authentication_page/signup_page.dart';
import 'package:woke_out/pages/authentication_page/welcome_page.dart';

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
      case 'dateRecordPage':
        return MaterialPageRoute(builder: (_) => DateRecordPage(today: settings.arguments));
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
