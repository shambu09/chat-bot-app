import 'package:flutter/material.dart';
import 'package:myapp/models/chatMessageModel.dart';

class ChatQAPair extends StatelessWidget {
  List<ChatMessage> messages = [];
  final myController = TextEditingController();
  String modelip = "";

  Function handleResponse = () {};
  Function handleClick = () {};
  int flag = 0;

  ChatQAPair(
    List<ChatMessage> messages,
    String modelip,
    Function handleResponse,
    Function handleClick,
    int flag,
  ) {
    this.modelip = modelip;
    this.messages = messages;
    this.handleClick = handleClick;
    this.handleResponse = handleResponse;
    this.flag = flag;
  }

  @override
  void dispose() {
    myController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(mainAxisSize: MainAxisSize.max, children: [
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
                      alignment: (messages[index].messageType == "status"
                          ? Alignment.topCenter
                          : messages[index].messageType == "receiver"
                              ? Alignment.topLeft
                              : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messages[index].messageType == "status"
                              ? Colors.transparent
                              : messages[index].messageType == "receiver"
                                  ? Colors.pink[50]
                                  : Colors.blue[200]),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          messages[index].messageContent,
                          style: TextStyle(
                              fontSize: (messages[index].messageType == "status"
                                  ? 13
                                  : 15),
                              color: (messages[index].messageType == "status"
                                  ? Colors.black54
                                  : Colors.black)),
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
                        flag += 1;
                        handleClick(myController.text, flag);
                        myController.clear();
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
