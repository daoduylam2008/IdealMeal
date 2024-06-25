import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:ideal_meal/constant.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key, 
    required this.name,
    required this.cls,
    required this.address,
    required this.birth
  });

  final String name;
  final String address;
  final String cls;
  final String birth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double fitWidth(double width) {
        return width * constraints.maxWidth / 430;
      }

      return Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(11)),
          side: BorderSide(
            width: 8,
            color: Color.fromRGBO(242, 242, 242, 1),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(11)),
            color: Colors.white,
          ),
          height: fitWidth(249),
          width: fitWidth(401),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        "assets/frame/profile_frame.png",
                        fit: BoxFit.contain,
                      ),
                      Image.asset("assets/frame/profile.png",
                          fit: BoxFit.contain)
                    ],
                  ),
                  Image.asset("assets/images/logo.png", fit: BoxFit.contain)
                ],
              ),
              SizedBox(width: fitWidth(14)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "Name:  ", style: font(16, Colors.black, FontWeight.bold)),
                      TextSpan(text: name, style: font(16, Colors.black, FontWeight.normal)),
                    ]
                  ),
                  ),
                  RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "Lớp:  ", style: font(16, Colors.black, FontWeight.bold)),
                      TextSpan(text: cls, style: font(16, Colors.black, FontWeight.normal)),
                    ]
                  ),
                  ),
                  RichText(text: TextSpan(
                    children: [
                      TextSpan(text: "Ngày sinh:  ", style: font(16, Colors.black, FontWeight.bold)),
                      TextSpan(text: birth, style: font(16, Colors.black, FontWeight.normal)),
                    ]
                  ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("Địa chỉ:  ", style: font(16, Colors.black, FontWeight.bold)),
                    SizedBox(width: 200, child: Column(
                      children: [
                        Text(address, softWrap: true, maxLines: 5, overflow: TextOverflow.clip, style: font(16, Colors.black, FontWeight.normal),),
                      ],
                    ))
                  ],)
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
