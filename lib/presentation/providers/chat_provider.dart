import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger_app/data/models/chat_info_entity.dart';
import 'package:flutter_messenger_app/data/models/chat_list_item_entity.dart';
import 'package:flutter_messenger_app/domain/chat/get_all_chats_uc.dart';
import 'package:flutter_messenger_app/domain/chat/get_conversation_stream_uc.dart';
import 'package:flutter_messenger_app/domain/chat/get_conversation_uc.dart';
import 'package:flutter_messenger_app/domain/chat/send_message_uc.dart';

class ChatProvider with ChangeNotifier {
  final GetConversationUC _getConversationUC;
  final SendMessageUC _sendMessageUC;
  final GetConversationStreamUC _getConversationStreamUC;
  final GetAllChatsUC _getAllChatsUC;

  ChatProvider(this._getConversationUC, this._sendMessageUC,
      this._getConversationStreamUC, this._getAllChatsUC);

  List<ChatInfo> _conversation = List.empty();
  Stream<DatabaseEvent> _conversationStream = const Stream.empty();
  List<ChatListItem> _allChats = List.empty();
  String _errorMessage = "";

  List<ChatInfo> get conversation => _conversation;
  Stream<DatabaseEvent> get conversationStream => _conversationStream;
  List<ChatListItem> get allChats => _allChats;

  String get errorMessage => _errorMessage;

  Future getConversation(String interlocutorId) async {
    try {
      _conversation = await _getConversationUC(interlocutorId);
      _resetErrorMessage();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future sendMessage(String message, String interlocutorId) async {
    try {
      ChatInfo sendedMessage = ChatInfo(
          isUser: true,
          message: message,
          time: DateTime.now().millisecondsSinceEpoch);
      await _sendMessageUC(sendedMessage, interlocutorId);
      _resetErrorMessage();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future getConversationStream(String interlocutorId) async {
    try {
      _conversationStream = await _getConversationStreamUC(interlocutorId);
      _resetErrorMessage();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future getAllChats() async {
    try {
      _allChats = await _getAllChatsUC();
      _resetErrorMessage();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void _resetErrorMessage() {
    _errorMessage = "";
  }
}
