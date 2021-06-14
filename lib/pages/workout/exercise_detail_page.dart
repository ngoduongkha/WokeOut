
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:woke_out/constants.dart';
import 'package:woke_out/model/exercise_model.dart';

class DetailPage extends StatefulWidget{
  final Exercise exercise;
  DetailPage({
    @required this.exercise
  });
  @override
  State<StatefulWidget> createState()=> _DetailPageState(exercise);
}

class _DetailPageState extends State<DetailPage> {
  Exercise exercise;
  _DetailPageState(Exercise inputExercise){
    this.exercise = inputExercise;
  }
  VideoPlayerController _controller;
  Future<void> _initVideoPlayerFuture;

  void initController() async {
    _controller = VideoPlayerController.network(exercise.video);
    _initVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(0.0);
    _controller.play();
  }
  @override
  void initState() {
    initController();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            _buildDetailPanel(),
            _buildGetBackButton(context)
          ],
        ),
      ),
    );
  }

  Widget _buildDetailPanel(){
    return FutureBuilder(
      future: _initVideoPlayerFuture,
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return SafeArea(
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
                _buildInfoPanel()
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator(),);
      },
    );
  }
  Widget _buildInfoPanel(){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailName(),
          SizedBox(height: 25.0,),
          _buildInfoTagItem("Difficulty Levels", <String>[this.exercise.level]),
          SizedBox(height: 25.0,),
          _buildInfoTagItem("Muscle", this.exercise.muscle),
          SizedBox(height: 25.0,),
          _buildInfoTagItem("Equipment", <String>[this.exercise.equipment.toString()])
        ],
      ),
    );
  }
  Widget _buildGetBackButton(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: TextButton(
        child: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: 30.0,
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        ),
        onPressed: () {
          Navigator.of(context).pop('detail_back');
        },
      ),
    );
  }
  Widget _buildDetailName(){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.exercise.name.toUpperCase(),
            style: TextStyle(
                fontSize: 20.0,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold
            ),
          ),
          Text(
            "${this.exercise.duration} seconds - rest ${this.exercise.rest} seconds",
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildInfoTagItem(String name, List<String> tags){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            name,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 8.0,),
        Row(
          children: tags.map((String tag)=> _buildTag(tag)).toList(),
        )
      ],
    );
  }
  Widget _buildTag(String text){
    return Container(
      padding: EdgeInsets.all(7.0),
      margin: EdgeInsets.only(left: 5.0),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
            fontSize: 13.0,
            color: kTextColor,
            fontWeight: FontWeight.bold
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(3.0)
      ),
    );
  }

}

