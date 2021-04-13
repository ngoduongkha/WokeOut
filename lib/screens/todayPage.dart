import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodayPage extends StatelessWidget {
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
        stretch: true,
        title: Container(
          width: 300,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              'Today Workout',
              style: GoogleFonts.bebasNeue(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        centerTitle: true,
        pinned: true,
      );
}
