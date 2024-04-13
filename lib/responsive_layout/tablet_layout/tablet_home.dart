import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            // next meal
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
                      ],
                    ),
                  )
                ],
              ),
            ),
            // feedback
            Expanded(
              child: Container(
                height: _width/3,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromRGBO(220, 220, 220, 1),
                      width: 2
                    )
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How was your meal?',
                      style: font(20, Colors.black, FontWeight.bold),
                    ),
                    Row(
                      children: List.generate(5, (index) => const Icon(Icons.star_border_rounded, color: Color.fromRGBO(187, 187, 187, 1),)),
                    ),
                    Text(
                      'Anything that can be improve?',
                      style: font(20, Colors.black, FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SizedBox(
                            height: constraints.maxHeight,
                            child: TextField(
                              textAlignVertical: TextAlignVertical.top,
                              maxLines: null,
                              expands: true,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(12),
                                hintText: 'Your feedback (Optional)',
                                hintStyle: TextStyle(
                                  color: Color.fromRGBO(187, 187, 187, 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(220, 220, 220, 1), width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color.fromRGBO(220, 220, 220, 1), width: 2.0),
                                ),
                              ),
                              onChanged: (value) {
                                print(value);
                              },  
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,10,0,5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {},
                            
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(242, 242, 242, 1), )
                            ),
                            child: Text(
                              'Send',
                              style: font(15, Colors.black, FontWeight.bold),
                            ),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.check_circle_outline_rounded, color: Color.fromRGBO(187, 187, 187, 1), size: 20,),
                              SizedBox(width: 5,),
                              Text(
                                'Thanks for your feedback!',
                                style: TextStyle(
                                  color: Color.fromRGBO(187, 187, 187, 1),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        Container(
          height: ((_width/3)/5)+2,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: Color.fromRGBO(220, 220, 220, 1),
              ),
            )
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Icon(Icons.calendar_month_rounded),
                  ),
                  Text(
                    'January, 2024',
                    style: font(25, Colors.black, FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
