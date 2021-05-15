import 'dart:io';

import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import "package:woke_out/model/app_user_model.dart";
import 'package:path/path.dart' as path;

class AppUserService {
  final ref = FirebaseFirestore.instance.collection("users");

  static final AppUserService _singleton = AppUserService._internal();

  factory AppUserService() {
    return _singleton;
  }

  AppUserService._internal();

  Future<MyAppUser> loadProfile(String uid) {
    return ref
        .doc(uid)
        .snapshots()
        .map((snapshot) => MyAppUser.fromMap(snapshot.data()))
        .first;
  }

  Future<bool> updateUser(MyAppUser user, {File localFile}) async {
    var resultUpdate = false;

    if (localFile != null) {
      _uploadImage(user, localFile).then((value) {
        user.photoUrl = value;
        print(user.toMap());
      });
    }

    await ref
        .doc(user.uid)
        .update(user.toMap())
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

  Future<bool> addUser(MyAppUser appUser) async {
    var resultCreate = false;
    var usersRef = ref.doc(appUser.uid);
    await usersRef.get().then((docSnapshot) => {
          if (!docSnapshot.exists) {usersRef.set(appUser.toMap())},
          resultCreate = true
        });
    return resultCreate;
  }
}
