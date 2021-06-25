import 'package:myapp/models/chatMessageModel.dart';

class QAPair {
  String question;
  String answer;

  QAPair({
    required this.question,
    required this.answer,
  });

  Map toJson() {
    return {
      "qs": this.question,
      "ans": this.answer,
    };
  }

  ChatMessage toChatMessage() {
    return ChatMessage(
        messageContent: "Question : $question\nAnswer : $answer",
        messageType: "sender");
  }
}
