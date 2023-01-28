import 'package:flutter_messenger_app/data/models/chat_info_entity.dart';
import 'package:flutter_messenger_app/data/repository/chat_repository.dart';

class SendMessageUC {
  final ChatRepository _chatRepository;

  SendMessageUC(this._chatRepository);

  Future call(ChatInfo message, String interlocutorId) async {
    await _chatRepository.sendMessage(message, interlocutorId);
  }
}
