import 'package:weather_app/src/features/repositories/api/weather_api.dart';
import 'package:weather_app/src/features/bloc/states/weather_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/weather.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitialState()) {}

  getWeather(String cityName) async {
    try {
      print(state);
      Weather weather = await WeatherApi().getData(cityName);

      emit(WeatherFetchState(weather));
    } catch (error) {
      emit(WeatherErrorState(error.toString()));
      throw (error);
    }
  }
}
