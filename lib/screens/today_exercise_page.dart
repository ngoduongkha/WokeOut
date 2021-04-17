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
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          buildAppBar(context),
          buildExerciseSet(context),
        ],
      );
  Widget buildAppBar(BuildContext context) {
    var _height = MediaQuery.of(context).size.height * 0.4;
    return SliverPadding(
      padding: EdgeInsets.zero,
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Stack(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget buildExerciseSet(BuildContext context) => SliverList(
        delegate: SliverChildListDelegate(
          [
            Container(
              height: MediaQuery.of(context).size.height,
              color: Color(0xff15152b),
            )
          ],
        ),
      );
}