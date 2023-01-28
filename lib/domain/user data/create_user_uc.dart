import 'package:flutter_messenger_app/data/repository/user_data_repository.dart';

class CreateUserUC {
  final UserDataRepository _userDataRepository;

  CreateUserUC(this._userDataRepository);

  Future<void> call(String name, String surname, String phoneNumber,
      String profileImage) async {
    await _userDataRepository.createUser(
        name, surname, phoneNumber, profileImage);
  }
}
