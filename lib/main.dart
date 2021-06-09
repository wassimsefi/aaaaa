import 'package:flutter/material.dart';
import 'package:flutterapp/acceuil.dart';
import 'package:flutterapp/homePage.dart';
import 'package:flutterapp/signIn.dart';
import 'package:flutterapp/signUpPage.dart';
import 'package:flutterapp/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AcceuilPage(),
    );
  }
}
