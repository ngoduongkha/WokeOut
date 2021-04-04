import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:woke_out/enum/app_state.dart';
import 'package:woke_out/model/baseModel.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthModel extends BaseModel {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FacebookLogin facebookLogin = new FacebookLogin();
  GoogleSignIn googleSignIn = new GoogleSignIn();
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

  Future<bool> createUserWithEmailAndPassword(
      String email, String password) async {
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

  Future<bool> signInWithFacebook() async {
    setViewState(ViewState.Busy);

    try {
      FacebookLoginResult facebookLoginResult =
          await facebookLogin.logIn(['email']);
      switch (facebookLoginResult.status) {
        case FacebookLoginStatus.cancelledByUser:
          print('Facebook login cancelled by user');
          setViewState(ViewState.Ideal);
          return false;
        case FacebookLoginStatus.loggedIn:
          FacebookAccessToken facebookAccessToken =
              facebookLoginResult.accessToken;
          AuthCredential authCredential =
              FacebookAuthProvider.credential(facebookAccessToken.token);
          await firebaseAuth.signInWithCredential(authCredential);
          break;
        case FacebookLoginStatus.error:
          errorMessage = 'Facebook login error';
          setViewState(ViewState.Ideal);
          return false;
        default:
          print('Error unknown');
          break;
      }
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      errorMessage = e.message;
      setViewState(ViewState.Ideal);
      return false;
    }
    setViewState(ViewState.Ideal);
    return true;
  }

  Future<bool> signInWithGoogle() async {
    setViewState(ViewState.Busy);

    try {
      final googleAccount = await googleSignIn.signIn().catchError((e) {
        errorMessage = e;
        print(errorMessage);
      });

      final googleAuth = await googleAccount.authentication.catchError((e) {
        errorMessage = e;
        print(errorMessage);
      });

      final googleCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await firebaseAuth.signInWithCredential(googleCredential);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      errorMessage = e.message;
      setViewState(ViewState.Ideal);
      return false;
    } catch (e) {
      errorMessage = e;
      print(errorMessage);
      setViewState(ViewState.Ideal);
      return false;
    }

    setViewState(ViewState.Ideal);
    return true;
  }

  void logOut() async {
    setViewState(ViewState.Busy);
    // var isLoggedInFacebook = await facebookLogin.isLoggedIn;
    // if (isLoggedInFacebook) facebookLogin.logOut();
    // var isSignedInFacebook = await googleSignIn.isSignedIn();
    // if (isSignedInFacebook) googleSignIn.disconnect();
    await firebaseAuth.signOut();
    setViewState(ViewState.Ideal);
  }
}
