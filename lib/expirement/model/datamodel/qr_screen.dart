import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ggmobile/model/orderdetails_model.dart';
import 'package:ggmobile/model/whenclick_model.dart';
import 'package:ggmobile/screens/listofOrders.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';

class QrScreen extends StatefulWidget {
  final String? transactionId;

  const QrScreen({
    Key? key,
    this.transactionId,
  }) : super(key: key);

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  var getResult = 'QR Code Result';

  List<When> when = [];
  late Future<List<Whenclick>> orderFuture;
  String? transactionId;

  Future<List<Whenclick>> getOrderDetails(String? transactionId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? jsonData = prefs.getInt('jsonData');
      String? storedTransactionId = prefs.getString('transanction_id');
      if (jsonData != null) {
        Map<String, String> headers = {'Content-Type': 'application/json'};
        final msg = jsonEncode({});
        final response = await http.get(
          Uri.parse(
              'http://gorder.website/API/order-details.php?id=$jsonData&transaction_id=$transactionId'),
          headers: headers,
        );

        if (response.statusCode == 405) {
          final jsonData = json.decode(response.body);
          Whenclick order = Whenclick.fromMap(jsonData);

          setState(() {
            when = order.when;
            print('transactionId: $transactionId');
          });

          return [order];
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
        print('load');
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data');
    }
  }

  String data = ''; // Remove the initial value

  @override
  void initState() {
    super.initState();
    orderFuture = getOrderDetails(transactionId);
  }

  Future<String?> transactionIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedTransactionId = prefs.getString('transaction_id');
    return storedTransactionId;
  }

  final TextEditingController _editingController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    String? transactionId = widget.transactionId;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await (getOrderDetails(transactionId));
          print(getOrderDetails(transactionId));
        },
      ),
      appBar: AppBar(
        title: Text('order details'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: Color(0xFF545D68)),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: ((context) => AllOrders())));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: when.length,
        itemBuilder: (BuildContext context, int i) {
          final e = when[i];
          return Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 200,
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                      ),
                    ),
                    child: Center(
                      child: QrImage(
                        data: '$e.transactionId',
                        version: QrVersions.auto,
                        size: 200,
                      ),
                    ),
                  ),
                  Text(e.productName)
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
