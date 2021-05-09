import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woke_out/widgets/avatar.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBEDF0),
      body: CustomScrollView(
        slivers: [
          settingAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                AvatarWidget(),
                accountProfile(),
                fitnessProfile(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget settingAppBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          'Settings',
          style: GoogleFonts.lato(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            color: Colors.black,
            letterSpacing: 1.2,
          ),
        ),
      ),
      actions: [
        Container(
          width: 100,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: MaterialButton(
            color: Color(0xFF40D876),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onPressed: () {},
            child: Text(
              'Save',
              style: GoogleFonts.lato(
                color: Color(0xFFFFFFFE),
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        )
      ],
    );
  }

//Begin avatar
  Widget avatar() {
    File _image;
    final picker = ImagePicker();
    Future pickImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        _image = File('assets/images/avartar_demo.jpg');
      }
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
                  ? Image.file(_image)
                  : AssetImage('assets/images/shoulder.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
//End avatar

//Begin Account Profile
  Widget accountProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            'Account profile',
            style: headerStyle(),
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: [
              settingCard('Username', 'ltl1313ltl'),
              settingCard('Email', 'ltl1313ltl@gmail.com'),
              settingCard('Name', 'Luan Le'),
            ],
          ),
        ),
      ],
    );
  }

  Widget settingCard(String title, String value) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: normalStyle()),
              Container(
                width: 250,
                child: TextFormField(
                  textAlign: TextAlign.right,
                  initialValue: value,
                  style: normalBoldStyle(),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(color: Color(0xFFEBEDF0), height: 1),
      ],
    );
  }
//End account profile

//Begin fitness profile
  Widget fitnessProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            'Fitness profile',
            style: headerStyle(),
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(
            children: [
              settingCard('Gender', 'Male'),
              settingCard('Height', '160 cm'),
              settingCard('Weight', '55 kg'),
              settingCard('Fitness level', 'Advanced'),
            ],
          ),
        ),
      ],
    );
  }
//End fitness profile
}

TextStyle headerStyle() {
  return GoogleFonts.lato(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.w900,
  );
}

TextStyle normalStyle() {
  return GoogleFonts.lato(
    fontSize: 17,
    color: Colors.black,
    fontWeight: FontWeight.normal,
  );
}

TextStyle normalBoldStyle() {
  return GoogleFonts.lato(
    fontSize: 17,
    color: Colors.black,
    fontWeight: FontWeight.w900,
  );
}
