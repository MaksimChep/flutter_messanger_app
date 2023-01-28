import 'package:flutter/widgets.dart';
import 'package:flutter_messenger_app/data/models/country_code_entity.dart';
import 'package:flutter_messenger_app/domain/country%20code/get_country_codes_uc.dart';

class CountryCodeProvider with ChangeNotifier {
  final GetCountryCodesUC _getCountryCodes;

  CountryCodeProvider(this._getCountryCodes);

  late List<CountryCode> _countryCodes = List.empty();
  late String _errorMessage;

  List<CountryCode> get countryCodes => _countryCodes;
  String get errorMessage => _errorMessage;

  void getCountryCodes() async {
    try {
      _countryCodes = await _getCountryCodes();
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
