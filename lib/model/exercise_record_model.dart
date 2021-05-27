

import 'package:flutter/cupertino.dart';

class RecordModel {
  double calorie;
  double score;
  int totalTime;
  int satisfactionLevel;
  String exName;
  String exLevel;
  DateTime timeStamp;

  RecordModel(){
    this.calorie = 0;
    this.score = 0;
    totalTime = 0;
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
      totalTime: data["totalTime"],
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
