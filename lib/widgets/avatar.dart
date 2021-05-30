import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woke_out/pages/user_info_page.dart';

class AvatarWidget extends StatefulWidget {
  final String photoUrl;

  const AvatarWidget({Key key, this.photoUrl}) : super(key: key);

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
          UserInfoPage.of(context).image = _image;
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
                  : widget.photoUrl != null
                      ? NetworkImage(widget.photoUrl)
                      : AssetImage('assets/images/shoulder.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
