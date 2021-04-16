import 'package:flutter/material.dart';
import 'package:woke_out/screens/choose_exercise_page.dart';
import 'package:woke_out/screens/base_view.dart';
import 'package:woke_out/services/auth_service.dart';
import 'package:woke_out/widgets/bottom_nav_item.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return BaseView<AuthService>(
      builder: (context, authModel, child) => Scaffold(
        bottomNavigationBar: myBottomNavigationBar(),
        body: ChooseExercisePage(),
      ),
    );
  }

  Widget myBottomNavigationBar() => Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        height: 80,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            BottomNavItemWidget(
              title: "Today",
              svgScr: "assets/icons/gym.svg",
              isActive: true,
              press: () => setState(() {
                selectedPage = 0;
              }),
            ),
            BottomNavItemWidget(
              title: "Schedule",
              svgScr: "assets/icons/calendar.svg",
            ),
            BottomNavItemWidget(
              title: "Settings",
              svgScr: "assets/icons/Settings.svg",
            ),
          ],
        ),
      );
}
