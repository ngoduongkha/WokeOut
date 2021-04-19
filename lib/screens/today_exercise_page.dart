import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'choose_today_exercise_page.dart';

class TodayExercisePage extends StatelessWidget {
  final TodayExerciseCategory chosenExerciseToday;

  const TodayExercisePage({
    Key key,
    @required this.chosenExerciseToday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: Color(0xFF15152B),
        width: double.infinity,
        height: double.infinity,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  buildAppBar(context),
                  buildExerciseSet(context),
                ],
              ),
            ),
          ],
        ),
      );
  Widget buildAppBar(BuildContext context) {
    var _height = MediaQuery.of(context).size.height * 0.4;
    return Stack(
      children: [
        Container(
          height: _height,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Color(0xff15152b)),
            image: DecorationImage(
              image: AssetImage(chosenExerciseToday.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: _height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff15152b).withOpacity(0.4),
                Color(0xff15152b),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                chosenExerciseToday.name,
                style: GoogleFonts.bebasNeue(
                  fontSize: 40,
                  color: Colors.white,
                  letterSpacing: 1.8,
                ),
              ),
              Text(
                ' workout',
                style: GoogleFonts.bebasNeue(
                  fontSize: 40,
                  color: Color(0xFF40D876),
                  letterSpacing: 1.8,
                ),
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: _height * 0.45),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 7,
                    offset: Offset(2, 2),
                    color: Colors.white,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 35,
                child: Icon(
                  Icons.play_arrow,
                  size: 50,
                  color: Colors.white,
                ),
                backgroundColor: Color(0xFF40D876),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildExerciseSet(BuildContext context) {
    final listOfExercisesToday = [
      TodayExerciseDetail(name: 'Wide push up', numOfReps: 10, duration: 3),
      TodayExerciseDetail(name: 'Diamond push up', numOfReps: 10, duration: 3),
      TodayExerciseDetail(name: 'Decline push up', numOfReps: 8, duration: 3),
      TodayExerciseDetail(name: 'Regular push up', numOfReps: 10, duration: 3),
      TodayExerciseDetail(name: 'Dip', numOfReps: 5, duration: 4),
      TodayExerciseDetail(name: 'Incline push up', numOfReps: 15, duration: 3),
      TodayExerciseDetail(name: 'Push up hold', numOfReps: 1, duration: 20),
    ];
    return Column(
      children:
          listOfExercisesToday.map((e) => buildExerciseButton(e)).toList(),
    );
  }

  Widget buildExerciseButton(TodayExerciseDetail exerciseDetail) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: RawMaterialButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.white30, width: 2),
          ),
          splashColor: Colors.grey[800],
          fillColor: Colors.black,
          child: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  exerciseDetail.name,
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${exerciseDetail.numOfReps} reps',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${exerciseDetail.duration} s/rep',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}

class TodayExerciseDetail {
  final String name;
  final int numOfReps;
  final int duration;

  TodayExerciseDetail({
    @required this.name,
    @required this.numOfReps,
    @required this.duration,
  });
}
