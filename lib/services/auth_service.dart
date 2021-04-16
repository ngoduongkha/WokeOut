import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:woke_out/enum/app_state.dart';
import 'package:woke_out/model/app_user_model.dart';
import 'package:woke_out/model/base_model.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthService extends BaseModel {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String errorMessage;

  MyAppUser _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return MyAppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  Future<MyAppUser> signInWithEmailAndPassword(
      String email, String password) async {
    setViewState(ViewState.busy);

    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      setViewState(ViewState.ideal);
      return _userFromFirebase(userCredential.user);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print('Failed with error message: ${e.message}');

      switch (e.code) {
        case "wrong-password":
        case "user-not-found":
          errorMessage = "Tài khoản hoặc mật khẩu không đúng";
          break;
        case "invalid-email":
          errorMessage = "Tài khoản email không hợp lệ";
          break;
        case "unknown":
          errorMessage = "Lỗi không xác định";
          break;
        case "too-many-requests":
          errorMessage = "Thao tác thất bại nhiều lần.\nVui lòng thử lại sau.";
          break;
        default:
          errorMessage = "Lỗi không xác định";
          break;
      }

      setViewState(ViewState.ideal);
      return null;
    }
  }

  Future<MyAppUser> createUserWithEmailAndPassword(
      String email, String password) async {
    setViewState(ViewState.busy);

    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      setViewState(ViewState.ideal);
      return _userFromFirebase(userCredential.user);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print('Failed with error message: ${e.message}');

      switch (e.code) {
        case "invalid-email":
          errorMessage = "Tài khoản email không hợp lệ";
          break;
        case "unknown":
          errorMessage = "Lỗi không xác định";
          break;
        case "too-many-requests":
          errorMessage = "Thao tác thất bại nhiều lần.\nVui lòng thử lại sau.";
          break;
        case "weak-password":
          errorMessage = "Mật khẩu phải có ít nhất 6 ký tự.";
          break;
        case "email-already-in-use":
          errorMessage = "Tài khoản đã tồn tại";
          break;
        default:
          errorMessage = "";
          break;
      }

      setViewState(ViewState.ideal);
      return null;
    }
  }

  Future<MyAppUser> signInWithFacebook() async {
    setViewState(ViewState.busy);
    final facebookLogin = FacebookLogin();

    try {
      FacebookLoginResult facebookLoginResult =
          await facebookLogin.logIn(['email']);
      switch (facebookLoginResult.status) {
        case FacebookLoginStatus.cancelledByUser:
          print('Facebook login cancelled by user');
          setViewState(ViewState.ideal);
          return null;
        case FacebookLoginStatus.loggedIn:
          FacebookAccessToken facebookAccessToken =
              facebookLoginResult.accessToken;
          AuthCredential authCredential =
              FacebookAuthProvider.credential(facebookAccessToken.token);
          final userCredential =
              await _firebaseAuth.signInWithCredential(authCredential);
          setViewState(ViewState.ideal);
          return _userFromFirebase(userCredential.user);
        case FacebookLoginStatus.error:
          errorMessage = 'Facebook login error';
          setViewState(ViewState.ideal);
          return null;
        default:
          print('Error unknown');
          setViewState(ViewState.ideal);
          return null;
      }
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      errorMessage = e.message;
      setViewState(ViewState.ideal);
      return null;
    }
  }

  Future<MyAppUser> signInWithGoogle() async {
    setViewState(ViewState.busy);
    final googleSignIn = GoogleSignIn();

    try {
      final googleAccount = await googleSignIn.signIn();

      final googleAuth = await googleAccount.authentication;

      final googleCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final userCredential =
          await _firebaseAuth.signInWithCredential(googleCredential);
      setViewState(ViewState.ideal);
      return _userFromFirebase(userCredential.user);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      errorMessage = e.message;
      setViewState(ViewState.ideal);
      return null;
    } catch (e) {
      errorMessage = e;
      print(errorMessage);
      setViewState(ViewState.ideal);
      return null;
    }
  }

  void signOut() async {
    setViewState(ViewState.busy);
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final FacebookLogin facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
    setViewState(ViewState.ideal);
  }
}
