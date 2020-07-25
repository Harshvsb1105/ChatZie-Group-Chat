import 'package:flutter/material.dart';

class Neo_Image extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300.00,
        width: 300.00,
        child: Image.asset('images/195.png'),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment(-1.0, -4.0),
                end: Alignment(1.0, 4.0),
                colors: [
                  Color(0xFF582296),
                  Color(0xFF5f26a5),
                  Color(0xFF6327ad),
                  Color(0xFF6929b3)
                ]),
            borderRadius: BorderRadius.all(Radius.circular(50)),
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF53208e),
                  offset: Offset(5.0, 5.0),
                  blurRadius: 1.0,
                  spreadRadius: 0.0),
              BoxShadow(
                  color: Color(0xFF712cc0),
                  offset: Offset(-5.0, -5.0),
                  blurRadius: 1.0,
                  spreadRadius: 0.0),
            ]));
  }
}
