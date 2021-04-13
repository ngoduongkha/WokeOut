import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodayExercisesWidget extends StatefulWidget {
  @override
  _TodayExercisesWidgetState createState() => _TodayExercisesWidgetState();
}

class _TodayExercisesWidgetState extends State<TodayExercisesWidget> {
  @override
  Widget build(BuildContext context) => SliverPadding(
        padding: EdgeInsets.all(16),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(height: 8),
              Text(
                'Exercise',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.black38,
                  ),
                  child: Center(
                    child: Text(
                      'Exercise 1, need data please',
                      style: GoogleFonts.lato(
                        fontSize: 26,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
