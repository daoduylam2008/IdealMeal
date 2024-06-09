import 'package:flutter/material.dart';
import 'package:ideal_meal/FileManager.dart';
import 'package:ideal_meal/constant.dart';

class History extends StatelessWidget {
  @override
  Widget build(context) {
    MealStorage storage = MealStorage();
    var data = processCsv("assets/test/test.csv");

    return FutureBuilder(
      future: Future.wait([storage.readMealData(), data]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          var meal = snapshot.data![0];
          Map<String, List<String>> d = dayMeal(snapshot.data![1]);
          List<String> date = d.keys.toList();
          return ListView.builder(
              itemCount: d.length,
              itemBuilder: (context, index) {
                return Item(
                    meal: meal[date[index]].toString(), date: DateTime.now());
              });
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

class Item extends StatelessWidget {
  Item({super.key, required this.meal, required this.date});
  final String meal;
  final DateTime date;

  String day = "";

  @override
  Widget build(context) {
    if (date.day.toString().length == 1) {
      day = "0${date.day}";
    } else {
      day = "${date.day}";
    }
    String dateString = "${date.day}/${date.month}/${date.year}";
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: EdgeInsets.only(
            left: constraints.maxWidth * 31 / 430,
            right: constraints.maxWidth * 31 / 430,
            top: 12,
            bottom: 12),
        child: Row(
          children: [
            Container(
                width: 98,
                height: 77,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(243, 243, 243, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(day,
                        style: font(20, Colors.black, FontWeight.normal)),
                    Text(dateDate[dateToDay(date)] ?? "N/A", style: font(20, Colors.black, FontWeight.bold)),
                  ],
                )),
            SizedBox(width: constraints.maxWidth * 14 / 430),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: constraints.maxWidth* 255/430,
                  child: Text(meal, style: font(20, Colors.black, FontWeight.bold))),
                Text(dateString)
                ],
            )
          ],
        ),
      );
    });
  }
}
