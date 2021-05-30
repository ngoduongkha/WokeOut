

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'challenge_finish.dart';

class TakeChallengePage extends StatefulWidget {
  const TakeChallengePage({Key key}) : super(key: key);

  @override
  _TakeChallengePageState createState() => _TakeChallengePageState();
}

class _TakeChallengePageState extends State<TakeChallengePage> {
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
          ]
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Plank challenge",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "00:49",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 80.0
          ),
        ),
        SizedBox(height: 35.0,),
        Icon(Icons.local_fire_department, color: Colors.white, size: 30.0,),
        SizedBox(height: 10.0,),
        Column(
          children: [
            Text(
              "Second-best".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0
              ),
            ),
            SizedBox(height: 5.0,),
            Text(
              "00:16".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
        SizedBox(height: 60.0,),
        Padding(
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
                  borderRadius: BorderRadius.circular(40.0)
              ),
              backgroundColor: Colors.white
            ),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChallengeFinishPage()));
            },
          ),
        )
      ],
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
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "00:19".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w900
              ),
            ),
          ],
        ),
      ),
    );
  }
}
