import 'package:firebase_auth/firebase_auth.dart';
import "package:meta/meta.dart";
import 'package:woke_out/enum.dart';

class MyAppUser {
  final String uid;
  String email;
  String displayName;
  String photoUrl;
  String bio;
  Gender gender;
  int height;
  int weight;
  String level;
  String goal;
  String address;

  MyAppUser({
    @required this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
    this.bio,
    this.gender,
    this.height,
    this.weight,
    this.level,
    this.goal,
    this.address,
  });

  factory MyAppUser.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    return MyAppUser(
      uid: data["uid"],
      displayName: data["displayName"],
      email: data["email"],
      photoUrl: data["photoUrl"],
      bio: data["bio"],
      gender: data["gender"] == "Gender.female"
          ? Gender.female
          : (data["gender"] == "Gender.male" ? Gender.male : Gender.other),
      height: data["height"],
      weight: data["weight"],
      level: data["level"],
      goal: data["goal"],
      address: data["address"],
    );
  }

  factory MyAppUser.fromFirebase(User user) {
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

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "displayName": displayName,
      "email": email,
      "photoUrl": photoUrl,
      "bio": bio,
      "gender": gender.toString(),
      "height": height,
      "weight": weight,
      "level": level,
      "goal": goal,
      "address": address,
    };
  }
}
