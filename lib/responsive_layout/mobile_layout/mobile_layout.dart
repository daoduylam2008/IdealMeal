import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:ideal_meal/FileManager.dart';
import 'package:ideal_meal/constant.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/Widget/MyIndexedStack.dart';

import 'screens/HomeView.dart';
import 'screens/OrderView.dart';
import 'screens/MealView.dart';
import 'screens/ProfileView.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffold();
}

class _MobileScaffold extends State<MobileScaffold> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> isLogin;

  int selection = 0;
  late String appBarTitle;

  final _view = [
    HomeView(datetime: Date()),
    MealView(storage: MealStorage(), datetime: Date()),
    OrderView(storage: MealStorage(), datetime: Date()),
    const ProfileView(),
  ];

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> signIn() async {
    final SharedPreferences prefs = await _prefs;
    const bool _isLogin = true;

    setState(() {
      isLogin = prefs.setBool('isLogin', _isLogin).then((bool success) {
        return isLogin;
      });
    });
    Phoenix.rebirth(context);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Create SharedPreference value, particularly islogin
    isLogin = _prefs.then((pref) {
      return pref.getBool('isLogin') ?? false;
    });

    if (selection == 0) {
      appBarTitle = "Up coming";
    } else if (selection == 1) {
      appBarTitle = "Meals";
    } else if (selection == 2) {
      appBarTitle = "Order";
    } else if (selection == 3) {
      appBarTitle = "";
    } else {
      appBarTitle = "App Bar";
    }
  }

  Widget userScreen() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: (selection == 3)
          ? null
          : AppBar(
              backgroundColor:
                  (selection == 0) ? Colors.white : appBarBackground,
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: Text(appBarTitle,
                  style: font(30, Colors.black, FontWeight.bold)),
            ),
      body: MyIndexedStack(
          reload: const [0, 1, 3],
          duration: const Duration(milliseconds: 200),
          axis: Axis.horizontal,
          index: selection,
          slideOffset: 0.3,
          children: _view),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: LayoutBuilder(
        builder: ((context, constraints) {
          return SafeArea(
              child: Stack(children: [
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 37, vertical: 32),
                child: BlurryContainer(
                  blur: 14,
                  width: constraints.maxWidth * (368 / 430),
                  height: 70,
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  color: const Color.fromRGBO(231, 231, 231, .5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Home tab
                      InkWell(
                        onTap: () {
                          setState(
                            () {
                              selection = 0;
                              appBarTitle = "Up Coming";
                            },
                          );
                        },
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            child: Image.asset(
                              iconPath("home"),
                              color: selection == 0 ? Colors.black : null,
                            )),
                      ),

                      // Meal tab
                      InkWell(
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            child: Image.asset(
                              iconPath("meal"),
                              color: selection == 1 ? Colors.black : null,
                            )),
                        onTap: () {
                          setState(
                            () {
                              selection = 1;
                              appBarTitle = "Meals";
                            },
                          );
                        },
                      ),

                      // Order tab
                      InkWell(
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            child: Image.asset(
                              iconPath("order"),
                              color: selection == 2 ? Colors.black : null,
                            )),
                        onTap: () {
                          setState(
                            () {
                              selection = 2;
                              appBarTitle = "Order";
                            },
                          );
                        },
                      ),

                      // Profile tab
                      InkWell(
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            child: Image.asset(
                              iconPath("profile"),
                              color: selection == 3 ? Colors.black : null,
                            )),
                        onTap: () {
                          setState(
                            () {
                              selection = 3;
                              appBarTitle = "Meal";
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ))
          ]));
        }),
      ),
    );
  }

  Widget loginScreen() {
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
                        controller: passwordController,
                        decoration: InputDecoration(
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
                                child: Text("Sign out",
                                    style: font(20, Colors.white,
                                        FontWeight.normal))))),
                  ],
                ));
          }),
        ));
  }

  @override
  Widget build(BuildContext context) {
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
                  return userScreen();
                } else {
                  return loginScreen();
                }
              }
          }
        });
  }
}
