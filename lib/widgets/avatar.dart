import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarWidget extends StatefulWidget {
  @override
  _AvatarWidgetState createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  File _image;
  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();
    Future pickImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          print('Avatar is not null');
          _image = File(pickedFile.path);
        } else {
          print('Avatar is null');
          _image = File('assets/images/avartar_demo.jpg');
        }
      });
    }

    return Center(
      child: GestureDetector(
        onTap: pickImage,
        child: Container(
          margin: EdgeInsets.all(20),
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 5, color: Colors.white),
            image: DecorationImage(
              image: _image != null
                  ? FileImage(_image)
                  : AssetImage('assets/images/shoulder.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
