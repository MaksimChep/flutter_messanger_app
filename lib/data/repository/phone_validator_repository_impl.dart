import 'package:flutter_messenger_app/data/repository/phone_validator_repository.dart';
import 'package:phone_number/phone_number.dart';

class PhoneValidatorRepositoryImpl extends PhoneValidatorRepository {
  PhoneNumberUtil plugin = PhoneNumberUtil();
  @override
  Future<bool> validatePhoneNumber(
      String phoneNumber, String countryCode) async {
    return await plugin.validate(phoneNumber, countryCode);
  }
}
