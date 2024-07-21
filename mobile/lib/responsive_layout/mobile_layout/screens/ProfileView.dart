// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:ideal_meal/constant.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/profile_tab/History.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/profile_tab/MyProfile.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/profile_tab/Settings.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileView();
}

class _ProfileView extends State<ProfileView> with TickerProviderStateMixin {
  TabController? tabController;
  int _selection = 0;

  final selectedColor = Colors.white;

  final tabs = [
    const Tab(text: "Profile"),
    const Tab(text: "History"),
    const Tab(text: "Settings")
  ];

  var tab_view = [
    const MyProfile(),
    const History(),
    const Settings(),
  ]; 

  void onTap (int selection) {
    setState(() {
      _selection = selection;
    });
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SafeArea(
          child: Container(
            color: Colors.white,
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              const SizedBox(height: 36),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                // Show student's profile
                Container(
                    width: 73,
                    height: 73,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 4),
                            blurRadius: 15)
                      ],
                      color: Color.fromRGBO(242, 242, 242, 1),
                      borderRadius: BorderRadius.all(Radius.elliptical(73, 73)),
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Show student's name firstly
                    Text(student.name,
                        style: font(20, Colors.black, FontWeight.bold)),
                    // Show student's information
                    Row(children: [
                      Container(
                        padding: const EdgeInsets.only(
                          top: 5,
                          right: 20,
                        ),
                        child: Row(
                          children: [
                            Text("Room  ",
                                style: font(
                                    15,
                                    myGrey,
                                    FontWeight.normal)),
                            Text(student.room,
                                style: font(20, Colors.black, FontWeight.bold)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 5,
                          left: 20,
                        ),
                        child: Row(
                          children: [
                            Text("Class  ",
                                style: font(
                                    15,
                                    myGrey,
                                    FontWeight.normal)),
                            Text(student.cls,
                                style: font(20, Colors.black, FontWeight.bold))
                          ],
                        ),
                      )
                    ])
                  ],
                ),
              ]),
              const SizedBox(height: 49),
              // Use tabbar to separate user's information
              Container(
                width: constraints.maxWidth*0.85,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TabBar(
                  dividerColor: Colors.white,
                  overlayColor: WidgetStateColor.transparent,
                  indicatorPadding: const EdgeInsets.all(5),
                  indicatorSize: TabBarIndicatorSize.tab,
                  controller: tabController,
                  indicator: BoxDecoration(boxShadow: const [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 4),
                        blurRadius: 15)
                  ], borderRadius: BorderRadius.circular(7.0), color: selectedColor),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: tabs,
                  onTap: onTap,
                ),
              ),
              const SizedBox(height: 27),
              // Navigation tab
              SizedBox(
                height: constraints.maxHeight*(530/932),
                child: tab_view[_selection])
            ]),
          ),
        );
      }
    );
  }
}
