import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ggmobile/screens/Homepage.dart';
import 'package:ggmobile/screens/login_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/user_model.dart';

class Profile extends StatefulWidget {
  static const routeName = "/profile";

  @override
  _ProfileState createState() => _ProfileState();
}

// http://gorder.website/API/user-profile.php?id=817622
class _ProfileState extends State<Profile> {
  List<Data> aica = [];
  List<UserModel> userModel = [];
  late Future<List<UserModel>> userFuture;
  String? barangayId;
  String? unitSt;

  Future<List<UserModel>> userDetails() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int? jsonData = prefs.getInt('jsonData');
      String? storedTransactionId = prefs.getString('transanction_id');
      if (jsonData != null) {
        Map<String, String> headers = {'Content-Type': 'application/json'};

        final response = await http.get(
          Uri.parse('http://gorder.website/API/user-profile.php?id=$jsonData'),
          headers: headers,
        );

        if (response.statusCode == 200) {
          final response1 = json.decode(response.body);
          UserModel user = UserModel.fromJson(response1);

          setState(() {
            aica = [user.data];
            barangayId = user.data.barangayId;
            unitSt = user.data.unitSt;
          });
          prefs.setString('barangayId', barangayId ?? '');
          prefs.setString('unitSt', unitSt ?? '');

          return [user];
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

  Future<void> printBarangayIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedBarangayId = prefs.getString('barangayId');
  }

  Future<void> unitStfromSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUnitSt = prefs.getString('unitSt');
    setState(() {
      unitSt = storedUnitSt ?? '';
    });
  }

  @override
  void initState() {
    super.initState();

    userFuture = userDetails();
    printBarangayIdFromSharedPreferences();
    unitStfromSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: aica.length,
        itemBuilder: (context, index) {
          final data = aica[index];
          return Column(
            children: [
              const SizedBox(height: 40),
              ClipOval(
                child: CircleAvatar(
                  radius: 70,
                  child: Image.network(
                    data.picture,
                    width: 140,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              itemProfile(
                  'Name',
                  data.firstName + data.middleInitial + data.lastName,
                  CupertinoIcons.person),
              const SizedBox(height: 10),
              itemProfile('Phone', data.contactNo, CupertinoIcons.phone),
              const SizedBox(height: 10),
              itemProfile('Address', data.barangay, CupertinoIcons.location),
              const SizedBox(height: 10),
              itemProfile('Email', data.email, CupertinoIcons.mail),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => MyHomePage(
                              data: '',
                              id: '',
                            ))));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text('Go back to Gorder'),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => LoginScreen(
                              id: '',
                            ))));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                  ),
                  child: const Text('log out'),
                ),
              ),
            ],
          );
        },
      ),
    ));
  }
}

itemProfile(String title, String subtitle, IconData iconData) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 5),
              color: Colors.deepOrange.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 10)
        ]),
    child: ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: Icon(iconData),
      trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
      tileColor: Colors.white,
    ),
  );
}
