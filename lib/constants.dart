import 'package:flutter/material.dart';
import 'package:woke_out/model/challenge_card_model.dart';

const kPrimaryColor = Color(0xFF40D876);
const kPrimaryLightColor = Color(0xFFF1E6FF);

const kBackgroundColor = Color(0xFF15152B);
const kActiveIconColor = Color(0xFFE68342);
const kTextColor = Color(0xFF222B45);
const kBlueLightColor = Color(0xFFC7B8F5);
const kBlueColor = Color(0xFF817DC0);
const kShadowColor = Color(0xFFE6E6E6);

const pickerDataGender = '''[["Male", "Female", "Others"]]''';

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 45;
}

const List<CardModel> cardsList = [
  CardModel(
    "assets/images/plank.jpg",
    Colors.red,
    "plank",
    "The most intuitive core strength assessment. Challenge yourself and hold the plank as long as you can.",
    "Challenge yourself and hold as long as you can",
  ),
  CardModel(
    "assets/images/hold_breath.jpg",
    Colors.green,
    "hold breath",
    "Self-test of your cardiorespiratory capacity. Hold your breath as long as you can and find your limit.",
    "Self-test of your cardiorespiratory capacity. Hold your breath as long as you can and find your limit.",
  ),
  CardModel(
    "assets/images/push_ups.jpg",
    Colors.orange,
    "push-ups",
    "Test and challenge your full body fitness level. Do as many push-ups as you can at once!",
    "Touch anywhere on the screen with your nose or chin when your body moves down to count your repetitions.",
  ),
  CardModel(
    "assets/images/squats.jpg",
    Colors.blue,
    "squats",
    "Measure the power of your large muscle groups. Do as many squats as you can at once!",
    "Hold your phone above your chest with two hands while your body moves up and down.",
  ),
];
