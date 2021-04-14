import 'package:flutter/cupertino.dart';
import 'package:woke_out/enum/app_state.dart';
import 'package:woke_out/model/exercise.dart';

String getExerciseName(ExerciseType type) {
  switch (type) {
    case ExerciseType.abs:
      return 'Abs';
      break;
    case ExerciseType.arm:
      return 'Arm';
      break;
    case ExerciseType.leg:
      return 'Leg';
      break;
    case ExerciseType.back:
      return 'Back';
      break;
    case ExerciseType.chest:
      return 'Chest';
      break;
    case ExerciseType.shoulder:
      return 'Shoulder';
      break;
    default:
      return 'All';
      break;
  }
}

class ExerciseSet {
  final String name;
  final List<Exercise> exercises;
  final ExerciseType exerciseType;
  final Color color;

  ExerciseSet(
      {@required this.name,
      @required this.exercises,
      @required this.exerciseType,
      @required this.color});
  String get totalDuration {
    final duration = exercises.fold(Duration.zero,
        (previousValue, element) => previousValue + element.duration);
    return duration.inMinutes.toString();
  }
}
