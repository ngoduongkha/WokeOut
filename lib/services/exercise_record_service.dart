

import 'package:cloud_firestore/cloud_firestore.dart';

class ExerciseRecordService{
  
  final recordRef = FirebaseFirestore.instance.collection("users");

  void addRecord(){
    String userId = "Nk36Enn5RBlHHvF5crqh";
    // recordRef.doc(userId).collection(userId).add(data)
  }
}