import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/model/challenge_card_model.dart';
import 'package:woke_out/model/challenge_model.dart';
import 'package:woke_out/services/app_user_service.dart';
import 'package:woke_out/util.dart';

import 'challenge_finish.dart';

class TakeChallengeCountPage extends StatefulWidget {
  final CardModel cardModel;

  const TakeChallengeCountPage({
    Key key,
    @required this.cardModel,
  }) : super(key: key);

  @override
  _TakeChallengeCountPageState createState() => _TakeChallengeCountPageState();
}

class _TakeChallengeCountPageState extends State<TakeChallengeCountPage> {
  int count = 0;
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
            "${widget.cardModel.title.capitalizeFirstofEach} Challenge",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
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
        body: Stack(
          children: [
            _buildCenterElements(),
            _challengeList.isNotEmpty ? _buildBestRecord() : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _buildCenterElements() {
    ChallengeModel secondBestRecord = findSecondBestRecord(_challengeList);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        secondBestRecord != null
            ? Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Icon(
                    Icons.local_fire_department,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  _buildSecondBestText(),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              )
            : SizedBox(height: 90.0),
        _buildCountBtn(),
        SizedBox(height: 40.0),
        _buildFinishBtn(),
      ],
    );
  }

  Widget _buildSecondBestText() {
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
        SizedBox(
          height: 5.0,
        ),
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

  Widget _buildCountBtn() {
    double ratio = 0.7;
    double height = MediaQuery.of(context).size.width * ratio;
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
            border: Border.all(
                width: 6.0, color: Color.fromRGBO(243, 243, 243, 0.6)),
            borderRadius: BorderRadius.circular(height),
          ),
        ),
        onTap: () {
          setState(() {
            count++;
          });
        },
      ),
    );
  }

  Widget _buildFinishBtn() {
    final challengeNotifier =
        Provider.of<ChallengeNotifier>(context, listen: false);

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
        onPressed: () {
          ChallengeModel record = ChallengeModel(
              name: widget.cardModel.title,
              time: count,
              createdAt: Timestamp.now());

          AppUserService().addChallengeRecord(record);
          challengeNotifier.addChallenge(record);

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChallengeFinishPage(
                  newRecord: record, cardModel: widget.cardModel)));
        },
      ),
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
              "Best Record".toUpperCase(),
              style: TextStyle(
                color: Colors.grey[200],
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${_challengeList[0].time} reps".toUpperCase(),
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
