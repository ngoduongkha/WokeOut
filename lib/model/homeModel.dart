import 'package:firebase_auth/firebase_auth.dart';
import 'package:woke_out/enum/app_state.dart';
import 'package:woke_out/model/baseModel.dart';

class HomeModel extends BaseModel {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void logOut() async {
    setViewState(ViewState.Busy);
    await firebaseAuth.signOut();
    setViewState(ViewState.Ideal);
  }
}