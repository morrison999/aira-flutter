import 'package:accessibility/components/FormInput.dart';

final Map<String, String> supportedCountries = {
  "United States": "+1",
  "Australia": "+43",
  "Canada": "+1",
  "New Zealand": "+64",
  "United Kingdom": "+44"
};

class Country implements SelectableItem<Country> {
  String _code;
  String _key;
  Country(this._key, this._code);

  static List<String> getCountries() {return supportedCountries.keys.toList();}
  static List<String> getCodes() { return supportedCountries.values.toList();}
  String getCode() {
    return _code;
  }
  String getKey() {
    return _key;
  }
  static List<Country> asList() {
    List<Country> list = [];
    supportedCountries.forEach((key, value) { list.add(Country(key,value));});
    return list;
  }

  @override
  Country getValue() {
    return this;
  }
}
