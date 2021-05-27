

import 'package:flutter/cupertino.dart';

class Time
{
  int minute;
  int second;
  Time(){
    this.minute = 0;
    this.second = 0;
  }
  Time.fromData(int inputMin, inputSec){
    this.minute = inputMin;
    this.second = inputSec;
  }
  factory Time.fromMap(Map<String, dynamic> data, String fieldName){
    int min = data[fieldName]/60;
    int sec = data[fieldName]%60;
    return Time.fromData(min, sec);
  }
  void addOneSec(){
    if(this.second >= 59){
      this.minute ++;
      this.second = 0;
    }else this.second ++;
  }
  double getTimeInMinutes(){
    return this.minute.toDouble()+ (this.second/60).toDouble();
  }
  int getTimeInSeconds(){
    return this.second + this.minute*60;
  }
  String getMinText(){
    if(minute< 10) return "0$minute";
    else return minute.toString();
  }
  String getSecondText(){
    if(second< 10) return "0$second";
    else return second.toString();
  }
}
class RecordModel {
  double calorie;
  double score;
  Time totalTime;
  int satisfactionLevel;
  String exName;
  String exLevel;
  DateTime timeStamp;

  RecordModel(){
    this.calorie = 0;
    this.score = 0;
    totalTime = Time();
    satisfactionLevel = 0;
    exName = "";
    exLevel = "";
    timeStamp = null;
  }

  RecordModel.withRequire({
    @required this.calorie,
    this.satisfactionLevel,
    this.totalTime,
    this.exLevel,
    this.exName,
    this.timeStamp,
    this.score
  });

  factory RecordModel.fromMap(Map<String, dynamic> data){
    return RecordModel.withRequire(
      calorie: data["calorie"],
      score: data["score"],
      totalTime: Time.fromMap(data, 'totalTime'),
      satisfactionLevel: data["satisfactionLevel"],
      exLevel: data["exLevel"],
      exName: data["exName"],
      timeStamp: data["timeStamp"]
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "calorie": calorie,
      "score": score,
      "totalTime": totalTime,
      "satisfactionLevel": satisfactionLevel,
      "exLevel": exLevel,
      "exName": exName,
      "timeStamp": timeStamp
    };
  }

}
