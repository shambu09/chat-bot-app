import 'homePageStyle.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String address = "https://jsonplaceholder.typicode.com/albums/1";

  handleAdChange(_address) {
    print("-------------------------------homePage: $_address");
    setState(() {
      address = _address;
    });
  }

  Widget build(BuildContext context) {
    return HomePageStyle(handleAdChange, address);
  }
}
