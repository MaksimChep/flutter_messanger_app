import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_messenger_app/data/models/chat_info_entity.dart';
import 'package:flutter_messenger_app/data/models/chat_list_item_entity.dart';

abstract class ChatRepository {
  Future<List<ChatInfo>> getConversation(String interlocutorId);
  Future sendMessage(ChatInfo message, String interlocutorId);
  Future<Stream<DatabaseEvent>> getConversationStream(String interlocutorId);
  Future<List<ChatListItem>> getAllChats();
}
