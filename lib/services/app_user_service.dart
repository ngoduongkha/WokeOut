import "package:cloud_firestore/cloud_firestore.dart";
import "package:woke_out/model/app_user_model.dart";

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
        .map((snapshot) => MyAppUser.fromMap(snapshot.data())).first;
  }

  Future<bool> updateUser(MyAppUser user) async {
    var resultUpdate = false;
    await ref
        .doc(user.uid)
        .update(user.toMap())
        .then((value) => resultUpdate = true)
        .catchError((error) => resultUpdate = false);
    return resultUpdate;
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
