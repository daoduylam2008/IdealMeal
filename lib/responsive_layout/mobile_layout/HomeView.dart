import 'package:flutter/material.dart';
import 'package:ideal_meal/FileManager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.storage});

  final MealStorage storage;

  @override
  State<HomeView> createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic >>(
        future: widget.storage.readMealData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.toString());
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const CircularProgressIndicator();
        });
  }
}
