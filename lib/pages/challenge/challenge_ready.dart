import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/constants.dart';
import 'package:woke_out/model/challenge_card_model.dart';
import 'package:woke_out/model/challenge_model.dart';
import 'package:woke_out/pages/challenge/take_challenge_count.dart';
import 'package:woke_out/pages/challenge/take_challenge_stopwatch.dart';
import 'package:woke_out/util.dart';

class ChallengeReadyPage extends StatefulWidget {
  final CardModel cardModel;

  ChallengeReadyPage({
    Key key,
    @required this.cardModel,
  }) : super(key: key);

  @override
  _ChallengeReadyPageState createState() => _ChallengeReadyPageState();
}

class _ChallengeReadyPageState extends State<ChallengeReadyPage> {
  List<ChallengeModel> _challengeList = [];

  @override
  void initState() {
    final challengeNotifier =
        Provider.of<ChallengeNotifier>(context, listen: false);
    _challengeList = challengeNotifier.challengeList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            kChallengeCardColor,
            kBackgroundColor,
          ])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "${widget.cardModel.title.capitalizeFirstofEach} Challenge",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: GestureDetector(
              child: Icon(
                Icons.chevron_left,
                size: 35.0,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            elevation: 0,
          ),
          body: Column(
            children: [_buildChallengeImage(), _buildLowerPanel()],
          )),
    );
  }

  Widget _buildChallengeImage() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: AspectRatio(
        aspectRatio: 5 / 3,
        child: Image.asset(
          widget.cardModel.image,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildLowerPanel() {
    return Expanded(
      flex: 1,
      child: Stack(
        children: [
          _buildLowerPanelTopElements(),
          _challengeList.isNotEmpty ? _buildBestRecord() : SizedBox(),
        ],
      ),
    );
  }

  Widget _buildLowerPanelTopElements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
          child: Text(
            "${widget.cardModel.title} challenge".toUpperCase(),
            style: TextStyle(
              color: kActiveIconColor,
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 40.0),
          child: Text(
            widget.cardModel.instruction,
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
                color: kPrimaryColor,
                fontWeight: FontWeight.bold),
          ),
          style: TextButton.styleFrom(
              padding: EdgeInsets.fromLTRB(90.0, 13.0, 90.0, 13.0),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0))),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => widget.cardModel.category !=
                        Category.count
                    ? TakeChallengeStopWatchPage(cardModel: widget.cardModel)
                    : TakeChallengeCountPage(cardModel: widget.cardModel),
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildBestRecord() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Best record".toUpperCase(),
              style: TextStyle(color: kActiveIconColor, fontSize: 16.0),
            ),
            (_challengeList.isNotEmpty)
                ? widget.cardModel.category == Category.stop_watch
                    ? Text(durationToString(_challengeList[0].time),
                        style: TextStyle(
                            color: kActiveIconColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900))
                    : Text("${_challengeList[0].time} REPS",
                        style: TextStyle(
                            color: kActiveIconColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900))
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
