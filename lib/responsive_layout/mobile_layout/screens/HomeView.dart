import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ideal_meal/FileManager.dart';
import 'package:ideal_meal/constant.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key, required this.datetime});

  final Date datetime;

  @override
  State<HomeView> createState() => _HomeView();
}

class _HomeView extends State<HomeView> {
  double rating = 0;
  DateTime today = DateTime.now();

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
                      bottom: 14,
                    ),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("How was your meal?",
                            style: font(20, Colors.black, FontWeight.bold)),
                        RatingBar(
                          glowColor: Colors.white,
                          unratedColor: Colors.white,
                          minRating: 0,
                          maxRating: 5,
                          initialRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ratingWidget: RatingWidget(
                            full: const Icon(Icons.star_rounded, size: 20),
                            half: const Icon(Icons.star_half_rounded, size: 20),
                            empty:
                                const Icon(Icons.star_border_rounded, size: 20),
                          ),
                          onRatingUpdate: (r) {
                            setState(() {
                              rating = r;
                            });
                          },
                        ),
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
                          const Text("Thanks for your feedback!")
                        ])
                      ],
                    )),
              ]))),
            );
          }),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MealStorage storage = MealStorage();
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: FutureBuilder<Map<String, dynamic>>(
            future: storage.readMealData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                    bottom: 25,
                  ),
                  child: Column(children: [
                    Text("Dish", style: font(20, myGrey, FontWeight.normal)),
                    Text(
                        snapshot.data![widget.datetime.dayDate(today)]
                            .toString(),
                        style: font(30, Colors.black, FontWeight.bold)),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('assets/frame/qr_frame1.png'),
                        QrImageView(
                          backgroundColor: Colors.white,
                          gapless: false,
                          data: snapshot.data![widget.datetime.dayDate(today)]
                              .toString(),
                          version: QrVersions.auto,
                          size: 180.0,
                        ),
                      ],
                    ),
                    Text(snapshot.data!.toString()),
                  ]),
                ));
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return const CircularProgressIndicator();
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
