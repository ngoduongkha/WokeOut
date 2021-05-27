

import 'package:flutter/cupertino.dart';
import 'package:woke_out/model/exercise_model.dart';
import 'package:woke_out/model/exercise_record_model.dart';

class ExercisePlayer with ChangeNotifier
{
  List<Exercise> exerciseList;
  RecordModel record = new RecordModel();
  int currentIndex = 0;
  String name;
  String level;

  void init(String name, String level, List<Exercise> inputList){
    this.name = name;
    this.level = level;
    this.exerciseList = inputList;
  }
  Exercise get currentExercise => this.exerciseList[this.currentIndex];
  int get index => this.currentIndex;
  int get length => this.exerciseList.length;
  Exercise get nextExercise => this.exerciseList[this.currentIndex+ 1];

  void reset(){
    this.currentIndex= 0;
    this.record = new RecordModel();
    notifyListeners();
  }

  void increaseIndexByOne(){
    this.currentIndex++;
    notifyListeners();
  }
  void decreaseIndexByOne(){
    this.currentIndex--;
    notifyListeners();
  }

  bool isAtLastExercise(){
    return this.currentIndex == this.exerciseList.length -1;
  }
  void increaseTotalTimeByOne(){
    this.record.totalTime.addOneSec();
    notifyListeners();
  }

  int getTotalTimeOfExerciseSet(){
    int result = 0;
    this.exerciseList.forEach((element) {
      result+= element.duration+ element.rest;
    });
    return result;
  }
  double calculateCalories(double weight){
    const int METs = 3;
    double calorie=  getTotalTimeOfExerciseSet()*(METs*3.5*weight)/200;
    return double.parse((calorie).toStringAsFixed(1));
  }
  double calculateScore(){
    int userTotalTime = this.record.totalTime.getTimeInSeconds();
    int requiredTime = getTotalTimeOfExerciseSet();
    if(userTotalTime >= requiredTime ) return 10.0;
    else return double.parse((userTotalTime/requiredTime).toStringAsFixed(1));
  }
}