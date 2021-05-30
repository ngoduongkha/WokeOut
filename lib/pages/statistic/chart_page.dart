
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:woke_out/model/exercise_record_model.dart';
import 'package:woke_out/services/exercise_record_service.dart';

class ChartMainPage extends StatefulWidget {
  const ChartMainPage({Key key}) : super(key: key);

  @override
  _ChartMainPageState createState() => _ChartMainPageState();
}

class _ChartMainPageState extends State<ChartMainPage> {
  final service = ExerciseRecordService();
  DateTime currentMonth = DateTime.now();
  List<RecordModel> currentMonthRecords = [];
  List<FlSpot> dataPoints = [];
  double maxY = 20.0;
  double weight = 1;
  // use weight to control maxY limit if it get too big
  String category = "Calorie";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder(
          // service.getRecordsByMonth(DateTime.utc(2021, 5, 1))
        future: service.getRecordsByMonth(currentMonth),
        builder: (context, snapshot){
          if(snapshot.hasData){
            currentMonthRecords = snapshot.data;
            _updateDataWithCategory();
            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 10.0,),
                  _buildSelectionPanel(),
                  SizedBox(height: 10.0,),
                  _buildChartWrapper()
                ]
              ),
            );
          }else return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
  void _updateDataWithCategory(){
    switch(category){
      case "Calorie":
        _updateChartDataCalorie();
        break;
      case "Time":
        _updateChartDataTime();
        break;
      case "Score":
        _updateChartDataScore();
        break;
    }
  }
  Widget _buildSelectionPanel(){
    return Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Column(
        children: [
          Row(
            children: [
              _buildSelectingLabel("Category: "),
              _buildCategoryMenu(),
            ],
          ),
          SizedBox(height: 10.0,),
          Row(
            children: [
              _buildSelectingLabel("Month: "),
              _buildDatePickerButton(),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildSelectingLabel(String text){
    return Container(
      width: 80.0,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  Widget _buildCategoryMenu(){
    return Container(
      width: 160.0,
      height: 42.0,
      padding: EdgeInsets.only(left: 20.0, right: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(40.0),

      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: category,
        icon: const Icon(Icons.keyboard_arrow_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.grey[800], fontSize: 16.0),
        underline: Container(height: 0, color: Colors.blueAccent,),
        onChanged: (String newValue) {
          setState(() {
            category = newValue;
          });
        },
        items: <String>['Calorie', 'Time', 'Score']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
  Widget _buildDatePickerButton(){
    return Container(
      width: 160.0,
      child: TextButton(
        child: Row(
          children: [
            Text(
              "Choose Month  ",
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            Icon(
              Icons.calendar_today_sharp,
              size: 20,
              color: Colors.black,
            )
          ],
        ),
        style: TextButton.styleFrom(
            padding: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Colors.blueAccent, width: 1)
            )
        ),
        onPressed: (){
          showMonthPicker(
            context: context,
            firstDate: DateTime(2020),
            lastDate: DateTime(2022),
            initialDate: DateTime.now(),
          ).then((value){
            setState(() {
              currentMonth = value;
              // _updateChartDataScore();
            });
          });
        }
      ),
    );
  }
  Widget _buildChartWrapper(){
    return Container(
      color: Color(0xff232d37),
      child: Column(
        children: [
          _buildChartTopBar(),
          _buildChartContainer()
        ],
      ),
    );
  }
  Widget _buildChartTopBar(){
    String monthName = _getMonthName(currentMonth.month);
    return Padding(
      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.multiline_chart_sharp,
                size: 45,
                color: Colors.white,
              ),
              Text(
                " Record",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          Text(
            "$monthName ${currentMonth.year}",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[400],
              fontStyle: FontStyle.italic
            ),
          )
        ],
      ),
    );
  }
  Widget _buildChartContainer(){
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = screenHeight*0.42;
    //  ~ 300.0
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
              width: screenWidth*2,
              height: containerHeight,
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0, right: 20.0),
              child: _buildChart(),
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          width: 20,
          height: containerHeight,
          child: Container(
            width: 20,
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          width: 20,
          height: containerHeight,
          child: Container(
            width: 20,
          ),
        ),
      ],
    );
  }
  Widget _buildChart(){
    dataPoints.sort((first, second)=> first.x.compareTo(second.x));
    final List<Color> gradientColors = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 32,
        minY: 0,
        maxY: maxY,
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            showTitles: true,
            margin: 8,
            getTextStyles: (value)=> TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.0
            ),
          ),
          leftTitles: SideTitles(
            showTitles: true,
            margin: 8,
            reservedSize: 40,
            getTitles: (value){
              double newValue = value*weight;
              return newValue.toStringAsFixed(0);
            },
            getTextStyles: (value)=> TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.0
            )
          )
        ),
        gridData: FlGridData(
          show: true,
          getDrawingHorizontalLine: (value){
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1
            );
          },
          drawVerticalLine: true,
          getDrawingVerticalLine: (value){
            return FlLine(
              color: const Color(0xff37434d),
              strokeWidth: 1
            );
          },
        ),
        borderData: FlBorderData(
          border: Border(
            bottom: BorderSide(color: Colors.white, width: 1.0),
            left: BorderSide(color: Colors.white, width: 1.0),
            top: BorderSide(color: Colors.white, width: 0.5)
          ),
          show: true,
        ),
        lineBarsData: [
          LineChartBarData(
            spots: dataPoints,
            isCurved: true,
            colors: gradientColors,
            barWidth: 3,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              colors: gradientColors.map((color) => color.withOpacity(0.3)).toList()
            )
          )
        ],
      ),
    );
  }

  String _getMonthName(int month){
    List<String> names = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    return names[month- 1];
  }
  void _updateChartDataCalorie(){

    // calculate total value of a day if there are many records in same day
    Map<String, double> dataOfDays = {};
    double maxCalorie = 0;

    currentMonthRecords.forEach((record) {
      var recordDate = DateTime.fromMillisecondsSinceEpoch(record.timeStamp.seconds*1000);
      String dayKey = recordDate.day.toString();

      double currentCalorie= 0;
      if(dataOfDays[dayKey] == null){
        currentCalorie = record.calorie;
        dataOfDays[dayKey] = currentCalorie;
      }
      else dataOfDays.update(dayKey, (value){
        currentCalorie = value + record.calorie;
        return currentCalorie;
      });
      if(currentCalorie> maxCalorie) maxCalorie = currentCalorie;
    });

    _updateMaxY(maxCalorie);

    dataPoints = dataOfDays.entries
        .map((day){
          double ratioValue = day.value/weight;
          return FlSpot(double.parse(day.key), ratioValue);
        })
        .toList();
  }
  void _updateChartDataTime(){
    // calculate total value of a day if there are many records in same day
    Map<String, double> dataOfDays = {};
    double maxTime = 0;
    currentMonthRecords.forEach((record) {
      var recordDate = DateTime.fromMillisecondsSinceEpoch(record.timeStamp.seconds*1000);
      String dayKey = recordDate.day.toString();
      double currentTime;
      if(dataOfDays[dayKey] == null){
        currentTime = record.totalTime.getTimeInMinutes();
        dataOfDays[dayKey] = currentTime;
      }
      else dataOfDays.update(dayKey, (value){
        currentTime = value+ record.totalTime.getTimeInMinutes();
        return currentTime;
      });
      if(currentTime> maxTime) maxTime = currentTime;
    });
    _updateMaxY(maxTime);
    dataPoints = dataOfDays.entries
        .map((day){
          double ratioValue = day.value/weight;
          return FlSpot(double.parse(day.key), ratioValue);
        })
        .toList();
  }
  void _updateChartDataScore(){
    // calculate total value of a day if there are many records in same day
    Map<String, Map<String, double>> dataOfDays = {};

    currentMonthRecords.forEach((record) {
      var recordDate = DateTime.fromMillisecondsSinceEpoch(record.timeStamp.seconds*1000);
      String dayKey = recordDate.day.toString();
      if(dataOfDays[dayKey] == null) dataOfDays[dayKey] = {"value": record.score, "count": 1};
      else dataOfDays.update(dayKey, (day){
        return{
          "value": day['value']+ record.score,
          "count": day['count']+ 1
        };
      });
    });

    double maxScore = 0;
    dataOfDays.forEach((key, value) {
      double currentAvgScore = value['value']/value['count'];
      if(currentAvgScore> maxScore) maxScore = currentAvgScore;
    });

    maxY = 10;
    weight = 1.0;
    // _updateMaxY();
    // maxY is always 10 with score
    dataPoints = dataOfDays.entries
        .map((day){
          double ratioValue = (day.value['value']/day.value['count'])/weight;
          return FlSpot(double.parse(day.key), ratioValue);
        })
        .toList();
  }
  void _updateMaxY(double maxValue){
    if(maxValue> 20.0){
      if(maxValue> 200.0){
        maxY = (maxValue/100.0).roundToDouble()+ 0.5;
        weight = 100.0;
      }else{
        maxY = (maxValue/10.0).roundToDouble()+ 1.0;
        weight = 10.0;
      }
    }else{
      maxY = maxValue.roundToDouble()+ 5.0;
      weight= 1.0;
    }
  }
}
