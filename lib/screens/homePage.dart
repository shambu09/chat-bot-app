import 'homePageStyle.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/chatMessageModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<ChatMessage> messages = [];
  String tmp = "";
  final myController = TextEditingController();
  String modelip = "https://jsonplaceholder.typicode.com/albums/1";

  handleAdChange(address) {
    this.setState(() {
      if (address != "") {
        modelip = address;
        messages.insert(
            0,
            ChatMessage(
                messageContent: "Server Changed: '$modelip'",
                messageType: "status"));
      }
    });
    print("-------------------------------homePage: $address");
  }

  sendReq(String query) async {
    try {
      final response = await http.get(Uri.parse(modelip));
      if (response.statusCode == 200) {
        handleResponse(jsonDecode(response.body)["title"]);
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      handleResponse("Invalid Config");
    }
  }

  handleResponse(String res) {
    setState(() {
      messages.insert(
          0, ChatMessage(messageContent: res, messageType: "receiver"));
    });
  }

  handleClick(String tmp) {
    print("----------------------------------------$modelip");
    setState(() {
      if (tmp != "") {
        sendReq(tmp);
        messages.insert(
            0, ChatMessage(messageContent: tmp, messageType: "sender"));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomePageStyle(
        handleAdChange, modelip, handleClick, handleResponse, messages);
  }
}
