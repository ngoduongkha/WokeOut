import 'package:woke_out/enum.dart';
import 'package:woke_out/screens/bmi_page/gender/gender_card.dart';
import 'package:woke_out/screens/bmi_page/height/height_card.dart';
import 'package:woke_out/screens/bmi_page/weight/weight_card.dart';
import 'package:flutter/material.dart';

import 'widget_utils.dart' show screenAwareSize;

class InputPage extends StatelessWidget {
  Gender gender;
  int weight;
  int height;

  InputPage({Key key, this.gender, this.weight, this.height}) : super(key: key);

  static InputPage of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<InputPage>();

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTitle(context),
            Expanded(child: _buildCards(context)),
            _buildBottom(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24.0,
        top: screenAwareSize(56.0, context),
      ),
      child: Text(
        "Input your BMI",
        style: new TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCards(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 14.0,
        right: 14.0,
        top: screenAwareSize(32.0, context),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(child: GenderCard(initialGender: gender)),
                Expanded(child: WeightCard(initialWeight: weight)),
              ],
            ),
          ),
          Expanded(child: HeightCard(height: height))
        ],
      ),
    );
  }

  Widget _buildBottom(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: screenAwareSize(108.0, context),
      width: double.infinity,
      child: TextButton(
        child: Text("Submit"),
        onPressed: () => _submitForm(context),
      ),
    );
  }

  void _submitForm(BuildContext context) {
    Map<String, dynamic> result = {
      'gender': gender,
      'height': height,
      'weight': weight,
    };

    Navigator.pop(context, result);
  }
}
