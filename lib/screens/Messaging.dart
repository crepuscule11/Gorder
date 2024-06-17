import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:ggmobile/screens/Homepage.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/cartmodel.dart';

import 'package:http/http.dart' as http;

class MyChatApp extends StatefulWidget {
  const MyChatApp({Key? key}) : super(key: key);

  @override
  MyChatAppState createState() => MyChatAppState();
}

class MyChatAppState extends State<MyChatApp> {
  TextEditingController pm = TextEditingController();
  Future<List<Products>?> chat(
    String productId,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? jsonData = prefs.getInt('jsonData');
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final msg = jsonEncode({"id": jsonData, "message": pm.text.trim()});

      print("$productId $jsonData");

      http.Response response = await post(
        Uri.parse('https://gorder.website/API/send-message.php'),
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

  String directmessage = "";
  bool _dm = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Golden Gate'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Container(child: Center(child: Text(directmessage)))),
            TextField(
              controller: pm,
              decoration: InputDecoration(
                  hintText: "message",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: (() {
                      pm.clear();
                    }),
                    icon: Icon(Icons.clear),
                  )),
            ),
            MaterialButton(
              onPressed: () async {
                await chat(directmessage);
                setState(() {
                  directmessage = pm.text;
                });
              },
              color: Colors.blue,
              child: Text("send"),
            )
          ],
        ),
      ),
    );
  }
}
