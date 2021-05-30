import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChallengeFinishPage extends StatefulWidget {
  const ChallengeFinishPage({Key key}) : super(key: key);

  @override
  _ChallengeFinishPageState createState() => _ChallengeFinishPageState();
}

class _ChallengeFinishPageState extends State<ChallengeFinishPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Column(
          children: [
            _buildHaftTopPanel(),
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 40.0,
                    ),
                    _buildCompareText(),
                    SizedBox(
                      height: 60.0,
                    ),
                    _buildChallengeAgainButton(),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildFinishButton()
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildHaftTopPanel() {
    return Expanded(
        flex: 1,
        child: Stack(
          children: [
            _buildImage(),
            _buildText(),
          ],
        ));
  }

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 1,
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

  Widget _buildText() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Positioned(
      width: screenWidth,
      bottom: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Opacity(
            opacity: 0.8,
            child: Text(
              "plank challenge".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            "challenge completed!".toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            "00:49",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 60.0),
          ),
        ],
      ),
    );
  }

  Widget _buildCompareText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "-11 Secs",
          style: TextStyle(
              color: Colors.deepOrangeAccent,
              fontSize: 20.0,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          "VS BEST",
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _buildChallengeAgainButton() {
    return Padding(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextButton(
        child: Text(
          "Challenge Again",
          style: TextStyle(
              fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        style: TextButton.styleFrom(
            padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0))),
        onPressed: () {},
      ),
    );
  }

  Widget _buildFinishButton() {
    return Padding(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextButton(
        child: Text(
          "Finish",
          style: TextStyle(
              fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
          backgroundColor: Colors.blueAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
        ),
        onPressed: () {},
      ),
    );
  }
}
