import 'package:flutter/material.dart';

class CardModel {
  final String image;
  final Color color;
  final String title;
  final String description;
  final String instruction;

  const CardModel(
    this.image,
    this.color,
    this.title,
    this.description,
    this.instruction,
  );
}
