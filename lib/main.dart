import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/constants/constants.dart';
import 'package:woke_out/routers/routers.dart';
import 'package:woke_out/screens/auth_widget_builder.dart';
import 'package:woke_out/screens/home_page.dart';
import 'package:woke_out/screens/landing_page.dart';
import 'package:woke_out/services/firebase_auth_service.dart';

import 'model/app_user_model.dart';

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
        Provider(create: (_) => AuthService()),
      ],
      child: LandingPageBuilder(
        builder: (BuildContext context, AsyncSnapshot<AppUser> userSnapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'WokeOut',
            theme: ThemeData(
              fontFamily: "Cairo",
              scaffoldBackgroundColor: kBackgroundColor,
              textTheme:
                  Theme.of(context).textTheme.apply(displayColor: kTextColor),
              primaryColor: kPrimaryColor,
            ),
            home: new LandingPage(userSnapshot: userSnapshot),
            //onGenerateRoute: Routers.generateRoute,
          );
        },
      ),
    );
  }
}
