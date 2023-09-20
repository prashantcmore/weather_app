import 'package:weather_app/src/features/models/weather_history.dart';

import '../../models/weather.dart';

abstract class CurrentHistoryState {}

class CurrentHistoryInitialState extends CurrentHistoryState {}

class CurrentHistoryLoadingState extends CurrentHistoryState {}

class CurrentHistoryFetchState extends CurrentHistoryState {
  List<WeatherHistory> weather;

  CurrentHistoryFetchState(this.weather);
}

class CurrentHistoryErrorState extends CurrentHistoryState {
  String error;
  CurrentHistoryErrorState(this.error);
}
