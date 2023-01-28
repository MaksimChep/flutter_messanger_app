import 'package:flutter_messenger_app/data/models/chat_info_entity.dart';
import 'package:flutter_messenger_app/data/models/user_data_entity.dart';

class ChatListItem {
  final ChatInfo lastChatItem;
  final UserData interlocutorData;

  ChatListItem({required this.lastChatItem, required this.interlocutorData});
}
