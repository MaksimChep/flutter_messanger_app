import 'package:flutter_messenger_app/data/repository/auth_repository.dart';
import 'package:flutter_messenger_app/data/services/auth_service.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<void> createUserWithPhoneNumber(String phoneNumber) async {
    await _authService.createUserWithPhoneNumber(phoneNumber);
  }

  @override
  Future<void> verifyOTP(String otp) async {
    await _authService.verifyOTP(otp);
  }
}
