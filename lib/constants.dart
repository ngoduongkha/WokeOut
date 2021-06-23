import 'package:flutter/material.dart';
import 'package:woke_out/model/challenge_card_model.dart';

const kPrimaryColor = Color(0xFF27ae60);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const kChallengeCardColor = Color(0xFF262626);
const kBackgroundColor = Color(0xFF272c34);
const kActiveIconColor = Color(0xFFE68342);
const kTextColor = Color(0xFF222B45);
const kBlueLightColor = Color(0xFFC7B8F5);
const kBlueColor = Color(0xFF817DC0);
const kShadowColor = Color(0xFFE6E6E6);
const kExerciseImagePlaceholder = "assets/images/workout/placeholder.png";

const pickerDataGender = '''[["Male", "Female", "Others"]]''';

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}

const List<CardModel> cardsList = [
  CardModel(
    "plank",
    Category.stop_watch,
    "assets/images/challenge/plank.jpg",
    "assets/images/challenge/finish-plank.png",
    Colors.red,
    "The most intuitive core strength assessment. Challenge yourself and hold the plank as long as you can.",
    "Challenge yourself and hold as long as you can",
  ),
  CardModel(
    "hold breath",
    Category.stop_watch,
    "assets/images/challenge/hold_breath.jpg",
    "assets/images/challenge/finish-hold-breath.png",
    Colors.green,
    "Self-test of your cardiorespiratory capacity. Hold your breath as long as you can and find your limit.",
    "Self-test of your cardiorespiratory capacity. Hold your breath as long as you can and find your limit.",
  ),
  CardModel(
    "push-ups",
    Category.count,
    "assets/images/challenge/push_ups.jpg",
    "assets/images/challenge/finish-push-up.png",
    Colors.orange,
    "Test and challenge your full body fitness level. Do as many push-ups as you can at once!",
    "Touch anywhere on the screen with your nose or chin when your body moves down to count your repetitions.",
  ),
  CardModel(
    "squats",
    Category.count,
    "assets/images/challenge/squats.jpg",
    "assets/images/challenge/finish-squat.png",
    Colors.blue,
    "Measure the power of your large muscle groups. Do as many squats as you can at once!",
    "Hold your phone above your chest with two hands while your body moves up and down.",
  ),
];
