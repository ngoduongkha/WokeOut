import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ChallengeModel {
  final String name;
  final int time;
  final Timestamp createdAt;

  const ChallengeModel({
    this.name,
    this.time,
    this.createdAt,
  });

  factory ChallengeModel.fromMap(Map<String, dynamic> data) {
    return ChallengeModel(
      name: data["name"] as String,
      time: data["time"] as int,
      createdAt: data["createdAt"] as Timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "time": time,
      "createdAt": createdAt,
    };
  }
}
