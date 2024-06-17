import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../model/orderlist_model.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List<Data>? data = [];

  @override
  void initState() {
    super.initState();
    fetchOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: fetchOrder,
      ),
      appBar: AppBar(title: Text('Orders')),
      body: ListView.builder(
          itemCount: data!.length,
          itemBuilder: (BuildContext context, int index) {
            final e = data![index];

            return GestureDetector(
              onTap: () {
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //     builder: ((context) => const QrScreen())));
              },
              child: Card(
                child: ListTile(
                  leading: Container(child: Text(e.transactionId)),
                  title: Text(e.orderStatus),
                  subtitle: Text("${e.orderDate} ${e.orderTime}"),
                ),
              ),
            );
          }),
    );
  }

  void fetchOrder() async {
    print('fetchuser');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? jsonData = prefs.getInt('jsonData');

    if (jsonData != null) {
      final url = 'http://gorder.website/API/orders.php?id=$jsonData ';
      print(url);
      final uri = Uri.parse(url);
      final response = await http.get(uri);
      final body = response.body;
      final json = jsonDecode(body);
      print(json);
      final ord = json['data'] as List<dynamic>;
      final transformed = ord.map((e) {
        return Data(
          transactionId: e["transaction_id"],
          orderTime: e["order_time"],
          orderDate: DateTime.parse(e["order_date"]),
          orderStatus: e["order_status"],
        );
      }).toList();
      setState(() {
        data = transformed;
      });
      print('fetch orders');
    } else {
      print('jsonData is null');
      // Handle the case when jsonData is null
    }
  }
}
