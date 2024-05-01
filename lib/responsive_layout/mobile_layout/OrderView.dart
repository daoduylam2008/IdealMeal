import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:student_attendance/FileManager.dart';
import 'package:student_attendance/constant.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderView();
}

class _OrderView extends State<OrderView> {
  // Read meal data from specific file
  var data = processCsv("assets/test/test.csv");

  // Check if user submitted or not
  bool onSubmit = false;

  var buttonColor = linearColor;

  // Submit Data
  Map<String, String> submitData = {};

  // Alert for pop-up window for user to confirm their selections
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: font(17, Colors.black, FontWeight.normal)),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget yesButton = TextButton(
      child: Text("Yes", style: font(17, Colors.black, FontWeight.normal)),
      onPressed: () {
        Navigator.pop(context);
        setState(() {
          onSubmit = true;
        });
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      surfaceTintColor: Colors.white,
      content: Text("Are you sure to submit your meal?",
          style: font(20, Colors.black, FontWeight.normal)),
      actions: [
        cancelButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (onSubmit) {
      return Container(
        child: const Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "You have been already submitted",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        )),
      );
    }
    return LayoutBuilder(builder: (context, constraints) {
      return FutureBuilder(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = dayMeal(snapshot.data!);
              var days = [];
              for (var i in data.keys) {
                days.add(i);
              }
              return Container(
                color: appBarBackground,
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: constraints.maxHeight * 560 / 649,
                        child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var lists = data[days[index]];
                            var date = days[index];

                            for (var element in days) {
                              submitData[element] = "";
                            }

                            return index == 0
                                ? Container()
                                : Container(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: Center(
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
                                                        overlayColor: MaterialStatePropertyAll(myGrey)),
                                                    iconStyleData: const IconStyleData(
                                                      icon: Icon(Icons.expand_more),
                                                    ),
                                                    dropdownStyleData: const DropdownStyleData(
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius.all(Radius.circular(15)))),
                                                    menuItemStyleData: const MenuItemStyleData(
                                                        overlayColor: MaterialStatePropertyAll(
                                                            Color.fromRGBO(243, 243, 243, 1))),
                                                    decoration: const InputDecoration(
                                                        hintText: "Select your dish",
                                                        hintStyle: TextStyle(
                                                            color: Color.fromRGBO(200, 200, 200, 1),
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.normal),
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
                                                      setState(() {
                                                        submitData[date] = newValue!;
                                                        print(submitData[date]);
                                                      });
                                                    }),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                          },
                        ),
                      ),
                      Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight * (1 - 560 / 649),
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(top: 12),
                          alignment: Alignment.bottomCenter,
                          margin: const EdgeInsets.only(top: 5), // ***
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                                blurRadius: 8,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          child: Column(children: [
                            InkWell(
                                hoverDuration: const Duration(seconds: 5),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                onTapDown: (details) {
                                  setState(() {
                                    buttonColor = overlayLinearColor;
                                  });
                                },
                                onTapUp: (details) {
                                  print(submitData["Friday#1"]);
                                  setState(() {
                                    buttonColor = linearColor;
                                    showAlertDialog(context);
                                  });
                                },
                                child: Container(
                                    width: constraints.maxWidth * 368 / 430,
                                    height: 72,
                                    decoration: BoxDecoration(
                                      gradient: buttonColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                    ),
                                    child: Center(
                                        child: Text("Submit",
                                            style: font(20, Colors.white,
                                                FontWeight.normal))))),
                          ]),
                        ),
                      )
                    ]),
              );
            } else {
              return const CircularProgressIndicator();
            }
          });
    });
  }
}
