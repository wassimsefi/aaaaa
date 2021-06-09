import 'package:flutter/material.dart';

import 'package:flutterapp/homePage.dart';
import 'package:flutterapp/signUpPage.dart';
import 'package:flutterapp/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  GlobalKey<FormState> mykey = new GlobalKey();
  String _email;
  String _password;

  User _user;

  Future<User> loginUser(String email, String password) async {
    final String apiUrl = "http://172.21.138.97:9090/user/signin";
    final Response = await http
        .post(apiUrl, body: {"username": email, "password": password});

    if (Response.statusCode == 200) {
      final String responseString = Response.body;
      return userFromJson(responseString);
    } else {
      throw Exception(showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Log In Error'),
          content: Text(
            'Account not found! ',
            style: TextStyle(fontSize: 20.0, color: Colors.red),
          ),
          actions: <Widget>[
            FlatButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: Text('OK'))
          ],
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Form(
              key: mykey,
              child: Column(
                children: <Widget>[
                  Padding(
                    //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                          hintText: 'Enter valid email id as abc@gmail.com'),
                      onSaved: (value) {
                        _email = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "required";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 15, bottom: 0),
                    //padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                          hintText: 'Enter secure password'),
                      onSaved: (value) {
                        _password = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "required";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: FlatButton(
                      onPressed: () async {
                        if (mykey.currentState.validate()) {
                          mykey.currentState.save();

                          final User user = await loginUser(_email, _password);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => HomePage()));
                          setState(() {
                            _user = user;
                          });

                          print("email" + _email);
                          print("id" + _user.id);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('id', _user.id);
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 100,
                    width: 250,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SignUp()));
                      },
                      child: Text(
                        'New User? Create Account',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
