import 'package:flutter/widgets.dart';
import 'package:flutter_messenger_app/domain/auth/validate_phone_number_uc.dart';

class PhoneValidatorProvider with ChangeNotifier {
  final ValidatePhoneNumberUC _validatePhoneNumberUC;

  PhoneValidatorProvider(this._validatePhoneNumberUC);

  bool _isValid = false;
  String _errorMessage = "";

  bool get isValid => _isValid;
  String get errorMessage => _errorMessage;

  Future isPhoneValid(String phoneNumber, String countryCode) async {
    try {
      _isValid = await _validatePhoneNumberUC(phoneNumber, countryCode);
      _resetErrorMessage();
    } catch (e) {
      _isValid = false;
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void _resetErrorMessage() {
    _errorMessage = "";
  }
}
