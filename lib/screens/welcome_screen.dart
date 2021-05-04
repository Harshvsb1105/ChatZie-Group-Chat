import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatzie/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:chatzie/Image_widget.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: animation.value,
        body: Container(
          color: Color(0xFF6226a7),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: Container(
                        child: Neo_Image(),
//                      height: 300.0,
                      ),
                    ),
                    SizedBox(
                      height: 28.0,
                    ),
                    TypewriterAnimatedTextKit(
                      text: ['CHATZIE'],
                      textStyle: TextStyle(
                        color: Color(0xFFff9ad4),
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF6226a7),
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF53208e),
                          offset: Offset(4, 2),
                          blurRadius: 4.0,
                          spreadRadius: 0.0),
                      BoxShadow(
                          color: Color(0xFF712cc0),
                          offset: Offset(-4, -2),
                          blurRadius: 4.0,
                          spreadRadius: 0.0)
                    ],
                  ),
                  child: RoundedButton(
                    title: 'Log In',
                    colour: Color(0xFF6226a7),
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF6226a7),
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xFF53208e),
                          offset: Offset(4, 2),
                          blurRadius: 4.0,
                          spreadRadius: 0.0),
                      BoxShadow(
                          color: Color(0xFF712cc0),
                          offset: Offset(-4, -2),
                          blurRadius: 4.0,
                          spreadRadius: 0.0)
                    ],
                  ),
                  child: RoundedButton(
                    title: 'Register',
                    colour: Color(0xFF6226a7),
                    onPressed: () {
                      Navigator.pushNamed(context, RegistrationScreen.id);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
