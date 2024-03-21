import 'package:flutter/material.dart';
import 'package:student_attendance/ResponseAPi.dart';
import 'package:student_attendance/constant.dart';
import 'package:student_attendance/DataTester.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  var view = WidgetsBinding.instance.platformDispatcher.views.first;
  TextStyle textFont(String color, double size){
    size/= view.devicePixelRatio;
    return color == 'black' ? TextStyle(color:Colors.black, fontSize: size, fontWeight: FontWeight.bold) : TextStyle(color: const Color.fromRGBO(187, 187, 187, 1), fontSize: size);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white10,
          border: Border(
            top: BorderSide(
              color: const Color.fromRGBO(220, 220, 220, 1),
              width: 2/view.devicePixelRatio,
            )
          ),
        )
      )
    );
  }
}