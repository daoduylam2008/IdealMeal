import 'package:flutter/material.dart';
import 'package:ideal_meal/API/ResponseAPi.dart';
import 'package:ideal_meal/FileManager.dart';
import 'package:ideal_meal/constant.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ideal_meal/responsive_layout/mobile_layout/Widget/CircularProgressIndicator.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.datetime});

  final Date datetime;

  @override
  State<HomeView> createState() => _HomeView();
}

class _HomeView extends State<HomeView> with TickerProviderStateMixin {
  double rating = 0;
  DateTime today = DateTime.now();
  String framePath = 'assets/frame/qr_frame1.png';
  String dish = "";
  int frameWidth = 0;
  int qrWidth = 0;

  late AnimationController _animationController;
  late Future<Map<String, dynamic>> data;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();

    data = fetchCalendar();
  }

  final commentController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _animationController.dispose();
    commentController.dispose();
    super.dispose();
  }

  void _showModalBottomSheet(BuildContext context, double maxWidth) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      )),
      builder: (context) => DraggableScrollableSheet(
          snapAnimationDuration: const Duration(milliseconds: 1),
          snapSizes: const [.3, .5],
          snap: true,
          initialChildSize: .3,
          maxChildSize: .5,
          minChildSize: .2,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              controller: scrollController,
              child: SizedBox(
                  child: Center(
                      child: Column(children: [
                const SizedBox(
                    width: 50,
                    child: Divider(thickness: 5, color: Colors.grey)),
                Container(
                    padding: EdgeInsets.only(
                      top: 14,
                      left: maxWidth * 30 / 430,
                      right: maxWidth * 30 / 430,
                      bottom: 14,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("How was your meal?",
                            style: font(20, Colors.black, FontWeight.bold)),
                        SizedBox(
                          height: 150,
                          child: TextField(
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.multiline,
                              minLines: 7,
                              maxLines: 7,
                              controller: commentController,
                              decoration: InputDecoration(
                                fillColor:
                                    const Color.fromRGBO(231, 231, 231, .5),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                hintText: 'Your feedback (Optional)',
                                hintStyle: font(20, myGrey, FontWeight.normal),
                                filled: true,
                              )),
                        ),
                        SizedBox(height: maxWidth * 10 / 430),
                        RatingBar(
                          itemPadding: const EdgeInsets.all(5),
                          itemSize: 30,
                          glowColor: Colors.white,
                          unratedColor: Colors.white,
                          minRating: 0,
                          maxRating: 5,
                          initialRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          ratingWidget: RatingWidget(
                            full: Image.asset("assets/icons/star_fill.png"),
                            half: Image.asset("assets/icons/star_empty.png"),
                            empty: Image.asset("assets/icons/star_empty.png"),
                          ),
                          onRatingUpdate: (r) {
                            setState(() {
                              rating = r;
                            });
                          },
                        ),
                        SizedBox(height: maxWidth * 20 / 430),
                        Row(children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                                width: 100,
                                height: 40,
                                decoration: const BoxDecoration(
                                  gradient: linearColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11)),
                                ),
                                child: Center(
                                    child: Text("Submit",
                                        style: font(15, Colors.white,
                                            FontWeight.normal)))),
                          ),
                          const Spacer(),
                          SizedBox(
                              child: Row(
                            children: [
                              Image.asset("assets/icons/tick.png",
                                  fit: BoxFit.contain),
                              const SizedBox(width: 5),
                              const Text("Thanks for your feedback!")
                            ],
                          )),
                        ])
                      ],
                    )),
              ]))),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> qrData = {"id": "", "meal": ""};

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: const Color.fromRGBO(242, 242, 242, 1),
        body: FutureBuilder<Map<String, dynamic>>(
            future: data,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                try {
                  dish = snapshot.data![dateToYYYYMMDD(DateTime.now())].toString();
                } catch (error) {
                  dish = "";
                }
                if (framePath == 'assets/frame/qr_frame2.png') {
                  frameWidth = 327;
                  qrWidth = 270;
                } else {
                  frameWidth = 218;
                  qrWidth = 180;
                }
                // frame for qrcode
                var frame = Image.asset(framePath,
                    width: constraints.maxWidth * frameWidth / 430,
                    height: constraints.maxWidth * frameWidth / 430);
                // qrcode image
                var qrcode = QrImageView(
                  // backgroundColor: Colors.white,
                  gapless: false,
                  data: dish,
                  version: QrVersions.auto,
                  size: constraints.maxWidth * qrWidth / 430,
                );

                return Center(
                    child: Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                    bottom: 25,
                  ),
                  child: Column(children: [
                    Text("Dish", style: font(20, myGrey, FontWeight.normal)),
                    Text(dish, style: font(30, Colors.black, FontWeight.bold)),
                    const SizedBox(height: 60),
                    SizedBox(
                      child: InkWell(
                        onLongPress: () {
                          setState(() {
                            framePath = 'assets/frame/qr_frame2.png';
                          });
                        },
                        onDoubleTap: () {
                          setState(() {
                            if (framePath == 'assets/frame/qr_frame2.png') {
                              framePath = 'assets/frame/qr_frame1.png';
                            } else {
                              framePath = 'assets/frame/qr_frame2.png';
                            }
                          });
                        },
                        onTapDown: (details) {
                          setState(() {
                            framePath = 'assets/frame/qr_frame1.png';
                          });
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            frame,
                            qrcode,
                          ],
                        ),
                      ),
                    ),
                  ]),
                ));
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
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
                    const Text("Please connect to internet"),
                  ],
                ),
              );
            }),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white.withOpacity(.9),
            onPressed: () =>
                _showModalBottomSheet(context, constraints.maxWidth),
            tooltip: 'Bottom Sheet',
            child: const Icon(Icons.star_outline)),
      );
    });
  }
}
