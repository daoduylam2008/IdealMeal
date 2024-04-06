import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';

import 'package:student_attendance/constant.dart';
import "PasswordChanging.dart";

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  var user = userTest;
  var biometricsLogin = false;

  void loginSwitch(bool value) {
    setState(() {
      biometricsLogin = value;
    });
  }

  @override
  Widget build(context) {
    return SafeArea(
        child: Padding(
            padding: const EdgeInsets.only(left: 31),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Password",
                    style: font(15, const Color.fromRGBO(150, 150, 150, 1),
                        FontWeight.normal)),
                const SizedBox(height: 7),
                Text("●" * user.password.length,
                    style: const TextStyle(
                        fontSize: 15)),
                const SizedBox(height: 20),
                InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const PasswordChanging())));
                    },
                    child: BlurryContainer(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        height: 62,
                        width: 368,
                        color: const Color.fromRGBO(231, 231, 231, .5),
                        child: Center(
                            child: Text("Change Password",
                                style: font(
                                    20, Colors.black, FontWeight.normal))))),
                const SizedBox(height: 51),
                Row(children: [
                  Text("Log in with biometrics",
                      style: font(20, Colors.black, FontWeight.bold)),
                  const SizedBox(width: 70),
                  Switch(value: biometricsLogin, onChanged: loginSwitch)
                ])
              ],
            )));
  }
}
