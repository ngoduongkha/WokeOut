import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:google_fonts/google_fonts.dart';

class PickerCard extends StatefulWidget {
  final String title;
  final String value;

  const PickerCard({Key key, this.title, this.value}) : super(key: key);
  @override
  _PickerCardState createState() => _PickerCardState();
}

class _PickerCardState extends State<PickerCard> {
  String value = "Male";
  @override
  Widget build(BuildContext context) {
    showPicker() {
      Picker(
        adapter: PickerDataAdapter<String>(pickerdata: ['Male', 'Female']),
        hideHeader: true,
        title: Text(
          'Your gender is',
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
        onConfirm: (Picker picker, List val) {
          setState(
            () {
              value = picker
                  .getSelectedValues()
                  .toString()
                  .replaceAll('[', '')
                  .replaceAll(']', '');
            },
          );
        },
      ).showDialog(context);
    }

    return Column(
      children: [
        GestureDetector(
          onTap: showPicker,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.lato(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Container(
                  width: 250,
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.lato(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 1),
      ],
    );
  }
}
