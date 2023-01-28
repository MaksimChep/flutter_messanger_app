import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/data/models/chat_info_entity.dart';

class ChatListTileWidget extends StatelessWidget {
  final ChatInfo chatItem;
  const ChatListTileWidget({
    Key? key,
    required this.chatItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          chatItem.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16.0),
                  topRight: const Radius.circular(16.0),
                  bottomLeft: chatItem.isUser
                      ? const Radius.circular(16.0)
                      : const Radius.circular(0.0),
                  bottomRight: chatItem.isUser
                      ? const Radius.circular(0.0)
                      : const Radius.circular(16.0)),
              color: chatItem.isUser ? const Color(0xFF002DE3) : Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: chatItem.isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(chatItem.message)),
                Builder(builder: (context) {
                  DateTime time =
                      DateTime.fromMillisecondsSinceEpoch(chatItem.time);
                  return Text('${time.hour}:${time.minute}');
                })
              ],
            ),
          ),
        ),
      ],
    );
  }
}
