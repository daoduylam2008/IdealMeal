import 'package:flutter/material.dart';

class History extends StatelessWidget {
  @override
  Widget build(context) {
    return Container(child: Expanded(
      child: ListView.builder(itemBuilder: (context, index) {
        return Item();
      }),
    ));
  }
}

class Item extends StatelessWidget {
  @override
  Widget build(context) {
    return Container();
  }
}
