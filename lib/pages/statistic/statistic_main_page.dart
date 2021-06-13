

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woke_out/constants.dart';
import 'package:woke_out/pages/statistic/calendar_page.dart';
import 'package:woke_out/pages/statistic/chart_page.dart';

class StatisticMainPage extends StatefulWidget {
  const StatisticMainPage({Key key}) : super(key: key);

  @override
  _StatisticMainPageState createState() => _StatisticMainPageState();
}

class _StatisticMainPageState extends State<StatisticMainPage> with TickerProviderStateMixin{
  TabController _tabController;
  Color unselectedColor = Colors.grey[600];
  Color selectedColor = Colors.blueAccent;
  @override
  void initState() {
    // TODO: implement initState
    _tabController = new TabController(vsync: this, length: 2);
    _tabController.addListener(selectTabHandler);
    super.initState();
  }

  void selectTabHandler(){
    setState(() {});
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("STATISTIC", style: TextStyle(fontWeight: FontWeight.bold, color: kTextColor),),
          bottom: TabBar(
            controller: _tabController,
            indicatorWeight: 4.0,
            unselectedLabelColor: unselectedColor,
            labelColor: selectedColor,
            tabs: [
              Tab(
                text: "Calendar",
                icon: Icon(
                  Icons.calendar_today_sharp,
                  color: _tabController.index == 0 ? selectedColor: unselectedColor,
                ),
              ),
              Tab(
                text: "Chart",
                icon: Icon(
                  Icons.stacked_bar_chart,
                  color: _tabController.index == 1 ? selectedColor: unselectedColor,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            CalendarMainPage(),
            ChartMainPage()
          ],
        ),
      ),
    );
  }
}
