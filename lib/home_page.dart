import 'package:flutter/material.dart';
import 'DataTester.dart';
import 'ResponseAPi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  late Future<ImportData> futureAlbum;


  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  void pressed() {
    print(futureAlbum);
  }

  Widget build(BuildContext context) {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: pressed, child: const Text("Press to get data"))
      ],
    ));
  }
}
