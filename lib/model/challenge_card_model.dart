import 'package:flutter/material.dart';

class CardModel {
  final String title;
  final Category category;
  final String image;
  final Color color;
  final String description;
  final String instruction;

  const CardModel(
    this.title,
    this.category,
    this.image,
    this.color,
    this.description,
    this.instruction,
  );
}

enum Category {
  stop_watch,
  count,
}
