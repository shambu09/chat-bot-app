import 'homePageStyle.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/chatMessageModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/models/trainingPostModel.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<ChatMessage> messages = [];
  List<ChatMessage> messages_t = [];

  String tmp = "";
  final myController = TextEditingController();
  String modelip = "https://jsonplaceholder.typicode.com/albums/1";

  QAPair q = QAPair(question: "question", answer: "answer");

  handleAdChange(address) {
    this.setState(() {
      if (address != "") {
        modelip = address;
        messages.insert(
            0,
            ChatMessage(
                messageContent: "Server Changed: '$modelip'",
                messageType: "status"));
        messages_t.insert(
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

  sendReq_t(String query) async {
    try {
      final response = await http.get(Uri.parse(modelip));
      if (response.statusCode == 200) {
        handleResponse_t(jsonDecode(response.body)["title"]);
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      handleResponse_t("Invalid Config");
    }
  }

  handleResponse(String res) {
    setState(() {
      messages.insert(
          0, ChatMessage(messageContent: res, messageType: "receiver"));
    });
  }

  handleResponse_t(String res) {
    setState(() {
      messages_t.insert(
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

  handleClick_t(String tmp) {
    print("----------------------------------------$modelip");
    setState(() {
      if (tmp != "") {
        sendReq_t(tmp);
        messages_t.insert(
            0, ChatMessage(messageContent: tmp, messageType: "sender"));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomePageStyle(handleAdChange, modelip, handleClick, handleResponse,
        messages, messages_t, handleResponse_t, handleClick_t);
  }
}
