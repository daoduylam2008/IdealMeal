import 'package:flutter/material.dart';
import 'package:student_attendance/constant.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderView();
}

class _OrderView extends State<OrderView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Container(
          width: 368,
          height: 72,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            gradient: linearColor,
            ),
        )
      ]),
    );
  }
}
