import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:student_attendance/constant.dart';

class PasswordChanging extends StatefulWidget {
  PasswordChanging({super.key});

  User user = userTest;

  @override
  State<PasswordChanging> createState() => _PasswordChanging();
}

class _PasswordChanging extends State<PasswordChanging> {
  bool _showOldPassword = true;
  bool _showNewPassword = true;
  bool _showConfirmPassword = true;

  void oldPasswordPressed(value) {}

  void newPasswordpressed(value) {}

  void confirmPasswordPressed(value) {}

  @override
  Widget build(context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Text("Change password",
                style: font(30, Colors.black, FontWeight.bold)),
            leading: const BackButton(
              color: myGrey,
            )),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 34),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 29),
              // Old password widgets
              Text("Old password",
                  style: font(15, myGrey,
                      FontWeight.normal)),
              const SizedBox(height: 5),
              SizedBox(
                  height: 59,
                  width: 368,
                  child: TextField(
                      obscureText: _showOldPassword,
                      obscuringCharacter: "●",
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showOldPassword = !_showOldPassword;
                              });
                            },
                            icon: (_showOldPassword == true)
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                        suffixIconColor: myGrey,
                        filled: true,
                        fillColor: const Color.fromRGBO(231, 231, 231, .5),
                        hintText: "Old Password",
                        hintStyle: font(
                            20,
                            myGrey,
                            FontWeight.normal),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ))),
              const SizedBox(height: 26),
              // New password widgets
              Text("New password",
                  style: font(15, myGrey,
                      FontWeight.normal)),
              const SizedBox(height: 5),
              SizedBox(
                  height: 59,
                  width: 368,
                  child: TextField(
                      obscureText: _showNewPassword,
                      obscuringCharacter: "●",
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showNewPassword = !_showNewPassword;
                              });
                            },
                            icon: (_showNewPassword == true)
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                        suffixIconColor: myGrey,
                        filled: true,
                        fillColor: const Color.fromRGBO(231, 231, 231, .5),
                        hintText: "New Password",
                        hintStyle: font(
                            20,
                            myGrey,
                            FontWeight.normal),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ))),
              const SizedBox(height: 26),
              // Confirm password widgets
              Text("Confirm password",
                  style: font(15, myGrey,
                      FontWeight.normal)),
              const SizedBox(height: 5),
              SizedBox(
                  height: 59,
                  width: 368,
                  child: TextField(
                      obscureText: _showConfirmPassword,
                      obscuringCharacter: "●",
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showConfirmPassword = !_showConfirmPassword;
                              });
                            },
                            icon: (_showConfirmPassword == true)
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                        suffixIconColor: myGrey,
                        filled: true,
                        fillColor: const Color.fromRGBO(231, 231, 231, .5),
                        hintText: "Confirm Password",
                        hintStyle: font(
                            20,
                            myGrey,
                            FontWeight.normal),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ))),
            ],
          ),
        )),
        bottomNavigationBar: SafeArea(
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 37, vertical: 32),
              child: BlurryContainer(
                  blur: 14,
                  width: 368,
                  height: 72,
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: const Color.fromRGBO(231, 231, 231, .5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 72,
                          width: 150,
                          child: IconButton(
                              splashRadius: 1,
                              padding: const EdgeInsets.all(0.0),
                              icon: const Icon(Icons.check, size: 34),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ),
                        SizedBox(
                          height: 72,
                          width: 150,
                          child: IconButton(
                              padding: const EdgeInsets.all(0.0),
                              icon: const Icon(Icons.close, size: 34),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ),
                      ]))),
        ));
  }
}
