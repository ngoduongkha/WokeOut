import 'dart:io';

import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import "package:woke_out/model/app_user_model.dart";
import 'package:path/path.dart' as path;
import 'package:woke_out/model/challenge_model.dart';

class AppUserService {
  final _ref = FirebaseFirestore.instance.collection("users");

  static final AppUserService _singleton = AppUserService._internal();

  factory AppUserService() {
    return _singleton;
  }

  AppUserService._internal();

  Future<MyAppUser> loadProfile(String uid) {
    return _ref
        .doc(uid)
        .snapshots()
        .map((snapshot) => MyAppUser.fromMap(snapshot.data()))
        .first;
  }

  Future<bool> updateUser(MyAppUser user, {File localFile}) async {
    var resultUpdate = false;

    if (localFile != null) {
      await _uploadImage(user, localFile).then((value) {
        user.photoUrl = value;
      });
    }

    await _ref
        .doc(user.uid)
        .set(user.toMap())
        .then((value) => resultUpdate = true)
        .catchError((error) => resultUpdate = false);

    return resultUpdate;
  }

  Future<String> _uploadImage(MyAppUser user, File localFile) async {
    var fileExtension = path.extension(localFile.path);

    var uuid = Uuid().v4();

    final Reference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('user/photo/${user.uid}/$uuid$fileExtension');

    await firebaseStorageRef.putFile(localFile);

    String url = await firebaseStorageRef.getDownloadURL();

    return url;
  }

  void addUser(MyAppUser appUser) async {
    await _ref.doc(appUser.uid).set(appUser.toMap());
  }

  void addChallengeRecord(ChallengeModel record) async {
    final _userUid = FirebaseAuth.instance.currentUser.uid;
    final _challengeRef = _ref.doc(_userUid).collection("challenges");

    await _challengeRef.add(record.toMap());
  }

  void clearChallengeRecord() async {
    final _userUid = FirebaseAuth.instance.currentUser.uid;
    final _challengeRef = _ref.doc(_userUid).collection("challenges");

    await _challengeRef.get().then((snapshot) {
      for (var doc in snapshot.docs) {
        doc.reference.delete();
      }
    });
  }

  Stream<List<ChallengeModel>> getChallengeRecordsByName(String name) {
    final _userUid = FirebaseAuth.instance.currentUser.uid;
    final _challengeRef = _ref.doc(_userUid).collection("challenges");

    return _challengeRef
        .where("name", isEqualTo: name)
        .snapshots(includeMetadataChanges: true)
        .map((snapshot) => snapshot.docs
            .map((doc) => ChallengeModel.fromMap(doc.data()))
            .toList());
  }
}
