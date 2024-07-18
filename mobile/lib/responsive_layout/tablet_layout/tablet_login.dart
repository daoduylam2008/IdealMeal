import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPressed = true;
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    Offset distance = isPressed ? const Offset(10, 10) : const Offset(28, 28);
    double blur = isPressed ? 5.0 : 30.0;
    return Scaffold(
      backgroundColor: const Color(0xFFE7ECEF),
      body: Center(
        child: GestureDetector(
          onTap: (){
            setState(() {
              isPressed = !isPressed;
            });
          },
          child: Container(
            width: _width/1.5,
            height: _width/1.5,
            decoration: BoxDecoration(
              color: const Color(0xFFE7ECEF),
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: distance,
                  blurRadius: blur,
                  inset: isPressed

                ),
                BoxShadow(
                  color: Colors.white,
                  offset: -distance,
                  blurRadius: blur,
                  inset: isPressed
                ),
              ]
            ),
            padding: const EdgeInsets.all(100),
            child: Column(
              children: [
                Text('data')
              ],
            ),
          ),
        ),
      ),
    );
  }
}