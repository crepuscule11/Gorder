import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ggmobile/expirement/Categories_home.dart';
import 'package:ggmobile/expirement/bottom_bar.dart';
import 'package:ggmobile/model/cartmodel.dart';
import 'package:ggmobile/model/searching_model.dart';
import 'package:ggmobile/screens/categories.dart';
import 'package:ggmobile/screens/experimentss.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../data/CartItem.dart';
import '../expirement/Categories_Details.dart';

class MyHomePage extends StatefulWidget {
  final String id;

  const MyHomePage({
    Key? key,
    required this.id,
    required String data,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TextEditingController _pmEditingController = TextEditingController();
  late TabController _tabController;
  String name = "";
  String img = "";
  String sellingPrice = "";
  String id = "";
  bool isProductFound = true;

  late Future<List<Products>> productFuture;

  int index = 0;

  get userId => null;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text('Golden Gate',
            style: TextStyle(fontSize: 20.0, color: Color(0xFF545D68))),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: Color(0xFF545D68)),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: ((context) => MainCat())));
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20.0),
        children: <Widget>[
          SizedBox(height: 15.0),
          Text('Categories',
              style: TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 15.0),
          TabBar(
              controller: _tabController,
              indicatorColor: Colors.transparent,
              labelColor: Color(0xFFC88D67),
              isScrollable: true,
              labelPadding: EdgeInsets.only(right: 45.0),
              unselectedLabelColor: Color(0xFFCDCDCD),
              tabs: [
                Tab(
                  child: Text('Branded',
                      style: TextStyle(
                        fontSize: 21.0,
                      )),
                ),
                Tab(
                  child: Text('Generic',
                      style: TextStyle(
                        fontSize: 21.0,
                      )),
                ),
                Tab(
                  child: Text('Consumer Goods',
                      style: TextStyle(
                        fontSize: 21.0,
                      )),
                ),
                Tab(
                  child: Text('Sari-sari',
                      style: TextStyle(
                        fontSize: 21.0,
                      )),
                ),
              ]),
          Container(
              height: MediaQuery.of(context).size.height - 50.0,
              width: double.infinity,
              child: TabBarView(controller: _tabController, children: [
                Category(
                  id: '',
                  data: '',
                  userId: userId,
                ),
                Category(
                  id: '',
                  data: '',
                  userId: userId,
                ),
                Category(
                  id: '',
                  data: '',
                  userId: userId,
                ),
                Category(id: '', data: '', userId: userId),
              ])),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        backgroundColor: Colors.blue,
        child: Icon(Icons.home),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}
