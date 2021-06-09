import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/signIn.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String username;
  String email;
  String password;
  String avatar;
  GlobalKey<FormState> myKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign UP"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: myKey,
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Image.asset("assets/crist.png")),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "avatar"),
                onSaved: (value) {
                  avatar = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: "username"),
                onSaved: (value) {
                  username = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "email", border: OutlineInputBorder()),
                onSaved: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "password", border: OutlineInputBorder()),
                obscureText: true,
                onSaved: (value) {
                  password = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text("Signup"),
                    onPressed: () {
                      if (myKey.currentState.validate()) {
                        myKey.currentState.save();
                        Map<String, dynamic> cardata = {
                          "username": username,
                          "email": email,
                          "password": password,
                          "avatar": avatar,
                        };
                        Map<String, String> headers = {
                          "Content-Type": "application/json; charset=UTF-8"
                        };
                        http
                            .post(
                                Uri.parse(
                                    "http://172.21.138.97:9090/user/signup"),
                                headers: headers,
                                body: json.encode(cardata))
                            .then((http.Response reponse) {
                          String message = reponse.statusCode == 201
                              ? "user added successfuly"
                              : "error";
                          print("username " +
                              username +
                              " email " +
                              email +
                              " password " +
                              password +
                              " avatar " +
                              avatar);
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("info"),
                                content: Text(message),
                              );
                            },
                          );
                        });
                      }
                    },
                  ),
                  RaisedButton(
                    child: Text("Sign in"),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginDemo()));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
