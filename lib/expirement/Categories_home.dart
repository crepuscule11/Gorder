// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:get/get.dart';
import 'package:ggmobile/expirement/Categories_Details.dart';
import 'package:ggmobile/model/cartmodel.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/productdisplay_model.dart';
import '../model/search_model.dart';
import '../screens/login_screen.dart';
import 'bottom_bar.dart';
import 'model/datamodel/myCartmodel.dart';
import 'model/datamodel/userId_data.dart';

class Category extends StatefulWidget {
  final String id;
  final dynamic data;
  final UserId? userId;

  const Category({
    Key? key,
    required this.id,
    required this.data,
    required this.userId,
  }) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController pm = TextEditingController();
  String name = "";
  String img = "";
  String sellingPrice = "";
  String productId = '';
  String query = "";
  List<Dproduct> datum = [];
  List<Dproduct> newdatum = [];
  late Future<List<Display>> productFuture;

  Future<List<Display>> getProductDetails(
      String name, String data, String img, String query) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? jsonData = prefs.getInt('jsonData');
      if (jsonData != null) {
        Map<String, String> headers = {'Content-Type': 'application/json'};
        final msg = jsonEncode({});

        final response = await http.get(
          Uri.parse(
              'http://gorder.website/API/products.php?id=$jsonData&category=all&sub_cat=all'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          Display product = Display.fromJson(jsonData);

          setState(() {
            newdatum = datum = product.products;
          });

          return [product];
        } else {
          setState(() {
            Map<String, dynamic> jsonMap = jsonDecode(response.body);
            String mess = jsonMap['message'];

            print(mess);
            print("failed");
          });
          throw Exception('Failed to load data');
        }
      } else {
        print('userId is null');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data');
    }
  }

  Future<List<Products>?> wishlist(
    String productId,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? jsonData = prefs.getInt('jsonData');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final msg = jsonEncode({
        {"id": jsonData, "product_id": productId}
      });

      print("$productId $jsonData");

      http.Response response = await post(
        Uri.parse('https://gorder.website/API/add-wish-list.php'),
        headers: headers,
        body: msg,
      );
      print(response.body);

      if (response.statusCode == 405) {
        final jsondata = json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  List<Category> cat = [];
  late Future<List<Sorting>> sortingFuture;

  Future<List<Sorting>> getSorting() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? jsonData = prefs.getInt('jsonData');
      if (jsonData != null) {
        Map<String, String> headers = {'Content-Type': 'application/json'};
        final msg = jsonEncode({});

        final response = await http.get(
          Uri.parse(
              'http://gorder.website/API/products.php?id=$jsonData&category=all&sub_cat=all'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          Sorting sort = Sorting.fromJson(jsonData);

          setState(() {
            cat = sort.categories.cast<Category>();
          });

          return [sort];
        } else {
          setState(() {
            Map<String, dynamic> jsonMap = jsonDecode(response.body);
            String mess = jsonMap['message'];

            print(mess);
            print("failed");
          });
          throw Exception('Failed to load data');
        }
      } else {
        print('userId is null');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    productFuture = getProductDetails(name, sellingPrice, img, query);
    sortingFuture = getSorting();
  }

  void updatelist(String val) {
    setState(() {
      if (val.isEmpty) {
        newdatum = datum;
      } else {
        newdatum = datum
            .where((element) => element.productName
                .toString()
                .toLowerCase()
                .contains(val.toString().toLowerCase()))
            .toList();
      }
      ;
    });
  }

  @override
  Widget build(BuildContext context) {
    int _count = 0;

    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      body: ListView(
        children: <Widget>[
          Center(
            child: TextField(
              onChanged: ((value) {
                updatelist(value);
              }),
              decoration: InputDecoration(
                  hintText: 'search',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  suffixIcon: Icon(Icons.search)),
            ),
          ),
          Container(
              padding: EdgeInsets.only(right: 15.0, bottom: 20.0),
              width: MediaQuery.of(context).size.width - 30.0,
              height: MediaQuery.of(context).size.height - 25.0,
              child: GridView.count(
                crossAxisCount: 2,
                primary: false,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 15.0,
                childAspectRatio: 0.8,
                children: <Widget>[
                  ...newdatum.map(
                    (e) => _buildCard(
                        ' ${e.productName}',
                        '₱ ${e.price}',
                        'img: ${e.img}',
                        '${e.productId}',
                        false,
                        false,
                        context),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildCard(String name, String sellingPrice, String img,
      String productId, bool added, bool isFavorite, context) {
    final heroTag = img;
    Dproduct(
      qty: 0, // Replace with the appropriate values
      productId: productId,
      productName: name,
      g: '...',
      mg: '...',
      ml: '...',
      description: Description.EMPTY,
      img: img,
      price: 0.0,
      prescribe: false,
    ).getImageUrl(img); //

    return Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
      child: InkWell(
        onTap: () async {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: ((context) => ProductDetail(
                    sellingPrice: sellingPrice,
                    img: img,
                    name: name,
                    productId: productId,
                  ))));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3.0,
                blurRadius: 5.0,
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        await wishlist(productId);

                        setState(() {
                          isFavorite = !isFavorite;
                          // Toggle the isFavorite value
                        });
                      },
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite
                            ? Colors.red
                            : Color.fromARGB(255, 22, 12, 82),
                      ),
                    ),
                  ],
                ),
              ),
              Hero(
                tag: heroTag,
                child: Container(
                  child: Image.network(
                    Dproduct(
                      qty: 0, // Replace with the appropriate values
                      productId: productId,
                      productName: name,
                      g: '...',
                      mg: '...',
                      ml: '...',
                      description: Description.EMPTY,
                      img: img,
                      price: 0.0,
                      prescribe: false,
                    ).getImageUrl(
                        img), // Remove the 'img: ' prefix from the URL
                    height: 100.0,
                    width: 75.0,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                sellingPrice,
                style: TextStyle(color: Color(0xFFCC8053), fontSize: 14.0),
              ),
              Text(
                name,
                style: TextStyle(color: Color(0xFF575E67), fontSize: 14.0),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Container(color: Color(0xFFEBEBEB), height: 1.0),
              ),
              InkWell(
                child: Text('Add to cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(Object context) {
    return [
      IconButton(
          icon: Icon(Icons.close),
          onPressed: (() {
            query = " ";
          }))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  List<Dproduct> datum = [];
  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: ListView.builder(
          itemCount: datum.length,
          itemBuilder: (context, index) {
            final item = datum[index];
            return Card(
                child: Text(
              item.productName,
              style: TextStyle(color: Colors.black),
            ));
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("Search Product"),
    );
  }
}
