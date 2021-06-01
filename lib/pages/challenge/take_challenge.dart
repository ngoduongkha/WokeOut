import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woke_out/model/challenge_card_model.dart';
import 'package:woke_out/model/challenge_model.dart';
import 'package:woke_out/pages/challenge/challenge_ready.dart';
import 'package:woke_out/services/app_user_service.dart';
import 'package:woke_out/util.dart';

import 'challenge_finish.dart';

class TakeChallengePage extends StatefulWidget {
  final List<ChallengeModel> challengeList;
  final CardModel cardModel;

  const TakeChallengePage({
    Key key,
    @required this.challengeList,
    @required this.cardModel,
  }) : super(key: key);

  @override
  _TakeChallengePageState createState() => _TakeChallengePageState();
}

class _TakeChallengePageState extends State<TakeChallengePage> {
  bool flag = true;
  int duration = 0;
  Stream<int> timerStream;
  StreamSubscription<int> timerSubscription;

  Stream<int> stopWatchStream() {
    StreamController<int> streamController;
    Timer timer;
    Duration timerInterval = Duration(seconds: 1);
    int counter = 0;

    void stopTimer() {
      if (timer != null) {
        timer.cancel();
        timer = null;
        counter = 0;
        streamController.close();
      }
    }

    void tick(_) {
      counter++;
      streamController.add(counter);
      if (!flag) {
        stopTimer();
      }
    }

    void startTimer() {
      timer = Timer.periodic(timerInterval, tick);
    }

    streamController = StreamController<int>(
      onListen: startTimer,
      onCancel: stopTimer,
      onResume: startTimer,
      onPause: stopTimer,
    );

    return streamController.stream;
  }

  @override
  void initState() {
    timerStream = stopWatchStream();
    timerSubscription = timerStream.listen((int newTick) {
      setState(() {
        duration = newTick;
      });
    });

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
          body: Stack(
            children: [_buildCenterElements(), _buildBestRecord()],
          )),
    );
  }

  Widget _buildCenterElements() {
    ChallengeModel secondBestRecord =
        findSecondBestRecord(widget.challengeList);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          durationToString(duration),
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 80.0),
        ),
        SizedBox(
          height: 35.0,
        ),
        secondBestRecord != null
            ? Icon(
                Icons.local_fire_department,
                color: Colors.white,
                size: 30.0,
              )
            : SizedBox(),
        SizedBox(
          height: 10.0,
        ),
        secondBestRecord != null
            ? Column(
                children: [
                  Text(
                    "Second-best".toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    durationToString(secondBestRecord.time),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            : SizedBox(),
        SizedBox(
          height: 60.0,
        ),
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
                    borderRadius: BorderRadius.circular(40.0)),
                backgroundColor: Colors.white),
            onPressed: () {
              timerSubscription.cancel();
              timerStream = null;

              ChallengeModel record = ChallengeModel(
                  name: widget.cardModel.title,
                  time: duration,
                  createdAt: Timestamp.now());

              AppUserService().addChallengeRecord(record);

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ChallengeFinishPage(
                        cardModel: widget.cardModel,
                        challengeList: widget.challengeList,
                        newRecord: record,
                      )));
            },
          ),
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
              "Best Record".toUpperCase(),
              style: TextStyle(
                  color: Colors.grey[200], fontWeight: FontWeight.bold),
            ),
            (widget.challengeList.isNotEmpty)
                ? Text(
                    durationToString(widget.challengeList[0].time),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w900),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
