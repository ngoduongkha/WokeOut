import 'dart:async';
import 'package:flutter/material.dart';
import 'package:woke_out/screens/choose_today_exercise_page.dart';
import 'package:woke_out/screens/today_exercise_page.dart';

final StreamController streamController = StreamController.broadcast();

class TodayPage extends StatefulWidget {
  final Stream stream = streamController.stream;
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  var showChooseExercise = true;
  TodayExerciseCategory chosenToday;

  @override
  void initState() {
    super.initState();
    widget.stream.listen(
      (event) {
        if (event is bool) {
          setState(() {
            showChooseExercise = event;
          });
        }
        if (event is TodayExerciseCategory) {
          setState(() {
            chosenToday = event;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return showChooseExercise
        ? ChooseTodayExercisePage(streamController: streamController)
        : TodayExercisePage(chosenExerciseToday: chosenToday);
  }
}
