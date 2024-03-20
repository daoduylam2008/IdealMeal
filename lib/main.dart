import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_attendance/ResponseAPi.dart';
import 'package:student_attendance/constant.dart';
import 'package:student_attendance/DataTester.dart';
import 'HomeView.dart';
import 'MealView.dart';
import 'OrderView.dart';
import 'ProfileView.dart';

void main() {
  runApp(const MyApp());
}

String iconPath(String name) {
  return "assets/icons/$name icon.png";
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: accentColor),
          useMaterial3: true,
          primarySwatch: Colors.blue),
      home: const MainView(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({super.key, required this.title});
  final String title;

  @override
  State<MainView> createState() => _MainView();
}

class _MainView extends State<MainView> {
  int selection = 0;

  void onTabPressed(int selector) {
    setState(() {
      selection = selector;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: IndexedStack(index: selection, children: [
        const HomeView(),
        const MealView(),
        const OrderView(),
        const ProfileView(),
      ]),
      bottomNavigationBar: SafeArea(
          child: Stack(
            children: [
        Container(
            height: 70,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 37, vertical: 32),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(231, 231, 231, .5),
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Home tab
                InkWell(
                  onTap: () {
                    setState(
                      () {
                        selection = 0;
                      },
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(
                        iconPath("home"),
                        color: selection == 0 ? Colors.black : null,
                      )),
                ),

                // Meal tab
                InkWell(
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(
                        iconPath("meal"),
                        color: selection == 1 ? Colors.black : null,
                      )),
                  onTap: () {
                    setState(
                      () {
                        selection = 1;
                      },
                    );
                  },
                ),

                // Order tab
                InkWell(
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(
                        iconPath("order"),
                        color: selection == 2 ? Colors.black : null,
                      )),
                  onTap: () {
                    setState(
                      () {
                        selection = 2;
                      },
                    );
                  },
                ),

                // Profile tab
                InkWell(
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(
                        iconPath("profile"),
                        color: selection == 3 ? Colors.black : null,
                      )),
                  onTap: () {
                    setState(
                      () {
                        selection = 3;
                      },
                    );
                  },
                ),
              ],
            ))
      ])),
    );
  }
}
