import 'package:flutter/material.dart';
import 'package:ideal_meal/constant.dart';

// ignore: must_be_immutable
class Item extends StatelessWidget {
  Item({super.key, required this.meal, required this.date});
  final String meal;
  final DateTime date;

  String day = "";
  String month = "";

  @override
  Widget build(context) {
    if (date.day.toString().length == 1) {
      day = "0${date.day}";
    } else {
      day = "${date.day}";
    }
    if (date.month.toString().length == 1) {
      month = "0${date.month}";
    } else {
      month = "${date.month}";
    }
    String dateString = "${date.day}/${date.month}/${date.year}";
    return LayoutBuilder(builder: (context, constraints) {
      double fitWidth(double size) {
        return constraints.maxWidth * size / 430;
      }

      return Padding(
        padding: EdgeInsets.only(
            left: constraints.maxWidth * 31 / 430,
            right: constraints.maxWidth * 31 / 430,
            top: 12,
            bottom: 12),
        child: Row(
          children: [
            Container(
                width: fitWidth(98),
                height: fitWidth(77),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(243, 243, 243, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("$day/$month",
                        style: font(
                            fitWidth(20), Colors.black, FontWeight.normal)),
                    Text(dateDate[dateToDay(date)] ?? "N/A",
                        style:
                            font(fitWidth(20), Colors.black, FontWeight.bold)),
                  ],
                )),
            SizedBox(width: constraints.maxWidth * 14 / 430),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: fitWidth(240),
                    child: Text(meal,
                        style:
                            font(fitWidth(20), Colors.black, FontWeight.bold))),
                Text(dateString)
              ],
            )
          ],
        ),
      );
    });
  }
}
