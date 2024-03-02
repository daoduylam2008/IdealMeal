import 'package:flutter/material.dart';
import 'package:student_attendance/constant.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:student_attendance/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: accentColor),
          useMaterial3: true,
          primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: IndexedStack(
        children: [
          const HomePage(),
        ],
        index: pageIndex,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.fastfood, color: Colors.white)
        ],
        index: pageIndex,
        backgroundColor: Colors.white10,
        color: accentColor,
        onTap: (pageSelectedIndex) =>
            setState(() => pageIndex = pageSelectedIndex),
      ),
    );
  }
}
