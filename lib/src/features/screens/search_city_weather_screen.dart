import 'dart:convert';

import 'package:weather_app/src/features/bloc/cubits/weather_cubits.dart';
import 'package:weather_app/src/features/bloc/states/weather_states.dart';
import 'package:weather_app/src/features/repositories/api/weather_api.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cubits/history_cubit.dart';
import '../bloc/states/history_states.dart';
import '../repositories/helper.dart';

import 'package:http/http.dart' as http;

import '../models/weather.dart';

class SearchCityWeather extends StatelessWidget {
  @override
  TextEditingController _cityName = TextEditingController();

  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    bool isloading = false;

    Weather? weather;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.orange,
          centerTitle: true,
          title: const Text('Search Weather by city'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Container(
                  color: Colors.orange,
                  child: TextField(
                    controller: _cityName,
                    onChanged: ((value) {}),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.location_city),
                      hintText: 'Enter the name of City',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0, top: 20),
                child: Container(
                  color: Colors.amber,
                  child: TextButton(
                    onPressed: () async {
                      BlocProvider.of<WeatherCubit>(context).getWeather(_cityName.text).then((x) {
                        if (helper.lattitude != null && helper.longitude != null) {
                          BlocProvider.of<HistoryCubit>(context).getHistoryData();
                        }
                      });
                    },
                    child: const Text(
                      'Get weather Details',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              BlocConsumer<WeatherCubit, WeatherState>(
                listener: (context, state) {
                  if (state is WeatherErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Something went wrong'),
                      backgroundColor: Colors.red,
                    ));
                  } else if (state is WeatherFetchState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Weather is fethced successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is WeatherLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is WeatherFetchState) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: deviceSize.height * 0.08,
                            width: deviceSize.width,
                            color: Colors.orange,
                            child: ListTile(
                              focusColor: Colors.amber,
                              leading: state.weather.temp! > 30
                                  ? const Icon(
                                      Icons.sunny,
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.cloudy_snowing,
                                      color: Colors.white,
                                    ),
                              title: Text(
                                _cityName.text.toUpperCase().toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: Text(
                                '${state.weather.temp.toString()}°C',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state is WeatherInitialState) {
                    return Icon(
                      Icons.sunny,
                      color: Colors.amber,
                      size: deviceSize.height * 0.1,
                    );
                  } else {
                    return const Center(child: Text('An Error has Occures'));
                  }
                },
              ),
              helper.lattitude != null && helper.longitude != null
                  ? Container(
                      height: deviceSize.height * 0.6,
                      width: deviceSize.width,
                      child: BlocConsumer<HistoryCubit, HistoryState>(
                        listener: (context, state) {
                          if (state is HistoryErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text('Something went wrong'),
                              backgroundColor: Colors.red,
                            ));
                          } else if (state is HistoryFetchState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Weather is fethced successfully'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is HistoryLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is HistoryFetchState) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Colors.black,
                                  height: deviceSize.height * 0.6,
                                  width: deviceSize.width,
                                  child: ListView.builder(
                                      itemCount: state.weather.length,
                                      itemBuilder: ((context, i) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Card(
                                              // height: deviceSize.height * 0.08,
                                              // width: deviceSize.width,
                                              elevation: 8,
                                              color: Colors.orange,
                                              child: ListTile(
                                                leading: Icon(
                                                  Icons.cloud,
                                                  color: Colors.white,
                                                ),
                                                focusColor: Colors.amber,
                                                title: Text(state.weather[i].timezone.toString()),
                                                trailing: Text(state.weather[i].current!.temp.toString()),
                                              ),
                                            ),
                                          ))),
                                ));
                          } else {
                            return const Center(
                                child: Text(
                              'An Error has Occures',
                              style: TextStyle(color: Colors.white),
                            ));
                          }
                        },
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
