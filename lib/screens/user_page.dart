import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  TextEditingController uidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
            controller: uidController,
          ),
        ],
      ),
    );
  }
}
