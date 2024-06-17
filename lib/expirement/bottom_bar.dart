import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:ggmobile/User/User_screen.dart';
import 'package:ggmobile/expirement/cart_screen.dart';
import 'package:ggmobile/expirement/model/datamodel/orderlist_screen.dart';
import 'package:ggmobile/screens/Messaging.dart';

import 'package:ggmobile/screens/listofOrders.dart';

class BottomBar extends StatelessWidget {
  late final int cust_id;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: Colors.transparent,
        elevation: 9.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
            height: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0)),
                color: Colors.white),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width / 2 - 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.message, color: Colors.blue),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const MyChatApp()));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.person, color: Colors.blue),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Profile()));
                            },
                          )
                        ],
                      )),
                  Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width / 2 - 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.bookmark_add_sharp,
                                color: Colors.blue),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const AllOrders()));
                            },
                          ),
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              IconButton(
                                icon: Icon(Icons.shopping_bag,
                                    color: Colors.blue),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CartList(),
                                  ));
                                },
                              ),
                              Badge(
                                badgeContent: Text("0"),
                              ),
                            ],
                          ),
                        ],
                      )),
                ])));
  }
}
