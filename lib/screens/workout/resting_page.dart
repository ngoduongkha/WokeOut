
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/model/do_exercise_model.dart';
import 'package:woke_out/model/exercise_model.dart';

class RestPage extends StatefulWidget {
  final ExercisePlayer player;
  RestPage({
    @required this.player
  });
  @override
  _RestPageState createState() => _RestPageState(player);
}

class _RestPageState extends State<RestPage> {
  ExercisePlayer player;
  int rest;
  _RestPageState(ExercisePlayer inputPlayer){
    this.player = inputPlayer;
    this.rest = inputPlayer.currentExercise.rest;
  }
  Timer _timer;
  int moreTimeInterval = 20;
  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }
  void startCounting() {
    const interval = Duration(seconds: 1);
    _timer = Timer.periodic(interval, (timer) {
      if (rest > 0) {
        setState(() {
          rest--;
        });
      } else {
        setState(() {
          _timer.cancel();
          completeResting();
        });
      }
    });
  }

  @override
  void initState() {
    startCounting();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildCountdownPanel(),
          _buildDoExerciseProgressBar(),
          _buildNextExercisePanel()
        ],
      ),
    );
  }
  Widget _buildDoExerciseProgressBar(){
    double progress= (this.player.currentIndex+1)/this.player.length;
    return LinearProgressIndicator(
        value: progress
    );
  }
  Widget _buildCountdownPanel(){
    return Expanded(
      flex: 1,
      child: Container(
        color: Color(0xff1e272e),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRestText(),
            SizedBox(height: 20.0,),
            _buildCountDownText(),
            SizedBox(height: 20.0,),
            _buildRestFunctionButtons(),
          ],
        ),
      ),
    );
  }
  Widget _buildRestText(){
    return Text(
      "Rest time".toUpperCase(),
      style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Colors.white
      ),
    );
  }
  Widget _buildCountDownText(){
    String countdownText = getCountdownTextFromRest(this.rest);
    return Text(
      countdownText,
      style: TextStyle(
          fontSize: 75.0,
          fontWeight: FontWeight.bold,
          color: Colors.white
      ),
    );
  }
  String getCountdownTextFromRest(int rest){
    int minutes = rest~/60;
    int seconds = rest%60;
    String minText = minutes>= 10? "$minutes": "0$minutes";
    String secText = seconds>= 10? "$seconds": "0$seconds";
    return "$minText:$secText";
  }
  Widget _buildRestFunctionButtons(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildMoreTimeButton(),
        SizedBox(width: 30.0,),
        _buildSkipExerciseButton()
      ],
    );
  }

  Widget _buildMoreTimeButton(){
    return TextButton(
      child: Text(
        "+${moreTimeInterval}s",
        style: TextStyle(
          color: Colors.white,
          fontSize: 17.0,
          fontWeight: FontWeight.bold
        ),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 15.0)
      ),
      onPressed: addMoreTime,
    );
  }
  void addMoreTime(){
    this.rest+= moreTimeInterval;
  }
  Widget _buildSkipExerciseButton(){
    return Consumer<ExercisePlayer>(
      builder: (context, player, child){
        return TextButton(
          child: Text(
            "Skip",
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 17.0,
              fontWeight: FontWeight.bold
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            padding: EdgeInsets.fromLTRB(50.0, 15.0, 50.0, 15.0)
          ),
          onPressed: completeResting,
        );
      },
    );
  }
  void completeResting(){
    this.player.increaseIndexByOne();
    Navigator.of(context).pushReplacementNamed("doExercisePage");
  }

  Widget _buildNextExercisePanel(){
    return Container(
      height: 130.0,
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: [
          _buildNextExerciseInfo(),
          _buildNextExerciseImg()
        ],
      ),
    );
  }
  Widget _buildNextExerciseInfo(){
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNextExerciseProgressText(this.player.currentIndex+ 2, this.player.length),
          SizedBox(height: 8.0,),
          _buildNextExerciseNameText(this.player.nextExercise),
          SizedBox(height: 8.0,),
          _buildNextExerciseRestText(this.player.nextExercise.rest)
        ],
      )
    );
  }
  Widget _buildNextExerciseProgressText(int current, int length){
    return RichText(
      text: TextSpan(
          children: [
            TextSpan(text: "NEXT ", style: TextStyle(color: Colors.grey[500], fontSize: 18.0)),
            TextSpan(text: "$current/$length", style: TextStyle(color: Colors.blue, fontSize: 18.0))
          ]
      ),
    );
  }
  Widget _buildNextExerciseNameText(Exercise nextExercise){
    return GestureDetector(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "${nextExercise.name} ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              )
            ),
            WidgetSpan(
              child: Icon(
                Icons.help_outline,
                color: Colors.grey[500],
                size: 15.0,
              )
            )
          ]
        ),
      ),
      onTap: (){
        watchExerciseDetailEvent(player.nextExercise);
      },
    );
  }
  void watchExerciseDetailEvent(Exercise exercise) async{
    _timer.cancel();
    var result = await Navigator.of(context).pushNamed("exerciseDetailPage", arguments: exercise);
    if(result == "detail_back") startCounting();
  }
  Widget _buildNextExerciseRestText(int dur){
    return RichText(
      text: TextSpan(
        text: "00:$dur",
        style: TextStyle(
          color: Colors.grey[500],
          fontSize: 18.0,
        )
      ),
    );
  }

  Widget _buildNextExerciseImg(){
    return Expanded(
      flex: 1,
      child: Container(
        child: Image.network(
          this.player.nextExercise.image,
          fit: BoxFit.cover,
        ),
        color: Colors.teal,
      )
    );
  }
}
