import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';

import 'package:ideal_meal/constant.dart';
import "PasswordChanging.dart";

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  var user = userTest;

  void loginSwitch(bool value) {
    setState(() {
      biometricsLogin = value;
    });
  }

  @override
  Widget build(context) {
    setState(() {
      user = userTest;
    });
    return LayoutBuilder(builder: ((context, constraints) {
      return SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
              left: constraints.maxWidth * (31 / 430),
              right: constraints.maxWidth * (31 / 430)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Password",
                  style: font(15, const Color.fromRGBO(150, 150, 150, 1),
                      FontWeight.normal)),
              const SizedBox(height: 7),
              Text("●" * user.password.length,
                  style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 20),
              InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => PasswordChanging())));
                  },
                  child: BlurryContainer(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      width: constraints.maxWidth * 368 / 430,
                      height: 62,
                      color: const Color.fromRGBO(231, 231, 231, .5),
                      child: Center(
                          child: Text("Change Password",
                              style:
                                  font(20, Colors.black, FontWeight.normal))))),
              const SizedBox(height: 51),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Auto-login",
                    style: font(20, Colors.black, FontWeight.bold)),
                Switch(
                    trackOutlineWidth: const MaterialStatePropertyAll(0),
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: const Color.fromRGBO(200, 200, 200, .8),
                    activeColor: const Color.fromARGB(184, 56, 223, 70),
                    thumbColor: const MaterialStatePropertyAll(Colors.white),
                    value: biometricsLogin,
                    onChanged: loginSwitch)
              ]),
              const SizedBox(height: 120),
              InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  onTap: () {
                    print("Sign out");
                  },
                  child: BlurryContainer(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      width: constraints.maxWidth * 368 / 430,
                      height: 62,
                      color: const Color.fromRGBO(231, 231, 231, .5),
                      child: Center(
                          child: Text("Sign out",
                              style:
                                  font(20, Colors.black, FontWeight.normal))))),
            ],
          ),
        ),
      );
    }));
  }
}
