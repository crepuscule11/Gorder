import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ggmobile/screens/login_screen.dart';

import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'data/CartItem.dart';
import 'expirement/Categories_home.dart';

// @dart=2.9
void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to GoldenGate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.blueGrey[100],
        primaryColor: Colors.blue[200],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(
        id: '',
      ),
    );
  }
}
