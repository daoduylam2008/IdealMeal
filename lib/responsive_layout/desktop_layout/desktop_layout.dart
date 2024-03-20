import 'package:flutter/material.dart';
import 'package:student_attendance/ResponseAPi.dart';
import 'package:student_attendance/constant.dart';
import 'package:student_attendance/DataTester.dart';



class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({super.key});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    var view = WidgetsBinding.instance.platformDispatcher.views.first;
    TextStyle textFont(String color, double size){
      size/= view.devicePixelRatio;
      return color == 'black' ? TextStyle(color:Colors.black, fontSize: size, fontWeight: FontWeight.bold) : TextStyle(color: const Color.fromRGBO(187, 187, 187, 1), fontSize: size);
}
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70/view.devicePixelRatio,
        backgroundColor: Colors.white10,
        title: Text(
          'Ideal Meal',
          style: textFont('black', 30),
        ),
        centerTitle: false,
      ),
      body: Row(
        children: [
          Container(
            width: 70/view.devicePixelRatio,
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
