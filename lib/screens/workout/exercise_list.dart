

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/model/do_exercise_model.dart';
import 'package:woke_out/model/exercise_model.dart';
import 'package:woke_out/services/exercise_service.dart';

class ExerciseSet
{
  String name;
  List<Exercise> list;
  ExerciseSet({
    @required this.name,
    @required this.list
  });

  String get category {return this.name;}
  List<Exercise> get exerciseList {return this.list;}

}

class ExerciseListPage extends StatefulWidget {
  @override
  _ExerciseListPageState createState() => _ExerciseListPageState();
}

class _ExerciseListPageState extends State<ExerciseListPage> {
  final ExerciseService exService = ExerciseService();
  Future<List<ExerciseSet>> loadExercisesWithCategory() async{
    List<ExerciseSet> exerciseSet = [];
    List<Exercise> beginner = await exService.loadBeginnerExercises();
    exerciseSet.add(ExerciseSet(name: "beginner", list: beginner));

    List<Exercise> intermediate = await exService.loadIntermediateExercises();
    exerciseSet.add(ExerciseSet(name: "intermediate", list: intermediate));

    List<Exercise> advance = await exService.loadAdvancedExercises();
    exerciseSet.add(ExerciseSet(name: "advance", list: advance));
    return exerciseSet;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: loadExercisesWithCategory(),
      builder: (BuildContext context, AsyncSnapshot<List<ExerciseSet>> snapshot){
        if(snapshot.hasData){
          return DefaultTabController(
            length: snapshot.data.length,
            child: Scaffold(
              body: _buildMainPage(snapshot.data),
            ),
          );
        }
        return Center(child: CircularProgressIndicator(),);
      }
    );
  }
  Widget _buildMainPage(List<ExerciseSet> data){
      return NestedScrollView(
        headerSliverBuilder: (context, isScrolled){
          return <Widget>[
            ExerciseListSliverAppBar(exerciseSets: data)
          ];
        },
        body: TabBarView(
          children: data.map((ExerciseSet e)=> _buildExerciseSetPage(e.exerciseList,)).toList(),
        )
    );
  }

  Widget _buildExerciseSetPage(List<Exercise> list) {
    String totalTime = getTotalTimeText(list);
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            _buildExerciseSetGeneralInfoItems(list.length, totalTime),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index){
                  return _buildListItem(list[index]);
                },
                childCount: list.length
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 80.0,
              ),
            )
          ],
        ),
        _buildStartExerciseButton(list)
      ]
    );
  }
  String getTotalTimeText(List<Exercise> list){
    int seconds = getTotalTimeInSeconds(list);
    if(seconds>= 60){
      return "${(seconds~/60)}m ${seconds%60}s";
    }else return "${seconds}s";
  }
  int getTotalTimeInSeconds(List<Exercise> list){
    int result = 0;
    list.forEach((element) {
      result+= element.duration+ element.rest;
    });
    return result;
  }

  Widget _buildStartExerciseButton(List<Exercise> exerciseList){
    double screenWidth = MediaQuery.of(context).size.width;
    return Consumer<ExercisePlayer>(
      builder: (context, player, child){
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
                  fontSize: 20.0
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.blueAccent
              ),
              onPressed: ()=> startExercise(player, exerciseList),
            ),
          ),
        );
      },
    );
  }
  void startExercise(ExercisePlayer player, List<Exercise> exerciseList){
    player.init(exerciseList);
    Navigator.of(context).pushNamed("doExercisePage");
  }

  Widget _buildExerciseSetGeneralInfoItems(int amount, String totalTime){
    return SliverToBoxAdapter(
      child: Row(
        children: [
          _buildGeneralInfoItem(Icons.bar_chart, amount, "exercises"),
          Container(
            width: 1.0,
            height: 30.0,
            color: Colors.grey,
          ),
          _buildGeneralInfoItem(Icons.access_time_outlined, totalTime, " seconds")
        ],
      )
    );
  }
  Widget _buildGeneralInfoItem(IconData icon, dynamic amount, String text){
    return Expanded(
      flex: 1,
      child: Container(
        height: 60.0,
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(icon, color: Colors.black,)
                    ),
                    TextSpan(
                      text: " $amount"
                    )
                  ],
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.grey[500],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildListItem(Exercise exercise){
    return ListTile(
      contentPadding: EdgeInsets.fromLTRB(25.0, 4.0, 25.0, 4.0),
      title: Container(
        width: double.infinity,
        // padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0),
        child: Row(
          children: [
            _buildLeftImageBox(exercise.image),
            _buildExerciseInfoSection(exercise)
          ],
        ),
      ),
      onTap: (){
        Navigator.of(context).pushNamed("exerciseDetailPage", arguments: exercise);
      },
    );
  }
  Widget _buildLeftImageBox(String imageUrl){
    return Expanded(
      flex: 7,
      child: Container(
        height: 60.0,
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.grey[900]
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
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
            Text(
              "${exercise.duration} seconds - rest ${exercise.rest} seconds",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[500],
                fontSize: 12.0
              ),
            )
          ],
        ),
      ),
    );
  }

}

class ExerciseListSliverAppBar extends StatelessWidget {
  final List<ExerciseSet> exerciseSets;
  ExerciseListSliverAppBar({
    @required this.exerciseSets
  });
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.grey[800],
      pinned: true,
      floating: true,
      expandedHeight: 200.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text("chest"),
        titlePadding: EdgeInsets.only(left: 50.0, bottom: 65.0),
        background: Image.asset(
          "assets/images/chest.jpg",
          fit: BoxFit.cover,
        ),
      ),
      bottom: TabBar(
        tabs: exerciseSets.map((ExerciseSet e)=> Tab(text: e.category,)).toList(),
        indicatorWeight: 4.0,
      ),
    );
  }
}


