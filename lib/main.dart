import 'package:chatzie/screens/chat_screen.dart';
import 'package:chatzie/screens/login_screen.dart';
import 'package:chatzie/screens/registration_screen.dart';
import 'package:chatzie/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(ChatZie());

class ChatZie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
