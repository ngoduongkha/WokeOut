import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/services.dart';
import "package:google_sign_in/google_sign_in.dart";
import "package:woke_out/model/app_user_model.dart";
import "package:flutter_facebook_login/flutter_facebook_login.dart";

class AuthService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String errorMessage;

  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  User currentUser() => _firebaseAuth.currentUser;

  Future<MyAppUser> signInWithEmailAndPassword(
      String email, String password) async {
    print("$email, $password");
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return MyAppUser.fromFirebase(userCredential.user);
    } on FirebaseAuthException catch (e) {
      print("Failed with error code: ${e.code}");
      print("Failed with error message: ${e.message}");

      switch (e.code) {
        case "wrong-password":
        case "user-not-found":
          errorMessage = "Tài khoản hoặc mật khẩu không đúng";
          break;
        case "user-disabled":
          errorMessage = "Tài khoản đã bị khóa";
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
      return null;
    } on PlatformException catch (e) {
      print("Failed with error code: ${e.code}");
      errorMessage = e.message;
      return null;
    }
  }

  Future<MyAppUser> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return MyAppUser.fromFirebase(userCredential.user);
    } on FirebaseAuthException catch (e) {
      print("Failed with error code: ${e.code}");
      print("Failed with error message: ${e.message}");

      switch (e.code) {
        case "operation-not-allowed":
          errorMessage = "Email hoặc mật khẩu chứa kí tự không hợp lệ";
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
      return null;
    }
  }

  Future<MyAppUser> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();

    try {
      FacebookLoginResult facebookLoginResult =
          await facebookLogin.logIn(["email"]);
      switch (facebookLoginResult.status) {
        case FacebookLoginStatus.cancelledByUser:
          print("Facebook login cancelled by user");
          return null;
        case FacebookLoginStatus.loggedIn:
          FacebookAccessToken facebookAccessToken =
              facebookLoginResult.accessToken;
          AuthCredential authCredential =
              FacebookAuthProvider.credential(facebookAccessToken.token);
          final userCredential =
              await _firebaseAuth.signInWithCredential(authCredential);
          return MyAppUser.fromFirebase(userCredential.user);
        case FacebookLoginStatus.error:
          errorMessage = "Facebook login error";
          return null;
        default:
          print("Error unknown");
          return null;
      }
    } on FirebaseAuthException catch (e) {
      print("Failed with error code: ${e.code}");
      errorMessage = e.message;
      return null;
    }
  }

  Future<MyAppUser> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();

    try {
      final googleAccount = await googleSignIn.signIn();

      final googleAuth = await googleAccount.authentication;

      final googleCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final userCredential =
          await _firebaseAuth.signInWithCredential(googleCredential);
      return MyAppUser.fromFirebase(userCredential.user);
    } on FirebaseAuthException catch (e) {
      print("Failed with error code: ${e.code}");
      errorMessage = e.message;
      return null;
    } on PlatformException catch (e) {
      errorMessage = e.message;
      print(errorMessage);
      return null;
    } catch (e) {
      errorMessage = e.toString();
      print(errorMessage);
      return null;
    }
  }

  void signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final FacebookLogin facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }
}
