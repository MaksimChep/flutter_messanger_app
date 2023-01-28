abstract class PhoneValidatorRepository {
  Future<bool> validatePhoneNumber(String phoneNumber, String countryCode);
}
