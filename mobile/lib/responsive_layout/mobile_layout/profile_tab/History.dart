import 'package:flutter/material.dart';
import 'package:ideal_meal/API/ResponseAPi.dart';
import 'package:ideal_meal/constant.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/Widget/CircularProgressIndicator.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/Widget/Item.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _History();
}

class _History extends State<History> with TickerProviderStateMixin{
  late Future<Map<String, dynamic>> data;
  late AnimationController _animationController;


  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
    data = fetchCalendar();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(context) {
    return FutureBuilder(
        future: data,
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            List meals = snapshot.data!.values.toList();
            List dates = snapshot.data!.keys.toList();

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
              return Item(
                date: YYYYMMDDtoDate(dates[index]),
                meal: meals[index],
              );
            });
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotationTransition(
                  turns:
                      Tween(begin: 0.0, end: 1.0).animate(_animationController),
                  child: const GradientCircularProgressIndicator(
                    radius: 30,
                    gradientColors: [
                      Colors.white,
                      Color.fromRGBO(45, 154, 255, .9),
                      Color.fromRGBO(255, 51, 112, .9),
                    ],
                    strokeWidth: 4.0,
                  ),
                ),
                const Text("Loading..."),
              ],
            ),
          );        });
  }
}
