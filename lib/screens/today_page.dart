import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woke_out/widgets/today_exercises_widget.dart';

class TodayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(), // Bounce effect when scrolling
          slivers: [
            buildMyAppBar(context),
            TodayExercisesWidget(),
          ],
        ),
      );
  SliverAppBar buildMyAppBar(BuildContext context) => SliverAppBar(
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/chest_workout.jpg"),
                  fit: BoxFit.fill,
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
                  child: Icon(Icons.play_arrow, color: Colors.black, size: 45),
                  backgroundColor: Colors.white,
                  radius: 36,
                ),
              ),
            ),
          ],
        ),
        expandedHeight: MediaQuery.of(context).size.height * 0.4,
        stretch: false,
        title: Container(
          width: 310,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              'Today Exercises',
              style: GoogleFonts.bebasNeue(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(.7),
              ),
            ),
          ),
        ),
        centerTitle: true,
        pinned: false,
      );
}
