import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodayPage extends StatelessWidget {
  final StreamController streamController;

  const TodayPage({Key key, this.streamController}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/choose_exercise_page.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    buildAppBar(context),
                    buildTodayExerciseCategory(),
                  ],
                ),
              )
            ],
          ),
        ),
      );
  Widget buildAppBar(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: 20),
        child: Column(
          children: [
            SizedBox(height: 40),
            Row(
              children: [
                Text(
                  'WELCOME,  ',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 40,
                    color: Colors.white,
                    letterSpacing: 1.8,
                  ),
                ),
                Text(
                  'LUAN',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 40,
                    color: Color(0xFF40D876),
                    letterSpacing: 1.8,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 5, color: Color(0xFF40D876)),
                  image: DecorationImage(
                    image: AssetImage('assets/images/avartar_demo.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'What\'s on',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 40,
                    color: Colors.white,
                    letterSpacing: 1.8,
                  ),
                ),
                Text(
                  ' for today ?',
                  style: GoogleFonts.bebasNeue(
                    fontSize: 40,
                    color: Color(0xFF40D876),
                    letterSpacing: 1.8,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      );
  Widget buildTodayExerciseCategory() {
    final upperCategory = [
      TodayExerciseCategory(
        imageUrl: 'assets/images/chest.jpg',
        name: 'chest',
      ),
      TodayExerciseCategory(
        imageUrl: 'assets/images/back.jpg',
        name: 'back',
      ),
      TodayExerciseCategory(
        imageUrl: 'assets/images/shoulder.jpg',
        name: 'shoulder',
      ),
      TodayExerciseCategory(
        imageUrl: 'assets/images/biceps.jpg',
        name: 'biceps',
      ),
      TodayExerciseCategory(
        imageUrl: 'assets/images/triceps.jpg',
        name: 'triceps',
      ),
    ];
    final lowerCategory = [
      TodayExerciseCategory(
        imageUrl: 'assets/images/abs.jpg',
        name: 'abs',
      ),
      TodayExerciseCategory(
        imageUrl: 'assets/images/leg.jpg',
        name: 'leg',
      ),
    ];
    final fullBodyCategory = [
      TodayExerciseCategory(
        imageUrl: 'assets/images/strength.jpg',
        name: 'strength',
      ),
      TodayExerciseCategory(
        imageUrl: 'assets/images/cardio.jpg',
        name: 'cardio',
      ),
    ];
    return Padding(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Upper body',
                style: GoogleFonts.bebasNeue(
                  color: Color(0xFF40D876),
                  fontSize: 35,
                  letterSpacing: 1.8,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          buildListCardCategory(upperCategory),
          Row(
            children: [
              Text(
                'Lower body',
                style: GoogleFonts.bebasNeue(
                  color: Color(0xFF40D876),
                  fontSize: 35,
                  letterSpacing: 1.8,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          buildListCardCategory(lowerCategory),
          Row(
            children: [
              Text(
                'Full body',
                style: GoogleFonts.bebasNeue(
                  color: Color(0xFF40D876),
                  fontSize: 35,
                  letterSpacing: 1.8,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          buildListCardCategory(fullBodyCategory),
        ],
      ),
    );
  }

  // Build list of cards for each category
  Widget buildListCardCategory(List<TodayExerciseCategory> list) => Container(
        width: double.infinity,
        height: 300,
        color: Colors.transparent,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: list.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(right: 20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => {
                    Navigator.pushNamed(
                      context,
                      "exerciseList",
                      arguments: [list[index].name, list[index].imageUrl]
                    )
                  },
                  child: Container(
                    height: 200,
                    width: 280,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.white.withOpacity(.3),
                      ),
                      image: DecorationImage(
                        image: AssetImage(list[index].imageUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  list[index].name,
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white,
                    fontSize: 30,
                    letterSpacing: 1.8,
                  ),
                )
              ],
            ),
          ),
        ),
      );
}

// // // Class for save today exercise category
class TodayExerciseCategory {
  final String imageUrl;
  final String name;

  TodayExerciseCategory({
    @required this.imageUrl,
    @required this.name,
  });
}
