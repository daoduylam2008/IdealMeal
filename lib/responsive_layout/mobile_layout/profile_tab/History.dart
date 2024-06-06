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
          return ListView.builder(
              itemCount: d.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Item(
                      meal: meal[date[index]].toString(), date: DateTime.now()),
                );
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
        Container(
          width: 98,
          height: 77,
          decoration: const BoxDecoration(
            borderRadius : BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          color : Color.fromRGBO(243, 243, 243, 1),
      )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(meal), Text(dateString)
          ],
        )
      ],
    );
  }
}
