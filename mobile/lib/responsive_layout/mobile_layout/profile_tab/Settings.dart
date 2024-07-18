import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ideal_meal/constant.dart';
import "PasswordChanging.dart";

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _Settings();
}

class _Settings extends State<Settings> {
  var user = userTest;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> isLogin;

  Future<void> signOut() async {
    final SharedPreferences prefs = await _prefs;
    const bool _isLogin = false;

    setState(() {
      isLogin = prefs.setBool('isLogin', _isLogin).then((bool success) {
        return isLogin;
      });
    });
    Phoenix.rebirth(context);
  }

  void loginSwitch(bool value) {
    setState(() {
      biometricsLogin = value;
    });
  }

  @override
  void initState() {
    isLogin = _prefs.then((pref) {
      return pref.getBool('isLogin') ?? true;
    });
  }

  Widget _view() {
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
                    trackOutlineWidth: const WidgetStatePropertyAll(0),
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: const Color.fromRGBO(200, 200, 200, .8),
                    activeColor: const Color.fromARGB(184, 56, 223, 70),
                    thumbColor: const WidgetStatePropertyAll(Colors.white),
                    value: biometricsLogin,
                    onChanged: loginSwitch)
              ]),
              const SizedBox(height: 120),
              InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  onTap: signOut,
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

  @override
  Widget build(context) {
    setState(() {
      user = userTest;
    });
    return FutureBuilder(
        future: isLogin,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                if (snapshot.data == true) {
                  return _view();
                } else {
                  return CircularProgressIndicator();
                }
              }
          }
        });
  }
}
