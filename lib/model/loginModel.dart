import 'package:firebase_auth/firebase_auth.dart';
import 'package:woke_out/enum/app_state.dart';
import 'package:woke_out/model/baseModel.dart';

class LoginModel extends BaseModel {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void signIn(String email, String password) async {
    setViewState(ViewState.Busy);
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    setViewState(ViewState.Ideal);
  }
}
