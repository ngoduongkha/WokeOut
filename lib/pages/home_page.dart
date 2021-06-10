import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woke_out/pages/challenge/challenge_main.dart';
import 'package:woke_out/pages/statistic/statistic_main_page.dart';
import 'package:woke_out/pages/user_info_page.dart';
import 'package:woke_out/pages/workout/today_page.dart';
import 'package:woke_out/widgets/app_icons.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<Widget> screens = [];

  @override
  void initState() {
    screens = [
      TodayPage(),
      ChallengeMainPage(),
      StatisticMainPage(),
      UserInfoPage()
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return screens[_currentIndex];
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey[800],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(AppIcons.dumbbell),
            label: 'Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.goal),
            label: 'Challenge',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.statistic),
            label: 'Statistic',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.user),
            label: 'User',
          ),
        ],
      ),
    );
  }
}
