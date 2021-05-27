import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:woke_out/model/exercise_model.dart';

class ExerciseService with ChangeNotifier {
  final ref = FirebaseFirestore.instance.collection("exercises");

  Future<List<Exercise>> loadBeginnerExercises(String muscleName) async {
    return ref.where("level", isEqualTo: "beginner")
      .get()
      .then((QuerySnapshot snapshot) =>
          snapshot.docs
              .where((doc) => isInMuscle(List.from(doc.data()['muscle']), muscleName))
              .map((doc) => Exercise.fromMap(doc.data()))
              .toList()
    );
  }

  Future<List<Exercise>> loadIntermediateExercises(String muscleName) async {
    return ref.where("level", isEqualTo: "intermediate")
        .get()
        .then((QuerySnapshot snapshot) =>
        snapshot.docs
            .where((doc) => isInMuscle(List.from(doc.data()['muscle']), muscleName))
            .map((doc) => Exercise.fromMap(doc.data()))
            .toList()
    );
  }

  Future<List<Exercise>> loadAdvancedExercises(String muscleName) async {
    return ref.where("level", isEqualTo: "advanced")
        .get()
        .then((QuerySnapshot snapshot) =>
        snapshot.docs
            .where((doc) => isInMuscle(List.from(doc.data()['muscle']), muscleName))
            .map((doc) => Exercise.fromMap(doc.data()))
            .toList()
    );
  }
  bool isInMuscle(List<String> muscleNames, String input){
    return muscleNames.contains(input);
  }

  Stream<List<Exercise>> loadExercises(String muscle) {
    List<Exercise> list = [];

    return ref.where("muscle", arrayContains: muscle).snapshots().map(
      (snapshot) {
        snapshot.docs.forEach(
          (element) {
            list.add(Exercise.fromMap(element.data()));
          },
        );
        return list;
      },
    );
  }

  Future<void> addListExercise(List<Exercise> lExercises) async {
    lExercises.forEach((element) {
      ref.doc().set(element.toMap());
    });
  }
}
