import 'package:flutter/widgets.dart';
import 'package:flutter_messenger_app/domain/auth/create_user_with_phone_number_uc.dart';
import 'package:flutter_messenger_app/domain/auth/verify_otp_uc.dart';

class AuthProvider with ChangeNotifier {
  final CreateUserWithPhoneNumberUC _createUserWithPhoneNumberUC;
  final VerifyOTPUC _verifyOTPUC;

  AuthProvider(this._createUserWithPhoneNumberUC, this._verifyOTPUC);

  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  void createUserWithPhoneNumber(String phoneNumber) async {
    try {
      await _createUserWithPhoneNumberUC(phoneNumber);
      _resetErrorMessage();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future verifyOTP(String otp) async {
    try {
      await _verifyOTPUC(otp);
      _resetErrorMessage();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void _resetErrorMessage() {
    _errorMessage = "";
  }
}
