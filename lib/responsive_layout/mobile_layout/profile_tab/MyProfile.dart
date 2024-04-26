import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  // const MyProfile({super.key});

  @override
  Widget build(context) {
    return LayoutBuilder(builder: ((context, constraints) {
      return Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Row(children: [
                SizedBox(
                  width: constraints.maxWidth*0.9,
                  child: Image.asset("assets/images/card.png", fit: BoxFit.cover)
                )
              ]),
            ],
          )
        ],
      ));
    }));
  }
}
