import 'package:weather_app/src/features/models/weather_history.dart';

import '../../models/weather.dart';

abstract class HistoryState {}

class HistoryInitialState extends HistoryState {}

class HistoryLoadingState extends HistoryState {}

class HistoryFetchState extends HistoryState {
  List<WeatherHistory> weather;

  HistoryFetchState(this.weather);
}

class HistoryErrorState extends HistoryState {
  String error;
  HistoryErrorState(this.error);
}
