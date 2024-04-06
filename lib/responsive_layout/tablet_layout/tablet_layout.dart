import 'package:flutter/material.dart';
import 'package:student_attendance/ResponseAPi.dart';
import 'package:student_attendance/constant.dart';
import 'package:student_attendance/DataTester.dart';
import 'package:student_attendance/responsive_layout/desktop_layout/desktop_home.dart';
import 'package:student_attendance/responsive_layout/desktop_layout/desktop_profile.dart';

class TabletScaffold extends StatefulWidget {
  const TabletScaffold({super.key});

  @override
  State<TabletScaffold> createState() => _TabletScaffoldState();
}

class _TabletScaffoldState extends State<TabletScaffold> {
  int _selectedIndex = 0;
  List<Widget> view = [
    const Home(),
    const Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: const Text(
          'Ideal Meal',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Divider(
            color: Color.fromRGBO(220, 220, 220, 1),
            thickness: 2,
            height: 2,
          ),  
        ),
      ),
      body: Row(
        children: [
          NavigationRail(
            minWidth: 70,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (value) {
              _selectedIndex = value;
            },
            destinations: [
              NavigationRailDestination(
                icon: Image.asset(
                  iconPath('home'),
                  color: _selectedIndex == 0 ? Colors.black : null
                ), 
                label: const Text('Home'),
              ),
              NavigationRailDestination(
                icon: Image.asset(
                  iconPath('profile'),
                  color: _selectedIndex == 1 ? Colors.black : null
                ), 
                label: const Text('Profile')
              ),
            ],
          ),
          const VerticalDivider(thickness: 2, color: Color.fromRGBO(220, 220, 220, 1),),

        ],
      ),
    );
  }
}