import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class Profile extends StatelessWidget {
  const Profile({super.key});
  final CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile'
        ),
      ),
      body: Column(children: [
        TableCalendar(
          calendarFormat: _calendarFormat,
          focusedDay: DateTime.now(),
           firstDay: kFirstDay,
            lastDay: kLastDay
            )
      ],),
    );
  }
}