import 'package:weather_app/src/features/bloc/states/current_history_state.dart';
import 'package:weather_app/src/features/bloc/states/history_states.dart';
import 'package:weather_app/src/features/repositories/api/weather_api.dart';
import 'package:weather_app/src/features/bloc/states/weather_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/weather.dart';
import '../../models/weather_history.dart';

class CurrentHistoryCubit extends Cubit<CurrentHistoryState> {
  CurrentHistoryCubit() : super(CurrentHistoryInitialState()) {}

  void getCurrentHistoryData(BuildContext context) async {
    try {
      emit(CurrentHistoryLoadingState());

      List<WeatherHistory> weather = await WeatherApi().getCurrentHistory(context);
      emit(CurrentHistoryFetchState(weather));
    } catch (error) {
      emit(CurrentHistoryErrorState(error.toString()));

      throw (error);
    }
  }
}
