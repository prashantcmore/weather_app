import 'package:weather_app/src/features/bloc/cubits/history_cubit.dart';
import 'package:weather_app/src/features/bloc/states/history_states.dart';
import 'package:weather_app/src/features/models/weather_history.dart';
import 'package:weather_app/src/features/repositories/api/weather_api.dart';
import 'package:weather_app/src/features/screens/search_city_weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../bloc/blocs/signIn_bloc.dart';
import '../bloc/cubits/current_history.dart';
import '../bloc/cubits/weather_cubits.dart';
import '../bloc/states/current_history_state.dart';
import '../bloc/states/weather_states.dart';
import '../repositories/helper.dart';

import '../repositories/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Location().getCurrentLocation(context).then((x) {
      BlocProvider.of<CurrentHistoryCubit>(context).getCurrentHistoryData(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    List<WeatherHistory> history = WeatherApi().histories;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Weather',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => BlocProvider.of<SignInBloc>(context).logout(),
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<CurrentHistoryCubit, CurrentHistoryState>(
              listener: (context, state) {
                if (state is CurrentHistoryErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Something went wrong'),
                    backgroundColor: Colors.red,
                  ));
                } else if (state is CurrentHistoryFetchState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Weather is fethced successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is CurrentHistoryLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CurrentHistoryFetchState) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // color: Colors.black,
                          height: deviceSize.height * 0.3,
                          width: deviceSize.width,
                          child: ListView.builder(
                            itemCount: 1,
                            itemBuilder: ((context, i) {
                              var weather = state.weather[0];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Card(
                                      elevation: 8,
                                      color: Colors.orange,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Zone :${weather.timezone.toString()}'),
                                          ),
                                          ListTile(
                                            leading: weather.current!.temp! > 30
                                                ? const Icon(Icons.sunny)
                                                : const Icon(
                                                    Icons.sunny_snowing,
                                                    color: Colors.white,
                                                  ),
                                            title: Text("current Temperature :${weather.current!.temp.toString()}"),
                                          ),
                                          ListTile(
                                            leading: const Icon(
                                              Icons.cloud,
                                              color: Colors.white,
                                            ),
                                            title: Text('Humidity :${weather.current!.temp.toString()}'),
                                          ),
                                          ListTile(
                                            leading: const Icon(
                                              Icons.cloud_queue,
                                              color: Colors.white,
                                            ),
                                            title: Text('Clouds :${weather.current!.clouds.toString()}'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: deviceSize.height,
                          width: deviceSize.width,
                          child: ListView.builder(
                            itemCount: state.weather.length,
                            itemBuilder: ((context, i) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: deviceSize.height * 0.09,
                                    width: deviceSize.width,
                                    color: Colors.orange,
                                    child: ListTile(
                                      leading: const Icon(
                                        Icons.cloud,
                                        color: Colors.white,
                                      ),
                                      focusColor: Colors.amber,
                                      title: Text(state.weather[i].timezone.toString()),
                                      subtitle: Text('Humidity:${state.weather[i].current!.humidity.toString()}'),
                                      trailing: Text(state.weather[i].current!.temp.toString()),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is CurrentHistoryInitialState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CurrentHistoryErrorState) {
                  return const Center(
                    child: Text(
                      'Please Provide valid data',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  );
                } else {
                  return Text('');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
