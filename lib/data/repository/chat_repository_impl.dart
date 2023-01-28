import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_messenger_app/data/models/chat_info_entity.dart';
import 'package:flutter_messenger_app/data/models/chat_list_item_entity.dart';
import 'package:flutter_messenger_app/data/models/user_data_entity.dart';
import 'package:flutter_messenger_app/data/repository/chat_repository.dart';
import 'package:flutter_messenger_app/data/services/firestore_service.dart';
import 'package:flutter_messenger_app/data/services/realtime_database_service.dart';

class ChatRepositoryImpl extends ChatRepository {
  final RealtimeDatabaseService _realtimeDatabaseService;
  final FirestoreService _firestoreService;

  ChatRepositoryImpl(this._realtimeDatabaseService, this._firestoreService);

  @override
  Future<List<ChatInfo>> getConversation(String interlocutorId) async {
    List<ChatInfo> conversation =
        await _realtimeDatabaseService.getConversation(interlocutorId);
    return conversation;
  }

  @override
  Future sendMessage(ChatInfo message, String interlocutorId) async {
    await _realtimeDatabaseService.sendMessage(message, interlocutorId);
  }

  @override
  Future<Stream<DatabaseEvent>> getConversationStream(
      String interlocutorId) async {
    return await _realtimeDatabaseService.getConversationStream(interlocutorId);
  }

  @override
  Future<List<ChatListItem>> getAllChats() async {
    List<ChatListItem> chatListItems = List.empty(growable: true);

    List<String> interlocutorIds =
        await _realtimeDatabaseService.getAllInterlocutorId();

    List<ChatInfo> lastItems = List.empty(growable: true);
    List<UserData> interlocutorsData = List.empty(growable: true);

    for (String interlocutorId in interlocutorIds) {
      ChatInfo lastItem =
          await _realtimeDatabaseService.getLastItem(interlocutorId);
      lastItems.add(lastItem);
    }

    for (String interlocutorId in interlocutorIds) {
      UserData interlocutorData =
          await _firestoreService.getInterlocutorData(interlocutorId);
      interlocutorsData.add(interlocutorData);
    }

    for (int i = 0; i < interlocutorIds.length; i++) {
      ChatListItem chatListItem = ChatListItem(
          lastChatItem: lastItems[i], interlocutorData: interlocutorsData[i]);
      chatListItems.add(chatListItem);
    }
    return chatListItems;
  }
}
