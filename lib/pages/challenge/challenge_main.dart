import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/constants.dart';
import 'package:woke_out/model/challenge_card_model.dart';
import 'package:woke_out/model/challenge_model.dart';
import 'package:woke_out/pages/challenge/challenge_ready.dart';
import 'package:woke_out/services/app_user_service.dart';
import 'package:woke_out/util.dart';

class ChallengeMainPage extends StatelessWidget {
  const ChallengeMainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController =
        PageController(initialPage: 0, viewportFraction: 0.9);
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.black,
          child: PageView.builder(
            controller: pageController,
            itemCount: 4,
            itemBuilder: (context, index) {
              return ChallengeCard(cardModel: cardsList[index]);
            },
          ),
        ),
      ),
    );
  }
}

class ChallengeCard extends StatefulWidget {
  final CardModel cardModel;

  ChallengeCard({Key key, this.cardModel}) : super(key: key);

  @override
  _ChallengeCardState createState() => _ChallengeCardState();
}

class _ChallengeCardState extends State<ChallengeCard> {
  List<ChallengeModel> challengeList = [];

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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    );
  }

  Widget _buildCardImageAndTitle() {
    return Stack(
      children: [_buildCardImage(), _buildTitle()],
    );
  }

  Widget _buildCardImage() {
    return AspectRatio(
      aspectRatio: 5 / 3,
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

  Widget _buildTitle() {
    return Positioned(
      child: Container(
        margin: EdgeInsets.only(left: 30.0),
        child: Row(
          children: [
            Container(
              height: 30.0,
              width: 5,
              color: widget.cardModel.color,
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              widget.cardModel.title.toUpperCase(),
              style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      bottom: 0,
    );
  }

  Widget _buildDescription() {
    return Container(
      padding: EdgeInsets.fromLTRB(30.0, 15.0, 5.0, 15.0),
      child: Text(
        widget.cardModel.description,
        style: TextStyle(color: Colors.white, fontSize: 14.0, height: 1.2),
      ),
    );
  }

  Widget _buildLowerPanel() {
    return Expanded(
      flex: 3,
      child: Stack(
        children: [_buildBestRecordSection(), _buildChallengeButton()],
      ),
    );
  }

  Widget _buildBestRecordSection() {
    final appUserService = Provider.of<AppUserService>(context, listen: false);

    return FutureBuilder<List<ChallengeModel>>(
      future: appUserService.getChallengeRecordsByName(widget.cardModel.title),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data.isNotEmpty) {
            challengeList = snapshot.data;

            return Padding(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    child: SvgPicture.asset(
                      "assets/icons/medal.svg",
                      width: 80,
                      height: 80,
                    ),
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
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        durationToString(snapshot.data[0].time),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 10.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        datetimeToString(snapshot.data[0].createdAt.toDate()),
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
          } else {
            return Center(child: Text("No record"));
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildChallengeButton() {
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
                fontWeight: FontWeight.bold),
          ),
          style: TextButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              padding: EdgeInsets.fromLTRB(70.0, 20.0, 70.0, 20.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0))),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ChallengeReadyPage(
                      challengeList: challengeList,
                      cardModel: widget.cardModel,
                    )));
          },
        ),
      ),
    );
  }
}
