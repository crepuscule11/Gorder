import 'package:flutter/material.dart';
import 'package:ggmobile/allorders_model/delivered_model.dart';
import 'package:ggmobile/allorders_model/pending_model.dart';
import 'package:ggmobile/allorders_model/toship_model.dart';
import 'package:ggmobile/expirement/model/datamodel/qr_screen.dart';
import 'package:ggmobile/model/allorders_model.dart';
import 'package:ggmobile/model/whenclick_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../allorders_model/toreceive_model.dart';
import '../expirement/Categories_home.dart';

class AllOrders extends StatefulWidget {
  const AllOrders({super.key});

  @override
  State<AllOrders> createState() => _AllOrdersState();
}

class _AllOrdersState extends State<AllOrders>
    with SingleTickerProviderStateMixin {
  List<Data> data = [];
  String userId = '';
  String? transaction_Id;
  late TabController _tabController;
  late Future<List<OlOrders>> allorderfuture;

  Future<List<OlOrders>> getAllOrders() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? jsonData = prefs.getInt('jsonData');
      if (jsonData != null) {
        Map<String, String> headers = {'Content-Type': 'application/json'};
        final response = await http.get(
          Uri.parse(
              'http://gorder.website/API/orders.php?id=$jsonData&order_type=Deliver&status=Accepted'),
          headers: headers,
        );

        if (response.statusCode == 405) {
          final jsonData = json.decode(response.body);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final responseData = json.decode(response.body);

          String? transactionId = jsonData['data'][0]['transaction_id'];
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => QrScreen(transactionId: transactionId),
            ),
          );
          await prefs
            ..setString('transaction_id', responseData);

          OlOrders product = OlOrders.fromJson(jsonData);

          debugPrint('transactionId: $transactionId');

          setState(() {
            data = product.data!;
            print('JSON Data: $jsonData');
            print('Transaction ID: $transactionId');
          });

          return [product];
        } else {
          setState(() {
            Map<String, dynamic> jsonMap = jsonDecode(response.body);
            String mess = jsonMap['message'];
            print(mess);
            print("failed");
          });
          throw Exception(
              'API request failed with status code ${response.statusCode}');
        }
      } else {
        print('userId is null');
        throw Exception('UserId is null');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<void> transactionIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedTransactionId = prefs.getString('transactionId');
    print('stored: $storedTransactionId');
  }

  List<Pen> pen = [];
  late Future<List<Pending>> pendingFUture;
  Future<List<Pending>> getPending() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? jsonData = prefs.getInt('jsonData');
      String? storedBarangayId = prefs.getString('barangayId');
      print(storedBarangayId);
      if (jsonData != null) {
        Map<String, String> headers = {'Content-Type': 'application/json'};
        final response = await http.get(
          Uri.parse(
              'http://gorder.website/API/orders.php?id=$jsonData&order_type=Deliver&status=Pending'),
          headers: headers,
        );
        print(jsonData);
        if (response.statusCode == 405) {
          final jsonData = json.decode(response.body);
          Pending product = Pending.fromJson(jsonData);
          final responseData = json.encode(response.body);
          String? transactionId = jsonData['data'][0]['transaction_id'];

          setState(() {
            pen = product.pen!;
            print(transactionId);
          });

          return [product];
        } else {
          setState(() {
            Map<String, dynamic> jsonMap = jsonDecode(response.body);
            String mess = jsonMap['message'];
            print(mess);
            print("failed");
          });
          throw Exception(
              'API request failed with status code ${response.statusCode}');
        }
      } else {
        print('userId is null');
        throw Exception('UserId is null');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch data: $e');
    }
  }

  List<Tosh> tosh = [];
  late Future<List<Toship>> toshFuture;
  Future<List<Toship>> getToShip() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? jsonData = prefs.getInt('jsonData');
      String transactionId = prefs.toString();
      print(transactionId);
      if (jsonData != null) {
        Map<String, String> headers = {'Content-Type': 'application/json'};
        final response = await http.get(
          Uri.parse(
              'http://gorder.website/API/orders.php?id=$jsonData&order_type=Deliver&status=To Ship'),
          headers: headers,
        );
        print(jsonData);
        if (response.statusCode == 405) {
          final jsonData = json.decode(response.body);
          Toship product = Toship.fromJson(jsonData);

          setState(() {
            tosh = product.tosh!;
          });

          return [product];
        } else {
          setState(() {
            Map<String, dynamic> jsonMap = jsonDecode(response.body);
            String mess = jsonMap['message'];
            print(mess);
            print("failed");
          });
          throw Exception(
              'API request failed with status code ${response.statusCode}');
        }
      } else {
        print('userId is null');
        throw Exception('UserId is null');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch data: $e');
    }
  }

  List<Rec> rec = [];
  late Future<List<Receiveee>> futureReceive;
  Future<List<Receiveee>> getToReceive() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? jsonData = prefs.getInt('jsonData');
      String transactionId = prefs.toString();
      print(transactionId);
      if (jsonData != null) {
        Map<String, String> headers = {'Content-Type': 'application/json'};
        final response = await http.get(
          Uri.parse(
              'http://gorder.website/API/orders.php?id=$jsonData&order_type=Deliver&status=To Receive'),
          headers: headers,
        );
        print(jsonData);
        if (response.statusCode == 405) {
          final jsonData = json.decode(response.body);
          Receiveee product = Receiveee.fromJson(jsonData);

          setState(() {
            rec = product.rec!;
          });

          return [product];
        } else {
          setState(() {
            Map<String, dynamic> jsonMap = jsonDecode(response.body);
            String mess = jsonMap['message'];
            print(mess);
            print("failed");
          });
          throw Exception(
              'API request failed with status code ${response.statusCode}');
        }
      } else {
        print('userId is null');
        throw Exception('UserId is null');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch data: $e');
    }
  }

  List<Del> del = [];
  late Future<List<Delivered>> Deliveredfuture;
  Future<List<Delivered>> ToDeliver() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? jsonData = prefs.getInt('jsonData');

      if (jsonData != null) {
        Map<String, String> headers = {'Content-Type': 'application/json'};
        final response = await http.get(
          Uri.parse(
              'http://gorder.website/API/orders.php?id=$jsonData&order_type=Deliver&status=Delivered'),
          headers: headers,
        );
        print(jsonData);
        if (response.statusCode == 405) {
          final jsonData = json.decode(response.body);
          Delivered product = Delivered.fromJson(jsonData);

          setState(() {
            del = product.del!;
          });

          return [product];
        } else {
          setState(() {
            Map<String, dynamic> jsonMap = jsonDecode(response.body);
            String mess = jsonMap['message'];
            print(mess);
            print("failed");
          });
          throw Exception(
              'API request failed with status code ${response.statusCode}');
        }
      } else {
        print('userId is null');
        throw Exception('UserId is null');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    allorderfuture = getAllOrders();
    toshFuture = getToShip();
    futureReceive = getToReceive();
    pendingFUture = getPending();
    _tabController = TabController(length: 5, vsync: this);
    transactionIdFromSharedPreferences();
    print("transaction: $transactionIdFromSharedPreferences()");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await getAllOrders();
          print(getAllOrders());
        },
        child: Icon(Icons.refresh),
      ),
      appBar: AppBar(
        title: Text('All Orders'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: Colors.blue),
                height: 50,
                width: 100,
                child: MaterialButton(
                  onPressed: () {},
                  child: Text(
                    "Delivered",
                    style: TextStyle(
                      fontSize: 8, // Adjust the font size as needed
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.amber),
                height: 50,
                width: 100,
                child: MaterialButton(
                  onPressed: () {},
                  child: Text(
                    "Pending",
                    style: TextStyle(
                      fontSize: 8, // Adjust the font size as needed
                    ),
                  ),
                ),
              ),
            ],
          ),
          Material(
            child: Container(
              height: 55,
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                physics: const ClampingScrollPhysics(),
                unselectedLabelColor: Colors.amber,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber,
                ),
                tabs: [
                  Tab(
                    icon: Icon(Icons.pending),
                    child: Text(
                      'pending',
                      style: TextStyle(
                        fontSize: 8, // Set your desired font size
                      ),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.check_circle),
                    child: Text(
                      'check',
                      style: TextStyle(
                        fontSize: 8, // Set your desired font size
                      ),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.local_shipping_rounded),
                    child: Text(
                      'shipped',
                      style: TextStyle(
                        fontSize: 8, // Set your desired font size
                      ),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.receipt),
                    child: Text(
                      'To receive',
                      style: TextStyle(
                        fontSize: 8, // Set your desired font size
                      ),
                    ),
                  ),
                  Tab(
                    icon: Icon(Icons.delivery_dining_outlined),
                    child: Text(
                      'Delivered',
                      style: TextStyle(
                        fontSize: 8, // Set your desired font size
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _pendingTab(),
                _buildShippedTab(),
                _Toshipped(),
                _buildToReceiveTab(),
                _buildDeliveredTab()
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pendingTab() {
    if (pen.isEmpty) {
      return Center(
        child: Text("Order now"),
      );
    } else if (pen.isNotEmpty) {
      return ListView.separated(
        itemCount: pen.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (context, index) {
          final e = pen[index];
          return Card(
            child: ListTile(
              onTap: () {
                // _tabController.animateTo(1);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: ((context) => const QrScreen(transactionId: "")),
                  ),
                );
              },
              title: Text(e.transactionId ?? ""),
              subtitle: Text(e.orderStatus ?? ""),
              trailing: Text(e.orderDate ?? ""),
            ),
          );
        },
      );
    } else {
      return Center(
        child: Text('No orders available.'),
      );
    }
  }

  Widget _buildShippedTab() {
    if (tosh.isEmpty) {
      return Center(
        child: Text("Please wait for your Delivery"),
      );
    } else if (tosh.isNotEmpty) {
      return ListView.separated(
        itemCount: tosh.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (context, index) {
          final l = tosh[index];
          return ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Order Details'),
                    content: Text('Transaction ID: ${l.transactionId ?? ""}'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ],
                  );
                },
              );
            },
            title: Text(l.transactionId ?? ""),
            trailing: const Icon(Icons.arrow_right),
          );
        },
      );
    } else {
      return Center(
        child: Text('No shipped orders available.'),
      );
    }
  }

  Widget _Toshipped() {
    if (tosh.isEmpty) {
      return Center(
        child: Text("Please wait for your delivery"),
      );
    } else if (tosh.isNotEmpty) {
      return ListView.separated(
        itemCount: tosh.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (context, index) {
          final f = tosh[index];
          return ListTile(
            onTap: () {},
            title: Text(f.transactionId ?? ""),
            trailing: const Icon(Icons.arrow_right),
          );
        },
      );
    } else {
      return Center(
        child: Text('No shipped orders available.'),
      );
    }
  }

  Widget _buildToReceiveTab() {
    if (rec.isEmpty) {
      return Center(
        child: Text("Please wait for your Delivery"),
      );
    } else if (rec.isNotEmpty) {
      return ListView.separated(
        itemCount: rec.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (context, index) {
          final e = rec[index];
          return ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Container(
                      child: QrImage(data: "${e.transactionId}"),
                    ),
                    content: Text('Transaction ID: ${e.transactionId}'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ],
                  );
                },
              );
            },
            title: Text(e.transactionId ?? ""),
            trailing: const Icon(Icons.arrow_right),
          );
        },
      );
    } else {
      return Center(
        child: Text('No orders available.'),
      );
    }
  }

  Widget _buildDeliveredTab() {
    if (del.isEmpty) {
      return Center(
        child: Text("Please wait for your Delivery"),
      );
    } else if (del.isNotEmpty) {
      return ListView.separated(
        itemCount: del.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemBuilder: (context, index) {
          final e = del[index];
          return ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Container(
                      child: QrImage(data: "$e.transactionId"),
                    ),
                    content: Text('Transaction ID: ${e.transactionId ?? ""}'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                    ],
                  );
                },
              );
            },
            title: Text(e.transactionId ?? ""),
            trailing: const Icon(Icons.arrow_right),
          );
        },
      );
    } else {
      return Center(
        child: Text('No orders available.'),
      );
    }
  }
}
