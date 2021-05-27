

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'calendar_page.dart';

class StatisticMainPage extends StatefulWidget {
  const StatisticMainPage({Key key}) : super(key: key);

  @override
  _StatisticMainPageState createState() => _StatisticMainPageState();
}

class _StatisticMainPageState extends State<StatisticMainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[800],
            title: Text("STATISTIC", style: TextStyle(fontWeight: FontWeight.bold),),
            bottom: TabBar(
              indicatorWeight: 3.0,
              tabs: [
                Tab(text: "Calendar", icon: Icon(Icons.calendar_today_outlined),),
                Tab(text: "Chart", icon: Icon(Icons.stacked_bar_chart),),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              CalendarMainScreen(),
              Text("data")
            ],
          ),
        ),
      ),
    );
  }
}
