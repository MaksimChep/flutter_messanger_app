import 'package:flutter/services.dart';
import 'package:flutter_messenger_app/data/models/country_code_entity.dart';
import 'package:flutter_messenger_app/data/repository/country_code_repository.dart';

class CountryCodeRepositoryImpl extends CountryCodeRepository {
  @override
  Future<List<CountryCode>> getCountryCodes() async {
    String data = await rootBundle.loadString('assets/json/countrycodes.json');
    return countryCodeFromJson(data);
  }
}
