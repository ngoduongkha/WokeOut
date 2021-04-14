import 'package:flutter/material.dart';
import 'package:woke_out/enum/app_state.dart';
import 'package:woke_out/model/exercise_set.dart';
import 'exercise_data.dart';

final exerciseSets = [
  ExerciseSet(
    name: 'Chilling back',
    exercises: exercises1,
    imageUrl: 'assets/workout1.png',
    exerciseType: ExerciseType.back,
    color: Colors.blue.shade100.withOpacity(0.6),
  ),
  ExerciseSet(
    name: 'Abs destroyer',
    exercises: exercises2,
    imageUrl: 'assets/crunch.png',
    exerciseType: ExerciseType.abs,
    color: Colors.green.shade100.withOpacity(0.6),
  ),
];
