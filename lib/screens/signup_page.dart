import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/components/already_have_an_account_acheck.dart';
import 'package:woke_out/components/rounded_button.dart';
import 'package:woke_out/components/rounded_input_field.dart';
import 'package:woke_out/components/rounded_password_field.dart';
import 'package:woke_out/constants.dart';
import 'package:woke_out/enum/app_state.dart';
import 'package:woke_out/services/app_user_service.dart';
import 'package:woke_out/services/auth_service.dart';
import 'package:woke_out/widgets/custom_dialog_box.dart';

class SignupPage extends StatelessWidget {
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
    final userService = Provider.of<AppUserService>(context, listen: false);

    _background() {
      return Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/signup.svg",
                height: size.height * 0.35,
              ),
              RoundedInputField(
                controller: emailController,
                hintText: "Your Email",
                onChanged: (value) {},
              ),
              RoundedPasswordField(
                controller: passwordController,
                onChanged: (value) {},
              ),
              RoundedButton(
                text: "SIGNUP",
                press: () async {
                  var user = await auth.createUserWithEmailAndPassword(
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
                          title: "Đăng ký thất bại",
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
                login: false,
                press: () {
                  Navigator.popAndPushNamed(context, 'login');
                },
              ),
              OrDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocialIcon(
                    iconSrc: "assets/icons/facebook.svg",
                    press: () async {
                      var user = await auth.signInWithFacebook();
                      if (user != null) {
                        userService.addUser(user);
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'home', ModalRoute.withName('landing'));
                      }
                    },
                  ),
                  SocialIcon(
                    iconSrc: "assets/icons/twitter.svg",
                    press: () {},
                  ),
                  SocialIcon(
                    iconSrc: "assets/icons/google-plus.svg",
                    press: () async {
                      var user = await auth.signInWithGoogle();
                      if (user != null) {
                        userService.addUser(user);
                        Navigator.pushNamedAndRemoveUntil(
                            context, 'home', ModalRoute.withName('landing'));
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _background(),
        ],
      ),
    );
  }
}

class SocialIcon extends StatelessWidget {
  final String iconSrc;
  final Function press;
  const SocialIcon({
    Key key,
    this.iconSrc,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: kPrimaryLightColor,
          ),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconSrc,
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: Color(0xFFD9D9D9),
        height: 1.5,
      ),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "assets/images/signup_top.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "assets/images/main_bottom.png",
              width: size.width * 0.25,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
