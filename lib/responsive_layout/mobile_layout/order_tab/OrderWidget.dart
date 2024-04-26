import 'package:flutter/material.dart';
import 'package:student_attendance/constant.dart';

class OrderWidget extends StatelessWidget {
  final List<String>? lists;

  final List<String> genderItems = [
    'Male',
    'Female',
  ];
  String? selectedValue;

  int choice = 0;

  OrderWidget({super.key, required this.lists});

  @override
  Widget build(context) {
    return Stack(
      children: [
        DropdownButton(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          hint: Text("Select your dish", style: font(20, myGrey, FontWeight.normal)),
          items: lists!.map((items) {
            return DropdownMenuItem(
                value: items, 
                child: Text(items), 
            );
          }).toList(),
          onChanged: (String? newValue) {
            // None
          })
      ],
    );
  }
}
