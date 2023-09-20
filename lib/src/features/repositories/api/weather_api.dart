import 'dart:convert';

import 'package:weather_app/src/features/bloc/states/history_states.dart';
import 'package:weather_app/src/features/models/weather_history.dart';
import 'package:weather_app/src/features/models/weather.dart';

import 'package:weather_app/src/features/repositories/helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/weather.dart';

class WeatherApi {
  Future<dynamic> getData(String city) async {
    try {
      final url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=709e924c4f4339b0236a946826faa97e&units=metric');

      var res = await http.get(url);
      print(res.statusCode);

      if (res.statusCode == 200) {
        print(res.statusCode);
        var payload = json.decode(res.body);
        print(payload);
        var cord = payload['coord'];

        var lat = cord['lat'];
        var long = cord['lon'];

        helper.lattitude = lat;
        helper.longitude = long;
        var weatherData = payload['main'];
        final weather = Weather.fromJson(weatherData);
        return weather;
      }
    } catch (e) {
      throw e;
    }
  }

  List<WeatherHistory> currenthistory = [];
  dynamic getCurrentHistory(BuildContext context) async {
    var d = DateTime.now();
    var weather = {
      'lat': helper.lat,
      'lon': helper.long,
    };

    for (int i = 1; i < 8; i++) {
      DateTime nowUtc = DateTime.utc(d.year, d.month, d.day - i);
      int unixtimestamp = nowUtc.toUtc().millisecondsSinceEpoch ~/ 1000;

      String apiUrl = 'https://api.openweathermap.org/data/2.5/onecall/timemachine?'
          'lat=${weather['lat']}&lon=${weather['lon']}&dt=$unixtimestamp&'
          'units=metric&appid=abe1eb51289c21c167c66ce790c2fac3';

      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);
        var history = WeatherHistory.fromJson(payload);
        currenthistory.add(history);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    return currenthistory;
  }

  List<WeatherHistory> histories = [];
  dynamic getHistory() async {
    var d = DateTime.now();
    var weather = {
      'lat': helper.lattitude,
      'lon': helper.longitude,
    };

    for (int i = 1; i < 8; i++) {
      DateTime nowUtc = DateTime.utc(d.year, d.month, d.day - i);
      int unixtimestamp = nowUtc.toUtc().millisecondsSinceEpoch ~/ 1000;

      String apiUrl = 'https://api.openweathermap.org/data/2.5/onecall/timemachine?'
          'lat=${weather['lat']}&lon=${weather['lon']}&dt=$unixtimestamp&'
          'units=metric&appid=abe1eb51289c21c167c66ce790c2fac3';

      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);
        var history = WeatherHistory.fromJson(payload);
        histories.add(history);
      } else {
        SnackBar(
          content: Text('Please give valid data'),
        );
      }
    }
    return histories;
  }
}
