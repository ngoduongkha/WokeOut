import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/constants.dart';
import 'package:woke_out/model/exercise_record_model.dart';
import 'package:woke_out/services/auth_service.dart';
import 'package:woke_out/services/exercise_record_service.dart';

class DateRecordPage extends StatefulWidget {
  final DateTime today;
  DateRecordPage({@required this.today});

  @override
  _DateRecordPageState createState() => _DateRecordPageState();
}

class _DateRecordPageState extends State<DateRecordPage> {

  ExerciseRecordService recordService;

  @override
  void initState() {
    AuthService auth = Provider.of<AuthService>(context, listen: false);
    recordService = ExerciseRecordService(userId: auth.currentUser().uid);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String date = "${widget.today.day}-${widget.today.month}-${widget.today.year}";

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(date, style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),),
          leading: GestureDetector(
            child: Icon(Icons.chevron_left, color: kTextColor, size: 30.0,),
            onTap: (){
              setState(() {
                Navigator.of(context).pop();
              });
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGeneralInfoPanel(),
              SizedBox(height: 10.0,),
              Container(
                height: 2,
                color: kActiveIconColor,
              ),

              _buildExerciseSetsList()
            ],
          ),
        ),
      ),
    );
  }

  double getTotalCalorie(List<RecordModel> records){
    double total = 0;
    records.forEach((record) {
      total+= record.calorie;
    });
    return total;
  }
  double getAvgScore(List<RecordModel> records){
    if(records.length == 0) return 0;
    else{
      double totalScore = 0;
      records.forEach((record) {
        totalScore+= record.score;
      });
      return totalScore/records.length;
    }
  }
  Widget _buildGeneralInfoPanel(){
    return FutureBuilder<List<RecordModel>>(
        future: recordService.getRecordsByDate(widget.today),
        builder: (BuildContext context, AsyncSnapshot<List<RecordModel>> snapshot){
          if(snapshot.hasData){

            double totalCalorie = getTotalCalorie(snapshot.data);
            double avgScore = getAvgScore(snapshot.data);
            return _buildGeneralInfoPanelWithData(snapshot.data.length, totalCalorie, avgScore);
          }else{
            return CircularProgressIndicator();
          }
        }
    );
  }
  Widget _buildGeneralInfoPanelWithData(int totalExercise, double calories, double avgScore){
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildGeneralInfoItem(Icons.stacked_bar_chart, "Total exercise", totalExercise, kActiveIconColor),
          _buildGeneralInfoItem(Icons.local_fire_department_outlined, "Calories", calories.toStringAsFixed(1), kActiveIconColor),
          _buildGeneralInfoItem(Icons.star, "Average score", avgScore.toStringAsFixed(1), kActiveIconColor)
        ],
      ),
    );
  }
  Widget _buildGeneralInfoItem(IconData icon, String title, dynamic value, Color color){
    return Column(
      children: [
        Icon(
          icon,
          size: 40.0,
          color: color,
        ),
        SizedBox(height: 10.0,),
        Text(
            title
        ),
        SizedBox(height: 5.0,),
        Text(
          value.toString(),
          style: TextStyle(
            color: Colors.grey[800],
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
  Widget _buildExerciseSetsList(){
    return FutureBuilder(
      future: recordService.getRecordsByDate(widget.today),
      builder: (context, snapshot){
        if(snapshot.hasData){
          return Expanded(
            flex: 5,
            child: Container(
              color: kBackgroundColor,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        "Your Exercises",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index){
                        return _buildExerciseSetDetailPanel(snapshot.data[index]);
                      },
                      childCount: snapshot.data.length,
                    ),
                  )
                ],
              )
            ),
          );
        }else{
          return CircularProgressIndicator();
        }
      },
    );
  }
  Widget _buildExerciseSetDetailPanel(RecordModel record){
    DateTime recordDate = DateTime.fromMillisecondsSinceEpoch(record.timeStamp.seconds*1000);
    return Card(
      margin: EdgeInsets.all(10.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(10.0),
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "# ${recordDate.toString()}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.grey[500]
                ),
              ),
              Text(
                "${record.exName.toUpperCase()} - ${record.exLevel}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0
                ),
              ),
              SizedBox(height: 10.0,),
              Container(
                height: 1,
                color: Colors.grey[600],
              ),
              _buildInfoItems(record)
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildInfoItems(RecordModel record){
    return Column(
      children: [
        SizedBox(height: 10.0,),
        Row(
          children: [
            Expanded(flex: 5, child: _buildInfoItem(Icons.access_time, "Time: ${record.totalTime.getTimeText()}")),
            Expanded(flex: 3, child: _buildInfoItem(Icons.star, "Score: ${record.score}")),
          ],
        ),
        SizedBox(height: 5.0,),
        Row(
          children: [
            Expanded(flex: 5, child: _buildInfoItem(Icons.local_fire_department_outlined, "Calories: ${record.calorie}")),
            Expanded(flex: 3, child: _buildInfoItem(_getRatingIcon(record.satisfactionLevel), "Rating: ${record.satisfactionLevel}")),
          ],
        ),
      ],
    );
  }
  Widget _buildInfoItem(IconData icon, String text){
    return Row(
      children: [
        Icon(
          icon,
          size: 25.0,
          color: kBlueColor,
        ),
        SizedBox(width: 10.0,),
        Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),)
      ],
    );
  }
  IconData _getRatingIcon(int index){
    final items = [
      Icons.sentiment_very_dissatisfied_outlined,
      Icons.sentiment_dissatisfied_outlined,
      Icons.sentiment_satisfied,
      Icons.sentiment_satisfied_alt,
      Icons.sentiment_very_satisfied_sharp,
    ];
    return items[index];
  }
}

