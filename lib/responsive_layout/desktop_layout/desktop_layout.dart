import 'package:flutter/material.dart';
import 'package:ideal_meal/ResponseAPi.dart';
import 'package:ideal_meal/constant.dart';
import 'package:ideal_meal/DataTester.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/mobile_layout.dart';
import 'desktop_home.dart';
import 'desktop_profile.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({super.key});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  var view = WidgetsBinding.instance.platformDispatcher.views.first;
  int _selectedIndex = 0;
  TextStyle textFont(String color, double size){
    size/= view.devicePixelRatio;
    return color == 'black' ? TextStyle(color:Colors.black, fontSize: size, fontWeight: FontWeight.bold) : TextStyle(color: const Color.fromRGBO(187, 187, 187, 1), fontSize: size);
  }
  final List<Widget> _screen = [
    const Home(),
    const Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Placeholder(color: Colors.white10),
        leadingWidth: 5/view.devicePixelRatio,
        toolbarHeight: 70/view.devicePixelRatio,
        backgroundColor: Colors.white10,
        title: Text(
          'Ideal Meal',
          style: textFont('black', 30),
        ),
        centerTitle: false,
      ),
      
      body: Row(
        children: [
          Container(
            width: 72/view.devicePixelRatio,
            decoration: BoxDecoration(
              color: Colors.white10,
              border: Border(
                top: BorderSide(
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  width: 2/view.devicePixelRatio,
                ),
                right: BorderSide(
                  color: const Color.fromRGBO(220, 220, 220, 1),
                  width: 2/view.devicePixelRatio,
                ),
              )
            ),
            child: NavigationRail(
              indicatorColor: const Color.fromRGBO(220, 220, 220, 1),
              useIndicator: false,
              minWidth: 70/view.devicePixelRatio,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: [
                NavigationRailDestination(
                  icon: Image.asset(
                    iconPath('home'),
                    color: _selectedIndex == 0 ? Colors.black : null
                  ),
                  label: const Text('Home')
                ),
                NavigationRailDestination(
                  icon: Image.asset(
                    iconPath('profile'),
                    color: _selectedIndex == 1 ? Colors.black : null
                  ),
                  label: const Text('Profile')
                )
              ],
            ),
          ),
          Expanded(
            child: _screen[_selectedIndex],
          )
        ],
      )
    );
  }
}
