import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_messenger_app/data/models/chat_info_entity.dart';
import 'package:flutter_messenger_app/data/services/shared_preferences_service.dart';

class RealtimeDatabaseService {
  final _realtimeDatabase = FirebaseDatabase.instance;
  final _sharedPreferencesService = SharedPreferencesService();

  Future<Stream<DatabaseEvent>> getConversationStream(
      String interlocutorId) async {
    String uid = await _sharedPreferencesService.getUid();
    final databaseRef =
        _realtimeDatabase.ref('$uid/$interlocutorId/last item/');
    return databaseRef.onChildChanged;
  }

  Future<List<ChatInfo>> getConversation(String interlocutorId) async {
    String uid = await _sharedPreferencesService.getUid();
    final databaseRef =
        _realtimeDatabase.ref('$uid/$interlocutorId/user chat/');
    List<ChatInfo> chatsInfo = List.empty(growable: true);
    try {
      final snapshot = await databaseRef.get();
      final children = snapshot.children.toList();

      for (var item in children) {
        ChatInfo chatInfo = ChatInfo.fromJson(
            Map<String, dynamic>.from(item.value as Map<dynamic, dynamic>));
        chatsInfo.add(chatInfo);
      }
      chatsInfo.sort((a, b) => b.time.compareTo(a.time));
    } catch (e) {
      print('Error:$e');
    }
    return chatsInfo;
  }

  Future sendMessage(ChatInfo message, String interlocutorId) async {
    String uid = await _sharedPreferencesService.getUid();
    final DatabaseReference databaseRef =
        _realtimeDatabase.ref('$uid/$interlocutorId/user chat/');
    String? newKey = databaseRef.push().key;
    final DatabaseReference databaseInterlocutorRef =
        _realtimeDatabase.ref('$interlocutorId/$uid/user chat/');
    String? newInterlocutorKey = databaseRef.push().key;

    if (newKey != null && newInterlocutorKey != null) {
      await databaseRef.child(newKey).set(message.toJson());
      ChatInfo interlocutorMessage =
          ChatInfo(isUser: false, message: message.message, time: message.time);
      await databaseInterlocutorRef
          .child(newInterlocutorKey)
          .set(interlocutorMessage.toJson());
      final DatabaseReference databaseLastItemRef =
          _realtimeDatabase.ref('$uid/$interlocutorId/last item/');
      final DatabaseReference databaseInterlocutorLastItemRef =
          _realtimeDatabase.ref('$interlocutorId/$uid/last item/');
      await databaseLastItemRef.set(message.toJson());
      await databaseInterlocutorLastItemRef.set(interlocutorMessage.toJson());
    }
  }

  Future<List<String>> getAllInterlocutorId() async {
    String uid = await _sharedPreferencesService.getUid();
    final DatabaseReference databaseRef = _realtimeDatabase.ref('$uid/');
    List<String> interlocutorIds = List.empty(growable: true);
    try {
      final DataSnapshot snapshot = await databaseRef.get();
      final List<DataSnapshot> children = snapshot.children.toList();
      for (DataSnapshot item in children) {
        interlocutorIds.add(item.key ?? '');
      }
    } catch (e) {
      print('Error:$e');
    }
    return interlocutorIds;
  }

  Future<ChatInfo> getLastItem(String interlocutorId) async {
    String uid = await _sharedPreferencesService.getUid();

    final DatabaseReference databaseRef =
        _realtimeDatabase.ref('$uid/$interlocutorId/last item/');
    final DataSnapshot snapshot = await databaseRef.get();

    ChatInfo chatInfo = ChatInfo.fromJson(
        Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>));

    return chatInfo;
  }
}
