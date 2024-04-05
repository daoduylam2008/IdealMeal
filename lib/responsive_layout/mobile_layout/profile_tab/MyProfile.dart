import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image.asset("assets/images/card.png"),
            Row(
              children: [
                Image.asset("assets/images/logo.png"),
                Text("Hello world")
              ]
            ),
            ],
        )
      ],
    ));
  }
}
