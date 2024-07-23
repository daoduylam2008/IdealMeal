import 'package:flutter/material.dart';
import 'package:ideal_meal/API/ResponseAPi.dart';
import 'package:ideal_meal/constant.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/Widget/CircularProgressIndicator.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderView();
}

class _OrderView extends State<OrderView> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Future<List<Map<String, dynamic>>> orderMeal;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();

    orderMeal = fetchOrder();
  }

  // Check if user submitted or not
  bool onRead = false;

  var buttonColor = linearColor;

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
        setState(() {});
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
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: orderMeal,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return LayoutBuilder(builder: (context, constraints) {
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
                                                        "${dateToDay(date)}, ${dateToString(date)}",
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
                                                    value: snapshot.data![index]
                                                        [meal],
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
                                                            fontSize:
                                                                constraints.maxWidth *
                                                                    20 /
                                                                    430),
                                                        hintText:
                                                            "Select your dish",
                                                        hintStyle: TextStyle(
                                                            color: const Color.fromRGBO(
                                                                200, 200, 200, 1),
                                                            fontSize:
                                                                constraints.maxWidth * 20 / 430,
                                                            fontWeight: FontWeight.normal),
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
                                                    onChanged: (dynamic newValue) {
                                                      setState(() {
                                                        // TODO:
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
            });
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotationTransition(
                  turns:
                      Tween(begin: 0.0, end: 1.0).animate(_animationController),
                  child: const GradientCircularProgressIndicator(
                    radius: 30,
                    gradientColors: [
                      Colors.white,
                      Color.fromRGBO(45, 154, 255, .9),
                      Color.fromRGBO(255, 51, 112, .9),
                    ],
                    strokeWidth: 4.0,
                  ),
                ),
                const Text("Loading..."),
              ],
            ),
          );
        });
  }
}
