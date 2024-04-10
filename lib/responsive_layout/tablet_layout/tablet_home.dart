import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_attendance/responsive_layout/mobile_layout/ProfileView.dart';

import 'package:student_attendance/constant.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: _width/3,
              width: _width/3,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Color.fromRGBO(220, 220, 220, 1),
                    width: 2
                  ),
                  bottom: BorderSide(
                    color: Color.fromRGBO(220, 220, 220, 1),
                    width: 2
                  )
                )
              ),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color.fromRGBO(220, 220, 220, 1),
                            width: 2
                          ) 
                        )
                      ),
                      child: Text(
                        'Your next meal',
                        style: font(25, Colors.black, FontWeight.bold)
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(10),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name',
                                  style: font(15, const Color.fromRGBO(187, 187, 187, 1), FontWeight.normal),
                                ),
                                Text(
                                  'XXXX XXXX XXXX',
                                  style: font(20, Colors.black, FontWeight.bold),
                                ),
                                Text(
                                  'Date',
                                  style: font(15, const Color.fromRGBO(187, 187, 187, 1), FontWeight.normal),
                                ),
                                Text(
                                  'DD/MM/YYYY',
                                  style: font(20, Colors.black, FontWeight.bold),
                                ),
                                Text(
                                  'Your set',
                                  style: font(15, const Color.fromRGBO(187, 187, 187, 1), FontWeight.normal),
                                ),
                                Text(
                                  'Xúc Xích Lúc Lắc',
                                  style: font(20, Colors.black, FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                        //   alignment: Alignment.bottomRight,
                        //   child: DecoratedBox(
                        //     decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       shape: BoxShape.circle,
                        //       boxShadow: 
                        //       [
                        //         BoxShadow(
                        //           color: Colors.grey,
                        //           offset: Offset(0, 3),
                        //           blurRadius: 10
                        //         )
                        //       ]
                        //     ),
                        //     child: CircleAvatar(
                        //       backgroundColor: Colors.white,
                        //       child: Container(
                        //         alignment: Alignment.center,
                        //         child: Text(
                        //           '1',
                        //           style: font(25, Colors.black, FontWeight.bold),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How was your meal?',
                      style: font(20, Colors.black, FontWeight.bold),
                    ),
                    Row(
                      children: List.generate(5, (index) => const Icon(Icons.star)),
                    ),
                    Text(
                      'Anything that can be improve?',
                      style: font(20, Colors.black, FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(242, 242, 242, 1), )
                          ),
                          
                          child: Text(
                            'Send',
                            style: font(15, Colors.black, FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
