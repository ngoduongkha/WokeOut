import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/constants.dart';
import 'package:woke_out/enum.dart';
import 'package:woke_out/model/administrative_unit.dart';
import 'package:woke_out/model/app_user_model.dart';
import 'package:woke_out/services/app_user_service.dart';
import 'package:woke_out/services/auth_service.dart';
import 'package:woke_out/widgets/address_picker.dart';
import 'package:woke_out/widgets/avatar.dart';
import 'package:woke_out/pages/bmi_page/input_page.dart';
import 'package:woke_out/string_extension.dart';
import 'package:woke_out/widgets/custom_dialog_box.dart';
import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;

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
          _bioController = new TextEditingController(text: _userLocal.bio);

          return GestureDetector(
            child: Scaffold(
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox(
                                  dialogType: DialogType.warning,
                                  title: "Warning",
                                  descriptions:
                                      "Are you sure to delete all data?",
                                  function: () =>
                                      AppUserService().clearChallengeRecord(),
                                );
                              },
                            );
                          },
                          child: Text(
                            'Delete All Data',
                            style: GoogleFonts.lato(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            auth.signOut();

                            Navigator.pushNamedAndRemoveUntil(context,
                                'welcome', ModalRoute.withName('landing'));
                          },
                          child: Text(
                            'Log Out',
                            style: GoogleFonts.lato(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
    _userLocal.displayName = _nameController.text;
    _userInternet.bio = _bioController.text;

    if (_userLocal != _userInternet) {
      _userInternet = _userLocal;
    }
    if (_image != null) {
      await AppUserService()
          .updateUser(_userInternet, localFile: _image)
          .then((value) {
        showDialog(
          context: context,
          builder: (_) {
            return CustomDialogBox(
              title: "Done",
              descriptions: "Your update successfully!",
              dialogType: DialogType.success,
            );
          },
        );
      });
    } else {
      await AppUserService().updateUser(_userInternet).then((value) {
        showDialog(
          context: context,
          builder: (_) {
            return CustomDialogBox(
              title: "Done",
              descriptions: "Your update successfully!",
              dialogType: DialogType.success,
            );
          },
        );
      });
    }
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
            color: kTextColor,
            letterSpacing: 1.2,
          ),
        ),
      ),
      actions: [
        Container(
          width: 100,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: MaterialButton(
            color: kPrimaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onPressed: () {
              saveProfile();
            },
            child: Text(
              'Save',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        )
      ],
    );
  }

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
          color: kBackgroundColor,
          child: Column(
            children: [
              settingCard('Name', _userLocal.displayName, _nameController),
              addressField('Address'),
              settingCard('Bio', _userLocal.bio, _bioController),
            ],
          ),
        ),
      ],
    );
  }

  String getVietnameseString(dvhcvn.Entity entity) {
    if (entity == null) return null;
    final parent = getVietnameseString(entity.parent);
    return parent != null ? '${entity.name}, $parent' : entity.name;
  }

  Widget addressField(String title) {
    final data = AdministrativeUnit.of(context, listen: true);

    dvhcvn.Entity entity = data.level3;
    entity ??= data.level2;
    entity ??= data.level1;

    _userLocal.address = getVietnameseString(entity) ?? _userLocal.address;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          color: kBackgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: normalStyle()),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => AddressPicker()));
                },
                child: Container(
                  width: 250,
                  child: Text(
                    _userLocal.address ?? "Your ${title.toLowerCase()}",
                    textAlign: TextAlign.end,
                    style: normalBoldStyle(),
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

  Widget settingCard(
      String title, String value, TextEditingController scontroller) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
          color: kBackgroundColor,
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
                  decoration: InputDecoration(
                    hintText: "Your ${title.toLowerCase()}",
                    hintStyle: normalBoldStyle(),
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
          color: kBackgroundColor,
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
        Container(color: kBackgroundColor, height: 1),
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
          color: kBackgroundColor,
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
    color: Colors.white,
    fontWeight: FontWeight.w900,
  );
}

TextStyle normalStyle() {
  return GoogleFonts.lato(
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.normal,
  );
}

TextStyle normalBoldStyle() {
  return GoogleFonts.lato(
    fontSize: 12,
    color: Colors.grey[200],
    fontWeight: FontWeight.w900,
  );
}
