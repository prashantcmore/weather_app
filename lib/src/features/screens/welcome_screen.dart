import 'package:flutter/cupertino.dart';
import 'package:weather_app/src/features/bloc/blocs/connectivity_bloc.dart';
import 'package:weather_app/src/features/bloc/blocs/signIn_bloc.dart';
import 'package:weather_app/src/features/screens/login_screen.dart';
import 'package:weather_app/src/features/screens/signin_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/states/connectivity_states.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: BlocConsumer<ConnectionBloc, ConnectionStat>(
                listener: (context, state) {
                  if (state is ConnectedState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Internet Connected'),
                      backgroundColor: Colors.green,
                    ));
                  } else if (state is DisConnectedState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Internet Lost'),
                      backgroundColor: Colors.red,
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is ConnectedState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => BlocProvider(
                                create: (context) => SignInBloc(),
                                child: SignInScreen(),
                              ),
                            ),
                          ),
                          child: Text(
                            'Sign Up',
                          ),
                        ),
                        CupertinoButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => BlocProvider(
                                create: (context) => SignInBloc(),
                                child: LoginScreen(),
                              ),
                            ),
                          ),
                          child: Text(
                            'Log in',
                          ),
                        ),
                      ],
                    );
                  } else if (state is DisConnectedState) {
                    return Text(
                      'Please Check Your internet connection',
                    );
                  } else {
                    return const Text(
                      "Loading...",
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
