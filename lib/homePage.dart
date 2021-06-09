import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/signIn.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String id = "";

  Future getId() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('id');
    print("home : " + id);
  }

  // List<CartView> cars = [
  //   CartView("Assets/bmw-serie3.jpg", "rimeh", "Serie 3", "", 8),
  //   //2
  //   CartView("Assets/chery-tiggo7.jpg", "Cherry", "Tiggo 7", "", 5),
  //   //3
  //   CartView("Assets/kia-sportage.jpg", "KIA", "Sportage", "", 5),
  //   //4
  //   CartView("Assets/bmw-serie3.jpg", "BMW", "Serie 3", "", 5),
  //   //2
  //   CartView("Assets/chery-tiggo7.jpg", "Cherry", "Tiggo 7", "", 5),
  //   //3
  //   CartView("Assets/kia-sportage.jpg", "KIA", "Sportage", "", 5),
  //   //4
  //   CartView("Assets/chery-tiggo7.jpg", "Cherry", "Tiggo 7", "", 5),
  //   //3
  //   CartView("Assets/kia-sportage.jpg", "KIA", "Sportage", "", 5),
  //   //4
  //   CartView("Assets/chery-tiggo7.jpg", "Cherry", "Tiggo 7", "", 5),
  //   //3
  //   CartView("Assets/kia-sportage.jpg", "KIA", "Sportage", "", 5),
  //   //4
  //   CartView("Assets/peugeot-208.jpg", "Peugeot", "208", "", 5)
  //   //1
  // ];

  List<prod> products = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    http
        .get(Uri.parse("http://192.168.0.4:9090/product"))
        .then((http.Response response) {
      List<dynamic> listofProds = json.decode(response.body);
      for (int i = 0; i < listofProds.length; i++) {
        Map<String, dynamic> prodlist = listofProds[i];
        products.add(prod(
            prodlist["label"],
            prodlist["description"],
            prodlist["price"],
            "http://192.168.0.4:9090/img/" + prodlist["image"]));
      }
      setState(() {});
    });
    getId();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.add_alert),
                tooltip: 'Show Snackbar',
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('id');
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginDemo()));
                }),
          ],
          title: Text("Home"),
          automaticallyImplyLeading: false,
          bottom: TabBar(
            tabs: [
              Tab(
                text: "List Produit",
                icon: Icon(Icons.list),
              ),
              Tab(
                text: "Favo",
                icon: Icon(Icons.edit),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return CartView(
                    products[index].prodLabel,
                    products[index].prodDescription,
                    products[index].prodPrice,
                    products[index].imageUrl);
              },
              itemCount: products.length,
            ),
            Text("data")
          ],
        ),
      ),
    );
  }
}

class CartView extends StatelessWidget {
  String _prodLabel;
  String _prodDescription;
  String _prodPrice;
  String _imageUrl;

  CartView(
      this._prodLabel, this._prodDescription, this._prodPrice, this._imageUrl);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("object");
      },
      child: Card(
        child: Row(
          children: [
            Image.network(
              _imageUrl,
              height: 100,
              width: 100,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(_prodLabel), Text(_prodDescription)],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class prod {
  String prodLabel;
  String prodDescription;
  String prodPrice;
  String imageUrl;

  prod(this.prodLabel, this.prodDescription, this.prodPrice, this.imageUrl);
}
