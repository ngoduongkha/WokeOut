import 'dart:collection';

import 'package:flutter/cupertino.dart';

class Exercise {
  String name;
  List<String> muscle;
  String level;
  int duration;
  bool equipment;
  int rep;
  int rest;
  String image;
  String video;

  Exercise();

  Exercise.fromMap(Map<String, dynamic> data) {
    name = data["name"];
    muscle = List.from(data["muscle"]);
    level = data["level"];
    duration = data["duration"];
    equipment = data["equipment"];
    rep = data["rep"];
    rest = data["rest"];
    image = data["image"];
    video = data["video"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "muscle": muscle,
      "level": level,
      "duration": duration,
      "equipment": equipment,
      "rep": rep,
      "rest": rest,
      "image": image,
      "video": video,
    };
  }
}

class ExerciseNotifier with ChangeNotifier {
  List<Exercise> _exerciseList = [];
  Exercise _currentExecise;

  UnmodifiableListView<Exercise> get exerciseList =>
      UnmodifiableListView(_exerciseList);

  Exercise get currentExercise => _currentExecise;

  set exerciseList(List<Exercise> exerciseList) {
    _exerciseList = exerciseList;
    notifyListeners();
  }

  set currentExercise(Exercise exercise) {
    _currentExecise = exercise;
    notifyListeners();
  }

  addExercise(Exercise exercise) {
    _exerciseList.insert(0, exercise);
    notifyListeners();
  }

  deleteExercise(Exercise exercise) {
    _exerciseList.removeWhere((_exercise) => _exercise.name == exercise.name);
    notifyListeners();
  }
}
