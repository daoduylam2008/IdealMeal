// ignore_for_file: avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_attendance/constant.dart';
import 'package:table_calendar/table_calendar.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderView();
}

class _OrderView extends State<OrderView> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  List item = ["Tom", "Bill"];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        TableCalendar(
          focusedDay: _focusedDay,
          firstDay: DateTime(1990),
          lastDay: DateTime(2050),
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay; // update `_focusedDay` here as well
            });
          },
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Text("Hello", style: TextStyle(fontSize: 20),),
              Text("World"),
            ]
            )
        )
      ]),
    );
  }
}
