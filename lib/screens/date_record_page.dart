

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateRecordPage extends StatefulWidget {
  const DateRecordPage({Key key}) : super(key: key);

  @override
  _DateRecordPageState createState() => _DateRecordPageState();
}

class _DateRecordPageState extends State<DateRecordPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("record", style: TextStyle(color: Colors.black),),
        leading: Icon(Icons.arrow_back, color: Colors.black,),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGeneralInfoPanel(),
          Container(
            height: 1,
            color: Colors.grey[500],
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "ExerciseSets",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          _buildExerciseSetsList()
        ],
      ),
    );
  }
  Widget _buildGeneralInfoPanel(){
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildGeneralInfoItem(Icons.stacked_bar_chart, "Total exercise", 20, Colors.grey[500]),
          _buildGeneralInfoItem(Icons.local_fire_department_outlined, "Calories", 150, Colors.red),
          _buildGeneralInfoItem(Icons.star, "Average score", 5.5, Colors.amber)
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
            fontWeight: FontWeight.bold
          ),
        )
      ],
    );
  }
  Widget _buildExerciseSetsList(){
    return Expanded(
      flex: 5,
      child: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index){
          return _buildExerciseSetDetailPanel();
        },
      ),
    );
  }
  Widget _buildExerciseSetDetailPanel(){
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(10.0),
        title: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "May 13, 2021 at 3:31:00",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.grey[500]
                ),
              ),
              Text(
                "Chest-beginner",
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
              Column(
                children: [
                  SizedBox(height: 10.0,),
                  _buildInfoItemRow(),
                  SizedBox(height: 5.0,),
                  _buildInfoItemRow()
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildInfoItemRow(){
    return Row(
      children: [
        _buildInfoItem(Icons.access_time, "Time: 152"),
        _buildInfoItem(Icons.star, "Score: 5")
      ],
    );
  }
  Widget _buildInfoItem(IconData icon, String text){
    return Expanded(
      flex: 1,
      child: Row(
        children: [
          Icon(
            icon,
            size: 30.0,
            color: Colors.amber,
          ),
          SizedBox(width: 10.0,),
          Text(text)
        ],
      ),
    );
  }
}

