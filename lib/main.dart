import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_attendance/constant.dart';
import 'responsive_layout/responsive_management.dart';
import 'responsive_layout/mobile_layout/mobile_layout.dart';
import 'responsive_layout/tablet_layout/tablet_layout.dart';
import 'responsive_layout/desktop_layout/desktop_layout.dart';

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
      home: ResponsiveLayout(
        mobileBody: const MobileScaffold(),
        tabletBody: const TabletScaffold(),
        desktopBody: const DesktopScaffold(),
      ),
    );
  }
}


