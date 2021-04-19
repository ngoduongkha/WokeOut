import "package:meta/meta.dart";

class MyAppUser {
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
  });

  final String uid;
  final String email;
  final String photoUrl;
  final String displayName;
  String bio;
  String gender;
  int height;
  int weight;
  String level;
  String goal;

  factory MyAppUser.fromMap(Map<String, dynamic> data) {
    return MyAppUser(
      uid: data["uid"],
      displayName: data["displayName"],
      email: data["email"],
      photoUrl: data["photoUrl"],
      bio: data["bio"],
      gender: data["gender"],
      height: data["height"],
      weight: data["weight"],
      level: data["level"],
      goal: data["goal"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "displayName": displayName,
      "email": email,
      "photoUrl": photoUrl,
      "bio": bio,
      "gender": gender,
      "height": height,
      "weight": weight,
      "level": level,
      "goal": goal,
    };
  }
}
