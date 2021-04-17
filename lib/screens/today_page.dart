import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woke_out/screens/choose_today_exercise_page.dart';
import 'package:woke_out/screens/today_exercise_page.dart';

final StreamController<bool> streamController =
    StreamController<bool>.broadcast();

class TodayPage extends StatefulWidget {
  final Stream<bool> stream = streamController.stream;
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  var showChooseExercise = true;

  @override
  void initState() {
    super.initState();
    widget.stream.listen((event) {
      mySetState(event);
    });
  }

  void mySetState(bool status) {
    setState(() {
      showChooseExercise = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showChooseExercise
        ? ChooseTodayExercisePage(streamController: streamController)
        : TodayExercisePage();
  }
}
