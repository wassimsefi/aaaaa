import 'package:flutter/material.dart';
import 'package:flutterapp/homePage.dart';

class ListData extends StatefulWidget {
  final String prodLabel;
  final String prodDescription;
  final String prodPrice;
  final String imageUrl;

  const ListData(
      {Key key,
      this.prodLabel,
      this.prodDescription,
      this.prodPrice,
      this.imageUrl})
      : super(key: key);
  @override
  _ListDataState createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  @override
  Widget build(BuildContext context) {
    return CartView(widget.prodLabel, widget.prodDescription, widget.prodPrice,
        widget.imageUrl);
  }
}
