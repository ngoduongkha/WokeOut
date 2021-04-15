import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/model/app_user_model.dart';
import 'package:woke_out/screens/choose_exercise_page.dart';
import 'package:woke_out/services/firebase_auth_service.dart';
import 'package:woke_out/widgets/bottom_nav_item.dart';
import 'package:woke_out/widgets/platform_alert_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('aa'),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
      bottomNavigationBar: myBottomNavigationBar(),
      body: ChooseExercisePage(),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    final AuthService auth = Provider.of<AuthService>(context, listen: false);
    await auth.signOut();
    // } on PlatformException catch (e) {
    //   await PlatformExceptionAlertDialog(
    //     title: Strings.logoutFailed,
    //     exception: e,
    //   ).show(context);
    // }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final bool didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  Widget myBottomNavigationBar() => Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        height: 80,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            BottomNavItemWidget(
              title: "Today",
              svgScr: "assets/icons/gym.svg",
              isActive: true,
              press: () => setState(() {
                selectedPage = 0;
              }),
            ),
            BottomNavItemWidget(
              title: "Schedule",
              svgScr: "assets/icons/calendar.svg",
            ),
            BottomNavItemWidget(
              title: "Settings",
              svgScr: "assets/icons/Settings.svg",
            ),
          ],
        ),
      );
}
