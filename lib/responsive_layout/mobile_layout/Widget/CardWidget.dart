import 'package:flutter/material.dart';
import 'package:ideal_meal/constant.dart';

class CardWidget extends StatelessWidget {
  final double width;

  CardWidget({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
            width: width * 401/430,
            child: Image.asset("assets/images/card.png", fit: BoxFit.cover)),
        Row(
          children: [
            SizedBox(
              width: width * 40/430,
              child: Image.asset("assets/images/logo.png", fit: BoxFit.cover)),
            Text(userTest.username),
          ],
        )
      ],
    );
  }
}
