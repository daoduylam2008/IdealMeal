import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:student_attendance/constant.dart';

// import 'package:student_attendance/ResponseAPi.dart';
// import 'package:student_attendance/constant.dart';
// import 'package:student_attendance/DataTester.dart';
import 'HomeView.dart';
import 'MealView.dart';
import 'OrderView.dart';
import 'ProfileView.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffold();
}

class _MobileScaffold extends State<MobileScaffold> {
  int selection = 0;
  late Offset offset;
  late String appBarTitle;

  @override
  void initState() {
    super.initState();
    if (selection == 0) {
      offset = homeOffset;
      appBarTitle = "Meal";
    } else if (selection == 1) {
      offset = mealOffset;
      appBarTitle = "Meal";
    } else if (selection == 2) {
      offset = orderOffset;
      appBarTitle = "Order";
    } else if (selection == 3) {
      offset = profileOffset;
      appBarTitle = "Meal";
    } else {
      offset = Offset.zero;
      appBarTitle = "App Bar";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  (selection==3) ? null :AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Container(
            child: Text(appBarTitle,
                style: font(30, Colors.black, FontWeight.bold))),
      ),
      body: IndexedStack(index: selection, children: const [
        HomeView(),
        MealView(),
        OrderView(),
        ProfileView(),
      ]),
      bottomNavigationBar: LayoutBuilder(
        builder: ((context, constraints) {
          return SafeArea(
              child: Stack(children: [
            AnimatedPositioned(
                duration: const Duration(milliseconds: 350),
                top: offset.dy,
                left: offset.dx,
                child: Container(
                    width: 17,
                    height: 17,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(1),
                        topRight: Radius.circular(1),
                        bottomLeft: Radius.circular(1),
                        bottomRight: Radius.circular(1),
                      ),
                      color: Color.fromRGBO(0, 0, 0, 1),
                    ))),
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 37, vertical: 32),
                child: BlurryContainer(
                  blur: 15,
                  width: constraints.maxWidth*(368/430),
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
                              offset = Offset(constraints.maxWidth*79/430, blackRectDY);
                              appBarTitle = "Up Coming";
                            },
                          );
                        },
                        child: Container(
                            padding: EdgeInsets.all(constraints.maxWidth*5/430),
                            child: Image.asset(
                              iconPath("home"),
                              color: selection == 0 ? Colors.black : null,
                            )),
                      ),

                      // Meal tab
                      InkWell(
                        child: Container(
                            padding: EdgeInsets.all(constraints.maxWidth*5/430),
                            child: Image.asset(
                              iconPath("meal"),
                              color: selection == 1 ? Colors.black : null,
                            )),
                        onTap: () {
                          setState(
                            () {
                              selection = 1;
                              offset = Offset(constraints.maxWidth*166/430, blackRectDY);
                              appBarTitle = "Meal";
                            },
                          );
                        },
                      ),

                      // Order tab
                      InkWell(
                        child: Container(
                            padding: EdgeInsets.all(constraints.maxWidth*5/430),
                            child: Image.asset(
                              iconPath("order"),
                              color: selection == 2 ? Colors.black : null,
                            )),
                        onTap: () {
                          setState(
                            () {
                              selection = 2;
                              offset = Offset(constraints.maxWidth*250.5/430, blackRectDY);
                              appBarTitle = "Order";
                            },
                          );
                        },
                      ),

                      // Profile tab
                      InkWell(
                        child: Container(
                            padding: EdgeInsets.all(constraints.maxWidth*5 /430),
                            child: Image.asset(
                              iconPath("profile"),
                              color: selection == 3 ? Colors.black : null,
                            )),
                        onTap: () {
                          setState(
                            () {
                              selection = 3;
                              offset = Offset(constraints.maxWidth*334.5/430, blackRectDY);
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
}
