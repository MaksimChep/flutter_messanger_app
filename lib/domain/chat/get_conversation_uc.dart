import 'package:flutter_messenger_app/data/models/chat_info_entity.dart';
import 'package:flutter_messenger_app/data/repository/chat_repository.dart';

class GetConversationUC {
  final ChatRepository _chatRepository;

  GetConversationUC(this._chatRepository);

  Future<List<ChatInfo>> call(String interlocutorId) async {
    final List<ChatInfo> conversation =
        await _chatRepository.getConversation(interlocutorId);
    return conversation;
  }
}
