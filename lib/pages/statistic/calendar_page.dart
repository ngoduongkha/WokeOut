
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:woke_out/constants.dart';
import 'package:woke_out/services/auth_service.dart';
import 'package:woke_out/services/exercise_record_service.dart';

class CalendarMainPage extends StatefulWidget {
  @override
  _CalendarMainPageState createState() => _CalendarMainPageState();
}

class _CalendarMainPageState extends State<CalendarMainPage> {
  ExerciseRecordService recordService;
  @override
  void initState() {
    AuthService auth = Provider.of<AuthService>(context, listen: false);
    recordService = ExerciseRecordService(userId: auth.currentUser().uid);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Training record",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            _buildCalendar()
          ],
        )
    );
  }
  Widget _buildCalendar(){
    return FutureBuilder(
        future: recordService.getAllRecordDates(),
        builder: (context, snapshot){
          if(snapshot.hasData){

            return TableCalendar(
              firstDay: DateTime.utc(2021, 1, 1),
              lastDay: DateTime.utc(2022, 1, 1),
              focusedDay: DateTime.now(),
              selectedDayPredicate: (day) {
                return isSameDay(day, DateTime.now());
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: kActiveIconColor,
                  shape: BoxShape.circle,
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
                defaultTextStyle: TextStyle(
                  color: Colors.white,
                ),
                weekendTextStyle: TextStyle(
                  color: Colors.white
                )
              ),
              headerStyle: HeaderStyle(
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                ),
                formatButtonDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(width: 2.0, color: Colors.white),
                ),
                formatButtonTextStyle: TextStyle(
                  color: Colors.white,
                )
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  color: Colors.white
                ),
                weekendStyle: TextStyle(
                  color: Colors.white
                )
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, current, date){
                  if(isInDateList(snapshot.data, current)){
                    return _buildHasRecordDayCircle(current);
                  }
                  else return null;
                },
              ),
              onDaySelected: (selectedDay, focusedDay) {
                selectedDayEvent(snapshot.data, selectedDay);
              },
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }
  void selectedDayEvent(List<DateTime> dateList, DateTime selectedDay){
    if(isInDateList(dateList, selectedDay)){
      setState(() {
        Navigator.of(context).pushNamed("dateRecordPage", arguments: selectedDay);
      });
    }
  }
  Widget _buildHasRecordDayCircle(DateTime date){
    return Center(
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: kPrimaryColor,
        ),
        child: Center(
          child: Text(date.day.toString(), style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }

  bool isInDateList(List<DateTime> dateList, DateTime inputDate){
    for(int i =0; i< dateList.length; i++){
      DateTime date = dateList[i];
      if(isSameDate(date, inputDate)) return true;
    }
    return false;
  }
  bool isSameDate(DateTime first, DateTime second){
    if(first.day == second.day
        && first.month == second.month &&
        first.year == second.year) return true;
    else return false;
  }
}

