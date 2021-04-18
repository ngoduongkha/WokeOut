import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:woke_out/model/exercise_model.dart';

class ExerciseService {
  final ref = FirebaseFirestore.instance.collection('exercises');

  Future<List<Exercise>> loadBeginnerExercises() async {
    QuerySnapshot snapshot =
        await ref.where('level', isEqualTo: 'beginner').get();

    List<Exercise> beginner = [];

    snapshot.docs.forEach((element) {
      Exercise exercise = Exercise.fromMap(element.data());
      beginner.add(exercise);
    });

    return beginner;
  }

  Future<List<Exercise>> loadIntermidiateExercises() async {
    QuerySnapshot snapshot =
        await ref.where('level', isEqualTo: 'intermidiate').get();

    List<Exercise> intermidiate = [];

    snapshot.docs.forEach((element) {
      Exercise exercise = Exercise.fromMap(element.data());
      intermidiate.add(exercise);
    });

    return intermidiate;
  }

  Future<List<Exercise>> loadAdvancedExercises() async {
    QuerySnapshot snapshot =
        await ref.where('level', isEqualTo: 'advanced').get();

    List<Exercise> advanced = [];

    snapshot.docs.forEach((element) {
      Exercise exercise = Exercise.fromMap(element.data());
      advanced.add(exercise);
    });

    return advanced;
  }

  Future<bool> addExercise(Exercise exercise) async {
    QuerySnapshot snapshot =
        await ref.where('level', isEqualTo: 'beginner').get();

    List<Exercise> beginner = [];

    snapshot.docs.forEach((element) {
      Exercise exercise = Exercise.fromMap(element.data());
      beginner.add(exercise);
    });

    beginner.forEach((element) {
      var exeref = ref.doc().set(element.toMap());
    });
  }
}
