import 'package:flutter_messenger_app/data/repository/auth_repository.dart';

class VerifyOTPUC {
  final AuthRepository _authRepository;

  VerifyOTPUC(this._authRepository);

  Future<void> call(String otp) async {
    await _authRepository.verifyOTP(otp);
  }
}
