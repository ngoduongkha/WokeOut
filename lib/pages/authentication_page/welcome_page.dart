import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woke_out/components/rounded_button.dart';
import 'package:woke_out/constants.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/welcome_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'WELCOME TO',
            style: GoogleFonts.bebasNeue(
              fontSize: 50,
              color: Color(0xFF40D876),
              fontWeight: FontWeight.w600,
              letterSpacing: 7,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'WOKEOUT',
            style: GoogleFonts.bebasNeue(
              fontSize: 50,
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              height: size.height * 0.15,
              width: size.height * 0.15,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/icon.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          RoundedButton(
            text: "LOGIN",
            press: () {
              Navigator.pushNamed(context, 'login');
            },
          ),
          RoundedButton(
            text: "SIGN UP",
            color: kPrimaryLightColor,
            textColor: Colors.black,
            press: () {
              Navigator.pushNamed(context, 'signup');
            },
          ),
          SizedBox(height: size.height * 0.1),
        ],
      ),
    );
    // This size provide us total height and width of our screen
    // return Background(
    //   child: SingleChildScrollView(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Text(
    //           "WELCOME TO EDU",
    //           style: TextStyle(fontWeight: FontWeight.bold),
    //         ),
    //         SizedBox(height: size.height * 0.05),
    //         // SvgPicture.asset(
    //         //   "assets/icons/chat.svg",
    //         //   height: size.height * 0.45,
    //         // ),
    //         SizedBox(height: size.height * 0.05),
    //         RoundedButton(
    //           text: "LOGIN",
    //           press: () {
    //             Navigator.pushNamed(context, 'login');
    //           },
    //         ),
    //         RoundedButton(
    //           text: "SIGN UP",
    //           color: kPrimaryLightColor,
    //           textColor: Colors.black,
    //           press: () {
    //             Navigator.pushNamed(context, 'signup');
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

// class Background extends StatelessWidget {
//   final Widget child;
//   const Background({
//     Key key,
//     @required this.child,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height,
//       width: double.infinity,
//       child: Stack(
//         alignment: Alignment.center,
//         children: <Widget>[
//           // Positioned(
//           //   top: 0,
//           //   left: 0,
//           //   child: Image.asset(
//           //     "assets/images/main_top.png",
//           //     width: size.width * 0.3,
//           //   ),
//           // ),
//           // Positioned(
//           //   bottom: 0,
//           //   left: 0,
//           //   child: Image.asset(
//           //     "assets/images/main_bottom.png",
//           //     width: size.width * 0.2,
//           //   ),
//           // ),
//           child,
//         ],
//       ),
//     );
//   }
// }
