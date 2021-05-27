

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text("exercise completed"),),
          SizedBox(height: 20.0,),
          TextButton(
            child: Text(
              "back",
              style: TextStyle(
                fontSize: 18.0
              ),
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0)
            ),
            onPressed: (){
              Navigator.of(context).popUntil(ModalRoute.withName('exerciseList'));
            },
          )
        ],
      ),
    );
  }
}
