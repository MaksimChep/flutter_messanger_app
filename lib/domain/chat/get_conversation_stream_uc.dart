import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_messenger_app/data/repository/chat_repository.dart';

class GetConversationStreamUC {
  final ChatRepository _chatRepository;

  GetConversationStreamUC(this._chatRepository);

  Future<Stream<DatabaseEvent>> call(String interlocutorId) async {
    return await _chatRepository.getConversationStream(interlocutorId);
  }
}
