import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/constants.dart';
import 'package:woke_out/model/challenge_card_model.dart';
import 'package:woke_out/model/challenge_model.dart';
import 'package:woke_out/util.dart';

class ChallengeFinishPage extends StatefulWidget {
  final CardModel cardModel;
  final ChallengeModel newRecord;

  const ChallengeFinishPage({
    Key key,
    @required this.newRecord,
    @required this.cardModel,
  }) : super(key: key);

  @override
  _ChallengeFinishPageState createState() => _ChallengeFinishPageState();
}

class _ChallengeFinishPageState extends State<ChallengeFinishPage> {
  List<ChallengeModel> _challengeList = [];

  @override
  void initState() {
    final ChallengeNotifier challengeNotifier =
        Provider.of<ChallengeNotifier>(context, listen: false);
    _challengeList = challengeNotifier.challengeList;
    super.initState();
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
            _challengeList[0].time <= _challengeList[0].time
                ? "challenge completed!".toUpperCase()
                : "new record!".toUpperCase(),
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
            durationToString(_challengeList[0].time),
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
          _challengeList.length == 1
              ? "0 Secs"
              : widget.newRecord.time < _challengeList[0].time
                  ? "${widget.newRecord.time - _challengeList[0].time} Secs"
                  : widget.newRecord.time > _challengeList[0].time
                      ? "+${widget.newRecord.time - _challengeList[0].time} Secs"
                      : "0 Secs",
          style: TextStyle(
              color: widget.newRecord.time < _challengeList[0].time
                  ? kActiveIconColor
                  : widget.newRecord.time > _challengeList[0].time
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

  Widget _buildChallengeAgainButton() {
    int count = 0;

    return Padding(
      padding: EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextButton(
        child: Text(
          "Challenge Again",
          style: TextStyle(
              fontSize: 22.0, color: kTextColor, fontWeight: FontWeight.bold),
        ),
        style: TextButton.styleFrom(
            padding: EdgeInsets.only(top: 18.0, bottom: 18.0),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0))),
        onPressed: () {
          Navigator.of(context).popUntil((_) => count++ >= 2);
        },
      ),
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
