import 'package:dio/dio.dart';
import 'Classes.dart';

const String _GLOBAL_ENDPOINT = "https://corona.lmao.ninja/all";
const String _COUNTRIES_ENDPOINT = "https://corona.lmao.ninja/countries";

class Manager {
  static Future<Global> getGlobal() async {
    try {
      var response = await Dio().get(_GLOBAL_ENDPOINT);
      return Global(
          cases: response.data['cases'],
          deaths: response.data['deaths'],
          recovered: response.data['recovered'],
          timestamp: response.data['timestamp']);
    } catch (e) {
      return Future.error("");
    }
  }

  static Future<List<Country>> getCountries(SortType type) async {
    try {
      var response = await Dio()
          .get('$_COUNTRIES_ENDPOINT?sort=${type.toString().split('.')[1]}');
      print(response.statusCode);
      List<Country> countries = [];
      (response.data as List<dynamic>).forEach((country) => countries.add(
          Country(
              country: country['country'],
              cases: country['cases'],
              todayCases: country['todayCases'],
              deaths: country['deaths'],
              todayDeaths: country['todayDeaths'],
              recovered: country['recovered'],
              critical: country['critical'])));
      return type == SortType.country ? countries : countries.reversed.toList();
    } catch (e) {
      return Future.error("");
    }
  }
}
