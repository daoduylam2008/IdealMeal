import 'package:flutter/material.dart';
import 'package:student_attendance/ResponseAPi.dart';
import 'package:student_attendance/constant.dart';
import 'package:student_attendance/DataTester.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var view = WidgetsBinding.instance.platformDispatcher.views.first;
  TextStyle textFont(String color, double size){
    size/= view.devicePixelRatio;
    return color == 'black' ? TextStyle(color:Colors.black, fontSize: size, fontWeight: FontWeight.bold) : TextStyle(color: const Color.fromRGBO(187, 187, 187, 1), fontSize: size);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 340/view.devicePixelRatio,
            decoration: BoxDecoration(
              color: Colors.white10,
              border: Border(
                top: BorderSide(
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  width: 2/view.devicePixelRatio,
                ),
                right: BorderSide(
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  width: 2/view.devicePixelRatio,
                ),
              )
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white10,
                border: Border(
                  top: BorderSide(
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    width: 2/view.devicePixelRatio,
                  ),
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}