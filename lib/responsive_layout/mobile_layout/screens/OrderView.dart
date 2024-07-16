import 'package:flutter/material.dart';
import 'package:ideal_meal/API/ResponseAPi.dart';
import 'package:ideal_meal/FileManager.dart';
import 'package:ideal_meal/constant.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key, required this.datetime});

  final Date datetime;

  @override
  State<OrderView> createState() => _OrderView();
}

class _OrderView extends State<OrderView> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> onSubmit;

  // Check if user submitted or not
  bool onRead = false;

  var buttonColor = linearColor;

  // Submit Data
  Map<String, String?> submitData = {};

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
  initState() {
    List<String> days = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday"
    ];
    super.initState();

    for (var i = 1; i <= 6; i++) {
      for (var day in days) {
        submitData["$day#$i"] = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // if (onSubmit) {
      //   return Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Text(
      //           "Submitted already!\nGo to Meals to change your dishes",
      //           style: TextStyle(fontSize: constraints.maxWidth * 20 / 430),
      //           textAlign: TextAlign.center,
      //         ),
      //       ],
      //     ),
      //   );
      // }
      return FutureBuilder(
          future: fetchOrder() ,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
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
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var meal = snapshot.data![index]["dish_ids"];
                            var date = snapshot.data![index]["date"];

                            DateTime day = widget.datetime.dateDay(date);
                            String today =
                                "${day.day}/${day.month}/${day.year}";

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
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            alignment: Alignment.center,
                                            width: constraints.maxWidth *
                                                397 /
                                                430,
                                            height: 130,
                                            padding: EdgeInsets.only(
                                              left: constraints.maxWidth *
                                                  16 /
                                                  430,
                                              right: constraints.maxWidth *
                                                  16 /
                                                  430,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                        "${date.split("#")[0]}, $today",
                                                        style: font(
                                                            constraints
                                                                    .maxWidth *
                                                                20 /
                                                                430,
                                                            Colors.black,
                                                            FontWeight.normal)),
                                                  ],
                                                ),
                                                DropdownButtonFormField2(
                                                    value: submitData[date],
                                                    buttonStyleData:
                                                        const ButtonStyleData(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      decoration:
                                                          BoxDecoration(),
                                                      height: 25,
                                                    ),
                                                    iconStyleData:
                                                        const IconStyleData(
                                                      icon: Icon(
                                                          Icons.expand_more),
                                                    ),
                                                    dropdownStyleData: const DropdownStyleData(
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        15)))),
                                                    menuItemStyleData:
                                                        const MenuItemStyleData(),
                                                    decoration: InputDecoration(
                                                        labelStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: constraints
                                                                    .maxWidth *
                                                                20 /
                                                                430),
                                                        hintText:
                                                            "Select your dish",
                                                        hintStyle: TextStyle(
                                                            color: const Color.fromRGBO(
                                                                200, 200, 200, 1),
                                                            fontSize: constraints
                                                                    .maxWidth *
                                                                20 /
                                                                430,
                                                            fontWeight:
                                                                FontWeight.normal),
                                                        fillColor: const Color.fromRGBO(243, 243, 243, 1),
                                                        filled: true,
                                                        border: const OutlineInputBorder(borderSide: BorderSide(width: 0, style: BorderStyle.none), borderRadius: BorderRadius.all(Radius.circular(15)))),
                                                    items: (meal).map((items) {
                                                      return DropdownMenuItem(
                                                          value:
                                                              items.toString(),
                                                          child: Text(items
                                                              .toString()));
                                                    }).toList(),
                                                    onChanged: (String? newValue) {
                                                      setState(() {
                                                        submitData[date] =
                                                            newValue!;
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
                              topLeft: Radius.circular(17),
                              topRight: Radius.circular(17)),
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(top: 12),
                          alignment: Alignment.bottomCenter,
                          margin: const EdgeInsets.only(top: 5), // ***
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(17),
                                topRight: Radius.circular(17)),
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
                                  setState(() {
                                    buttonColor = linearColor;
                                    showAlertDialog(context);
                                  });
                                },
                                child: Container(
                                    width: constraints.maxWidth * 368 / 430,
                                    height: constraints.maxHeight * 65 / 649,
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
              return const Center(child: CircularProgressIndicator());
            }
          });
    });
  }
}
