
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/model/do_exercise_model.dart';
import 'package:woke_out/model/exercise_model.dart';
import 'package:woke_out/model/exercise_record_model.dart';
import 'package:woke_out/services/auth_service.dart';
import 'package:woke_out/services/exercise_record_service.dart';

GlobalKey<_ExerciseRatingFeedbackState> ratingFeedbackKey = new GlobalKey<_ExerciseRatingFeedbackState>();
// use global key to get rating value;

class ResultPage extends StatefulWidget {
  const ResultPage({Key key}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  int exAmount;
  double calorie;
  double score;
  Time totalTime;
  @override
  void initState() {
    ExercisePlayer player = Provider.of<ExercisePlayer>(context, listen: false);
    this.exAmount = player.exerciseList.length;
    this.calorie = player.calculateCalories(40);
    this.score = player.calculateScore();
    this.totalTime = player.record.totalTime;

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _buildHalfTopPanel(),
            _buildHalfLowPanel()
          ],
        ),
      ),
    );
  }
  Widget _buildHalfTopPanel(){
    return Expanded(
      flex: 4,
      child: Container(
        color: Colors.grey[800],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCheckIcon(),
            SizedBox(height: 30.0,),
            _buildTopPanelTitle(),
            SizedBox(height: 30.0,),
            _buildTopPanelInfoItems()
          ],
        ),
      ),
    );
  }
  Widget _buildCheckIcon(){
    return Container(
      width: 100,
      height: 100,
      child: Icon(
        Icons.check,
        size: 60,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(50.0),
      ),
    );
  }
  Widget _buildTopPanelTitle(){
    return Text(
      "Exercise completed",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 25
      ),
    );
  }
  Widget _buildTopPanelInfoItems(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildTopPanelInfoItem(Icons.stacked_bar_chart, "$exAmount ex"),
        _buildTopPanelInfoItem(Icons.local_fire_department, "$calorie kcal"),
        _buildTopPanelInfoItem(Icons.access_time, "${totalTime.getTimeText()}"),
      ],
    );
  }
  Widget _buildTopPanelInfoItem(IconData icon, String text){
    return Column(
      children: [
        Icon(
          icon,
          size: 30,
          color: Colors.white,
        ),
        SizedBox(height: 5.0,),
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18
          ),
        )
      ],
    );
  }

  Widget _buildHalfLowPanel(){
    return Expanded(
      flex: 5,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildScoreInfoContainer(),
            Container(
              height: 1,
              color: Colors.grey[600],
            ),
            _buildRatingSection()
          ],
        ),
      ),
    );
  }
  Widget _buildScoreInfoContainer(){
    return Expanded(
      flex: 2,
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0, left: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildScoreText(),
              _buildScore()
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildScoreText(){
    return Text(
      "Your score",
      style: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.bold
      ),
    );
  }
  Widget _buildScore(){
    return Row(
      children: [
        Icon(
          Icons.star,
          size: 50,
          color: Colors.amber[300],
        ),
        SizedBox(width: 10.0,),
        Text(
          this.score.toString(),
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  Widget _buildRatingSection(){
    return Expanded(
      flex: 5,
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRatingText(),
              SizedBox(height: 20.0,),
              _buildRatingScaleText(),
              SizedBox(height: 20.0,),
              ExerciseRatingFeedback(key: ratingFeedbackKey,),
              SizedBox(height: 40.0,),
              _buildSaveButton()
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildRatingScaleText(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildScaleText("Dissatisfied"),
        _buildScaleText("Satisfied"),
      ],
    );
  }
  Widget _buildScaleText(String text){
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.grey[500]
      ),
    );
  }
  Widget _buildRatingText(){
    return Text(
      "Rate Exercise",
      style: TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  Widget _buildSaveButton(){
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: 55,
      child: TextButton(
        child: Text(
          "Save",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: TextButton.styleFrom(
          backgroundColor: Colors.blueAccent
        ),
        onPressed: save
      ),
    );
  }
  void save(){
    AuthService auth = Provider.of<AuthService>(context, listen: false);
    String userId = auth.currentUser().uid;
    // String userId = "cw1kyc8wsPWTdnQ3onXYWRZtyp13";
    final recordService = ExerciseRecordService(userId: userId);

    ExercisePlayer player = Provider.of<ExercisePlayer>(context, listen: false);
    int satisfactionLevel = ratingFeedbackKey.currentState.getValue();

    player.record.exName = player.name;
    player.record.exLevel = player.level;
    player.record.calorie = calorie;
    player.record.score = score;
    player.record.satisfactionLevel = satisfactionLevel;
    player.record.timeStamp = Timestamp.fromDate(DateTime.now());
    // put data to record

    recordService.addRecord(player.record);
    // add data to database
    Navigator.of(context).pushNamedAndRemoveUntil("home", ModalRoute.withName("landing"));
  }
  int getTotalTimeInSeconds(List<Exercise> list){
    int result = 0;
    list.forEach((exercise) {
      result+= exercise.duration;
    });
    return result - list[list.length - 1].rest;
  }
}

class ExerciseRatingFeedback extends StatefulWidget {
  const ExerciseRatingFeedback({Key key}) : super(key: key);

  @override
  _ExerciseRatingFeedbackState createState() => _ExerciseRatingFeedbackState();
}

class _ExerciseRatingFeedbackState extends State<ExerciseRatingFeedback> {

  Color defaultColor = Colors.grey[600];
  Color selectedColor = Colors.amber;
  final items = [
    {'icon': Icons.sentiment_very_dissatisfied_outlined, 'color': Colors.grey[600]},
    {'icon': Icons.sentiment_dissatisfied_outlined, 'color': Colors.grey[600]},
    {'icon': Icons.sentiment_satisfied, 'color': Colors.grey[600]},
    {'icon': Icons.sentiment_satisfied_alt, 'color': Colors.grey[600]},
    {'icon': Icons.sentiment_very_satisfied_sharp, 'color': Colors.grey[600]},
  ];
  int _selectedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items.map((item) => _buildFeedBackIcon(item['icon'], item['color'], items.indexOf(item))).toList(),
    );
  }
  Widget _buildFeedBackIcon(IconData icon, Color color, int index){
    return GestureDetector(
      child: Icon(
        icon,
        color: color,
        size: 40.0,
      ),
      onTap: (){
        _itemTapEvent(index);
      },
    );
  }
  void _itemTapEvent(int index){
    setState(() {
      _clearItemsColor();
      items[index]['color'] = selectedColor;
      _selectedItemIndex = index;
    });
  }
  void _clearItemsColor(){
    items.forEach((item){
      item['color'] = defaultColor;
    });
  }
  int getValue(){
    return _selectedItemIndex;
  }
}

