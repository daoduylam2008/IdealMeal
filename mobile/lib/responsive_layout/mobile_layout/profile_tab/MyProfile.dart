import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ideal_meal/constant.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/Widget/CardWidget.dart';


class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfile();
}

class _MyProfile extends State<MyProfile> {
  @override
  Widget build(context) {
    setState(() {
      
    });
    return LayoutBuilder(builder: ((context, constraints) {
      return SingleChildScrollView(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardWidget(name: studentTest.name, cls: studentTest.cls, address: studentTest.address, birth: studentTest.birth),
                SizedBox(height: constraints.maxHeight*20/440),
                SizedBox(
                  width: constraints.maxHeight*368/440,
                  child: const Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: constraints.maxHeight*15/440),
                ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Phone number", style: font(15 , const Color.fromRGBO(150, 150, 150, 1),
                                FontWeight.normal)),
                  Text(studentTest.phone, style: font(20, Colors.black, FontWeight.bold)),
                  Text("Email", style: font(15, const Color.fromRGBO(150, 150, 150, 1), FontWeight.normal)),
                  Text(studentTest.email,  style: font(20, Colors.black, FontWeight.bold))
                ],
              ),
            )
          ],
        ),
      );
    }));
  }
}
