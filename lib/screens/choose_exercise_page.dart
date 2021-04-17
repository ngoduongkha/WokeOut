import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseExercisePage extends StatefulWidget {
  @override
  _ChooseExercisePageState createState() => _ChooseExercisePageState();
}

// State to let user choose what kind of exercise they wana do today
class _ChooseExercisePageState extends State<ChooseExercisePage> {
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
              buildAppBar(context),
              buildTodayExerciseCategory(),
            ],
          ),
        ),
      );
  Widget buildAppBar(BuildContext context) => SliverPadding(
        padding: EdgeInsets.only(left: 20),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            [
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
        ),
      );

  // This is the today exercise category
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
    return SliverPadding(
      padding: EdgeInsets.only(left: 20),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            SizedBox(height: 10),
            Text(
              'Upper body',
              style: GoogleFonts.bebasNeue(
                color: Color(0xFF40D876),
                fontSize: 35,
                letterSpacing: 1.8,
              ),
            ),
            SizedBox(height: 10),
            buildListCardCategory(upperCategory),
            Text(
              'Lower body',
              style: GoogleFonts.bebasNeue(
                color: Color(0xFF40D876),
                fontSize: 35,
                letterSpacing: 1.8,
              ),
            ),
            SizedBox(height: 10),
            buildListCardCategory(lowerCategory),
            Text(
              'Full body',
              style: GoogleFonts.bebasNeue(
                color: Color(0xFF40D876),
                fontSize: 35,
                letterSpacing: 1.8,
              ),
            ),
            SizedBox(height: 10),
            buildListCardCategory(fullBodyCategory),
          ],
        ),
      ),
    );
  }

  // Build list of cards for each category
  Widget buildListCardCategory(List list) => Container(
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
                  onTap: () {},
                  child: Container(
                    height: 200,
                    width: 280,
                    decoration: BoxDecoration(
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
// Class for save today exercise category
class TodayExerciseCategory {
  final String imageUrl;
  final String name;

  TodayExerciseCategory({
    @required this.imageUrl,
    @required this.name,
  });
}
