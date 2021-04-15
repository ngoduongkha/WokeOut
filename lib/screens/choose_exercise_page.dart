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
            ],
          ),
        ),
      );
  Widget buildAppBar(BuildContext context) => SliverAppBar(
        expandedHeight: MediaQuery.of(context).size.height * 0.5,
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
        flexibleSpace: Container(
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
      );
}
