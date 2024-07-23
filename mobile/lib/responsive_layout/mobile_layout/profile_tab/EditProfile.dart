import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:ideal_meal/API/ResponseAPI.dart';
import 'package:ideal_meal/API/RequestAPI.dart';
import 'package:ideal_meal/constant.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  late Future<User> profile;
  late Future<Student> me;

  String error = "";

  @override
  void initState() {
    super.initState();

    profile = fetchProfile();
    me = fetchMe();
  }

  // Alert or Pop-up notification
  showAlertDialog(BuildContext context) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel", style: font(17, Colors.black, FontWeight.normal)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget yesButton = TextButton(
      child: Text("Yes", style: font(17, Colors.black, FontWeight.normal)),
      onPressed: () async {
        String oldPhone = (await profile).phone;
        String oldEmail = (await me).email;
        if (emailController.text == oldEmail ||
            phoneController.text == oldPhone) {
          setState(() {
            error = "Email or Phone number is already existed";
          });
        } else {
          try {
            await changeEmail(emailController.text);
            await changePhone(phoneController.text);

            print("Change email & phone successfully");

            Navigator.pop(context);
            Navigator.pop(context);
          } catch (e) {
            if (e == Exception("Email or phone is already existed")) {
            setState(() {
              error = "Email or Phone number is already existed";
            });
              error = "Email or Phone number is already existed";
            } else {
              setState(() {
              error = "Some error with your Email or Phone Number";
            });
            }
          } finally {}
        }

        Phoenix.rebirth(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      surfaceTintColor: Colors.white,
      content: Text("Are you sure to change your password?",
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
    """
    snapshot_1 is for Student class
    snapshot_2 is for User class
    """;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: false,
            title:
                Text("Profile", style: font(30, Colors.black, FontWeight.bold)),
            leading: const BackButton(
              color: myGrey,
            )),
        body: FutureBuilder(
            future: me,
            builder: (context, snapshot_1) {
              return FutureBuilder(
                  future: profile,
                  builder: (context, snapshot_2) {
                    if (snapshot_2.hasData && snapshot_1.hasData) {
                      emailController.text = snapshot_1.data!.email;
                      phoneController.text = snapshot_2.data!.phone;
                      return LayoutBuilder(builder: (context, constraints) {
                        return SafeArea(
                            child: Padding(
                          padding: EdgeInsets.only(
                            left: constraints.maxWidth * (31 / 430),
                            right: constraints.maxWidth * (31 / 430),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Phone number",
                                  style: font(15, myGrey, FontWeight.normal)),
                              const SizedBox(height: 5),
                              SizedBox(
                                  height: 59,
                                  width: constraints.maxWidth * 368 / 430,
                                  child: TextField(
                                      style: font(
                                          20, Colors.black, FontWeight.normal),
                                      keyboardType: TextInputType.phone,
                                      controller: phoneController,
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color.fromRGBO(
                                            231, 231, 231, .5),
                                        hintText: "New phone number",
                                        hintStyle:
                                            font(20, myGrey, FontWeight.normal),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                      ))),
                              const SizedBox(height: 26),
                              Text("Email",
                                  style: font(15, myGrey, FontWeight.normal)),
                              const SizedBox(height: 5),
                              SizedBox(
                                  height: 59,
                                  width: constraints.maxWidth * 368 / 430,
                                  child: TextField(
                                      style: font(
                                          20, Colors.black, FontWeight.normal),
                                      controller: emailController,
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: const Color.fromRGBO(
                                            231, 231, 231, .5),
                                        hintText: "New email ",
                                        hintStyle:
                                            font(20, myGrey, FontWeight.normal),
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        errorBorder: const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                      ))),
                              Text(
                                error,
                                style: font(20, Colors.red, FontWeight.normal),
                              )
                            ],
                          ),
                        ));
                      });
                    }
                    return CircularProgressIndicator();
                  });
            }),
        bottomNavigationBar: LayoutBuilder(builder: (context, constraints) {
          return SafeArea(
            child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 37, vertical: 32),
                child: BlurryContainer(
                    blur: 14,
                    width: constraints.maxWidth * 368 / 430,
                    height: 72,
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    color: const Color.fromRGBO(231, 231, 231, .5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 72,
                            width: constraints.maxWidth * 150 / 430,
                            child: IconButton(
                                splashRadius: 1,
                                padding: const EdgeInsets.all(0.0),
                                icon: const Icon(Icons.check, size: 34),
                                onPressed: () {
                                  showAlertDialog(context);
                                }),
                          ),
                          SizedBox(
                            height: 72,
                            width: constraints.maxWidth * 150 / 430,
                            child: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                icon: const Icon(Icons.close, size: 34),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ),
                        ]))),
          );
        }));
  }
}
