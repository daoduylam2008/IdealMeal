import 'package:flutter/material.dart';
import 'package:ideal_meal/constant.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/Widget/CardWidget.dart';


class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfile();
}

class _MyProfile extends State<MyProfile> {
  @override
  Widget build(context) {
    setState(() {
      
    });
    return LayoutBuilder(builder: ((context, constraints) {
      return SingleChildScrollView(
        child: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CardWidget(width: constraints.maxWidth),
            SizedBox(height: constraints.maxHeight*20/440),
            SizedBox(
              width: constraints.maxHeight*380/440,
              child: const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: constraints.maxHeight*15/440),
            ],
          ),
        ),
      );
    }));
  }
}
