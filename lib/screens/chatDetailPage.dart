import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:myapp/models/chatMessageModel.dart';

class ChatDetailPage extends StatefulWidget {
  String address = "";
  ChatDetailPage(String _address) {
    address = _address;
  }

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState(address);
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<ChatMessage> messages = [];
  String tmp = "";
  final myController = TextEditingController();
  String modelip = "";

  _ChatDetailPageState(String address) {
    modelip = address;
  }

  sendReq(String query) async {
    final response = await http.get(Uri.parse(modelip));

    if (response.statusCode == 200) {
      handleResponse(jsonDecode(response.body)["title"]);
    } else {
      throw Exception('Failed to load album');
    }
  }

  handleResponse(String res) {
    setState(() {
      messages.insert(
          0, ChatMessage(messageContent: res, messageType: "receiver"));
    });
  }

  handleCLick() {
    setState(() {
      tmp = myController.text;
      if (tmp != "") {
        sendReq(tmp);
        messages.insert(
            0, ChatMessage(messageContent: tmp, messageType: "sender"));
        myController.clear();
      }
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("-------------------ChatDetailPage: $modelip");
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(mainAxisSize: MainAxisSize.max, //Add this line onyour column
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    shrinkWrap: true,
                    reverse: true,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: 16, right: 16, top: 10, bottom: 10),
                        child: Align(
                          alignment: (messages[index].messageType == "receiver"
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (messages[index].messageType == "receiver"
                                  ? Colors.grey.shade200
                                  : Colors.blue[200]),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Text(
                              messages[index].messageContent,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Write message...",
                                hintStyle: TextStyle(color: Colors.black54),
                                border: InputBorder.none),
                            controller: myController,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            handleCLick();
                            print("pressed");
                          },
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
                          ),
                          backgroundColor: Colors.blue,
                          elevation: 0,
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ],
      ),
    );
  }
}
