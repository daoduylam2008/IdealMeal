import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/mobile_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ideal_meal/constant.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  bool _showPassword = true;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> isLogin;

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    final SharedPreferences prefs = await _prefs;
    const bool _isLogin = true;

    setState(() {
      isLogin = prefs.setBool('isLogin', _isLogin).then((bool success) {
        return isLogin;
      });
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MobileScaffold()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("Login", style: font(30, Colors.black, FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: LayoutBuilder(builder: (context, constraints) {
            return Padding(
                padding: EdgeInsets.only(
                  right: constraints.maxWidth * 30 / 430,
                  left: constraints.maxWidth * 30 / 430,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 59,
                      width: constraints.maxWidth * 369 / 430,
                      child: TextField(
                        controller: usernameController,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromRGBO(231, 231, 231, .5),
                          hintText: "Email",
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
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 59,
                      width: constraints.maxWidth * 369 / 430,
                      child: TextField(
                        cursorColor: Colors.black,
                        obscuringCharacter: "●",
                        obscureText: _showPassword,
                        controller: passwordController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                              icon: (_showPassword == false)
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility)),
                          filled: true,
                          fillColor: const Color.fromRGBO(231, 231, 231, .5),
                          hintText: "Password",
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
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        onTap: signIn,
                        child: Container(
                            decoration: const BoxDecoration(
                              gradient: linearColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            width: constraints.maxWidth * 368 / 430,
                            height: 62,
                            child: Center(
                                child: Text("Sign in",
                                    style: font(20, Colors.white,
                                        FontWeight.normal))))),
                  ],
                ));
          }),
        ));
  }
}
