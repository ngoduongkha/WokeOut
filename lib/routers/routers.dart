// import 'package:flutter/material.dart';
// import 'package:woke_out/screens/landing_page.dart';
// import 'package:woke_out/screens/home_page.dart';
// import 'package:woke_out/screens/loginPage.dart';
// import 'package:woke_out/screens/signupPage.dart';
// import 'package:woke_out/screens/welcomePage.dart';

// class Routers {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case 'home':
//         return MaterialPageRoute(builder: (_) => HomePage());
//       case 'landing':
//         return MaterialPageRoute(builder: (_) => LandingPage());
//       case 'login':
//         return MaterialPageRoute(builder: (_) => LoginPage());
//       case 'welcome':
//         return MaterialPageRoute(builder: (_) => WelcomePage());
//       case 'signup':
//         return MaterialPageRoute(builder: (_) => SignupPage());
//       default:
//         return MaterialPageRoute(
//           builder: (_) {
//             return Scaffold(
//               body: Center(
//                 child: Text('No route defined for ${settings.name}'),
//               ),
//             );
//           },
//         );
//     }
//   }
// }
