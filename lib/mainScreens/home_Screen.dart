import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:food_users/assistantMethods/assistant_methods.dart';
import 'package:food_users/global/global.dart';
import 'package:food_users/models/sellers_model.dart';
import 'package:food_users/widgets/sellers_design.dart';
import 'package:food_users/widgets/my_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final items = [
    "slider/0.jpg",
    "slider/1.jpg",
    "slider/2.jpg",
    "slider/3.jpg",
    "slider/4.jpg",
    "slider/5.jpg",
    "slider/6.jpg",
    "slider/7.jpg",
    "slider/8.jpg",
    "slider/9.jpg",
    "slider/10.jpg",
    "slider/11.jpg",
    "slider/12.jpg",
    "slider/13.jpg",
    "slider/14.jpg",
    "slider/15.jpg",
    "slider/16.jpg",
    "slider/17.jpg",
    "slider/18.jpg",
    "slider/19.jpg",
    "slider/20.jpg",
    "slider/21.jpg",
    "slider/22.jpg",
    "slider/23.jpg",
    "slider/24.jpg",
    "slider/25.jpg",
    "slider/26.jpg",
    "slider/27.jpg",
  ];
  @override
  void initState() {
    super.initState();
    clearCartNow(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtenPressed(context),
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.cyan, Colors.amber],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          title: const Text(
            "Super Foodie",
            style: TextStyle(fontFamily: "KiwiMaru"),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Kerala",
                    style: TextStyle(fontFamily: "Acme", fontSize: 25),
                  ),
                )
              ],
            )
          ],
        ),
        drawer: MyDrawer(),
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 59.3,
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2.78, //260
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            CarouselSlider(
                              items: items.map((index) {
                                return Builder(builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 1.0),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(12),
                                      image: DecorationImage(
                                          image: AssetImage(
                                            index,
                                          ),
                                          fit: BoxFit.cover),
                                      color: Colors.black,
                                    ),
                                    // child: Padding(
                                    //   padding: const EdgeInsets.all(4.0),
                                    //   child: Image.asset(
                                    //     index,
                                    //     fit: BoxFit.fill,
                                    //   ),
                                    // ),
                                  );
                                });
                              }).toList(),
                              options: CarouselOptions(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.8,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 500),
                                autoPlayCurve: Curves.decelerate,
                                enlargeCenterPage: true,
                                scrollDirection: Axis.horizontal,
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height / 47.46,
                            ),
                            Container(
                              height:
                                  MediaQuery.of(context).size.height / 26.37,
                              margin: const EdgeInsets.only(left: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Restaurants",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  Text(
                                    " around you...",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black38),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("sellers")
                        .snapshots(),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? const SliverToBoxAdapter(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : SliverStaggeredGrid.countBuilder(
                              crossAxisCount: 1,
                              staggeredTileBuilder: (c) =>
                                  const StaggeredTile.fit(1),
                              itemBuilder: (context, index) {
                                Sellers smodel = Sellers.fromJson(
                                    snapshot.data!.docs[index].data()!
                                        as Map<String, dynamic>);
                                //
                                return SellersDesignWidget(
                                  model: smodel,
                                  context: context,
                                );
                              },
                              itemCount: snapshot.data!.docs.length,
                            );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackButtenPressed(BuildContext context) async {
    bool exitApp = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: const Text(
              "Do you want to close the app ?",
              style: TextStyle(
                  fontFamily: "KiwiMaru",
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
            title: const Text(
              "Really ??",
              style: TextStyle(
                  fontFamily: "KiwiMaru",
                  fontSize: 22,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text(
                    "No",
                    style: TextStyle(fontSize: 30, color: Colors.blueAccent),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    "Yes",
                    style: TextStyle(fontSize: 30, color: Colors.blueAccent),
                  )),
            ],
          );
        });

    return exitApp;
  }
}
