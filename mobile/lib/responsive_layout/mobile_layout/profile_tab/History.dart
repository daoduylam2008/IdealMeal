import 'package:flutter/material.dart';
import 'package:ideal_meal/API/ResponseAPi.dart';
import 'package:ideal_meal/constant.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/Widget/Item.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _History();
}

class _History extends State<History> {
  late Future<Map<String, dynamic>> data;

  @override
  void initState() {
    super.initState();

    data = fetchCalendar();
  }

  @override
  Widget build(context) {
    return FutureBuilder(
        future: data,
        builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            List meals = snapshot.data!.values.toList();
            List dates = snapshot.data!.keys.toList();

            return ListView.builder(itemBuilder: (context, index) {
              return Item(
                date: YYYYMMDDtoDate(dates[index]),
                meal: meals[index],
              );
            });
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
