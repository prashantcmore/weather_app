import 'package:weather_app/src/features/bloc/blocs/connectivity_bloc.dart';
import 'package:weather_app/src/features/bloc/blocs/signIn_bloc.dart';
import 'package:weather_app/src/features/bloc/cubits/current_history.dart';
import 'package:weather_app/src/features/bloc/cubits/history_cubit.dart';
import 'package:weather_app/src/features/bloc/cubits/weather_cubits.dart';
import 'package:weather_app/src/features/repositories/location.dart';
import 'package:weather_app/src/features/bloc/states/signIn_states.dart';
import 'package:weather_app/src/features/screens/home_screen.dart';
import 'package:weather_app/src/features/screens/tab_bar.dart';
import 'package:weather_app/src/features/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/features/screens/search_city_weather_screen.dart';
import 'src/features/screens/search_city_weather_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectionBloc(),
      child: BlocProvider(
        create: (context) => SignInBloc(),
        child: BlocProvider(
          create: (context) => WeatherCubit(),
          child: BlocProvider(
            create: (context) => HistoryCubit(),
            child: BlocProvider(
              create: (context) => CurrentHistoryCubit(),
              child: MaterialApp(
                theme: ThemeData(
                  primaryColor: Colors.deepOrange,
                  primarySwatch: Colors.deepOrange,
                ),
                debugShowCheckedModeBanner: false,
                home: BlocProvider(
                  create: (context) => SignInBloc(),
                  child: BlocBuilder<SignInBloc, SignInStates>(
                    builder: (context, state) {
                      print(state);
                      if (state is SignedInState) {
                        return const TabNavigationBar();
                      } else
                        return WelcomeScreen();
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
