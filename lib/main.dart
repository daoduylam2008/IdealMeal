import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:ideal_meal/API/MongoDBAPI.dart';
import 'package:ideal_meal/constant.dart';
import 'responsive_layout/responsive_management.dart';
import 'responsive_layout/mobile_layout/mobile_layout.dart';
import 'responsive_layout/tablet_layout/tablet_layout.dart';
import 'responsive_layout/desktop_layout/desktop_layout.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MealsDatabase.connect();
  runApp(Phoenix(child: const MyApp()));
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
      home: ResponsiveLayout(
        mobileBody: const MobileScaffold(),
        tabletBody: const TabletScaffold(),
        desktopBody: const DesktopScaffold(),
      ),
    );
  }
}
