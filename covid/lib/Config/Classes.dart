import 'package:flutter/material.dart';

class Global {
  int cases, deaths, recovered, timestamp;
  Global(
      {@required this.cases,
      @required this.deaths,
      @required this.recovered,
      @required this.timestamp});
}

class Country {
  String country;
  int cases, todayCases, deaths, todayDeaths, recovered, critical;
  Country(
      {@required this.country,
      @required this.cases,
      @required this.todayCases,
      @required this.deaths,
      @required this.todayDeaths,
      @required this.recovered,
      @required this.critical});
  Map<String, dynamic> getDumpedInfo() => {
        "Cases": cases,
        "Today Cases": todayCases,
        "Deaths": deaths,
        "Today Deaths": todayDeaths,
        "Recovered": recovered,
        "Critical": critical,
      };
}

enum SortType {
  country,
  cases,
  todayCases,
  deaths,
  todayDeaths,
  recovered,
  critical
}
