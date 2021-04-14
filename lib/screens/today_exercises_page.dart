import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woke_out/model/exercise.dart';
import 'package:woke_out/model/exercise_set.dart';

class TodayExercisePage extends StatefulWidget {
  final ExerciseSet exerciseSet;

  const TodayExercisePage({Key key, this.exerciseSet}) : super(key: key);
  @override
  _TodayExercisePageState createState() => _TodayExercisePageState();
}

class _TodayExercisePageState extends State<TodayExercisePage> {
  final controller = PageController();
  Exercise currentExercise;
  @override
  void initState() {
    super.initState();
    currentExercise = widget.exerciseSet.exercises.first;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            currentExercise.name,
            style: GoogleFonts.lato(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
}
