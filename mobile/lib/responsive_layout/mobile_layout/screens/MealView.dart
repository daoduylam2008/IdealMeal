import 'package:flutter/material.dart';
import 'package:ideal_meal/API/ResponseAPi.dart';
import 'package:ideal_meal/constant.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/Widget/CircularProgressIndicator.dart';
import 'package:table_calendar/table_calendar.dart';

class MealView extends StatefulWidget {
  const MealView({super.key});

  @override
  State<MealView> createState() => _MealView();
}

class _MealView extends State<MealView> with TickerProviderStateMixin {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  User user = userTest;

  late Future orderMeal;
  late AnimationController _animationController;


  @override
  void initState() {
    super.initState();
    orderMeal = fetchOrder();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder(
            future: orderMeal,
            builder: (context, snapshot) {
              String searchMeal() {
                DateTime now = DateTime.now();
                DateTime today = DateTime(now.year, now.month, now.day);

                return "";
              }

              if (snapshot.hasData) {
                return Container(
                  color: appBarBackground,
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(35))),
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.only(left: 29, right: 29),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              TableCalendar(
                                startingDayOfWeek: StartingDayOfWeek.monday,
                                daysOfWeekStyle: DaysOfWeekStyle(
                                  weekdayStyle: font(
                                      17.12, Colors.black, FontWeight.bold),
                                  weekendStyle: font(
                                      17.12, Colors.black, FontWeight.bold),
                                ),
                                daysOfWeekHeight: 37.35,
                                headerStyle: HeaderStyle(
                                  titleTextStyle:
                                      font(17, Colors.black, FontWeight.bold),
                                  rightChevronIcon: const Icon(
                                      Icons.chevron_right,
                                      color: myGrey),
                                  leftChevronIcon: const Icon(
                                      Icons.chevron_left,
                                      color: myGrey),
                                  formatButtonVisible: false,
                                  titleCentered: true,
                                ),
                                calendarStyle: CalendarStyle(
                                    outsideDaysVisible: false,
                                    todayTextStyle: font(
                                        16, Colors.black, FontWeight.normal),
                                    todayDecoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromRGBO(200, 200, 200, .3)),
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
                                    _focusedDay =
                                        focusedDay; // update `_focusedDay` here as well
                                  });
                                },
                              ),
                              const SizedBox(height: 5),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 9),
                              Text("Name",
                                  style: font(15, myGrey, FontWeight.normal)),
                              Text(user.username,
                                  style:
                                      font(20, Colors.black, FontWeight.bold)),
                              Text("Date",
                                  style: font(15, myGrey, FontWeight.normal)),
                              Text(dateToString(_focusedDay),
                                  style:
                                      font(20, Colors.black, FontWeight.bold)),
                              Text("Dish",
                                  style: font(15, myGrey, FontWeight.normal)),
                              Text("${searchMeal()}",
                                  style:
                                      font(20, Colors.black, FontWeight.bold)),
                              const SizedBox(height: 34),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                      onTap: () {},
                                      child: Image.asset(iconPath("note"))),
                                ],
                              )
                            ]),
                      )),
                );
              }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
                    child: const GradientCircularProgressIndicator (
                      radius: 30,
                      gradientColors: [
                        Colors.white,
                        Color.fromRGBO(45, 154, 255, .9),
                        Color.fromRGBO(255, 51, 112, .9),
                      ] ,
                      strokeWidth: 4.0,
                    ),
                  ),
                  const Text("Please connect to internet"),
                ],
              ),
            );
            });
      },
    );
  }
}
