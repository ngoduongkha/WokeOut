import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:woke_out/model/exercise_model.dart';

class ExerciseService with ChangeNotifier {
  final ref = FirebaseFirestore.instance.collection("exercises");

  Future<List<Exercise>> loadBeginnerExercises() async {
    QuerySnapshot snapshot =
        await ref.where("level", isEqualTo: "beginner").get();

    List<Exercise> beginner = [];

    snapshot.docs.forEach((element) {
      Exercise exercise = Exercise.fromMap(element.data());
      beginner.add(exercise);
    });
    return beginner;
  }

  Future<List<Exercise>> loadIntermediateExercises() async {
    QuerySnapshot snapshot =
        await ref.where("level", isEqualTo: "intermediate").get();

    List<Exercise> intermidiate = [];

    snapshot.docs.forEach((element) {
      Exercise exercise = Exercise.fromMap(element.data());
      intermidiate.add(exercise);
    });

    return intermidiate;
  }

  Future<List<Exercise>> loadAdvancedExercises() async {
    QuerySnapshot snapshot =
        await ref.where("level", isEqualTo: "advanced").get();

    List<Exercise> advanced = [];

    snapshot.docs.forEach((element) {
      Exercise exercise = Exercise.fromMap(element.data());
      advanced.add(exercise);
    });

    return advanced;
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

  Future<void> addExercise(Exercise exercise) async {
    // QuerySnapshot snapshot =
    //     await ref.where("level", isEqualTo: "intermediate").get();

    // List<Exercise> beginner = [];

    // snapshot.docs.forEach((element) {
    //   Exercise exercise = Exercise.fromMap(element.data());
    //   beginner.add(exercise);
    // });

    // beginner.forEach((element) {
    //   var exeref = ref.doc().set(element.toMap());
    // });

    ref.doc().set(exercise.toMap());
  }

  Future<void> addListExercise(List<Exercise> lExercises) async {
    lExercises.forEach((element) {
      ref.doc().set(element.toMap());
    });
  }
}
