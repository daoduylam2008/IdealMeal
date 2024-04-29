import 'package:flutter/material.dart';
import 'package:student_attendance/RequestAPI.dart';
import 'package:student_attendance/constant.dart';
import 'package:student_attendance/responsive_layout/mobile_layout/order_tab/OrderWidget.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderView();
}

class _OrderView extends State<OrderView> {
  Meal meals = Meal(
      student_id: "",
      monday: "",
      tuesday: " ",
      wednesday: "",
      thursday: "",
      friday: "");

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Column(children: [
      OrderWidget(date: "Monday", lists: const ["Thịt kho trứng", "Xíu mại kho cà", "Cá thu kho cà"],)
    ]));
  }
}
