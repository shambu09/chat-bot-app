import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:myapp/screens/chatDetailPage.dart';

Future<dynamic> createDialog(BuildContext context) {
  TextEditingController _controller = TextEditingController();
  String tmp = "";

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Model server address: "),
          content: TextField(
            controller: _controller,
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text("Add"),
              onPressed: () {
                tmp = _controller.text.toString();
                print("-------------------------------homePageStyle: $tmp");
                Navigator.of(context).pop(tmp);
              },
            )
          ],
        );
      });
}

class HomePageStyle extends StatelessWidget {
  final tab = new TabBar(tabs: <Tab>[
    new Tab(icon: new Icon(Icons.arrow_forward)),
    new Tab(icon: new Icon(Icons.arrow_downward)),
    new Tab(icon: new Icon(Icons.arrow_back)),
  ]);

  String address = "";
  Function callback = () {};

  HomePageStyle(Function _callback, String _address) {
    callback = _callback;
    address = _address;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Chat",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 8, right: 8, top: 2, bottom: 2),
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.pink[50],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              print("pressed model");
                              createDialog(context)
                                  .then((value) => callback(value));
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.add,
                                  color: Colors.pink,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Add Model Server",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.blue[200],
            tabs: [
              Tab(icon: Icon(Icons.message)),
              Tab(icon: Icon(Icons.add)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ChatDetailPage(""),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}
