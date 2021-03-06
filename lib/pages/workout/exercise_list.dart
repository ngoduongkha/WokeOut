import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/model/do_exercise_model.dart';
import 'package:woke_out/model/exercise_model.dart';
import 'package:woke_out/services/exercise_service.dart';
import 'package:woke_out/util.dart';

import '../../constants.dart';

class ExerciseSet {
  String name;
  String level;
  List<Exercise> list;
  ExerciseSet({@required this.name, this.level, this.list});

  String get category {
    return this.level;
  }

  List<Exercise> get exerciseList {
    return this.list;
  }
}

class ExerciseListPage extends StatefulWidget {
  final String muscleName;
  final String imgPath;

  ExerciseListPage({
    @required this.muscleName,
    @required this.imgPath,
  });

  @override
  _ExerciseListPageState createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  final ExerciseService exService = ExerciseService();

  Future<List<ExerciseSet>> loadExercisesWithCategory() async {
    List<ExerciseSet> exerciseSet = [];

    List<Exercise> beginner =
        await exService.loadBeginnerExercises(widget.muscleName);
    exerciseSet.add(ExerciseSet(
        name: widget.muscleName, level: "beginner", list: beginner));

    List<Exercise> intermediate =
        await exService.loadIntermediateExercises(widget.muscleName);
    exerciseSet.add(ExerciseSet(
        name: widget.muscleName, level: "intermediate", list: intermediate));

    List<Exercise> advance =
        await exService.loadAdvancedExercises(widget.muscleName);
    exerciseSet.add(
        ExerciseSet(name: widget.muscleName, level: "advance", list: advance));

    return exerciseSet;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadExercisesWithCategory(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ExerciseSet>> snapshot) {
        if (snapshot.hasData) {
          return DefaultTabController(
            length: snapshot.data.length,
            child: Scaffold(
              body: _buildMainPage(snapshot.data),
            ),
          );
        }
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _buildMainPage(List<ExerciseSet> data) {
    return NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return <Widget>[
            ExerciseListSliverAppBar(
                muscleName: widget.muscleName.capitalizeFirstofEach,
                imgPath: widget.imgPath,
                exerciseSets: data)
          ];
        },
        body: TabBarView(
          children: data
              .map((ExerciseSet exerciseSet) =>
                  _buildExerciseSetPage(exerciseSet))
              .toList(),
        ));
  }

  Widget _buildExerciseSetPage(ExerciseSet exerciseSet) {
    List<Exercise> list = exerciseSet.list;
    String totalTime = getTotalTimeText(list);

    return Stack(children: [
      CustomScrollView(
        slivers: [
          _buildExerciseSetGeneralInfoItems(list.length, totalTime),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return _buildListItem(list[index]);
            }, childCount: list.length),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 80.0,
            ),
          )
        ],
      ),
      _buildStartExerciseButton(exerciseSet)
    ]);
  }

  String getTotalTimeText(List<Exercise> list) {
    int seconds = getTotalTimeInSeconds(list);
    if (seconds >= 60) {
      return "${(seconds ~/ 60)}m ${seconds % 60}s";
    } else
      return "${seconds}s";
  }

  int getTotalTimeInSeconds(List<Exercise> list) {
    int result = 0;
    list.forEach((element) {
      result += element.duration + element.rest;
    });
    return result;
  }

  Widget _buildStartExerciseButton(ExerciseSet exerciseSet) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        width: screenWidth,
        height: 80.0,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
        child: TextButton(
          child: Text(
            "Start",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: kPrimaryColor,
          ),
          onPressed: () => startExercise(exerciseSet),
        ),
      ),
    );
  }

  void startExercise(ExerciseSet exerciseSet) {
    ExercisePlayer player = Provider.of<ExercisePlayer>(context, listen: false);
    player.reset();
    player.init(exerciseSet.name, exerciseSet.level, exerciseSet.list);
    Navigator.of(context).pushNamed("doExercisePage");
  }

  Widget _buildExerciseSetGeneralInfoItems(int amount, String totalTime) {
    return SliverToBoxAdapter(
        child: Row(
      children: [
        _buildGeneralInfoItem(Icons.bar_chart, amount, "exercises"),
        Container(
          width: 1.0,
          height: 30.0,
          color: Colors.white,
        ),
        _buildGeneralInfoItem(Icons.access_time_outlined, totalTime, " seconds")
      ],
    ));
  }

  Widget _buildGeneralInfoItem(IconData icon, dynamic amount, String text) {
    return Expanded(
      flex: 1,
      child: Container(
        height: 60.0,
        color: kBackgroundColor,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                    children: [
                      WidgetSpan(
                          child: Icon(
                        icon,
                        color: Colors.white,
                      )),
                      TextSpan(
                        text: " $amount",
                      ),
                    ],
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              Text(text,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(Exercise exercise) {
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(25.0, 4.0, 25.0, 4.0),
      title: Container(
        width: double.infinity,
        // padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
        child: Row(
          children: [
            _buildLeftImageBox(exercise.image),
            _buildExerciseInfoSection(exercise),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed("exerciseDetailPage", arguments: exercise);
      },
    );
  }

  Widget _buildLeftImageBox(String imageUrl) {
    return Expanded(
      flex: 7,
      child: Container(
        height: 60.0,
        clipBehavior: Clip.antiAlias,
        child: FadeInImage.assetNetwork(
          placeholder: kExerciseImagePlaceholder,
          height: 30,
          fadeInDuration: Duration(seconds: 1),
          image: imageUrl,
          fit: BoxFit.cover,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildExerciseInfoSection(Exercise exercise) {
    return Expanded(
      flex: 13,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
            Text(
              "${exercise.duration} seconds - rest ${exercise.rest} seconds",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[500],
                  fontSize: 12.0),
            )
          ],
        ),
      ),
    );
  }
}

class ExerciseListSliverAppBar extends StatelessWidget {
  final String muscleName;
  final String imgPath;
  final List<ExerciseSet> exerciseSets;

  ExerciseListSliverAppBar(
      {@required this.exerciseSets, this.muscleName, this.imgPath});
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: kBackgroundColor,
      pinned: true,
      floating: true,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          this.muscleName,
          style: TextStyle(color: Colors.white),
        ),
        titlePadding: EdgeInsets.only(left: 30.0, bottom: 60.0),
        background: Image.asset(
          this.imgPath,
          fit: BoxFit.cover,
        ),
      ),
      leading: GestureDetector(
        child: Icon(
          Icons.chevron_left,
          size: 30.0,
          color: Colors.white,
        ),
        onTap: () => Navigator.of(context).pop(),
      ),
      bottom: TabBar(
        labelColor: Colors.white,
        tabs: exerciseSets
            .map((ExerciseSet e) => Tab(text: e.category.capitalizeFirstofEach))
            .toList(),
        indicatorWeight: 4.0,
        indicatorColor: kPrimaryColor,
      ),
    );
  }
}
