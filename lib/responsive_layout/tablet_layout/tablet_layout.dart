import 'package:flutter/material.dart';
import 'package:ideal_meal/constant.dart';
import 'tablet_home.dart';
import 'tablet_profile.dart';

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
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: (_width/3)/5,
        title: Text(
          'Ideal Meal',
          style: font(30, Colors.black, FontWeight.bold)
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
          Container(
            width: ((_width/3)/5)+2,
            decoration: const BoxDecoration(
              color: Colors.white10,
              border: Border(
                right: BorderSide(
                  color: Color.fromRGBO(220, 220, 220, 1),
                  width: 2,
                ),
              )
            ),
            child: NavigationRail(
              indicatorColor: const Color.fromRGBO(220, 220, 220, 1),
              useIndicator: false,
              minWidth: (_width/3)/5,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: [
                NavigationRailDestination(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  icon: Center(
                    child: Image.asset(
                      iconPath('home'),
                      color: _selectedIndex == 0 ? Colors.black : null
                    ),
                  ), 
                  label: const Text('Home'),
                ),
                NavigationRailDestination(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  icon: Center(
                    child: Image.asset(
                      iconPath('profile'),
                      color: _selectedIndex == 1 ? Colors.black : null
                    ),
                  ), 
                  label: const Text('Profile')
                ),
              ],
            ),
          ),
          //const VerticalDivider(thickness: 2, color: Color.fromRGBO(220, 220, 220, 1),),
          Expanded(
            child: view[_selectedIndex],
          )
        ],
      ),
    );
  }
}