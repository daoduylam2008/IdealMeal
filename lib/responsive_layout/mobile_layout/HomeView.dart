import 'package:flutter/material.dart';
import 'package:ideal_meal/FileManager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  Future<Map<String, String>> data = readMealData();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Text(snapshot.data!["Thursday#3"].toString());
          }
          return const CircularProgressIndicator();
        });
  }
}
