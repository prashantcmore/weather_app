class Weather {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  Weather({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.seaLevel,
    required this.grndLevel,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        tempMin: json["temp_min"]?.toDouble(),
        tempMax: json["temp_max"]?.toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        seaLevel: json["sea_level"],
        grndLevel: json["grnd_level"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
        "sea_level": seaLevel,
        "grnd_level": grndLevel,
      };
}

// class Sys {
//   String country;
//   int sunrise;
//   int sunset;

//   Sys({
//     required this.country,
//     required this.sunrise,
//     required this.sunset,
//   });

//   factory Sys.fromJson(Map<String, dynamic> json) => Sys(
//         country: json["country"],
//         sunrise: json["sunrise"],
//         sunset: json["sunset"],
//       );

//   Map<String, dynamic> toJson() => {
//         "country": country,
//         "sunrise": sunrise,
//         "sunset": sunset,
//       };
// }

// class WeatherElement {
//   int id;
//   String main;
//   String description;
//   String icon;

//   WeatherElement({
//     required this.id,
//     required this.main,
//     required this.description,
//     required this.icon,
//   });

//   factory WeatherElement.fromJson(Map<String, dynamic> json) => WeatherElement(
//         id: json["id"],
//         main: json["main"],
//         description: json["description"],
//         icon: json["icon"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "main": main,
//         "description": description,
//         "icon": icon,
//       };
// }

// class Wind {
//   double speed;
//   int deg;
//   double gust;

//   Wind({
//     required this.speed,
//     required this.deg,
//     required this.gust,
//   });

//   factory Wind.fromJson(Map<String, dynamic> json) => Wind(
//         speed: json["speed"]?.toDouble(),
//         deg: json["deg"],
//         gust: json["gust"]?.toDouble(),
//       );

//   Map<String, dynamic> toJson() => {
//         "speed": speed,
//         "deg": deg,
//         "gust": gust,
//       };
// }
