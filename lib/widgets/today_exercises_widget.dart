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
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'Exercise $index',
                  style: GoogleFonts.lato(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            childCount: 10,
          ),
        ),
      );
}
