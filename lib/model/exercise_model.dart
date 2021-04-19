class Exercise {
  String name;
  List muscle;
  String level;
  int duration;
  bool equipment;
  int rep;
  int rest;
  String image;
  String video;

  Exercise();

  Exercise.fromMap(Map<String, dynamic> data) {
    name = data['name'];
    muscle = data['muscle'];
    level = data['level'];
    duration = data['duration'];
    equipment = data['equipment'];
    rep = data['rep'];
    rest = data['rest'];
    image = data['image'];
    video = data['video'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': name,
      'muscle': muscle,
      'level': level,
      'duration': duration,
      'equipment': equipment,
      'rep': rep,
      'rest': rest,
      'image': image,
      'video': video,
    };
  }
}
