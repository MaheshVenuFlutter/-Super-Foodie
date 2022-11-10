import 'package:flutter/material.dart';
import 'package:food_users/mainScreens/menus_screen.dart';
import 'package:food_users/models/sellers_model.dart';

import 'Icon_and_text_widget.dart';

class SellersDesignWidget extends StatefulWidget {
  Sellers? model;
  BuildContext? context;

  SellersDesignWidget({
    this.model,
    this.context,
  });

  @override
  State<SellersDesignWidget> createState() => _SellersDesignWidgetState();
}

class _SellersDesignWidgetState extends State<SellersDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (c) => MenuScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    ),
                  ]),
              child: Row(
                children: [
                  ///image container
                  Container(
                    height: MediaQuery.of(context).size.width / 3,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              widget.model!.sellerAvatarUrl!,
                            ),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadiusDirectional.circular(12)),
                  ),

                  // text container
                  Expanded(
                    child: Container(
                      height: 100,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.model!.sellerName!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontFamily: "Acme"),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.model!.restInfo!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: Colors.black38, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconAndTextWidget(
                                    icon: Icons.circle_sharp,
                                    text: 'Non veg',
                                    iconColor: Colors.cyan),
                                //
                                //secopnd icon
                                IconAndTextWidget(
                                    icon: Icons.location_on,
                                    text: '1.7',
                                    iconColor: Colors.red),
                                //
                                //third icon
                                IconAndTextWidget(
                                    icon: Icons.access_time_outlined,
                                    text: '32min',
                                    iconColor: Colors.amber)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Container(
//               height: 150,
//               width: 150,
//               child: Column(
//                 children: [
//                   const Divider(
//                     height: 10,
//                     thickness: 3,
//                     color: Colors.grey,
//                   ),
//                   const SizedBox(
//                     height: 1.0,
//                   ),
//                   Text(
//                     widget.model!.sellerName!,
//                     style: const TextStyle(
//                         color: Colors.cyan, fontSize: 20, fontFamily: "Train"),
//                   ),
//                   Text(
//                     widget.model!.sellerEmail!,
//                     style: const TextStyle(
//                       color: Colors.grey,
//                       fontSize: 15,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
