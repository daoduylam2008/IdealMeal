import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:ideal_meal/constant.dart';

// import 'package:ideal_meal/ResponseAPi.dart';
// import 'package:ideal_meal/constant.dart';
// import 'package:ideal_meal/DataTester.dart';
import 'HomeView.dart';
import 'OrderView.dart';
import 'MealView.dart';
import 'ProfileView.dart';

Map<String, String> meal_data = {};

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffold();
}

class _MobileScaffold extends State<MobileScaffold> {
  int selection = 0;
  late String appBarTitle;

  final _view = [
    const HomeView(),
    const MealView(),
    const OrderView(),
    const ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    if (selection == 0) {
      appBarTitle = "Meal";
    } else if (selection == 1) {
      appBarTitle = "Meal";
    } else if (selection == 2) {
      appBarTitle = "Order";
    } else if (selection == 3) {
      appBarTitle = "Meal";
    } else {
      appBarTitle = "App Bar";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: (selection == 3)
          ? null
          : AppBar(
              backgroundColor: appBarBackground,
              scrolledUnderElevation: 0,
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: Text(appBarTitle,
                  style: font(30, Colors.black, FontWeight.bold)),
            ),
      body: IndexedStack(index: selection, children: _view),
      bottomNavigationBar: SizedBox(
        child: LayoutBuilder(
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
                                appBarTitle = "Meal";
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
      ),
    );
  }
}
