import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ggmobile/model/mainCat_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainCat extends StatefulWidget {
  const MainCat({super.key});

  @override
  State<MainCat> createState() => _MainCatState();
}

class _MainCatState extends State<MainCat> {
  List<Categories> frelyn = [];
  late Future<List<MainCategories>> categoriesfuture;

  Future<List<MainCategories>> getCategoriesDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? jsonData = prefs.getInt('jsonData');
      if (jsonData != null) {
        Map<String, String> headers = {'Content-Type': 'application/json'};
        final msg = jsonEncode({});

        final response = await http.get(
          Uri.parse(
              'http://gorder.website/API/products-category.php?id=82780333'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final jsonDataString = response.body; // Response body is a string
          final jsonData = json.decode(jsonDataString); // Parse the JSON

          MainCategories cate = MainCategories.fromJson(jsonData);

          setState(() {
            frelyn = cate.categories!;
          });

          return [cate];
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
    categoriesfuture = getCategoriesDetails();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await getCategoriesDetails();
        },
      ),
      body: ListView.builder(
          itemCount: frelyn.length,
          itemBuilder: (context, index) {
            final item = frelyn[index];
            return GestureDetector(
              onTap: () {},
              child: Card(
                child: ListTile(leading: Text(item.catName.toString())),
              ),
            );
          }),
    );
  }
}
