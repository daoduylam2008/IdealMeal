import 'package:flutter/material.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';

class OrderWidget extends StatelessWidget {
  final List<String>? lists;
  int choice = 0;

  OrderWidget({super.key, required this.lists});

  @override
  Widget build(context) {
    return Container(
      child: Stack(children: [
        Text(lists![1])
    ],));
  }
}
