import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woke_out/screens/workout/today_page.dart';
import 'package:woke_out/screens/user_info_page.dart';
import 'package:woke_out/services/exercise_service.dart';
import 'package:woke_out/widgets/app_icons.dart';
import 'package:woke_out/widgets/bottom_nav_item.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  List<Widget> screens = [];

  @override
  void initState() {
    // TODO: implement initState
    screens = [TodayPage(), ChallengePage(), StatisticPage(), UserPage()];
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

class ChallengePage extends StatelessWidget {
  const ChallengePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Challenge page",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

class StatisticPage extends StatelessWidget {
  const StatisticPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Statistic page",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  const UserPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "user page",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

