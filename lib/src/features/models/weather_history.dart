import 'dart:convert';

WeatherHistory weatherHistoryFromJson(String str) => WeatherHistory.fromJson(json.decode(str));

String weatherHistoryToJson(WeatherHistory data) => json.encode(data.toJson());

class WeatherHistory {
  double? lat;
  double? lon;
  String? timezone;
  int? timezoneOffset;
  Current? current;
  List<Current?> hourly;

  WeatherHistory({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.hourly,
  });

  factory WeatherHistory.fromJson(Map<String, dynamic> json) => WeatherHistory(
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        timezone: json["timezone"],
        timezoneOffset: json["timezone_offset"],
        current: Current.fromJson(json["current"]),
        hourly: List<Current>.from(json["hourly"].map((x) => Current.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "timezone": timezone,
        "timezone_offset": timezoneOffset,
      };
}

class Current {
  int? dt;
  int? sunrise;
  int? sunset;
  double? temp;
  double? feelsLike;
  int? pressure;
  int? humidity;
  double? dewPoint;
  double? uvi;
  int? clouds;
  int? visibility;
  double? windSpeed;
  int? windDeg;
  double? windGust;
  // List<Weathers?> weather;

  Current({
    required this.dt,
    this.sunrise,
    this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    // required this.weather,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"]?.toDouble(),
        uvi: json["uvi"]?.toDouble(),
        clouds: json["clouds"],
        visibility: json["visibility"],
        windSpeed: json["wind_speed"]?.toDouble(),
        windDeg: json["wind_deg"],
        windGust: json["wind_gust"]?.toDouble(),
        // weather: List<Weathers>.from(json["weather"].map((x) => Weathers.fromJson(x))),
      );
}

// class Weathers {
// int id;
// Main main;
// Description description;
// Icon icon;

// Weathers({
//   required this.id,
//   required this.main,
//   // required this.description,
//   required this.icon,
// });

// factory Weathers.fromJson(Map<String, dynamic> json) => Weathers(
//       id: json["id"],
//       main: mainValues.map[json["main"]]!,
//       // description: descriptionValues.map[json["description"]]!,
//       icon: iconValues.map[json["icon"]]!,
//     );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "main": mainValues.reverse[main],
//         // "description": descriptionValues.reverse[description],
//         "icon": iconValues.reverse[icon],
//       };
// }

enum Description { LIGHT_RAIN, MODERATE_RAIN, OVERCAST_CLOUDS }

final descriptionValues = EnumValues({
  "light rain": Description.LIGHT_RAIN,
  "moderate rain": Description.MODERATE_RAIN,
  "overcast clouds": Description.OVERCAST_CLOUDS
});

enum Icond { THE_04_D, THE_04_N, THE_10_D, THE_10_N }

final iconValues =
    EnumValues({"04d": Icond.THE_04_D, "04n": Icond.THE_04_N, "10d": Icond.THE_10_D, "10n": Icond.THE_10_N});

enum Main { CLOUDS, RAIN }

final mainValues = EnumValues({"Clouds": Main.CLOUDS, "Rain": Main.RAIN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
