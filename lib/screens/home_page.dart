import 'package:flutter/material.dart';
import 'package:woke_out/screens/today_page.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/services/auth_service.dart';
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

    return Scaffold(
      bottomNavigationBar: myBottomNavigationBar(),
      body: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            TextButton(
              onPressed: () {
                auth.signOut();
                Navigator.pushNamedAndRemoveUntil(
                    context, 'welcome', ModalRoute.withName('landing'));
              },
              child: Text(
                'signout',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        body: _homeBodyDirector(selectedPage),
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

  Widget _homeBodyDirector(int selectedPage) {
    switch (selectedPage) {
      case 0:
        return TodayPage();
        break;
    }
  }
}
