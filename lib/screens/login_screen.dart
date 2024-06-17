import 'dart:convert';
import 'dart:developer';

import 'package:ggmobile/expirement/model/datamodel/userId_data.dart';
import 'package:ggmobile/screens/Homepage.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

import '../expirement/Categories_home.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../model/cartmodel.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  final String id;

  LoginScreen({Key? key, required this.id}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw "Can not launch url";
    }
  }

  TextEditingController emailController =
      TextEditingController(text: "lynard1");
  TextEditingController passwordController =
      TextEditingController(text: "password123!");
  TextEditingController idController = TextEditingController();

  Future<UserId?> login(String email, String password, String data) async {
    try {
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final msg = jsonEncode({
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      });

      print("$email $password ");
      Response response = await post(
        Uri.parse('https://gorder.website/API/login.php'),
        headers: headers,
        body: msg,
      );
      print(response.body);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        UserId userId = UserId.fromJson(responseData);

        var jsonData = int.parse(responseData['data']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('jsonData', jsonData);
        String? storedUnitSt = prefs.getString('unitSt');
        String? storedBarangayId = prefs.getString('barangayId');
        print(storedBarangayId);
        print(storedUnitSt);
        return userId;
      } else {
        print('failed');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  bool _isLoggedInUnsuccessful = false;
  bool test = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        // Remove debug
        child: Container(
          height: 0.8 * MediaQuery.of(context).size.height,
          width: 0.8 * MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Container(
                height: 140,
                width: 140,
                margin: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/goldengate1.png")),
                ),
              ),
              Container(
                height: 30,
              ),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "Username",
                          prefixIcon: const Icon(Icons.email),
                          errorText: _isLoggedInUnsuccessful
                              ? "Email or password is incorrect"
                              : null),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.security),
                      ),
                    ),
                    Container(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 50.0,
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 18, 83, 136),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.white,
                                textStyle: const TextStyle(fontSize: 20)),
                            onPressed: () async {
                              Object? isLoggedIn = await login(
                                  emailController.text.toString(),
                                  passwordController.text.toString(),
                                  idController.text.toString());

                              if (isLoggedIn != null) {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: ((context) => const MyHomePage(
                                              id: "",
                                              data: "",
                                            ))));
                                setState() {}

                                return;
                              }
                              setState(() {
                                _isLoggedInUnsuccessful = true;
                              });
                            },
                            child: const Center(child: Text("Log in"))),
                      ),
                    ),
                    Container(
                      height: 3,
                    ),
                    Center(
                      child: ListTile(
                        title: Center(
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 15)),
                              onPressed: () {
                                _launchURL(
                                    "https://gorder.website/forgot-password.php?fbclid=IwAR3UEODKljh15rusLkXjOZvWHtnqtTRHZxVnwFiwibaSK_-CWdE6ILVebA4");
                              },
                              child: const Text(
                                "forgot password",
                                style: TextStyle(color: Colors.black),
                              )),
                        ),
                        onTap: () {},
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1.0,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 15,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: 200,
                      decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 15)),
                            onPressed: () {
                              _launchURL("https://gorder.website/signup.php");
                            },
                            child: const Text(
                              "Create New Account",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
