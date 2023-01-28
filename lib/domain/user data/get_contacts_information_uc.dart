import 'package:flutter_messenger_app/data/models/user_data_entity.dart';
import 'package:flutter_messenger_app/data/repository/user_data_repository.dart';

class GetContactsInformationUC {
  final UserDataRepository _userDataRepository;

  GetContactsInformationUC(this._userDataRepository);

  Future<List<UserData>> call() async {
    List<UserData> contacts =
        await _userDataRepository.getContactsInformation();
    return contacts;
  }
}
