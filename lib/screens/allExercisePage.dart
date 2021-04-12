import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/chest_workout.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.0),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(2, 2),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  child: Icon(Icons.play_arrow, color: Colors.black, size: 40),
                  backgroundColor: Colors.white,
                  radius: 36,
                ),
              ),
            ),
          ],
        ),
        expandedHeight: MediaQuery.of(context).size.height * 0.4,
        stretch: true,
        title: Text(
          'Today Workout',
          style: GoogleFonts.bebasNeue(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        pinned: true,
      );
}
