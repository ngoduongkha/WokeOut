
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'challenge_finish.dart';

class PushUpPage extends StatefulWidget {
  const PushUpPage({Key key}) : super(key: key);

  @override
  _PushUpPageState createState() => _PushUpPageState();
}

class _PushUpPageState extends State<PushUpPage> {

  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff1e3799),
            Colors.blueAccent,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Push-up challenge",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: GestureDetector(
            child: Icon(Icons.chevron_left, size: 35.0,),
            onTap: (){
              Navigator.of(context).pop();
            },
          ),
          elevation: 0,
        ),
        body: Stack(
          children: [
            _buildCenterElements(),
            _buildBestRecord()
          ],
        )
      ),
    );
  }
  Widget _buildCenterElements(){

    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20.0,),
        Icon(Icons.local_fire_department, color: Colors.white, size: 30.0,),
        SizedBox(height: 20.0,),
        _buildSecondBestText(),
        SizedBox(height: 30.0,),
        _buildCountBtn(),
        SizedBox(height: 40.0,),
        _buildFinishBtn(),
      ],
    );
  }
  Widget _buildSecondBestText(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Second-best".toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
        SizedBox(height: 5.0,),
        Text(
          "7 Reps".toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  Widget _buildCountBtn(){
    double ratio= 0.7;
    double height = MediaQuery.of(context).size.width*ratio;
    return FractionallySizedBox(
      widthFactor: ratio,
      child: GestureDetector(
        child: Container(
          height: height,
          child: Center(
            child: Text(
              count.toString(),
              style: TextStyle(
                fontSize: 110.0,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Color.fromRGBO(119, 139, 235, 0.6),
            border: Border.all(width: 6.0, color: Color.fromRGBO(243, 243, 243, 0.6)),
            borderRadius: BorderRadius.circular(height),
          ),
        ),
        onTap: (){
          setState(() {
            count ++;
          });
        },
      ),
    );
  }
  Widget _buildFinishBtn(){
    return Padding(
      padding: EdgeInsets.only(left: 40.0, right: 40.0),
      child: TextButton(
        child: Text(
          "finish".toUpperCase(),
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          backgroundColor: Colors.white,
        ),
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChallengeFinishPage()));
        },
      ),
    );
  }

  Widget _buildBestRecord(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Best Record".toUpperCase(),
              style: TextStyle(
                color: Colors.grey[200],
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "10 reps".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
