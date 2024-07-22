import 'package:flutter/material.dart';
import 'package:ideal_meal/API/ResponseAPi.dart';
import 'package:ideal_meal/constant.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/Widget/CardWidget.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfile();
}

class _MyProfile extends State<MyProfile> {
  late Future<User> profile;
  late Future<Student> me;

  @override
  void initState() {
    super.initState();

    profile = fetchProfile();
    me = fetchMe();
  }

  @override
  Widget build(context) {
    """
    snapshot_1 is for profile
    snapshot_2 is for me
    """;
    return FutureBuilder(
        future: profile,
        builder: (context, snapshot_1) {
          return FutureBuilder(
              future: me,
              builder: (context, snapshot_2) {
                if (snapshot_2.hasData && snapshot_1.hasData) {
                  return LayoutBuilder(builder: ((context, constraints) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CardWidget(
                                  name: snapshot_1.data!.name,
                                  // cls: studentTest.cls,
                                  // address: studentTest.address,
                                  birth: snapshot_1.data!.birth),
                              SizedBox(
                                  height: constraints.maxHeight * 20 / 440),
                              SizedBox(
                                width: constraints.maxHeight * 368 / 440,
                                child: const Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                  height: constraints.maxHeight * 15 / 440),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Phone number",
                                    style: font(
                                        15,
                                        const Color.fromRGBO(150, 150, 150, 1),
                                        FontWeight.normal)),
                                Text(snapshot_1.data!.phone,
                                    style: font(
                                        20, Colors.black, FontWeight.bold)),
                                Text("Email",
                                    style: font(
                                        15,
                                        const Color.fromRGBO(150, 150, 150, 1),
                                        FontWeight.normal)),
                                Text(snapshot_2.data!.email,
                                    style:
                                        font(20, Colors.black, FontWeight.bold))
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }));
                }
                return CircularProgressIndicator();
              });
        });
  }
}
