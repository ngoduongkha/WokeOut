import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseExercisePage extends StatelessWidget {
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

  // This is app bar of the choose_exercise_page
  Widget buildAppBar(BuildContext context) => SliverAppBar(
        expandedHeight: MediaQuery.of(context).size.height * 0.4,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Text(
              'WELCOME,  ',
              style: GoogleFonts.bebasNeue(
                fontSize: 43,
                color: Colors.white,
                letterSpacing: 1.8,
              ),
            ),
            Text(
              'LUAN',
              style: GoogleFonts.bebasNeue(
                fontSize: 43,
                color: Color(0xFF40D876),
                letterSpacing: 1.8,
              ),
            ),
          ],
        ),
        flexibleSpace: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 3, color: Color(0xFF40D876)),
                  image: DecorationImage(
                    image: AssetImage('assets/images/avartar_demo.jpg'),
                    fit: BoxFit.cover,
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
        imageUrl: 'assets/images/triceps.jpg',
        name: 'triceps',
      ),
    ];
    return SliverPadding(
      padding: EdgeInsets.only(left: 20),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Text(
              'Upper body',
              style: GoogleFonts.bebasNeue(
                color: Colors.white,
                fontSize: 32,
                letterSpacing: 1.8,
              ),
            ),
            Container(
              width: double.infinity,
              height: 300,
              color: Colors.transparent,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: upperCategory.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        width: 141,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(upperCategory[index].imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        upperCategory[index].name,
                        style: GoogleFonts.bebasNeue(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Text(
              'Lower body',
              style: GoogleFonts.bebasNeue(
                color: Colors.white,
                fontSize: 32,
                letterSpacing: 1.8,
              ),
            ),
            Text(
              'Full body',
              style: GoogleFonts.bebasNeue(
                color: Colors.white,
                fontSize: 32,
                letterSpacing: 1.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodayExerciseCategory {
  final String imageUrl;
  final String name;

  TodayExerciseCategory({
    @required this.imageUrl,
    @required this.name,
  });
}
