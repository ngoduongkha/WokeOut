import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woke_out/model/exercise_model.dart';
import 'package:woke_out/services/exercise_service.dart';

class TodayExercisePage extends StatefulWidget {
  final muscleName;

  TodayExercisePage({
    Key key,
    @required this.muscleName,
  }) : super(key: key);

  @override
  _TodayExercisePageState createState() => _TodayExercisePageState();
}

class _TodayExercisePageState extends State<TodayExercisePage> {
  final ExerciseService exerciseService = ExerciseService();
  List<Exercise> _listExercises = [];
  List<Exercise> _listChosen = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Color(0xFF15152B),
        width: double.infinity,
        height: double.infinity,
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  buildAppBar(context),
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          child: Text('Beginner'),
                          onPressed: () {
                            _listChosen = _listExercises
                                .where((element) => element.level == "beginner")
                                .toList();
                            setState(() {});
                          },
                        ),
                        TextButton(
                          child: Text('Intermediate'),
                          onPressed: () {
                            _listChosen = _listExercises
                                .where((element) =>
                                    element.level == "intermediate")
                                .toList();

                            setState(() {});
                          },
                        ),
                        TextButton(
                          child: Text('Advanced'),
                          onPressed: () {
                            _listChosen = _listExercises
                                .where((element) => element.level == "advanced")
                                .toList();
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  buildExerciseSet(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    var _height = MediaQuery.of(context).size.height * 0.4;
    return Stack(
      children: [
        Container(
          height: _height,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Color(0xff15152b)),
            image: DecorationImage(
              image: AssetImage("assets/images/chest.jpg"),
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
                widget.muscleName,
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
    return StreamBuilder<List<Exercise>>(
      stream: exerciseService.loadExercises(widget.muscleName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _listExercises = snapshot.data;

          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: _listChosen.length,
            itemBuilder: (context, index) {
              return buildExerciseButton(_listChosen[index]);
            },
          );
        } else
          return Container(child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget buildExerciseButton(Exercise exercise) {
    return Padding(
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
                exercise.name,
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
                    '${exercise.rep} reps',
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${exercise.duration} s/rep',
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
}
