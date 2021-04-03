import 'package:firebase_auth/firebase_auth.dart';
import 'package:woke_out/enum/app_state.dart';
import 'package:woke_out/model/baseModel.dart';

class AuthModel extends BaseModel {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String errorMessage;

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    setViewState(ViewState.Busy);

    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      errorMessage = e.message;
      setViewState(ViewState.Ideal);
      return false;
    }
    setViewState(ViewState.Ideal);
    return true;
  }

  Future<bool> createUserWithEmailAndPassword(String email, String password) async {
    setViewState(ViewState.Busy);

    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      errorMessage = e.message;
      setViewState(ViewState.Ideal);
      return false;
    }
    setViewState(ViewState.Ideal);
    return true;
  }

  void logOut() async {
    setViewState(ViewState.Busy);
    await firebaseAuth.signOut();
    setViewState(ViewState.Ideal);
  }
}
