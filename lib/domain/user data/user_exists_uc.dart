import 'package:flutter_messenger_app/data/repository/user_data_repository.dart';

class UserExistsUC {
  final UserDataRepository _userDataRepository;

  UserExistsUC(this._userDataRepository);

  Future<bool> call() async {
    bool exist = await _userDataRepository.userExists();
    return exist;
  }
}
