
import 'package:flutter/cupertino.dart';
import 'package:woke_out/model/exercise_model.dart';
import 'package:woke_out/model/exercise_record_model.dart';

class ExercisePlayer with ChangeNotifier
{
  List<Exercise> exerciseList;
  RecordModel record;
  int currentIndex;
  String name;
  String level;

  ExercisePlayer(){
    exerciseList = null;
    record = new RecordModel();
    name = null;
    level = null;
    currentIndex = 0;
  }
  void init(String name, String level, List<Exercise> inputList){
    this.name = name;
    this.level = level;
    this.exerciseList = inputList;
    notifyListeners();
  }
  Exercise get currentExercise => this.exerciseList[this.currentIndex];
  int get index => this.currentIndex;
  int get length => this.exerciseList.length;
  Exercise get nextExercise{
    if(this.currentIndex +1 < this.exerciseList.length) return this.exerciseList[this.currentIndex+ 1];
    else return null;
  }
  void reset(){
    this.currentIndex= 0;
    this.record = new RecordModel();
    this.exerciseList = null;
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

  double getTotalTimeOfExerciseSet(){
    int result = 0;
    this.exerciseList.forEach((element) {
      result+= element.duration+ element.rest;
    });
    result -= this.exerciseList[this.exerciseList.length - 1].rest;
    // final rest isn't count;
    return result/60;
  }
  double calculateCalories(int weight){
    const int METs = 3;
    double calorie=  getTotalTimeOfExerciseSet()*(METs*3.5*weight)/200;
    return double.parse((calorie).toStringAsFixed(1));
  }
  double calculateScore(){
    double userTotalTime = this.record.totalTime.getTimeInMinutes();
    double requiredTime = getTotalTimeOfExerciseSet();
    if(userTotalTime >= requiredTime ) return 10.0;
    else return double.parse(((userTotalTime/requiredTime)*10).toStringAsFixed(1));
  }
}