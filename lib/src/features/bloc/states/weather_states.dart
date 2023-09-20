import '../../models/weather.dart';

abstract class WeatherState {}

class WeatherInitialState extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherFetchState extends WeatherState {
  Weather weather;

  WeatherFetchState(this.weather);
}

class WeatherErrorState extends WeatherState {
  String error;

  WeatherErrorState(this.error);
}
