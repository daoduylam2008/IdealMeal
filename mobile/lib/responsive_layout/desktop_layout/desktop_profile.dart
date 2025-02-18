import 'package:flutter/material.dart';

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
        ),
        child: Column(
          children: [
            Container(
              height: 72/view.devicePixelRatio,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    width: 2/view.devicePixelRatio,
                  )
                )
              ),
              child: Row(
                children: [
                  SizedBox(width: 20/view.devicePixelRatio),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Profile',
                      style: textFont('black', 30),
                    ),
                  ),
                ]
              ),
            )
          ],
        ),
      )
    );
  }
}