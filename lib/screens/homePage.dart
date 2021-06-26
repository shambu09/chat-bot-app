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

  List<ChatMessage> messages_t = [
    ChatMessage(messageContent: "Enter Question: ", messageType: "receiver")
  ];
  int flag = 0;
  QAPair qa = QAPair(question: "", answer: "");

  String tmp = "";
  final myController = TextEditingController();
  String modelip = "https://d1d0aa2a32bd.ngrok.io";

  QAPair q = QAPair(question: "question", answer: "answer");

  handleTabChange(int index) {
    setState(() {
      if (index == 0) {
        if (modelip.substring(modelip.length - 4) == "/add") {
          modelip = modelip.substring(0, modelip.length - 4);
        }
      } else {
        if (modelip.substring(modelip.length - 4) != "/add") {
          if (modelip[modelip.length - 1] == '/') {
            modelip += "add";
          } else
            modelip += "/add";
        }
      }
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
    });
  }

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
  }

  sendReq(String query) async {
    var url = "$modelip?qs=$query";
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      handleResponse(response.body);
    } catch (e) {
      print(url.toString());
      handleResponse("Invalid Config");
    }
  }

  sendReq_t() async {
    var url = "$modelip?${qa.toQuery()}";

    try {
      var k = await http.get(
        Uri.parse(url),
      );
      handleGetResponse(k.body);
    } catch (e) {
      handleGetResponse("Invalid Config");
    }
  }

  handleResponse(String res) {
    setState(() {
      messages.insert(
          0, ChatMessage(messageContent: res, messageType: "receiver"));
    });
  }

  handleGetResponse(String res) {
    setState(() {
      messages_t.insert(0,
          ChatMessage(messageContent: "\u2713 ${res}", messageType: "status"));
      flag = 0;
      messages_t.insert(
        0,
        ChatMessage(
            messageContent: "Enter Question: ", messageType: "receiver"),
      );
    });
  }

  handleResponse_t(String res) {
    setState(() {
      messages_t.insert(
          0, ChatMessage(messageContent: res, messageType: "receiver"));

      flag = 0;
      messages_t.insert(
        0,
        ChatMessage(
            messageContent: "Enter Question: ", messageType: "receiver"),
      );
    });
  }

  handleClick(String tmp) {
    setState(() {
      if (tmp == "/clear") {
        messages.clear();
        return;
      }
      if (tmp != "") {
        sendReq(tmp);
        messages.insert(
            0, ChatMessage(messageContent: tmp, messageType: "sender"));
      }
    });
  }

  handleClick_t(String tmp, int flag_t) {
    setState(() {
      if (tmp == "/clear") {
        messages_t.clear();
        flag = 0;
        messages_t.add(
          ChatMessage(
              messageContent: "Enter Question: ", messageType: "receiver"),
        );
        return;
      }

      if (tmp != "") {
        flag = flag_t;
        if (flag == 1) {
          qa.question = tmp;
          messages_t.insert(
              0, ChatMessage(messageContent: tmp, messageType: "sender"));
          messages_t.insert(
              0,
              ChatMessage(
                  messageContent: "Enter the answer: ",
                  messageType: "receiver"));
        }
      }
      if (flag == 2) {
        qa.answer = tmp;
        messages_t.insert(
          0,
          ChatMessage(messageContent: tmp, messageType: "sender"),
        );

        print("https://d1d0aa2a32bd.ngrok.io/?${qa.toQuery()}");
        sendReq_t();
        messages_t.insert(
          0,
          ChatMessage(
              messageContent: jsonEncode(qa).toString(), messageType: "status"),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomePageStyle(
      handleAdChange,
      modelip,
      handleClick,
      handleResponse,
      messages,
      messages_t,
      handleResponse_t,
      handleClick_t,
      flag,
      handleTabChange,
    );
  }
}
