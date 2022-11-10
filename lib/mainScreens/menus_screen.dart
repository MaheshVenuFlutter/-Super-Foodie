import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_users/assistantMethods/assistant_methods.dart';
import 'package:food_users/models/sellers_model.dart';
import 'package:food_users/widgets/menus_design.dart';

import '../global/global.dart';
import '../models/menus_model.dart';
import '../splashScreen/splash_screen.dart';
import '../widgets/sellers_design.dart';
import '../widgets/my_drawer.dart';
import '../widgets/text_widget_header.dart';

class MenuScreen extends StatefulWidget {
  final Sellers? model;
  MenuScreen({this.model});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
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
          leading: IconButton(
              onPressed: () {
                clearCartNow(context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (c) => const MySplashScreen()),
                    (route) => false);
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text(
            "Super Foodie",
            style: TextStyle(fontSize: 45, fontFamily: "Signatra"),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
                pinned: true,
                delegate: TextWidgetHeader(
                  title: widget.model!.sellerName.toString() + "'s " + "Menu",
                )),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("sellers")
                  .doc(widget.model!.sellerUID)
                  .collection("menus")
                  .orderBy(
                    "publishedDate",
                    descending: true,
                  )
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
                        staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                        itemBuilder: (context, index) {
                          Menus model = Menus.fromJson(
                              snapshot.data!.docs[index].data()!
                                  as Map<String, dynamic>);
                          return MenusDesignWidget(
                            model: model,
                            context: context,
                          );
                        },
                        itemCount: snapshot.data!.docs.length,
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}

// Future<bool> _onBackButtenPressed(BuildContext context) async {
//   bool exitApp = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           content: const Text(
//             "Do you want to close the app ?",
//             style: TextStyle(
//                 fontFamily: "KiwiMaru",
//                 fontSize: 15,
//                 color: Colors.black87,
//                 fontWeight: FontWeight.bold),
//           ),
//           title: const Text(
//             "Really ??",
//             style: TextStyle(
//                 fontFamily: "KiwiMaru",
//                 fontSize: 22,
//                 color: Colors.black87,
//                 fontWeight: FontWeight.bold),
//           ),
//           actions: <Widget>[
//             TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(false);
//                 },
//                 child: const Text(
//                   "No",
//                   style: TextStyle(fontSize: 30, color: Colors.blueAccent),
//                 )),
//             TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(true);
//                 },
//                 child: const Text(
//                   "Yes",
//                   style: TextStyle(fontSize: 30, color: Colors.blueAccent),
//                 )),
//           ],
//         );
//       });

//   return exitApp;
// }
