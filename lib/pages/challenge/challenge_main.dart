
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'challenge_ready.dart';


class ChallengeMainPage extends StatelessWidget {
  const ChallengeMainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: 0, viewportFraction: 0.9);
    return SafeArea(
      child: Scaffold(
          body: Container(
            color: Colors.black,
            child: PageView.builder(
              controller: pageController,
              itemCount: 3,
              itemBuilder: (context, index){
                return ChallengeCard();
              },
            ),
          )
      ),
    );
  }
}


class ChallengeCard extends StatefulWidget {
  const ChallengeCard({Key key}) : super(key: key);

  @override
  _ChallengeCardState createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<ChallengeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
      color: Colors.grey[800],
      child: Column(
        children: [
          _buildCardImageAndTitle(),
          _buildDescription(),
          Container(
            height: 1.0,
            color: Colors.grey,
          ),
          // break line
          _buildLowerPanel()
        ],
      ),
      clipBehavior: Clip.antiAlias,
      // put image inside card to see card corner
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
    );
  }
  Widget _buildCardImageAndTitle(){
    return Stack(
      children: [
        _buildCardImage(),
        _buildTitle()
      ],
    );
  }
  Widget _buildCardImage(){
    return AspectRatio(
      aspectRatio: 5/3,
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.center,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.transparent],
          ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
        },
        blendMode: BlendMode.dstIn,
        child: Image.asset(
          'assets/images/plank.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
  Widget _buildTitle(){
    return Positioned(
      child: Container(
        margin: EdgeInsets.only(left: 30.0),
        child: Row(
          children: [
            Container(
              height: 30.0,
              width: 5,
              color: Colors.redAccent,
            ),
            SizedBox(width: 5.0,),
            Text(
              "Plank".toUpperCase(),
              style: TextStyle(
                fontSize: 35.0,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
      bottom: 0,
    );
  }

  Widget _buildDescription(){
    return Container(
      padding: EdgeInsets.fromLTRB(30.0, 15.0, 5.0, 15.0),
      child: Text(
        "The brazen arrest of a Belarusian activist has terrified dissidents around the world. Their fears are unlikely",
        style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            height: 1.2
        ),
      ),
    );
  }

  Widget _buildLowerPanel(){
    return Expanded(
      flex: 3,
      child: Stack(
        children: [
          _buildBestRecordSection(),
          _buildChallengeButton()
        ],
      ),
    );
  }
  Widget _buildBestRecordSection(){
    return Padding(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            child: Icon(Icons.home, size: 60.0, color: Colors.white,),
            padding: EdgeInsets.only(right: 20.0),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Best Record".toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "00:49",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              Container(
                height: 10.0,
                width: 200.0,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 5.0,),
              Text(
                "May 12, 2021 04:09 PM",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
      padding: EdgeInsets.all(15.0),
    );
  }
  Widget _buildChallengeButton(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: TextButton(
          child: Text(
            "challenge".toUpperCase(),
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            padding: EdgeInsets.fromLTRB(70.0, 20.0, 70.0, 20.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
            )
          ),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ChallengeReadyPage()));
          },
        ),
      ),
    );
  }
}
