import 'package:flutter_messenger_app/data/repository/auth_repository.dart';

class CreateUserWithPhoneNumberUC {
  final AuthRepository _authRepository;

  CreateUserWithPhoneNumberUC(this._authRepository);

  Future<void> call(String phoneNumber) async {
    await _authRepository.createUserWithPhoneNumber(phoneNumber);
  }
}
