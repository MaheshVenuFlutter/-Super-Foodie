import 'package:flutter/material.dart';
import 'package:food_users/mainScreens/item_details_screen.dart';
import 'package:food_users/models/items.dart';
import 'package:food_users/models/sellers_model.dart';

class itemsDesignWidget extends StatefulWidget {
  Items? model;
  BuildContext? context;

  itemsDesignWidget({
    this.model,
    this.context,
  });

  @override
  State<itemsDesignWidget> createState() => _itemsDesignWidgetState();
}

class _itemsDesignWidgetState extends State<itemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => ItemDetailScreen(model: widget.model)));
      },
      splashColor: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: MediaQuery.of(context).size.height / 3.747,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned(
                top: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height / 4.188,
                  width: MediaQuery.of(context).size.width / 1.0588,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.model!.thumbnailUrl!,
                          ),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(20)),
                )),
            Positioned(
              bottom: 5,
              child: Container(
                height: MediaQuery.of(context).size.height / 14.24, //50,
                width: MediaQuery.of(context).size.width / 1.0588,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.cyan, Colors.amber],
                        begin: FractionalOffset(0.0, 0.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFe8e8e8),
                        offset: Offset(0, 5),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0, 0),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0, 0),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.model!.title!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width / 18,
                          fontFamily: "Acme"),
                    ),
                    Text(
                      widget.model!.shortInfo!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
Column(
            children: [
              const Divider(
                height: 10,
                thickness: 3,
                color: Colors.grey,
              ),
              Image.network(
                widget.model!.thumbnailUrl!,
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 1.0,
              ),
              Text(
                widget.model!.title!,
                style: const TextStyle(
                    color: Colors.cyan, fontSize: 20, fontFamily: "Train"),
              ),
              Text(
                widget.model!.shortInfo!,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ],
          ),
*/
