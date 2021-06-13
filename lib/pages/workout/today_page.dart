
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woke_out/constants.dart';
import 'package:woke_out/widgets/app_icons.dart';

class ExerciseCategory {
  final String imageUrl;
  final String name;

  ExerciseCategory({
    @required this.imageUrl,
    @required this.name,
  });
}

class TodayPage extends StatefulWidget {
  const TodayPage({Key key}) : super(key: key);

  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  List<Map<String, dynamic>> groups=[
    {
      'groupName': 'upper body',
      'muscles': [
        ExerciseCategory(imageUrl: "assets/images/workout/chest.jpg", name: "chest"),
        ExerciseCategory(imageUrl: "assets/images/workout/back.jpg", name: "back"),
        ExerciseCategory(imageUrl: "assets/images/workout/shoulder.jpeg", name: "shoulder"),
        ExerciseCategory(imageUrl: "assets/images/workout/biceps.jpg", name: "biceps"),
        ExerciseCategory(imageUrl: "assets/images/workout/triceps.jpg", name: "triceps"),
      ]
    },
    {
      'groupName': 'lower body',
      'muscles': [
        ExerciseCategory(imageUrl: "assets/images/workout/abs.jpg", name: "abs"),
        ExerciseCategory(imageUrl: "assets/images/workout/legs.jpg", name: "legs"),
      ]
    },
    {
      'groupName': 'full body',
      'muscles': [
        ExerciseCategory(imageUrl: "assets/images/workout/strength.jpg", name: "strength"),
        ExerciseCategory(imageUrl: "assets/images/workout/cardio.jpg", name: "cardio"),
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            _buildTopPanel(),
            _buildExerciseLibraryText(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index){
                  return ExerciseGroup(group: groups[index]);
                },
                childCount: groups.length,
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _buildTopPanel(){
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Text(
                "Workout",
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 32.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            Center(
              child: Container(
                width: 120.0,
                height: 120.0,
                child: Center(
                  child: Icon(
                    AppIcons.dumbbell,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(120.0),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            Text(
              "Muscle emphasis",
              style: TextStyle(
                color: kActiveIconColor,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Let's start workout with a specific group of muscle",
              style: TextStyle(
                color: kTextColor,
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
      ),
    );
  }
  Widget _buildExerciseLibraryText(){
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(height: 20.0,),
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Text(
              "Exercise Library",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 2.0, color: Theme.of(context).primaryColor)
            ),
          ),
          SizedBox(height: 20.0,),
        ],
      ),
    );
  }
}
class ExerciseGroup extends StatefulWidget {
  final group;
  const ExerciseGroup({
    @required this.group,
  });

  @override
  _ExerciseGroupState createState() => _ExerciseGroupState();
}

class _ExerciseGroupState extends State<ExerciseGroup> {

  final pageController = PageController(initialPage: 0, viewportFraction: 0.9);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 0.05*screenWidth),
          child: Text(
            widget.group['groupName'].toUpperCase(),
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor
            ),
          ),
        ),
        SizedBox(height: 10.0,),
        Container(
          width: screenWidth,
          height: 200.0,
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.group['muscles'].length,
            itemBuilder: (context, index){
              return _buildExerciseThumbnail(widget.group['muscles'][index]);
            },
          ),
        ),
        SizedBox(height: 30.0,),
      ],
    );
  }

  Widget _buildExerciseThumbnail(ExerciseCategory category){
    return GestureDetector(
      child: Card(
        color: Colors.white,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              category.imageUrl,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0, left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),

                  Row(
                    children: [
                      Icon(
                        Icons.stacked_bar_chart,
                        color: Colors.white,
                        size: 25.0,
                      ),
                      SizedBox(width: 5.0,),
                      Text(
                        "3 level",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2.0,
            color: Color.fromRGBO(255, 255, 255, 0.6),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      onTap: (){
        goToExerciseListPage(category);
      },
    );
  }
  void goToExerciseListPage(ExerciseCategory category){
    Navigator.of(context).pushNamed(
      "exerciseList",
      arguments: [category.name, category.imageUrl]
    );
  }
}
