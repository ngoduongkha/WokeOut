import 'dart:ui';

import 'package:flutter/material.dart';

class AllExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(), // Bounce effect when scrolling
          slivers: [
            buildAppBar(context),
          ],
        ),
      );
  SliverAppBar buildAppBar(BuildContext context) => SliverAppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/chest_workout.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Container(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.0),
                ),
              ),
            ),
          ),
        ),
        expandedHeight: MediaQuery.of(context).size.height * 0.4,
        stretch: true,
        title: Text(
          'Today Workout',
        ),
        centerTitle: true,
        pinned: true,
      );
}
