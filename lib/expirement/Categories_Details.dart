// ignore_for_file: unused_import, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ggmobile/expirement/bottom_bar.dart';
import 'package:ggmobile/screens/Homepage.dart';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/cartmodel.dart';

import 'package:http/http.dart' as http;

class ProductDetail extends StatefulWidget {
  // final Products product;

  final img, sellingPrice, name, productId, userId, description;

  const ProductDetail({
    Key? key,
    this.img,
    this.sellingPrice,
    this.name,
    this.productId,
    this.userId,
    this.description,
    // required this.product,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List<Datum> datum = [];

  Future<List<Products>?> addtoCart(
    String productId,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? jsonData = prefs.getInt('jsonData');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final msg = jsonEncode({
        'product_id': productId,
        'cust_id': jsonData,
      });

      print("$productId $jsonData");

      http.Response response = await post(
        Uri.parse('https://gorder.website/API/add-to-cart.php'),
        headers: headers,
        body: msg,
      );
      print(response.body);

      if (response.statusCode == 200) {
        final jsondata = json.decode(response.body);
        Products product = Products.fromJson(jsondata);

        setState(() {
          datum = product.data;
        });

        // Do something with the response, such as showing a success message

        return [product];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  final bool _isAddtoCart = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: ((context) => MyHomePage(
                      id: '',
                      data: '',
                    ))));
          },
        ),
        title: const Text('Details',
            style: TextStyle(fontSize: 20.0, color: Color(0xFF545D68))),
        actions: <Widget>[
          IconButton(
            icon:
                const Icon(Icons.notifications_none, color: Color(0xFF545D68)),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(children: [
        const SizedBox(height: 15.0),
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text('Description',
              style: TextStyle(
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF17532))),
        ),
        const SizedBox(height: 15.0),
        Hero(
          tag: '${widget.img}',
          child: Image.network(
            widget.img, // Use widget.img as the URL
            height: 150.0,
            width: 100.0,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 20.0),
        Center(
          child: Text('${widget.sellingPrice}',
              style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF17532))),
        ),
        const SizedBox(height: 10.0),
        Center(
          child: Text('${widget.name}',
              style: const TextStyle(color: Color(0xFF575E67), fontSize: 24.0)),
        ),
        const SizedBox(height: 20.0),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width - 50.0,
            child: Text('',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0, color: Color(0xFFB4B8B9))),
          ),
        ),
        const SizedBox(height: 20.0),
        GestureDetector(
            onTap: addtoCart == null
                ? null
                : () async {
                    await addtoCart(widget.productId);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Successful"),
                    ));
                  },
            child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.lightBlue),
                child: const Center(
                    child: Text(
                  'Add to cart',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )))),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: ((context) => MyHomePage(
                    id: '',
                    data: '',
                  ))));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.local_hospital),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}
