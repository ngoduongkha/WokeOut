import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:woke_out/constants.dart';
import 'package:woke_out/locator.dart';
import 'package:woke_out/routers/routers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WokeOut',
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
        primaryColor: kPrimaryColor,
      ),
      initialRoute: 'landing',
      onGenerateRoute: Routers.generateRoute,
    );
  }
}
