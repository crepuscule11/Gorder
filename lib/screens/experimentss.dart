import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:ggmobile/model/searching_model.dart';
import 'package:ggmobile/screens/Homepage.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cartmodel.dart';

import 'package:http/http.dart' as http;

class Experiment extends StatefulWidget {
  const Experiment({Key? key}) : super(key: key);

  @override
  ExperimentState createState() => ExperimentState();
}

class ExperimentState extends State<Experiment> {
  TextEditingController _pmEditingController = TextEditingController();
  // List<Etits> lala = [];
  bool isProductFound = true;
  String productImg = '';
  String prodName = '';
  // late Future<List<Searching>> productFuture;

  Future<List<Searching>> getSearchingDetails(String text) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? jsonData = prefs.getInt('jsonData');
      if (jsonData != null) {
        Map<String, String> headers = {'Content-Type': 'application/json'};
        final msg = jsonEncode({});

        final response = await http.get(
          Uri.parse(
              'http://gorder.website/API/products.php?id=95363208&pro_search=$prodName'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final jsonString = response.body;
          Searching tahong = Searching.fromJson(jsonString);

          setState(() {
            productImg = tahong.etits[0].img;
            isProductFound = true;
            print(response);
          });
          return [tahong];
        } else {
          setState(() {
            isProductFound = false;
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
  // void initState() {
  //   super.initState();
  //   productFuture = getSearchingDetails();
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await getSearchingDetails(_pmEditingController.text);
        },
      ),
      appBar: AppBar(title: Text('Golden Gate'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: ((context) => MyHomePage(
                      data: '',
                      id: '',
                    ))));
          },
        ),
      ]),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 250,
                child: TextField(
                  controller: _pmEditingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      hintText: "Search Product"),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 50,
                width: 100,
                color: Colors.blue,
                child: TextButton(
                  onPressed: () async {
                    await getSearchingDetails(_pmEditingController.text);
                  },
                  child: Text('Search'),
                ),
              )
            ],
          ),
          isProductFound
              ? Column(
                  children: [
                    Container(
                      child: Image.network(
                        productImg,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Text(
                      prodName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )
              : Expanded(
                  child: Center(
                  child: Text('Product Not Found'),
                ))
        ],
      ),
    );
  }
}
