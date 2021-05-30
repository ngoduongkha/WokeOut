import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/model/app_user_model.dart';
import 'package:woke_out/services/app_user_service.dart';
import 'package:woke_out/services/auth_service.dart';
import 'package:woke_out/widgets/avatar.dart';
import 'package:woke_out/pages/bmi_page/input_page.dart';
import 'package:woke_out/string_extension.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();

  static _UserInfoPageState of(BuildContext context) =>
      context.findAncestorStateOfType<_UserInfoPageState>();
}

class _UserInfoPageState extends State<UserInfoPage> {
  MyAppUser _userInternet;
  MyAppUser _userLocal;

  File _image;

  TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _stateController;
  TextEditingController _cityController;
  TextEditingController _bioController;

  set image(File value) {
    assert(value != null);
    _image = value;
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);

    return FutureBuilder<MyAppUser>(
      future: AppUserService().loadProfile(auth.currentUser().uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _userInternet = snapshot.data;

          if (_userLocal == null) _userLocal = _userInternet;

          _nameController =
              new TextEditingController(text: _userLocal.displayName);
          _emailController = new TextEditingController(text: _userLocal.email);
          _stateController = new TextEditingController(text: _userLocal.state);
          _cityController = new TextEditingController(text: _userLocal.city);
          _bioController = new TextEditingController(text: _userLocal.bio);

          return Scaffold(
            backgroundColor: Color(0xFFEBEDF0),
            body: CustomScrollView(
              slivers: [
                settingAppBar(context),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      AvatarWidget(photoUrl: _userLocal.photoUrl),
                      accountProfile(),
                      fitnessProfile(),
                      TextButton(
                  onPressed: () {
                    auth.signOut();
                  },
                  child: Text(
                    'Log out',
                    style: GoogleFonts.lato(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  void saveProfile() async {
    if (_userLocal != _userInternet) _userInternet = _userLocal;
    if (_image != null) 
    await AppUserService()
        .updateUser(_userInternet, localFile: _image)
        .then((value) => print(value));
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
            onPressed: () {
              saveProfile();
            },
            child: Text(
              'Lưu',
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
              settingCard('Tên', _userLocal.displayName, _nameController),
              settingCard('Email', _userLocal.email, _emailController),
              settingCard('Quận/Huyện', _userLocal.state, _stateController),
              settingCard('Tỉnh/Thành phố', _userLocal.city, _cityController),
              settingCard('Tiểu sử', _userLocal.bio, _bioController),
            ],
          ),
        ),
      ],
    );
  }

  Widget settingCard1(String title, String value) {
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
                child: null,
              ),
            ],
          ),
        ),
        SizedBox(height: 1),
      ],
    );
  }

  Widget settingCard(
      String title, String value, TextEditingController scontroller) {
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
                  controller: scontroller,
                  textAlign: TextAlign.right,
                  style: normalBoldStyle(),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: "Nhập ${title.toLowerCase()}",
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
        SizedBox(height: 1),
      ],
    );
  }

  void _awaitReturnValueFromBMIScreen(BuildContext context) async {
    // start the SecondScreen and wait for it to finish with a result
    final Map<String, dynamic> result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InputPage(
          gender: _userLocal.gender,
          height: _userLocal.height,
          weight: _userLocal.weight,
        ),
      ),
    );

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      if (result != null) {
        _userLocal.gender = result['gender'];
        _userLocal.height = result['height'];
        _userLocal.weight = result['weight'];
      }
    });
  }

  Widget gestureCard(String title, String value) {
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
                child: GestureDetector(
                  child: Text(
                    value,
                    textAlign: TextAlign.right,
                    style: normalBoldStyle(),
                  ),
                  onTap: () => _awaitReturnValueFromBMIScreen(context),
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
              gestureCard(
                  'Gender',
                  _userLocal.gender
                      .toString()
                      .substring(_userLocal.gender.toString().indexOf('.') + 1)
                      .capitalize()),
              gestureCard('Height', '${_userLocal.height.toString()} cm'),
              gestureCard('Weight', '${_userLocal.weight.toString()} kg'),
              gestureCard('Fitness level', '${_userLocal.level.toString()}'),
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
