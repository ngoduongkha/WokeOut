

import 'package:flutter/cupertino.dart';

class RecordModel {
  RecordModel({
    @required this.calorie,
    this.score,
    this.totalTime,
    this.satisfactionLevel,
    this.exName,
    this.exLevel,
    this.timeStamp
  });

  final double calorie;
  final double score;
  final int totalTime;
  final int satisfactionLevel;
  final String exName;
  final String exLevel;
  final DateTime timeStamp;

  factory RecordModel.fromMap(Map<String, dynamic> data) {
    return RecordModel(
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
