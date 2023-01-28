// To parse this JSON data, do
//
//     final chatInfo = chatInfoFromJson(jsonString);

import 'dart:convert';

ChatInfo chatInfoFromJson(String str) => ChatInfo.fromJson(json.decode(str));

String chatInfoToJson(ChatInfo data) => json.encode(data.toJson());

class ChatInfo {
  ChatInfo({
    required this.isUser,
    required this.message,
    required this.time,
  });

  final bool isUser;
  final String message;
  final int time;

  factory ChatInfo.fromJson(Map<String, dynamic> json) => ChatInfo(
        isUser: json["isUser"],
        message: json["message"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "isUser": isUser,
        "message": message,
        "time": time,
      };

  @override
  String toString() {
    return 'isUser: $isUser\nmessage: $message\ntime:$time';
  }

  bool compare(ChatInfo another) {
    return isUser == another.isUser &&
        message == another.message &&
        time == another.time;
  }
}
