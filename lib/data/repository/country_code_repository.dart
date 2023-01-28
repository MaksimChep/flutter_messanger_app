import 'package:flutter_messenger_app/data/models/country_code_entity.dart';

abstract class CountryCodeRepository {
  Future<List<CountryCode>> getCountryCodes();
}
