import 'package:flutter/material.dart';
import 'package:woke_out/screens/today_page.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/screens/user_info_page.dart';
import 'package:woke_out/services/auth_service.dart';
import 'package:woke_out/services/exercise_service.dart';
import 'package:woke_out/widgets/bottom_nav_item.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    final exercise = ExerciseService();

    return Scaffold(
      bottomNavigationBar: myBottomNavigationBar(exercise),
      body: _homeBodyDirector(selectedPage),
    );
  }

  Widget myBottomNavigationBar(ExerciseService exe) => Container(
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
              press: () => setState(() {
                selectedPage = 1;
              }),
            ),
            BottomNavItemWidget(
              title: "Settings",
              svgScr: "assets/icons/Settings.svg",
              press: () => setState(() {
                selectedPage = 2;
              }),
            ),
          ],
        ),
      );

  Widget _homeBodyDirector(int selectedPage) {
    switch (selectedPage) {
      case 0:
        return TodayPage();
        break;
      case 1:
        return TodayPage();
        break;
      case 2:
        return UserInfoPage();
        break;
    }
  }
}
