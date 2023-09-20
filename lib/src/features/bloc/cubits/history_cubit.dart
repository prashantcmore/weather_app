import 'package:weather_app/src/features/bloc/states/history_states.dart';
import 'package:weather_app/src/features/repositories/api/weather_api.dart';
import 'package:weather_app/src/features/bloc/states/weather_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/weather.dart';
import '../../models/weather_history.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitialState()) {}

  void getHistoryData() async {
    try {
      emit(HistoryLoadingState());

      List<WeatherHistory> weather = await WeatherApi().getHistory();
      emit(HistoryFetchState(weather));
    } catch (error) {
      emit(HistoryErrorState(error.toString()));
      throw (error);
    }
  }
}
