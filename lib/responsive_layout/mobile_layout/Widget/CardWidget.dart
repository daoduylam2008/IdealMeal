import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:ideal_meal/constant.dart';

class CardWidget extends StatelessWidget {

  const CardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            side: BorderSide(
              width: 8,
              color: Color.fromRGBO(242, 242, 242, 1),
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(11)),
              color: Colors.white,
            ),
            height: 249*constraints.maxWidth/430,
            width: 401*constraints.maxWidth/430,
            child: Column(
              children: [
              SafeArea(
                child: ListTile(
                  leading: Column(
                    children: [
                    Image.asset("assets/frame/profile_frame.png")
                  ],),
                ),
              )
            ],),
          ),
        );
      }
    );
  }
}
