import 'package:woke_out/screens/bmi_page/card_title.dart';
import 'package:woke_out/screens/bmi_page/height/height_picker.dart';
import 'package:woke_out/screens/bmi_page/input_page.dart';
import 'package:woke_out/screens/bmi_page/widget_utils.dart';
import 'package:flutter/material.dart';

class HeightCard extends StatefulWidget {
  final int height;

  const HeightCard({Key key, this.height}) : super(key: key);

  @override
  HeightCardState createState() => HeightCardState();
}

class HeightCardState extends State<HeightCard> {
  int height;

  @override
  void initState() {
    super.initState();
    height = widget.height ?? 170;

    InputPage.of(context).height = height;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(top: screenAwareSize(16.0, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CardTitle("HEIGHT", subtitle: "(cm)"),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: screenAwareSize(8.0, context)),
                child: LayoutBuilder(builder: (context, constraints) {
                  return HeightPicker(
                    widgetHeight: constraints.maxHeight,
                    height: height,
                    onChange: (val) => setState(() {
                      height = val;
                      InputPage.of(context).height = height;
                    }),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
