import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:woke_out/model/exercise_record_model.dart';

class ExerciseRecordService {
  final String userId;
  final recordRef = FirebaseFirestore.instance.collection("users");

  ExerciseRecordService({@required this.userId});

  void addRecord(RecordModel record) {
    recordRef.doc(this.userId).collection("records").add(record.toMap());
  }

  Future<dynamic> getRecordsByDate(DateTime targetDate) async {
    return recordRef.doc(this.userId).collection("records").get().then(
        (QuerySnapshot snapshot) => snapshot.docs
            .where((doc) => isSameDate(doc.data()['timeStamp'], targetDate))
            .map((doc) => RecordModel.fromMap(doc.data()))
            .toList());
  }

  Future<dynamic> getAllRecordDates() async {
    return recordRef.doc(this.userId).collection("records").get().then(
        (QuerySnapshot snapshot) => snapshot.docs
            .map((doc) => DateTime.fromMillisecondsSinceEpoch(
                doc.data()['timeStamp'].seconds * 1000))
            .toList());
  }

  Future<dynamic> getRecordsByMonth(DateTime targetDate) async {
    return recordRef.doc(this.userId).collection("records").get().then(
        (QuerySnapshot snapshot) => snapshot.docs
            .where((doc) => isSameMonth(doc.data()['timeStamp'], targetDate))
            .map((doc) => RecordModel.fromMap(doc.data()))
            .toList());
  }

  bool isSameDate(Timestamp time, DateTime targetDate) {
    var recordDate = DateTime.fromMillisecondsSinceEpoch(time.seconds * 1000);
    if (targetDate.day == recordDate.day &&
        targetDate.month == recordDate.month &&
        targetDate.year == recordDate.year)
      return true;
    else
      return false;
  }

  bool isSameMonth(Timestamp time, DateTime targetDate) {
    var recordDate = DateTime.fromMillisecondsSinceEpoch(time.seconds * 1000);
    if (recordDate.month == targetDate.month &&
        recordDate.year == targetDate.year)
      return true;
    else
      return false;
  }

  Future<String> test() async {
    String userId = "Nk36Enn5RBlHHvF5crqh";
    return recordRef.doc(userId).get().then((value) => value.data()['name']);
  }
}
