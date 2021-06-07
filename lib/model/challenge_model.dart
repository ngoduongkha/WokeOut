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

class ChallengeNotifier with ChangeNotifier {
  List<ChallengeModel> _challengeList = [];
  ChallengeModel _currentChallenge;

  UnmodifiableListView<ChallengeModel> get challengeList =>
      UnmodifiableListView(_challengeList);

  ChallengeModel get currentChallenge => _currentChallenge;

  set challengeList(List<ChallengeModel> challengeList) {
    _challengeList = challengeList;
    notifyListeners();
  }

  set currentChallenge(ChallengeModel challenge) {
    _currentChallenge = challenge;
    notifyListeners();
  }

  addChallenge(ChallengeModel challenge) {
    int index = 0;

    for (var element in challengeList) {
      if (element.time > challenge.time)
        index++;
      else
        break;
    }

    _challengeList.insert(index, challenge);
    notifyListeners();
  }

  deleteChallenge(ChallengeModel challenge) {
    _challengeList
        .removeWhere((_challenge) => _challenge.name == challenge.name);
    notifyListeners();
  }
}
