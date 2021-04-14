import 'package:flutter/material.dart';
import 'package:woke_out/model/authModel.dart';
import 'package:woke_out/screens/today_page.dart';
import 'package:woke_out/screens/baseView.dart';
import 'package:woke_out/widgets/bottom_nav_bar.dart';
import 'package:woke_out/widgets/category_card.dart';
import 'package:woke_out/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => homePageState();
}

class homePageState extends State<HomePage> {
  var selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return BaseView<AuthModel>(
      builder: (context, authModel, child) => Scaffold(
        bottomNavigationBar: myBottomNavigationBar(),
        body: TodayPage(),
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
