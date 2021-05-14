import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/components/already_have_an_account_acheck.dart';
import 'package:woke_out/components/rounded_button.dart';
import 'package:woke_out/components/rounded_input_field.dart';
import 'package:woke_out/components/rounded_password_field.dart';
import 'package:woke_out/enum.dart';
import 'package:woke_out/services/auth_service.dart';
import 'package:woke_out/services/exercise_service.dart';
import 'package:woke_out/widgets/custom_dialog_box.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Body();
  }
}

class _Body extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final auth = Provider.of<AuthService>(context, listen: false);

    // _background() {
    //   return Background(
    //     child: SingleChildScrollView(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           Text(
    //             "LOGIN",
    //             style: TextStyle(fontWeight: FontWeight.bold),
    //           ),
    //           SizedBox(height: size.height * 0.03),
    //           SizedBox(height: size.height * 0.03),
    //           RoundedInputField(
    //             hintText: "Your Email",
    //             controller: emailController,
    //             onChanged: (value) {},
    //           ),
    //           RoundedPasswordField(
    //             controller: passwordController,
    //             onChanged: (value) {},
    //           ),
    //           RoundedButton(
    //             text: "LOGIN",
    //             press: () async {
    //               var user = await auth.signInWithEmailAndPassword(
    //                   emailController.text, passwordController.text);
    //               if (user != null) {
    //                 Navigator.pushNamedAndRemoveUntil(
    //                     context, 'home', ModalRoute.withName('landing'));
    //               } else {
    //                 showDialog(
    //                   context: context,
    //                   builder: (BuildContext context) {
    //                     return CustomDialogBox(
    //                       dialogType: DialogType.error,
    //                       title: "Đăng nhập thất bại",
    //                       descriptions: auth.errorMessage,
    //                       text: "OK",
    //                     );
    //                   },
    //                 );
    //               }
    //             },
    //           ),
    //           SizedBox(height: size.height * 0.03),
    //           AlreadyHaveAnAccountCheck(
    //             press: () {
    //               Navigator.popAndPushNamed(context, 'signup');
    //             },
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/signin_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: size.height * 0.03),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              controller: emailController,
              onChanged: (value) {},
            ),
            RoundedPasswordField(
              controller: passwordController,
              onChanged: (value) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () async {
                var user = await auth.signInWithEmailAndPassword(
                    emailController.text, passwordController.text);
                if (user != null) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'home', ModalRoute.withName('landing'));
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialogBox(
                        dialogType: DialogType.error,
                        title: "Đăng nhập thất bại",
                        descriptions: auth.errorMessage,
                        text: "OK",
                      );
                    },
                  );
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.popAndPushNamed(context, 'signup');
              },
            ),
            SizedBox(height: size.height * 0.1),
          ],
        ),
      ),
    );
  }
}
