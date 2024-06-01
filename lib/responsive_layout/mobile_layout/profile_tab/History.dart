import 'package:flutter/material.dart';
import 'package:ideal_meal/FileManager.dart';

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
          print(d.length);
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
  const Item({super.key, required this.meal, required this.date});
  final String meal;
  final DateTime date;

  @override
  Widget build(context) {
    String dateString = "${date.day}/${date.month}/${date.year}";
    return Row(
      children: [
        Container(),
        Container(
            child: Column(
          children: [Text(meal), Text(dateString)],
        ))
      ],
    );
  }
}
