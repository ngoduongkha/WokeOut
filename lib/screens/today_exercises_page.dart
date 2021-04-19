import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woke_out/model/exercise_model.dart';
import 'package:woke_out/services/exercise_service.dart';

class TodayExercisePage extends StatefulWidget {
  final ExerciseService exerciseService = ExerciseService();

  @override
  _TodayExercisePageState createState() => _TodayExercisePageState();
}

class _TodayExercisePageState extends State<TodayExercisePage> {
  final controller = PageController();
  Exercise currentExercise;
  
  @override
  void initState() async {
    super.initState();
    var listExer = await widget.exerciseService.loadBeginnerExercises();
    currentExercise = listExer.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
}
