import 'package:flutter_messenger_app/data/models/country_code_entity.dart';
import 'package:flutter_messenger_app/data/repository/country_code_repository.dart';

class GetCountryCodesUC {
  final CountryCodeRepository _countryCodeRepository;

  GetCountryCodesUC(this._countryCodeRepository);

  Future<List<CountryCode>> call() {
    return _countryCodeRepository.getCountryCodes();
  }
}
