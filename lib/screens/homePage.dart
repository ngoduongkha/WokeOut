import 'package:flutter/material.dart';
import 'package:woke_out/model/authModel.dart';
import 'package:woke_out/screens/allExercisePage.dart';
import 'package:woke_out/screens/baseView.dart';
import 'package:woke_out/screens/detailsPage.dart';
import 'package:woke_out/widgets/bottom_nav_bar.dart';
import 'package:woke_out/widgets/category_card.dart';
import 'package:woke_out/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => homePageState();
}

class homePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return BaseView<AuthModel>(
      builder: (context, authModel, child) => Scaffold(
        bottomNavigationBar: BottomNavBar(),
        body: AllExercisePage(),
      ),
    );
  }
}
