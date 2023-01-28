abstract class AuthRepository {
  Future<void> createUserWithPhoneNumber(String phoneNumber);
  Future<void> verifyOTP(String otp);
}
