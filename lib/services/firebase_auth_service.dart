import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:woke_out/model/app_user_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String errorMessage;

  AppUser _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
    );
  }

  Future<AppUser> currentUser() async {
    return _userFromFirebase(_firebaseAuth.currentUser);
  }

  Stream<AppUser> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<AppUser> signInWithEmailAndPassword(
      String email, String password) async {
    final UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .onError<FirebaseAuthException>((error, stackTrace) {
      switch (error.code) {
        case "wrong-password":
          throw PlatformException(code: 'WRONG_PASSWORD');
        case "user-disabled":
          throw PlatformException(code: 'USER_DISABLE');
        case "user-not-found":
          throw PlatformException(code: 'USER_NOT_FOUND');
        case "invalid-email":
          throw PlatformException(code: 'INVALID_EMAIL');
        case "too-many-requests":
          throw PlatformException(code: 'TOO_MANY_REQUESTS');
        default:
          throw PlatformException(code: 'UNKNOWN');
      }
    });

    return _userFromFirebase(userCredential.user);
  }

  Future<AppUser> createUserWithEmailAndPassword(
      String email, String password) async {
    final UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .onError<FirebaseAuthException>((error, stackTrace) {
      switch (error.code) {
        case "wrong-password":
          throw PlatformException(code: 'WRONG_PASSWORD');
        case "user-disabled":
          throw PlatformException(code: 'USER_DISABLE');
        case "user-not-found":
          throw PlatformException(code: 'USER_NOT_FOUND');
        case "invalid-email":
          throw PlatformException(code: 'INVALID_EMAIL');
        case "too-many-requests":
          throw PlatformException(code: 'TOO_MANY_REQUESTS');
        default:
          throw PlatformException(code: 'UNKNOWN');
      }
    });
    
    return _userFromFirebase(userCredential.user);
  }

  Future<AppUser> signInWithFacebook() async {
    final FacebookLogin facebookLogin = FacebookLogin();
    UserCredential userCredential;

    try {
      FacebookLoginResult facebookLoginResult =
          await facebookLogin.logIn(['email']);
      switch (facebookLoginResult.status) {
        case FacebookLoginStatus.cancelledByUser:
          errorMessage = 'Facebook login cancelled by user';
          break;
        case FacebookLoginStatus.loggedIn:
          FacebookAccessToken facebookAccessToken =
              facebookLoginResult.accessToken;
          AuthCredential authCredential =
              FacebookAuthProvider.credential(facebookAccessToken.token);
          userCredential =
              await _firebaseAuth.signInWithCredential(authCredential);
          break;
        case FacebookLoginStatus.error:
          errorMessage = 'Facebook login error';
          break;
        default:
          errorMessage = 'Error unknown';
          break;
      }
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
      return null;
    } on FacebookLoginResult catch (e) {
      errorMessage = e.errorMessage;
    }

    if (userCredential != null) return _userFromFirebase(userCredential.user);
    return null;
  }

  Future<AppUser> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    UserCredential userCredential;

    try {
      final googleAccount = await googleSignIn.signIn().catchError((e) {
        errorMessage = e;
      });

      final googleAuth = await googleAccount.authentication.catchError((e) {
        errorMessage = e;
      });

      final googleCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      userCredential =
          await _firebaseAuth.signInWithCredential(googleCredential);
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
    } catch (e) {
      errorMessage = e;
    }

    if (userCredential != null) return _userFromFirebase(userCredential.user);
    return null;
  }

  Future<void> signOut() async {
    // var isLoggedInFacebook = await facebookLogin.isLoggedIn;
    // if (isLoggedInFacebook) facebookLogin.logOut();
    // var isSignedInFacebook = await googleSignIn.isSignedIn();
    // if (isSignedInFacebook) googleSignIn.disconnect();
    await _firebaseAuth.signOut();
  }
}
