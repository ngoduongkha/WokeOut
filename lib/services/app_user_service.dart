import "package:cloud_firestore/cloud_firestore.dart";
import "package:woke_out/model/app_user_model.dart";

class AppUserService {
  final ref = FirebaseFirestore.instance.collection("users");
  MyAppUser user;

  Stream<MyAppUser> loadProfile(String uid) {
    return ref
        .doc(uid)
        .snapshots()
        .map((snapshot) => MyAppUser.fromMap(snapshot.data()));
  }

  Future<bool> updateUser(String uid, String field, String value) async {
    var resultUpdate = false;
    await ref
        .doc(uid)
        .update({field: value})
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
