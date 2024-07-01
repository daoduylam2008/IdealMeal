import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ideal_meal/constant.dart';

class PasswordChanging extends StatefulWidget {
  PasswordChanging({super.key});

  User user = userTest;

  @override
  State<PasswordChanging> createState() => _PasswordChanging();
}

class _PasswordChanging extends State<PasswordChanging> {
  String error = "";

  bool _showOldPassword = true;
  bool _showNewPassword = true;
  bool _showConfirmPassword = true;

  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: font(17, Colors.black, FontWeight.normal)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget yesButton = TextButton(
      child: Text("Yes", style: font(17, Colors.black, FontWeight.normal)),
      onPressed: () {
        setState(() {
          Navigator.pop(context);
          Navigator.pop(context);
          userTest.password = confirmPassController.text;
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      surfaceTintColor: Colors.white,
      content: Text("Are you sure to change your password?",
          style: font(20, Colors.black, FontWeight.normal)),
      actions: [
        cancelButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    oldPassController.dispose();
    newPassController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: false,
            title: Text("Change password",
                style: font(30, Colors.black, FontWeight.bold)),
            leading: const BackButton(
              color: myGrey,
            )),
        body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.only(
              left: constraints.maxWidth * (31 / 430),
              right: constraints.maxWidth * (31 / 430),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 29),
                // Old password widgets
                Text("Old password",
                    style: font(15, myGrey, FontWeight.normal)),
                const SizedBox(height: 5),
                SizedBox(
                    height: 59,
                    width: constraints.maxWidth * 368 / 430,
                    child: TextField(
                        controller: oldPassController,
                        cursorColor: Colors.black,
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
                          hintStyle: font(20, myGrey, FontWeight.normal),
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
                    style: font(15, myGrey, FontWeight.normal)),
                const SizedBox(height: 5),
                SizedBox(
                    height: 59,
                    width: constraints.maxWidth * 368 / 430,
                    child: TextField(
                        controller: newPassController,
                        cursorColor: Colors.black,
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
                          hintStyle: font(20, myGrey, FontWeight.normal),
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
                    style: font(15, myGrey, FontWeight.normal)),
                const SizedBox(height: 5),
                SizedBox(
                    height: 59,
                    width: constraints.maxWidth * 368 / 430,
                    child: TextField(
                        controller: confirmPassController,
                        cursorColor: Colors.black,
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
                          hintStyle: font(20, myGrey, FontWeight.normal),
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
                Text(error, style: font(17, Colors.red, FontWeight.normal)),
              ],
            ),
          );
        })),
        bottomNavigationBar: LayoutBuilder(builder: (context, constraints) {
          return SafeArea(
            child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 37, vertical: 32),
                child: BlurryContainer(
                    blur: 14,
                    width: constraints.maxWidth * 368 / 430,
                    height: 72,
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    color: const Color.fromRGBO(231, 231, 231, .5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 72,
                            width: constraints.maxWidth * 150 / 430,
                            child: IconButton(
                                splashRadius: 1,
                                padding: const EdgeInsets.all(0.0),
                                icon: const Icon(Icons.check, size: 34),
                                onPressed: () {
                                  User user = userTest;
                                  if (oldPassController.text != user.password) {
                                    setState(() {
                                      error = "Your old password is not fitted";
                                    });
                                  } else if (newPassController.text !=
                                      confirmPassController.text) {
                                    setState(() {
                                      error = "Confirm your password again";
                                    });
                                  } else {
                                    showAlertDialog(context);
                                  }
                                }),
                          ),
                          SizedBox(
                            height: 72,
                            width: constraints.maxWidth * 150 / 430,
                            child: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                icon: const Icon(Icons.close, size: 34),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ),
                        ]))),
          );
        }));
  }
}
