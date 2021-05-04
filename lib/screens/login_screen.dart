import 'package:chatzie/Controller/AccessController.dart';
import 'package:chatzie/components/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  String email;
  String password;
  AccessController accessController = Get.put(AccessController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6226a7),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 380.0,
                    child: Image.asset('images/195.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF6829b5),
                        Color(0xFF6327ad),
                        Color(0xFF5f26a5),
                        Color(0xFF5c24a0),
                      ]),
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
                child: TextField(
                  style: TextStyle(color: Color(0xFFff9ad4)),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Enter your email',
                      border: InputBorder.none),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xFF6829b5),
                        Color(0xFF6327ad),
                        Color(0xFF5f26a5),
                        Color(0xFF5c24a0),
                      ]),
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
                child: TextField(
                  style: TextStyle(color: Color(0xFFff9ad4)),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Enter your password',
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
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
                child: StatefulBuilder(
                    builder: (context, snapshot) {
                      return RoundedButton(
                        title: 'LogIn',
                        colour: Color(0xFF6226a7),
                        onPressed: () async {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            final user = await accessController.logIn(email, password);
                            if (user != null) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(mode: 0,)));
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          } catch (e) {
                            setState(() {
                              showSpinner = false;
                            });
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text('Wrong Email or Password / User not found')));
                            print(e);
                          }
                        },
                      );
                    }
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                child: FlatButton.icon(
                    label: Text(
                      "Sign in with Facebook",
                      style: TextStyle(
                          color: Color(0xFFff9ad4),
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    icon: Icon(
                      FontAwesome5.facebook,
                      color: Color(0xFFff9ad4),
                      size: 30,
                    ),
                    color: Color(0xFF6226a7),
                    onPressed: () {
                      accessController.fbSignIn(context);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

