import 'package:flutter/cupertino.dart';

class Exercise {
  final String name;
  final Duration duration;
  final int noOfReps;

  Exercise({
    @required this.name,
    @required this.duration,
    @required this.noOfReps,
  });
}
