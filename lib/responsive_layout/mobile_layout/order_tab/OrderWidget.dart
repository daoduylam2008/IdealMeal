import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_attendance/constant.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


class OrderWidget extends StatelessWidget {
  final List<String>? lists;
  final String? date;

  String? selectedValue;

  int choice = 0;

  OrderWidget({super.key, required this.lists, required this.date});

  @override
  Widget build(context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Center(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              alignment: Alignment.center,
              width: constraints.maxWidth * 397 / 430,
              height: 130,
              padding: EdgeInsets.only(
                left: constraints.maxWidth * 16 / 430,
                right: constraints.maxWidth * 16 / 430,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(date!, style: font(20, Colors.black, FontWeight.normal)),
                  DropdownButtonFormField2(
                      buttonStyleData: const ButtonStyleData(
                        height: 20,
                        overlayColor: MaterialStatePropertyAll(myGrey)
                      ),
                      iconStyleData: const  IconStyleData( 
                        icon: Icon(Icons.expand_more),
                      ),
                      dropdownStyleData: const DropdownStyleData(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))
                        )
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        overlayColor: MaterialStatePropertyAll(Color.fromRGBO(243, 243, 243, 1))
                      ),
                      decoration: const InputDecoration(
                          hintText: "Select your dish",
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(200, 200, 200, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.normal
                          ),
                          fillColor: Color.fromRGBO(243, 243, 243, 1),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 0, style: BorderStyle.none),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                      items: lists!.map((items) {
                        return DropdownMenuItem(
                            value: items, child: Text(items));
                      }).toList(),
                      onChanged: (String? newValue) {
                        // None
                      }),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
