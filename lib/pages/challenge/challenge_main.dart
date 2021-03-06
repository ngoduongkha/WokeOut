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
        body: PageView.builder(
          controller: pageController,
          itemCount: 4,
          itemBuilder: (context, index) {
            return ChallengeCard(cardModel: cardsList[index]);
          },
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
  List<ChallengeModel> _challengeList = [];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 15.0),
      color: kChallengeCardColor,
      child: Stack(
        children: [
          _buildScrollPanel(),
          _buildChallengeButton(),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      // put image inside card to see card corner
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    );
  }

  Widget _buildScrollPanel() {
    final screenWidth = MediaQuery.of(context).size.width;
    final appUserService = Provider.of<AppUserService>(context, listen: true);

    return StreamBuilder<List<ChallengeModel>>(
      stream: appUserService.getChallengeRecordsByName(widget.cardModel.title),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _challengeList = snapshot.data;
          _challengeList.sort((a, b) => b.time.compareTo(a.time));

          return CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildCardImageAndTitle(),
                    _buildDescription(),
                    Container(
                      height: 1.0,
                      color: Colors.grey,
                      width: 0.8 * screenWidth,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: _challengeList.isNotEmpty
                    ? _buildBestRecordSection(_challengeList[0])
                    : _buildNoDataPanel(),
              ),
              _challengeList.length >= 2
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return _buildRecordItem(_challengeList, index);
                        },
                        childCount: _challengeList.length - 1,
                      ),
                    )
                  : SliverToBoxAdapter(child: Container()),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 70.0,
                ),
              )
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildCardImageAndTitle() {
    return Stack(
      children: [
        _buildCardImage(),
        _buildTitle(),
      ],
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
                  fontSize: 32.0,
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
      padding: EdgeInsets.fromLTRB(30.0, 15.0, 15.0, 15.0),
      child: Text(
        widget.cardModel.description,
        style: TextStyle(color: Colors.white, fontSize: 14.0, height: 1.2),
      ),
    );
  }

  Widget _buildBestRecordSection(ChallengeModel bestRecord) {
    final size = MediaQuery.of(context).size;

    return Padding(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            child: SvgPicture.asset(
              "assets/icons/medal.svg",
              width: 60,
              height: 60,
            ),
            padding: EdgeInsets.only(
              right: 20.0,
              top: 10.0,
              left: 3.0,
            ),
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
              widget.cardModel.category == Category.stop_watch
                  ? Text(
                      durationToString(bestRecord.time),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold),
                    )
                  : Text(
                      "${bestRecord.time} REPS",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold),
                    ),
              Container(
                height: 10.0,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                datetimeToString(bestRecord.createdAt.toDate()),
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

  Widget _buildChallengeButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          color: kChallengeCardColor,
          height: 70.0,
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Padding(
            padding: EdgeInsets.only(left: 25.0, right: 25.0),
            child: TextButton(
              child: Text(
                "challenge".toUpperCase(),
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              style: TextButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChallengeReadyPage(
                        cardModel: widget.cardModel,
                        challengeList: _challengeList),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecordItem(List<ChallengeModel> challengeList, int index) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: widget.cardModel.category == Category.stop_watch
                  ? Text(
                      durationToString(challengeList[index + 1].time),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    )
                  : Text(
                      "${challengeList[index + 1].time} REPS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.0,
              ),
              Container(
                height: 10.0,
                width: challengeList[index + 1].time == challengeList[0].time
                    ? size.width * 0.5
                    : challengeList[index + 1].time != 0
                        ? (challengeList[index + 1].time /
                                challengeList[0].time) *
                            size.width *
                            0.5
                        : 0,
                decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                datetimeToString(challengeList[index + 1].createdAt.toDate()),
                style: TextStyle(color: Colors.white, fontSize: 14.0),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildNoDataPanel() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/icons/no-data-medal.svg",
            width: 100.0,
            height: 100.0,
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "NO RECORDS YET",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Create your first record now",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
