import 'package:flutter/material.dart';
import 'DataTester.dart';
import 'ResponseAPi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late Future<List<UserTest>> futureData; //late keyword is important

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String n = snapshot.data![0].name;
          return Text("$n}");
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        
      // By default, show a loading spinner.
      return const CircularProgressIndicator();
      },
    ));
  }
}
