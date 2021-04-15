import 'package:flutter/material.dart';

class ChooseExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/choose_exercise_page.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: CustomScrollView(
            slivers: [],
          ),
        ),
      );
}
