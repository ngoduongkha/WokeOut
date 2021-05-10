import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/constants.dart';
import 'package:woke_out/model/do_exercise_model.dart';
import 'package:woke_out/routers/routers.dart';
import 'package:woke_out/screens/landing_page.dart';
import 'package:woke_out/services/app_user_service.dart';
import 'package:woke_out/services/auth_service.dart';
import 'package:woke_out/services/exercise_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<AppUserService>(create: (_) => AppUserService()),
        ChangeNotifierProvider<ExercisePlayer>(create: (_) => ExercisePlayer())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WokeOut',
        theme: ThemeData(
          fontFamily: "Cairo",
          scaffoldBackgroundColor: kBackgroundColor,
          textTheme:
              Theme.of(context).textTheme.apply(displayColor: kTextColor),
          primaryColor: kPrimaryColor,
        ),
        home: new LandingPage(),
        onGenerateRoute: Routers.generateRoute,
      ),
    );
  }
}
