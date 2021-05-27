

import 'package:flutter/cupertino.dart';
import 'package:woke_out/model/exercise_model.dart';
import 'package:woke_out/model/exercise_record_model.dart';

class ExercisePlayer with ChangeNotifier
{
  List<Exercise> exerciseList;
  RecordModel record = new RecordModel();
  int currentIndex = 0;

  void init(List<Exercise> inputList){
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
}