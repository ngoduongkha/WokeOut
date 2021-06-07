import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woke_out/components/already_have_an_account_acheck.dart';
import 'package:woke_out/components/rounded_button.dart';
import 'package:woke_out/components/rounded_input_field.dart';
import 'package:woke_out/enum.dart';
import 'package:woke_out/services/auth_service.dart';
import 'package:woke_out/widgets/custom_dialog_box.dart';
import 'package:woke_out/widgets/password_text_form_field.dart';

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

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/signin_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration:
                BoxDecoration(color: Color(0xFF15152B).withOpacity(0.5)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Your Email",
                controller: emailController,
                onChanged: (value) {},
              ),
              PasswordField(
                hintText: "Your Password",
                controller: passwordController,
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
        ],
      ),
    );
  }
}
