import 'package:flutter/material.dart';
import 'package:student_attendance/DataTester.dart';
import 'package:student_attendance/constant.dart';
import 'package:table_calendar/table_calendar.dart';

class MealView extends StatefulWidget {
  const MealView({super.key});

  @override
  State<MealView> createState() => _MealView();
}

class _MealView extends State<MealView> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  User user = userTest;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.only(left: 29, right: 29),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TableCalendar(
          startingDayOfWeek: StartingDayOfWeek.monday,
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: font(17.12, Colors.black, FontWeight.bold),
            weekendStyle: font(17.12, Colors.black, FontWeight.bold),
          ),
          daysOfWeekHeight: 37.35,
          headerStyle: HeaderStyle(
            titleTextStyle: font(17, Colors.black, FontWeight.bold),
            rightChevronIcon: const Icon(Icons.chevron_right, color: myGrey),
            leftChevronIcon: const Icon(Icons.chevron_left, color: myGrey),
            formatButtonVisible: false,
            titleCentered: true,
          ),
          calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              todayTextStyle: font(16, Colors.black, FontWeight.normal),
              todayDecoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(200, 200, 200, .3)),
              selectedDecoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: linearColor,
                // borderRadius: BorderRadius.all(Radius.circular(6.22))
              )),
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
        const SizedBox(height: 18),
        Text("Họ và tên", style: font(15, myGrey, FontWeight.normal)),
        Text(user.username, style: font(20, Colors.black, FontWeight.bold)),
        Text("Ngày ăn", style: font(15, myGrey, FontWeight.normal)),
        Text(dateToString(_focusedDay),
            style: font(20, Colors.black, FontWeight.bold)),
        Text("Món ăn", style: font(15, myGrey, FontWeight.normal)),
        Text("None", style: font(20, Colors.black, FontWeight.bold)),
        const SizedBox(height: 34),
        InkWell(
            onTap: () {
              print("Hello");
            },
            child: Image.asset(iconPath("note")))
      ]),
    ));
  }
}
