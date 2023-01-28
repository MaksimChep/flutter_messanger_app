import 'package:flutter_messenger_app/data/models/user_data_entity.dart';
import 'package:flutter_messenger_app/data/repository/user_data_repository.dart';

class GetUserInformationUC {
  final UserDataRepository _userDataRepository;

  GetUserInformationUC(this._userDataRepository);

  Future<UserData> call() async {
    UserData user = await _userDataRepository.getUserInformation();
    return user;
  }
}
