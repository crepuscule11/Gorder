import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ggmobile/expirement/checkout_screen.dart';
import 'package:ggmobile/expirement/expirement.dart';
import 'package:ggmobile/model/cartItems_model.dart';
import 'package:ggmobile/model/cartmodel.dart';
import 'package:ggmobile/model/checkout_model.dart';
import 'package:ggmobile/screens/Homepage.dart';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bottom_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:http/http.dart' as http;

class CartList extends StatefulWidget {
  static const id = '/cart';
  const CartList({
    Key? key,
  }) : super(key: key);

  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  String productName = "";
  String picture = '';
  String sellingPrice = '';
  String productId = "";
  String qty = " ";
  String amount = "";
  List<Lhendcy> lhendcy = [];
  List<CartItems> pepeto = [];
  late int cartTotal;
  late Future<List<CartItems>> productFuture;
  Future<List<CartItems>> cartItems() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? jsonData = prefs.getInt('jsonData');
      if (jsonData != null) {
        Map<String, String> headers = {'Content-Type': 'application/json'};
        final msg = jsonEncode({});

        final response = await http.get(
          Uri.parse(
              'https://gorder.website/API/cart-items.php?cust_id=$jsonData'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          CartItems cartItems = CartItems.fromJson(jsonData);
          cartTotal = cartItems.total;

          setState(() {
            lhendcy = cartItems.data;
          });

          return [cartItems];
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

  Future<List<Products>?> minus(
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
        Uri.parse('https://gorder.website/API/minus-cart.php'),
        headers: headers,
        body: msg,
      );
      print(response.body);

      if (response.statusCode == 405) {
        final jsondata = json.decode(response.body);
        Products product = Products.fromJson(jsondata);

        setState(() {
          datum = product.data;
        });

        return [product];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<Products>?> delete(
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
        Uri.parse('https://gorder.website/API/delete-cart.php'),
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

        return [product];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  List<Pepito> pepito = [];
  Future<List<CheckOut>?> checkoutDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? jsonData = prefs.getInt('jsonData');

      Map<String, String> headers = {'Content-Type': 'application/json'};
      final msg = jsonEncode({
        "id": jsonData,
        "payment_type": "GCash",
        "delivery_type": "Deliver"
      });
      print(jsonData);

      http.Response response = await post(
        Uri.parse('https://gorder.website/API/check-out.php'),
        headers: headers,
        body: msg,
      );
      print(response.body);

      if (response.statusCode == 200) {
        final jsondata = json.decode(response.body);
        CheckOut lhendcy = CheckOut.fromJson(jsondata);

        setState(() {
          pepito = lhendcy.items;
        });

        return [lhendcy];
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
    productFuture = cartItems();
  }

  int _count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
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
      ),
      backgroundColor: Color(0xFFFCFAF8),
      body: lhendcy.isEmpty
          ? Center(
              child: Text('Your cart is empty.'),
            )
          : Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '₱ $cartTotal',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await checkoutDetails();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      const CheckoutScreen())));
                        },
                        child: Text('Checkout'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: lhendcy.length,
                    itemBuilder: (context, index) {
                      final item = lhendcy[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigator.of(context).pushReplacement(
                          //     MaterialPageRoute(
                          //         builder: ((context) =>
                          //             const ProductDetail())));
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Card(
                            child: ListTile(
                              // ListTile content
                              title: Text(item.productName),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15),
                                  Text("₱ ${item.sellingPrice.toString()}"),
                                ],
                              ),
                              leading: Container(
                                  height: 50,
                                  width: 40,
                                  child: CachedNetworkImage(
                                    imageUrl: item.picture,
                                    // Other image properties...
                                  )),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_rounded,
                                      color: Colors.black,
                                    ),
                                    onPressed: addtoCart == null
                                        ? null
                                        : () async {
                                            await addtoCart(item.productId);
                                            setState(() {
                                              item.qty++;
                                            });
                                          },
                                  ),
                                  Text(item.qty.toString()),
                                  IconButton(
                                    icon: Icon(
                                      Icons.remove_rounded,
                                      color: Color.fromARGB(255, 1, 1, 1),
                                    ),
                                    onPressed: minus == null
                                        ? null
                                        : () async {
                                            await minus(item.productId);
                                            if (item.qty > 1) {
                                              setState(() {
                                                item.qty--;
                                              });
                                            }
                                          },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: delete == null
                                        ? null
                                        : () async {
                                            await delete(item.productId);
                                            setState(() {
                                              lhendcy.removeAt(index);
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Item Deleted Successfully"),
                                            ));
                                          },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: ((context) => MyHomePage(
                    data: '',
                    id: '',
                  ))));
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.home),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}
