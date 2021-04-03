import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woke_out/components/already_have_an_account_acheck.dart';
import 'package:woke_out/components/rounded_button.dart';
import 'package:woke_out/components/rounded_input_field.dart';
import 'package:woke_out/components/rounded_password_field.dart';
import 'package:woke_out/enum/app_state.dart';
import 'package:woke_out/model/loginModel.dart';
import 'package:woke_out/screens/baseView.dart';
import 'package:woke_out/screens/signupPage.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final LoginModel loginModel;

  LoginPage({
    @required this.emailController,
    @required this.passwordController,
    @required this.loginModel,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, loginModel, __) => Scaffold(
        body: Body(
          emailController: this.emailController,
          passwordController: this.passwordController,
          loginModel: loginModel,
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final LoginModel loginModel;

  const Body({
    Key key,
    @required this.emailController,
    @required this.passwordController,
    @required this.loginModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      loginModel: loginModel,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
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
              press: () {
                loginModel.signIn(
                    emailController.text, passwordController.text);
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignupPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;
  final LoginModel loginModel;

  const Background({
    Key key,
    @required this.child,
    @required this.loginModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_top.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "assets/images/login_bottom.png",
              width: size.width * 0.4,
            ),
          ),
          child,
          loginModel.viewState == ViewState.Busy
              ? Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
