import 'dart:ui';
import 'dart:math';

import 'package:myapp/models/chatMessageModel.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/chatDetailPage.dart';
import 'package:myapp/screens/chatQAPair.dart';

Future<dynamic> createDialog(BuildContext context) {
  TextEditingController _controller = TextEditingController();
  String tmp = "";

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Model Server Address: "),
          content: TextField(
            controller: _controller,
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text("Add"),
              onPressed: () {
                tmp = _controller.text.toString();
                Navigator.of(context).pop(tmp);
              },
            )
          ],
        );
      });
}

class HomePageStyle extends StatelessWidget {
  List<ChatMessage> messages = [];
  List<ChatMessage> messages_t = [];
  String modelip = "";
  Function handleResponse = () {};
  Function handleResponse_t = () {};
  Function handleClick = () {};
  Function handleClick_t = () {};
  Function callback = () {};

  HomePageStyle(
    Function callback,
    String modelip,
    Function handleClick,
    Function handleResponse,
    List<ChatMessage> messages,
    List<ChatMessage> messages_t,
    Function handleResponse_t,
    Function handleClick_t,
  ) {
    print("-------------------------------changing: $modelip");
    this.callback = callback;
    this.modelip = modelip;
    this.handleClick = handleClick;
    this.handleResponse = handleResponse;
    this.messages = messages;
    this.messages_t = messages_t;
    this.handleResponse_t = handleResponse_t;
    this.handleClick_t = handleClick_t;
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
                                  this.modelip == ""
                                      ? "Add a model server"
                                      : this.modelip.substring(
                                          0, min(this.modelip.length, 30)),
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
            ChatDetailPage(messages, modelip, handleResponse, handleClick),
            ChatQAPair(messages_t, modelip, handleResponse_t, handleClick_t),
          ],
        ),
      ),
    );
  }
}
