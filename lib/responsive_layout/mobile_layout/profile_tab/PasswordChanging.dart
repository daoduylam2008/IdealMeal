import 'package:flutter/material.dart';
import 'package:student_attendance/constant.dart';


class PasswordChanging extends StatefulWidget {
  const PasswordChanging({super.key});

  @override
  State<PasswordChanging> createState() => _PasswordChanging();
}

class _PasswordChanging extends State<PasswordChanging> {
  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Text("Change password",
                style: font(30, Colors.black, FontWeight.bold)),
            leading: const BackButton(
              color: Color.fromRGBO(150, 150, 150, 1),
            )),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Old password",
                  style: font(15, const Color.fromRGBO(150, 150, 150, 1),
                      FontWeight.normal)),
            SizedBox(
                height: 59,
                width: 368,
                child: TextField(
                  obscureText: true,
                  obscuringCharacter: "●",
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(231, 231, 231, .5),
                    hintText: "Old Password",
                    hintStyle: font(20, const Color.fromRGBO(150, 150, 150, 1),
                      FontWeight.normal),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                    ),
                  )
              )
              )
            ],
          ),
        )));
  }
}
