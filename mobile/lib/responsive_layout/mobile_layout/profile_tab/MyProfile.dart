import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:ideal_meal/API/ResponseAPi.dart';
import 'package:ideal_meal/constant.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/Widget/CardWidget.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/Widget/CircularProgressIndicator.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/profile_tab/EditProfile.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfile();
}

class _MyProfile extends State<MyProfile> with TickerProviderStateMixin {
  late Future<User> profile;
  late Future<Student> me;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();

    profile = fetchProfile();
    me = fetchMe();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
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
                                  cls: cls(snapshot_1.data!.id),
                                  // address: studentTest.address,
                                  birth: birth(snapshot_1.data!.birth)),
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
                                    style: font(
                                        20, Colors.black, FontWeight.bold)),
                                SizedBox(height: 30),
                                InkWell(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) => EditProfile())));
                                    },
                                    child: BlurryContainer(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        width: constraints.maxWidth * 368 / 430,
                                        height: 62,
                                        color: const Color.fromRGBO(
                                            231, 231, 231, .5),
                                        child: Center(
                                            child: Text("Edit profile",
                                                style: font(20, Colors.black,
                                                    FontWeight.normal))))),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }));
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RotationTransition(
                        turns: Tween(begin: 0.0, end: 1.0)
                            .animate(_animationController),
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
        });
  }
}
