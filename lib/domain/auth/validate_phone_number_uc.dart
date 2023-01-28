import 'package:flutter_messenger_app/data/repository/phone_validator_repository.dart';

class ValidatePhoneNumberUC {
  final PhoneValidatorRepository _phoneValidatorRepository;

  ValidatePhoneNumberUC(this._phoneValidatorRepository);

  Future<bool> call(String phoneNumber, String countryCode) async {
    return await _phoneValidatorRepository.validatePhoneNumber(
        phoneNumber, countryCode);
  }
}
