import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/model/do_exercise_model.dart';
import 'package:woke_out/model/exercise_model.dart';

GlobalKey<_CountdownProgressIndicatorState> countdownProgressIndicatorKey =
    new GlobalKey<_CountdownProgressIndicatorState>();
// use global key storing countdown progress indicator state to access function like: pause, resume...

class DoExercisePage extends StatefulWidget {
  // List<int>
  @override
  _DoExercisePageState createState() => _DoExercisePageState();
}

class _DoExercisePageState extends State<DoExercisePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          _buildHalfPageTop(),
          _buildDoExerciseProgressBar(),
          _buildHalfPageLow()
        ],
      )),
    );
  }

  Widget _buildDoExerciseProgressBar() {
    return Consumer<ExercisePlayer>(
      builder: (context, player, child) {
        double progress = (player.currentIndex + 1) / player.length;
        return LinearProgressIndicator(value: progress);
      },
    );
  }

  Widget _buildHalfPageTop() {
    return Stack(children: <Widget>[
      AspectRatio(
        aspectRatio: 5 / 3,
        child: Container(
          decoration: BoxDecoration(color: Colors.teal),
          // child: _addData(),
        ),
      ),
      _buildGetBackButton(context)
    ]);
  }

  Widget _buildGetBackButton(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: TextButton(
        child: Icon(
          Icons.arrow_back,
          color: Colors.grey[800],
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        ),
        onPressed: () {
          getOutDoExercisePage();
        },
      ),
    );
  }

  void getOutDoExercisePage() {
    ExercisePlayer player = Provider.of<ExercisePlayer>(context, listen: false);
    player.reset();
    Navigator.of(context).pop();
  }

  Widget _buildHalfPageLow() {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        child: Stack(children: [
          Column(
            children: [
              SizedBox(
                height: 10.0,
              ),
              _buildTimeCountText(),
              SizedBox(
                height: 10.0,
              ),
              _buildExerciseDetailButton(),
              SizedBox(
                height: 30.0,
              ),
              _buildCountDownProgressIndicator(),
              SizedBox(
                height: 40.0,
              ),
              _buildDoneButton()
            ],
          ),
          _buildSkipButtons()
        ]),
      ),
    );
  }

  Widget _buildCountDownProgressIndicator() {
    return Consumer<ExercisePlayer>(
      builder: (context, player, child) {
        return new CountdownProgressIndicator(
          key: countdownProgressIndicatorKey,
          player: player,
        );
      },
    );
  }

  Widget _buildTimeCountText() {
    return Consumer<ExercisePlayer>(
      builder: (context, player, child) {
        String min = player.record.totalTime.getMinText();
        String sec = player.record.totalTime.getSecondText();
        return Text(
          "$min:$sec",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50.0),
        );
      },
    );
  }

  Widget _buildDoneButton() {
    // ExercisePlayer player = Provider.of<ExercisePlayer>(context);
    return Consumer<ExercisePlayer>(
      builder: (context, player, child) {
        String btnName = player.isAtLastExercise() ? "Finish" : "Done";
        return Padding(
          padding: const EdgeInsets.only(left: 60.0, right: 60.0),
          child: TextButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                Text(
                  btnName,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 25.0,
                      color: Colors.white),
                ),
              ],
            ),
            style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
            onPressed: () {
              doneEvent(player);
            },
          ),
        );
      },
    );
  }

  Widget _buildExerciseDetailButton() {
    return Consumer<ExercisePlayer>(
      builder: (context, player, child) {
        return TextButton(
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: player.currentExercise.name,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20.0,
                    color: Colors.black),
              ),
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(Icons.help_outline),
                ),
              )
            ]),
          ),
          style: TextButton.styleFrom(backgroundColor: Colors.transparent),
          onPressed: () {
            watchExerciseDetailEvent(player);
          },
        );
      },
    );
  }

  void watchExerciseDetailEvent(ExercisePlayer player) async {
    countdownProgressIndicatorKey.currentState.pause();
    var result = await Navigator.of(context)
        .pushNamed("exerciseDetailPage", arguments: player.currentExercise);
    if (result == "detail_back")
      countdownProgressIndicatorKey.currentState.resume();
  }

  Widget _buildSkipButtons() {
    double screenWidth = MediaQuery.of(context).size.width;
    return Positioned(
      bottom: 0,
      left: 0,
      width: screenWidth,
      height: 60.0,
      child: Row(children: [
        _buildSkipButton("previous"),
        Container(
          color: Colors.grey,
          width: 1.0,
          height: 30.0,
        ),
        _buildSkipButton("next"),
      ]),
    );
  }

  Widget _buildSkipButton(String type) {
    return Expanded(
      flex: 1,
      child: Consumer<ExercisePlayer>(
        builder: (context, player, child) {
          Color textCol = Colors.grey[700];
          Function event;
          IconData icon;
          String name;
          ExercisePlayer param = player;
          if (type == "next") {
            event = doneEvent;
            icon = Icons.skip_next_outlined;
            name = "Next";
            if (player.isAtLastExercise()) {
              textCol = Colors.grey[300];
              event = null;
              param = null;
            }
          } else if (type == "previous") {
            event = backToPrevious;
            icon = Icons.skip_previous_outlined;
            name = "Previous";
            if (player.currentIndex == 0) {
              textCol = Colors.grey[300];
              event = null;
              param = null;
            }
          }
          return _buildSkipButtonWithCondition({
            'name': name,
            'icon': icon,
            'color': textCol,
            'event': event,
            'param': param
          });
        },
      ),
    );
  }

  Widget _buildSkipButtonWithCondition(Map<String, dynamic> data) {
    return TextButton(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              data['icon'],
              color: data['color'],
            ),
          ),
          Text(
            data['name'],
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20.0,
                color: data['color']),
          ),
        ],
      ),
      style: TextButton.styleFrom(backgroundColor: Colors.transparent),
      onPressed: () {
        Function func = data['event'];
        ExercisePlayer param = data['param'];
        if (func != null) func(param);
      },
    );
  }

  void backToPrevious(ExercisePlayer player) {
    player.decreaseIndexByOne();
    Exercise previous = player.currentExercise;
    countdownProgressIndicatorKey.currentState.reset(previous.duration);
    // Navigator.of(context).pushReplacementNamed("doExercisePage");
  }

  void doneEvent(ExercisePlayer player) {
    if (player.isAtLastExercise()) {
      Navigator.of(context).pushReplacementNamed("resultPage");
    } else {
      Navigator.of(context).pushReplacementNamed("restPage", arguments: player);
    }
  }
}

class CountdownProgressIndicator extends StatefulWidget {
  final ExercisePlayer player;

  CountdownProgressIndicator({Key key, @required this.player})
      : super(key: key);
  @override
  _CountdownProgressIndicatorState createState() =>
      _CountdownProgressIndicatorState(player);
}

class _CountdownProgressIndicatorState extends State<CountdownProgressIndicator>
    with TickerProviderStateMixin {
  ExercisePlayer player;
  int duration;
  _CountdownProgressIndicatorState(ExercisePlayer inputPlayer) {
    this.player = inputPlayer;
    this.duration = player.currentExercise.duration;
  }
  AnimationController _controller;
  Timer _timer;
  double size = 130.0;
  double textSize = 50.0;

  void startCounting() {
    const interval = Duration(seconds: 1);
    _timer = Timer.periodic(interval, (timer) {
      if (duration > 0) {
        setState(() {
          duration--;
          player.increaseTotalTimeByOne();
          //  update total time in player;
        });
      } else {
        setState(() {
          this._timer.cancel();
          nextAction();
        });
      }
    });
  }

  void nextAction() {
    if (player.currentIndex < player.length - 1) {
      // player.increaseIndexByOne();
      Navigator.of(context).pushReplacementNamed("restPage", arguments: player);
    } else {
      //  complete exercise
      Navigator.of(context).pushNamed("resultPage");
      //  reset
    }
  }

  void pause() {
    _controller.stop();
    _timer.cancel();
  }

  void resume() {
    _controller.forward();
    startCounting();
  }

  void initController() {}
  void reset(int inputDur) {
    setState(() {
      this.duration = inputDur;
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: this.duration))
      ..addListener(() {
        setState(() {
          if (_controller.isCompleted) _controller.stop();
        });
      });
    _controller.forward();
    startCounting();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: this.size,
          height: this.size,
          child: CircularProgressIndicator(
            value: _controller.value,
            strokeWidth: 8.0,
            backgroundColor: Colors.grey[200],
          ),
        ),
        Container(
          width: this.size,
          height: this.size,
          child: Center(
            child: Text(
              "$duration",
              style: TextStyle(
                  fontSize: this.textSize, fontWeight: FontWeight.w600),
            ),
          ),
        )
      ],
    );
  }
}
