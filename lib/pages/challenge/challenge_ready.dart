
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woke_out/pages/challenge/take_challenge.dart';

class ChallengeReadyPage extends StatefulWidget {
  const ChallengeReadyPage({Key key}) : super(key: key);

  @override
  _ChallengeReadyPageState createState() => _ChallengeReadyPageState();
}

class _ChallengeReadyPageState extends State<ChallengeReadyPage> {
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
        body: Column(
          children: [
            _buildChallengeImage(),
            _buildLowerPanel()
          ],
        )
      ),
    );
  }
  Widget _buildChallengeImage(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: AspectRatio(
        aspectRatio: 5/3,
        child: Image.asset(
          "assets/images/plank.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
  Widget _buildLowerPanel(){
    return Expanded(
      flex: 1,
      child: Stack(
        children: [
          _buildLowerPanelTopElements(),
          _buildBestRecord()
        ],
      ),
    );
  }
  Widget _buildLowerPanelTopElements(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
          child: Text(
            "Plank challenge".toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 40.0),
          child: Text(
            "Challenge yourself and hold as long as you can.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
        TextButton(
          child: Text(
            "Start".toUpperCase(),
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold
            ),
          ),
          style: TextButton.styleFrom(
            padding: EdgeInsets.fromLTRB(90.0, 13.0, 90.0, 13.0),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40.0)
            )
          ),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> TakeChallengePage()));
          },
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
              "Best record".toUpperCase(),
              style: TextStyle(
                color: Colors.grey[200],
                fontSize: 16.0
              ),
            ),
            Text(
              "00:19".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w900
              ),
            )
          ],
        ),
      ),
    );
  }
}
