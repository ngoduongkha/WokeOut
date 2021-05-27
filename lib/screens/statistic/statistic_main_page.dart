

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woke_out/screens/statistic/calendar_page.dart';
import 'package:woke_out/screens/statistic/chart_page.dart';

class StatisticMainPage extends StatefulWidget {
  const StatisticMainPage({Key key}) : super(key: key);

  @override
  _StatisticMainPageState createState() => _StatisticMainPageState();
}

class _StatisticMainPageState extends State<StatisticMainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: Text("STATISTIC", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
          bottom: TabBar(
            indicatorWeight: 3.0,
            labelColor: Colors.white,
            tabs: [
              Tab(text: "Calendar", icon: Icon(Icons.calendar_today_sharp),),
              Tab(text: "Chart", icon: Icon(Icons.stacked_bar_chart),),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CalendarMainPage(),
            ChartMainPage()
          ],
        ),
      ),
    );
  }
}
