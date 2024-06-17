import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ggmobile/model/experiment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Lynard extends StatefulWidget {
  const Lynard({super.key});

  @override
  State<Lynard> createState() => _LynardState();
}

class _LynardState extends State<Lynard> {
  List<Len> orders = [];
  late Future<List<Len>> noobFuture;
  Future<List<Len>> getNoobDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? jsonData = prefs.getInt('jsonData');
      if (jsonData != null) {
        Map<String, String> headers = {'Content-Type': 'application/json'};
        final msg = jsonEncode({});

        final response = await http.get(
          Uri.parse(
              'http://gorder.website/API/check-out-get.php?id=$jsonData&payment_type=Gcash&delivery_type=Deliver'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          Exp exp = Exp.fromJson(jsonData);

          setState(() {
            orders = exp.orderDetails as List<Len>;
          });

          return orders;
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

  void initState() {
    super.initState();
    noobFuture = getNoobDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Text"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getNoobDetails();
        },
      ),
    );
  }
}
