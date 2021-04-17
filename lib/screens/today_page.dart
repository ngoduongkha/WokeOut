import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woke_out/screens/choose_exercise_page.dart';

class TodayExercisePage extends State<ChooseExercisePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(), // Bounce effect when scrolling
          slivers: [
            buildMyAppBar(context),
            //TodayExercisesWidget(),
          ],
        ),
      );
  Widget buildMyAppBar(BuildContext context) => SliverPadding(
        padding: EdgeInsets.only(left: 20, top: 40),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/triceps.jpg"),
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
                    child:
                        Icon(Icons.play_arrow, color: Colors.white, size: 45),
                    backgroundColor: Color(0xFF40D876),
                    radius: 36,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
