import 'package:flutter_messenger_app/data/models/chat_list_item_entity.dart';
import 'package:flutter_messenger_app/data/repository/chat_repository.dart';

class GetAllChatsUC {
  final ChatRepository _chatRepository;

  GetAllChatsUC(this._chatRepository);

  Future<List<ChatListItem>> call() async {
    final List<ChatListItem> allChats = await _chatRepository.getAllChats();
    return allChats;
  }
}
