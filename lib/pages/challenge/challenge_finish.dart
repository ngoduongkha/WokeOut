import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woke_out/constants.dart';
import 'package:woke_out/model/challenge_card_model.dart';
import 'package:woke_out/model/challenge_model.dart';
import 'package:woke_out/util.dart';
import 'package:confetti/confetti.dart';

class ChallengeFinishPage extends StatefulWidget {
  final CardModel cardModel;
  final ChallengeModel newRecord;
  final List<ChallengeModel> challengeList;

  const ChallengeFinishPage({
    Key key,
    @required this.newRecord,
    @required this.cardModel,
    @required this.challengeList,
  }) : super(key: key);

  @override
  _ChallengeFinishPageState createState() => _ChallengeFinishPageState();
}

class _ChallengeFinishPageState extends State<ChallengeFinishPage> {
  ConfettiController _confettiController;

  @override
  void initState() {
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 10));

    int index = 0;

    widget.challengeList.forEach((element) {
      if (element.time > widget.newRecord.time) {
        index++;
      }
    });

    widget.challengeList.insert(index, widget.newRecord);

    if (widget.newRecord.time == widget.challengeList[0].time) {
      _confettiController.play();
    }

    super.initState();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kChallengeCardColor,
        child: Column(
          children: [
            _buildHaftTopPanel(),
            Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 40.0),
                    _buildCompareText(),
                    SizedBox(height: 60.0),
                    SizedBox(height: 60.0),
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
          widget.cardModel.image,
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
              "${widget.cardModel.title} challenge".toUpperCase(),
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
            widget.newRecord.time == widget.challengeList[0].time
                ? "new record!".toUpperCase()
                : "challenge completed!".toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality
                  .explosive, // don't specify a direction, blast randomly
              shouldLoop:
                  true, // start again as soon as the animation is finished
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ], // manually specify the colors to be used
              createParticlePath: drawStar, // define a custom shape/path.
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            durationToString(widget.challengeList[0].time),
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
          widget.challengeList.length == 1
              ? "0 Secs"
              : widget.newRecord.time < widget.challengeList[0].time
                  ? "${widget.newRecord.time - widget.challengeList[0].time} Secs"
                  : widget.newRecord.time > widget.challengeList[0].time
                      ? "+${widget.newRecord.time - widget.challengeList[0].time} Secs"
                      : "0 Secs",
          style: TextStyle(
              color: widget.newRecord.time < widget.challengeList[0].time
                  ? kActiveIconColor
                  : widget.newRecord.time > widget.challengeList[0].time
                      ? kPrimaryColor
                      : Colors.white,
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

  Widget _buildFinishButton() {
    int count = 0;

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
          backgroundColor: kPrimaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
        ),
        onPressed: () {
          Navigator.of(context).popUntil((_) => count++ >= 3);
        },
      ),
    );
  }
}
