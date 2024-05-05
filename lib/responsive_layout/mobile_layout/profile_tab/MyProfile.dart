import 'package:flutter/material.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/Widget/CardWidget.dart';


class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfile();
}

class _MyProfile extends State<MyProfile> {
  // const MyProfile({super.key});

  @override
  Widget build(context) {
    return LayoutBuilder(builder: ((context, constraints) {
      return SingleChildScrollView(
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardWidget(width: constraints.maxWidth)
          ],
        )),
      );
    }));
  }
}
